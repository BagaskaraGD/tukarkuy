import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String _baseUrl = "http://192.168.0.8:8000/api";

  String? _token; // simpan token login di sini

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
        final data = jsonDecode(response.body);
        // Pastikan sesuai struktur respons dari backendmu
        _token = data['token'];
        print("Token: $_token");
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

  /// Fungsi Logout dengan Sanctum
  Future<bool> logout() async {
    try {
      if (_token == null) {
        print("Token belum ada, user belum login");
        return false;
      }

      final response = await http.post(
        Uri.parse('$_baseUrl/logout'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $_token', // token dikirim di sini
        },
      );

      if (response.statusCode == 200) {
        print("Logout berhasil!");
        _token = null; // hapus token lokal
        return true;
      } else {
        print("Logout gagal!");
        print("Status Code: ${response.statusCode}");
        print("Response Body: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Terjadi error saat logout: $e");
      return false;
    }
  }
}
