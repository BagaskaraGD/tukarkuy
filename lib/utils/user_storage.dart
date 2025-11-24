import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserStorage {
  final _storage = const FlutterSecureStorage();
  static const _userIdKey = 'user_id';

  Future<void> saveUserId(int id) async {
    await _storage.write(key: _userIdKey, value: id.toString());
  }

  Future<int?> getUserId() async {
    final idString = await _storage.read(key: _userIdKey);
    if (idString != null) {
      return int.tryParse(idString);
    }
    return null;
  }

  Future<void> deleteUserId() async {
    await _storage.delete(key: _userIdKey);
  }
}
