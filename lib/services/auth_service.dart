// lib/services/auth_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tukarkuy/utils/token_storage.dart'; // <-- IMPORT BARU

class AuthService {
  final String _baseUrl = "https://70dc0835574c.ngrok-free.app/api";
  final TokenStorage _tokenStorage = TokenStorage(); // <-- BUAT INSTANCE

  Future<bool> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/login'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        print("Login berhasil!");

        // --- PERUBAHAN DI SINI ---
        // 1. Decode JSON response
        final body = jsonDecode(response.body);

        // 2. Ambil token (sesuaikan key 'token' jika berbeda di API kamu)
        final String? token = body['token'];

        if (token != null) {
          // 3. Simpan token menggunakan TokenStorage
          await _tokenStorage.saveToken(token);
          print("Token berhasil disimpan.");
          return true;
        } else {
          print("Token tidak ditemukan di response.");
          return false;
        }
        // --- AKHIR PERUBAHAN ---
      } else {
        print("Login gagal!");
        print("Status Code: ${response.statusCode}");
        print("Response Body: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Terjadi error saat login: $e");
      return false;
    }
  }

  // --- FUNGSI LOGOUT (TAMBAHAN) ---
  Future<void> logout() async {
    // Panggil API logout jika ada
    // ...

    // Hapus token dari storage
    await _tokenStorage.deleteToken();
    print("Token telah dihapus (logout berhasil).");
  }

  /// Fungsi Register (tetap sama)
  Future<bool> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    // ... (kode register tidak perlu diubah)
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/register'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
        }),
      );

      // Backend Laravel Breeze biasanya memberikan status 201 (Created)
      if (response.statusCode == 201) {
        print("Registrasi berhasil!");
        return true;
      } else {
        print("Registrasi gagal!");
        print("Status Code: ${response.statusCode}");
        print("Response Body: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Terjadi error saat registrasi: $e");
      return false;
    }
  }
}
