import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:tukarkuy/models/user_model.dart';
import 'package:tukarkuy/services/config.dart';
import 'package:tukarkuy/utils/token_storage.dart';
import 'package:tukarkuy/utils/user_storage.dart';

class UserService {
  final TokenStorage _tokenStorage = TokenStorage();
  final UserStorage _userStorage = UserStorage();

  Future<UserModel?> getUser() async {
    try {
      final token = await _tokenStorage.getToken();
      final userId = await _userStorage.getUserId();

      if (token == null || userId == null) {
        print("Token or User ID not found");
        return null;
      }

      final response = await http.get(
        Uri.parse('${Config.baseUrl}/user/$userId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        if (body['success'] == true) {
          return UserModel.fromJson(body['data']);
        }
      }
      print("Failed to get user: ${response.body}");
      return null;
    } catch (e) {
      print("Error getting user: $e");
      return null;
    }
  }

  Future<bool> updateUser({
    required String name,
    required String noWa,
    required String alamat,
    File? fotoProfil,
  }) async {
    try {
      final token = await _tokenStorage.getToken();
      final userId = await _userStorage.getUserId();

      if (token == null || userId == null) {
        return false;
      }

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${Config.baseUrl}/user/$userId'),
      );

      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });

      request.fields['_method'] = 'PUT';
      request.fields['name'] = name;
      request.fields['no_wa'] = noWa;
      request.fields['alamat'] = alamat;

      if (fotoProfil != null) {
        request.files.add(
          await http.MultipartFile.fromPath('foto_profil', fotoProfil.path),
        );
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        print("Update successful: ${response.body}");
        return true;
      } else {
        print("Update failed: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Error updating user: $e");
      return false;
    }
  }
}
