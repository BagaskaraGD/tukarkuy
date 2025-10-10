import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  // Pastikan URL ini benar
  final String _baseUrl = "http://10.0.2.2:8000/api";

  /// Fungsi untuk Login
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
        print("Response: ${response.body}");
        // Nanti kita akan simpan token dari response.body di sini
        return true;
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

  /// --- FUNGSI REGISTER YANG BARU ---
  /// Fungsi untuk Register
  Future<bool> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
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
