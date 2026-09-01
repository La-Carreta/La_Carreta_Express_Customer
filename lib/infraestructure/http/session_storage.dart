import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract interface class SessionStorage {
  Future<String?> read();

  Future<void> write(String value);

  Future<void> delete();
}

class SecureSessionStorage implements SessionStorage {
  SecureSessionStorage({FlutterSecureStorage? storage})
      : _storage = storage ??
            const FlutterSecureStorage(
              aOptions: AndroidOptions(migrateWithBackup: true),
            );

  static const _sessionKey = 'la_carreta.customer.session.v1';
  final FlutterSecureStorage _storage;

  @override
  Future<String?> read() => _storage.read(key: _sessionKey);

  @override
  Future<void> write(String value) =>
      _storage.write(key: _sessionKey, value: value);

  @override
  Future<void> delete() => _storage.delete(key: _sessionKey);
}

class MemorySessionStorage implements SessionStorage {
  MemorySessionStorage([this.value]);

  String? value;

  @override
  Future<String?> read() async => value;

  @override
  Future<void> write(String value) async {
    this.value = value;
  }

  @override
  Future<void> delete() async {
    value = null;
  }
}
