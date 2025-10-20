import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  // Buat instance dari FlutterSecureStorage
  final _storage = const FlutterSecureStorage();

  // Key untuk menyimpan token di storage
  static const _tokenKey = 'auth_token';

  /// Menyimpan token ke secure storage
  Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  /// Mengambil token dari secure storage
  /// Akan mengembalikan null jika tidak ada token
  Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  /// Menghapus token dari secure storage (untuk logout)
  Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
  }
}
