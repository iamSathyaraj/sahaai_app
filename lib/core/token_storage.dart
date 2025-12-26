import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  static const _storage = FlutterSecureStorage();
  static const _accessKey = 'access_token';
  static String? _cachedToken; 

  static Future<void> saveAccessToken(String token) async {
        _cachedToken = token; // ✅ Update cache

    await _storage.write(key: _accessKey, value: token);
  }

  static Future<String?> getAccessToken() async {
    // return _storage.read(key: _accessKey);
     _cachedToken ??= await _storage.read(key: _accessKey);
    return _cachedToken;

  }

    static String? getAccessTokenSync() => _cachedToken;


  static Future<void> clear() async {
  _cachedToken = null;
    await _storage.delete(key: _accessKey);
  }
}
