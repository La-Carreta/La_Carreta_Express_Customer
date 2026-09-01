import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'session_storage.dart';

class ApiClient {
  ApiClient({
    http.Client? httpClient,
    SessionStorage? sessionStorage,
    String? apiBaseUrl,
    DateTime Function()? now,
  })  : _http = httpClient ?? http.Client(),
        _sessionStorage = sessionStorage ?? SecureSessionStorage(),
        _apiBaseUrl = apiBaseUrl ?? baseUrl,
        _now = now ?? DateTime.now;

  static ApiClient _instance = ApiClient();

  static ApiClient get instance => _instance;

  @visibleForTesting
  static void useInstanceForTesting(ApiClient client) {
    _instance = client;
  }

  static const baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://10.0.2.2:3000/api/v1',
  );
  static const tenantId = String.fromEnvironment('TENANT_ID');
  static const branchId = String.fromEnvironment('BRANCH_ID');
  static const tableId = String.fromEnvironment('TABLE_ID');
  static const _refreshLeeway = Duration(seconds: 30);

  final http.Client _http;
  final SessionStorage _sessionStorage;
  final String _apiBaseUrl;
  final DateTime Function() _now;
  Future<void>? _refreshInFlight;
  DateTime? _accessExpiresAt;

  String? accessToken;
  String? refreshToken;
  String? userId;
  String? email;

  Future<Map<String, dynamic>> login(String email, String password) async {
    final tokens = _asMap(await _send(
      'POST',
      '/auth/login',
      body: {'email': email, 'password': password},
    ));
    _applyTokenPair(tokens);
    userId = _jwtSubject(accessToken!);
    this.email = email.trim().toLowerCase();
    await _persist();
    await _removeLegacyTokens();
    return tokens;
  }

  Future<String> register(String email, String password) async {
    final response = _asMap(await request(
      'POST',
      '/auth/register',
      body: {'email': email, 'password': password},
      authenticated: false,
    ));
    return _requiredString(response, 'userId');
  }

  Future<bool> restore() async {
    await _removeLegacyTokens();
    final document = await _sessionStorage.read();
    if (document == null) return false;

    try {
      final session = _asMap(jsonDecode(document));
      accessToken = _requiredString(session, 'accessToken');
      refreshToken = _requiredString(session, 'refreshToken');
      userId = _requiredString(session, 'userId');
      email = _requiredString(session, 'email');
      _accessExpiresAt = DateTime.parse(
        _requiredString(session, 'accessExpiresAt'),
      ).toUtc();
      if (_accessNeedsRefresh) await _refreshSession();
      return accessToken != null && userId != null;
    } on ApiException {
      await _clearSession();
      return false;
    } on FormatException {
      await _clearSession();
      return false;
    }
  }

  Future<void> logout() async {
    if (accessToken != null) {
      try {
        await request('POST', '/auth/logout');
      } catch (_) {
        // Removing the local credentials still signs this device out.
      }
    }
    await _clearSession();
  }

  Future<dynamic> request(
    String method,
    String path, {
    Map<String, dynamic>? body,
    bool authenticated = true,
    bool retry = true,
  }) async {
    if (!authenticated) return _send(method, path, body: body);

    if (accessToken == null || refreshToken == null) {
      if (!await restore()) throw const SessionExpiredException();
    }
    if (_accessNeedsRefresh) await _refreshSession();
    final usedToken = accessToken;
    if (usedToken == null) throw const SessionExpiredException();

    try {
      return await _send(
        method,
        path,
        body: body,
        bearerToken: usedToken,
      );
    } on ApiException catch (error) {
      if (!retry || error.statusCode != 401) rethrow;
      if (accessToken == usedToken) await _refreshSession();
      return request(
        method,
        path,
        body: body,
        retry: false,
      );
    }
  }

  bool get _accessNeedsRefresh {
    final expiresAt = _accessExpiresAt;
    return expiresAt == null ||
        !_now().toUtc().add(_refreshLeeway).isBefore(expiresAt);
  }

  Future<void> _refreshSession() async {
    final active = _refreshInFlight;
    if (active != null) return active;

    final operation = _performRefresh();
    _refreshInFlight = operation;
    try {
      await operation;
    } finally {
      if (identical(_refreshInFlight, operation)) _refreshInFlight = null;
    }
  }

  Future<void> _performRefresh() async {
    final currentRefreshToken = refreshToken;
    if (currentRefreshToken == null) throw const SessionExpiredException();

    try {
      final tokens = _asMap(await _send(
        'POST',
        '/auth/refresh',
        body: {'refreshToken': currentRefreshToken},
      ));
      _applyTokenPair(tokens);
      userId = _jwtSubject(accessToken!);
      await _persist();
    } on ApiException catch (error) {
      if (error.statusCode == 401) {
        await _clearSession();
        throw const SessionExpiredException();
      }
      rethrow;
    }
  }

  void _applyTokenPair(Map<String, dynamic> tokens) {
    accessToken = _requiredString(tokens, 'accessToken');
    refreshToken = _requiredString(tokens, 'refreshToken');
    final expiresIn = tokens['expiresIn'];
    if (expiresIn is! num || expiresIn <= 0) {
      throw const ApiException('Respuesta de autenticación inválida');
    }
    _accessExpiresAt = _now().toUtc().add(
          Duration(seconds: expiresIn.toInt()),
        );
  }

  Future<dynamic> _send(
    String method,
    String path, {
    Map<String, dynamic>? body,
    String? bearerToken,
  }) async {
    final headers = <String, String>{'Accept': 'application/json'};
    if (body != null) headers['Content-Type'] = 'application/json';
    if (bearerToken != null) {
      headers['Authorization'] = 'Bearer $bearerToken';
    }
    final request = http.Request(
      method.toUpperCase(),
      Uri.parse('$_apiBaseUrl$path'),
    )..headers.addAll(headers);
    if (body != null) request.body = jsonEncode(body);

    final streamed = await _http.send(request);
    final response = await http.Response.fromStream(streamed);
    final decoded = response.body.isEmpty ? null : _decodeJson(response.body);
    if (response.statusCode < 200 || response.statusCode >= 300) {
      final message = decoded is Map<String, dynamic>
          ? decoded['message']?.toString()
          : null;
      throw ApiException(
        message ?? 'No se pudo completar la solicitud',
        statusCode: response.statusCode,
      );
    }
    return decoded;
  }

  Future<void> _persist() async {
    final expiresAt = _accessExpiresAt;
    if (accessToken == null ||
        refreshToken == null ||
        userId == null ||
        email == null ||
        expiresAt == null) {
      throw const SessionExpiredException();
    }
    await _sessionStorage.write(jsonEncode({
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'userId': userId,
      'email': email,
      'accessExpiresAt': expiresAt.toIso8601String(),
    }));
  }

  Future<void> _clearSession() async {
    accessToken = null;
    refreshToken = null;
    userId = null;
    email = null;
    _accessExpiresAt = null;
    await _sessionStorage.delete();
    await _removeLegacyTokens();
  }

  Future<void> _removeLegacyTokens() async {
    final preferences = await SharedPreferences.getInstance();
    for (final key in const [
      'accessToken',
      'refreshToken',
      'userId',
      'email',
    ]) {
      await preferences.remove(key);
    }
  }

  String _jwtSubject(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) throw const FormatException();
      final payload = utf8.decode(
        base64Url.decode(base64Url.normalize(parts[1])),
      );
      final claims = _asMap(jsonDecode(payload));
      return _requiredString(claims, 'sub');
    } on FormatException {
      throw const ApiException('Token de acceso inválido');
    }
  }
}

class ApiException implements Exception {
  const ApiException(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() => message;
}

class SessionExpiredException extends ApiException {
  const SessionExpiredException()
      : super('Tu sesión expiró. Inicia sesión nuevamente.', statusCode: 401);
}

dynamic _decodeJson(String value) {
  try {
    return jsonDecode(value);
  } on FormatException {
    throw const ApiException('El servidor devolvió una respuesta inválida');
  }
}

Map<String, dynamic> _asMap(dynamic value) {
  if (value is Map<String, dynamic>) return value;
  throw const ApiException('El servidor devolvió una respuesta inválida');
}

String _requiredString(Map<String, dynamic> value, String key) {
  final field = value[key];
  if (field is String && field.isNotEmpty) return field;
  throw const ApiException('El servidor devolvió una respuesta inválida');
}
