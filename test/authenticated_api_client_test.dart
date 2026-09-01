import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:la_carreta_express_cs/infraestructure/http/authenticated_api_client.dart';
import 'package:la_carreta_express_cs/infraestructure/http/session_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({
      'accessToken': 'legacy-access',
      'refreshToken': 'legacy-refresh',
      'userId': 'legacy-user',
      'email': 'legacy@example.com',
    });
  });

  test('rotates one refresh token for concurrent requests', () async {
    var now = DateTime.utc(2026, 9, 1, 12);
    var refreshCalls = 0;
    final protectedAuthorizations = <String?>[];
    final storage = MemorySessionStorage();
    final accessA = _jwt('user-a');
    final accessB = _jwt('user-a', marker: 'rotated');
    final httpClient = MockClient((request) async {
      final path = request.url.path;
      if (path.endsWith('/auth/login')) {
        return _json({
          'accessToken': accessA,
          'refreshToken': 'refresh-a-which-is-long-enough',
          'tokenType': 'Bearer',
          'expiresIn': 900,
        });
      }
      if (path.endsWith('/auth/refresh')) {
        refreshCalls++;
        expect(
          jsonDecode(request.body),
          {'refreshToken': 'refresh-a-which-is-long-enough'},
        );
        await Future<void>.delayed(Duration.zero);
        return _json({
          'accessToken': accessB,
          'refreshToken': 'refresh-b-which-is-long-enough',
          'tokenType': 'Bearer',
          'expiresIn': 900,
        });
      }
      if (path.endsWith('/orders')) {
        protectedAuthorizations.add(request.headers['authorization']);
        return _json([]);
      }
      return http.Response('Not found', 404);
    });
    final client = ApiClient(
      httpClient: httpClient,
      sessionStorage: storage,
      apiBaseUrl: 'https://api.example.test/api/v1',
      now: () => now,
    );

    await client.login('customer@example.com', 'correct horse battery');
    now = now.add(const Duration(minutes: 15));

    await Future.wait([
      client.request('GET', '/customer/tenants/example/orders'),
      client.request('GET', '/customer/tenants/example/orders'),
    ]);

    expect(refreshCalls, 1);
    expect(protectedAuthorizations, ['Bearer $accessB', 'Bearer $accessB']);
    expect(storage.value, contains('refresh-b-which-is-long-enough'));

    final preferences = await SharedPreferences.getInstance();
    expect(preferences.getString('accessToken'), isNull);
    expect(preferences.getString('refreshToken'), isNull);
    expect(preferences.getString('userId'), isNull);
    expect(preferences.getString('email'), isNull);
  });

  test('clears credentials when refresh rotation is rejected', () async {
    var now = DateTime.utc(2026, 9, 1, 12);
    final storage = MemorySessionStorage();
    final client = ApiClient(
      sessionStorage: storage,
      apiBaseUrl: 'https://api.example.test/api/v1',
      now: () => now,
      httpClient: MockClient((request) async {
        if (request.url.path.endsWith('/auth/login')) {
          return _json({
            'accessToken': _jwt('user-a'),
            'refreshToken': 'refresh-a-which-is-long-enough',
            'tokenType': 'Bearer',
            'expiresIn': 900,
          });
        }
        if (request.url.path.endsWith('/auth/refresh')) {
          return _json({'message': 'Invalid session'}, status: 401);
        }
        return http.Response('Not found', 404);
      }),
    );

    await client.login('customer@example.com', 'correct horse battery');
    now = now.add(const Duration(minutes: 15));

    await expectLater(
      client.request('GET', '/customer/tenants/example/orders'),
      throwsA(isA<SessionExpiredException>()),
    );
    expect(storage.value, isNull);
    expect(client.accessToken, isNull);
    expect(client.refreshToken, isNull);
  });

  test('removes an invalid persisted session', () async {
    final storage = MemorySessionStorage('{not-json');
    final client = ApiClient(
      sessionStorage: storage,
      apiBaseUrl: 'https://api.example.test/api/v1',
    );

    expect(await client.restore(), isFalse);
    expect(storage.value, isNull);
  });
}

String _jwt(String subject, {String marker = 'initial'}) {
  String encode(Object value) =>
      base64Url.encode(utf8.encode(jsonEncode(value))).replaceAll('=', '');
  return '${encode({'alg': 'RS256', 'typ': 'JWT'})}.'
      '${encode({'sub': subject, 'marker': marker})}.signature';
}

http.Response _json(Object value, {int status = 200}) => http.Response(
      jsonEncode(value),
      status,
      headers: {'content-type': 'application/json'},
    );
