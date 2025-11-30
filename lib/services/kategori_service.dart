import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tukarkuy/models/Category.dart';
import 'package:tukarkuy/services/config.dart';
import 'package:tukarkuy/utils/token_storage.dart';

class KategoriService {
  final TokenStorage _tokenStorage = TokenStorage();

  Future<List<Category>> getCategories() async {
    try {
      final token = await _tokenStorage.getToken();
      if (token == null) {
        throw Exception("Token tidak ditemukan, user belum login.");
      }

      final response = await http.get(
        Uri.parse("${Config.baseUrl}/kategori"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        
        if (responseData['success'] == true) {
          final List<dynamic> categoriesData = responseData['data'];
          return categoriesData.map((json) => Category.fromJson(json)).toList();
        } else {
          throw Exception(responseData['message'] ?? 'Failed to load categories');
        }
      } else {
        throw Exception('Failed to load categories: ${response.statusCode}');
      }
    } catch (e) {
      print("Error getCategories: $e");
      throw e;
    }
  }
}
