import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  static const _storage = FlutterSecureStorage();

  static const String _tokenKey = "jwt_token";
  static const String _studentIdKey = "student_id";

  static Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  static Future<void> saveStudentId(String id) async {
    await _storage.write(key: _studentIdKey, value: id);
  }

  static Future<String?> getStudentId() async {
    return await _storage.read(key: _studentIdKey);
  }

  static Future<void> clearAuthData() async {
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _studentIdKey);
  }
}
