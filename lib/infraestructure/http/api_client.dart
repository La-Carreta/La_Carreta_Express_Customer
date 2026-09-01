import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  ApiClient._();
  static final ApiClient instance = ApiClient._();
  static const baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://10.0.2.2:3000/api/v1',
  );
  static const tenantId = String.fromEnvironment('TENANT_ID');
  static const branchId = String.fromEnvironment('BRANCH_ID');
  static const tableId = String.fromEnvironment('TABLE_ID');

  String? accessToken;
  String? refreshToken;
  String? userId;
  String? email;

  Future<Map<String, dynamic>> login(String email, String password) async {
    final tokens = await request(
      'POST',
      '/auth/login',
      body: {'email': email, 'password': password},
      authenticated: false,
    ) as Map<String, dynamic>;
    accessToken = tokens['accessToken'] as String;
    refreshToken = tokens['refreshToken'] as String;
    userId = _jwtSubject(accessToken!);
    this.email = email;
    await _persist();
    return tokens;
  }

  Future<String> register(String email, String password) async {
    final response = await request(
      'POST',
      '/auth/register',
      body: {'email': email, 'password': password},
      authenticated: false,
    ) as Map<String, dynamic>;
    return response['userId'] as String;
  }

  Future<bool> restore() async {
    final preferences = await SharedPreferences.getInstance();
    accessToken = preferences.getString('accessToken');
    refreshToken = preferences.getString('refreshToken');
    userId = preferences.getString('userId');
    email = preferences.getString('email');
    return accessToken != null && userId != null;
  }

  Future<void> logout() async {
    if (accessToken != null) {
      try {
        await request('POST', '/auth/logout');
      } catch (_) {
        // Local session removal is authoritative for this device.
      }
    }
    accessToken = null;
    refreshToken = null;
    userId = null;
    email = null;
    final preferences = await SharedPreferences.getInstance();
    await preferences.remove('accessToken');
    await preferences.remove('refreshToken');
    await preferences.remove('userId');
    await preferences.remove('email');
  }

  Future<dynamic> request(
    String method,
    String path, {
    Map<String, dynamic>? body,
    bool authenticated = true,
  }) async {
    if (authenticated && accessToken == null) await restore();
    final headers = <String, String>{'Accept': 'application/json'};
    if (body != null) headers['Content-Type'] = 'application/json';
    if (authenticated && accessToken != null) {
      headers['Authorization'] = 'Bearer $accessToken';
    }
    final uri = Uri.parse('$baseUrl$path');
    late http.Response response;
    if (method == 'GET') {
      response = await http.get(uri, headers: headers);
    } else if (method == 'POST') {
      response = await http.post(uri, headers: headers, body: jsonEncode(body));
    } else {
      throw ApiException('Método HTTP no soportado');
    }
    final decoded = response.body.isEmpty ? null : jsonDecode(response.body);
    if (response.statusCode < 200 || response.statusCode >= 300) {
      final message = decoded is Map<String, dynamic>
          ? decoded['message']?.toString()
          : null;
      throw ApiException(message ?? 'No se pudo completar la solicitud');
    }
    return decoded;
  }

  Future<void> _persist() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString('accessToken', accessToken!);
    await preferences.setString('refreshToken', refreshToken!);
    await preferences.setString('userId', userId!);
    await preferences.setString('email', email!);
  }

  String _jwtSubject(String token) {
    final parts = token.split('.');
    if (parts.length != 3) throw ApiException('Token de acceso inválido');
    final payload =
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
    final claims = jsonDecode(payload) as Map<String, dynamic>;
    return claims['sub'] as String;
  }
}

class ApiException implements Exception {
  final String message;
  ApiException(this.message);
  @override
  String toString() => message;
}
