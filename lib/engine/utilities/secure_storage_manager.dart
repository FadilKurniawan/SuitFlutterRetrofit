import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';

class SecureStorageManager {
  static SecureStorageManager _instance;
  static FlutterSecureStorage _secureStorage;

  String _tokenKey = "token";
  String _userIdKey = "user_id";

  static SecureStorageManager getInstance() {
    if (_instance == null) {
      _instance = SecureStorageManager();
    }
    if (_secureStorage == null) {
      _secureStorage = FlutterSecureStorage();
    }
    return _instance;
  }

  // User Token
  //

  Future<String> getToken() async {
    return await _secureStorage.read(key: _tokenKey);
  }

  Future setToken({@required String value}) async {
    return await _secureStorage.write(key: _tokenKey, value: value);
  }

  // User ID
  //

  Future<int> getUserId() async {
    final userId = await _secureStorage.read(key: _userIdKey);
    if (userId != null && userId != '') {
      if (int.tryParse(userId) != null) {
        return int.tryParse(userId);
      }
    }
    return null;
  }

  Future setUserId({@required String value}) async {
    if (value != null) {
      return await _secureStorage.write(key: _userIdKey, value: value);
    } else {
      return await _secureStorage.write(key: _userIdKey, value: '');
    }
  }
}
