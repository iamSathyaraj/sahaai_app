import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  static const _storage = FlutterSecureStorage();
  static const _accessKey = 'access_token';

  static Future<void> saveAccessToken(String token) async {
    await _storage.write(key: _accessKey, value: token);
  }

  static Future<String?> getAccessToken() async {
    return _storage.read(key: _accessKey);
  }

  static Future<void> clear() async {
    await _storage.delete(key: _accessKey);
  }
}
