
import 'package:hive/hive.dart';
import 'package:jasamarga_nde_flutter/engine/utilities/secure_storage_manager.dart';
import 'package:jasamarga_nde_flutter/hive_helper/hive_boxes.dart';
import 'package:jasamarga_nde_flutter/models/user.dart';

class UserManager {
  
  User _user;

  Future<User> getCurrentUser() async {
    if (_user == null) {
      final box = Hive.box<User>(HiveBoxes.users);
      final userId = await SecureStorageManager.getInstance().getUserId();
      if (userId != null) {
        final user = box.get(userId);
        if (user != null) this._user = user;
      }
    }
    return _user;
  }

  Future<bool> isLoggedIn() async {
    final token = await SecureStorageManager.getInstance().getToken();
    final userId = await SecureStorageManager.getInstance().getUserId();
    if (token != null && token != "" && userId != null) {
      return true;
    }
    return false;
  }
}
