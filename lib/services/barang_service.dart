import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:tukarkuy/utils/token_storage.dart';
import 'package:tukarkuy/services/config.dart';
import 'dart:convert';
import 'package:tukarkuy/models/barang.dart';

class BarangService {
  final TokenStorage _tokenStorage = TokenStorage();

  Future<List<Barang>> fetchBarangList({int? categoryId}) async {
    try {
      final token = await _tokenStorage.getToken();
      if (token == null) {
        print("Token tidak ditemukan, user belum login.");
        return [];
      }

      final uri = Uri.parse("${Config.baseUrl}/barang").replace(
        queryParameters: {if (categoryId != null) 'id_kategori': '$categoryId'},
      );
      final response = await http.get(
        uri,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        final List data = body['data'] ?? [];
        return data.map((item) => Barang.fromJson(item)).toList();
      } else {
        print(
          "fetchBarangList failed: ${response.statusCode} ${response.body}",
        );
        return [];
      }
    } catch (e) {
      print("Error fetchBarangList: $e");
      return [];
    }
  }

  String? buildImageUrl(String? fotoPath) {
    if (fotoPath == null || fotoPath.isEmpty) return null;
    final base = Config.baseUrl.replaceFirst(RegExp(r'/api/?$'), '');
    return "$base/storage/$fotoPath";
  }

  Future<bool> createBarang({
    required String namaBar,
    required String deskripsiBar,
    required int stokBar,
    required String kondisi,
    File? imageFile,
  }) async {
    try {
      final token = await _tokenStorage.getToken();
      if (token == null) {
        print("Token tidak ditemukan, user belum login.");
        return false;
      }

      final uri = Uri.parse("${Config.baseUrl}/barang");
      final request = http.MultipartRequest('POST', uri);

      // headers
      request.headers.addAll({
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      // field biasa
      request.fields['nama_bar'] = namaBar;
      request.fields['deskripsi_bar'] = deskripsiBar;
      request.fields['stok_bar'] = stokBar.toString();
      request.fields['kondisi'] = kondisi; // kalau kamu pakai kolom ini di DB

      // file (opsional)
      if (imageFile != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'foto_bar', // <-- harus sama dengan field di Laravel
            imageFile.path,
          ),
        );
      }

      final streamedResponse = await request.send();
      final responseBody = await streamedResponse.stream.bytesToString();

      print("Status code: ${streamedResponse.statusCode}");
      print("Response body: $responseBody");

      if (streamedResponse.statusCode == 201) {
        return true;
      } else {
        // kalau mau, bisa parse error dari backend
        return false;
      }
    } catch (e) {
      print("Error createBarang: $e");
      return false;
    }
  }
}
