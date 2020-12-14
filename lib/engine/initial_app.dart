import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jasamarga_nde_flutter/engine/utilities/shared_preference_manager.dart';
import 'package:jasamarga_nde_flutter/engine/utilities/secure_storage_manager.dart';
import 'package:jasamarga_nde_flutter/hive_helper/hive_boxes.dart';
import 'package:jasamarga_nde_flutter/models/place.dart';
import 'package:jasamarga_nde_flutter/models/place_category.dart';
import 'package:jasamarga_nde_flutter/models/user.dart';

class InitialApp {
  static setup() async {
    SharedPreferenceManager _manager = await SharedPreferenceManager.getInstance();
    final firstInstall = _manager.getIsFirstInstall();
    if (firstInstall) {
      final _secureStorage = SecureStorageManager.getInstance();
      _secureStorage.setToken(value: '');
      _secureStorage.setUserId(value: '');
      _manager.setIsFirstInstall(value: false);
    }
  }

  static hiveInitial() async {
    await Hive.initFlutter();
    Hive.registerAdapter<User>(UserAdapter());
    Hive.registerAdapter<Place>(PlaceAdapter());
    Hive.registerAdapter<PlaceCategory>(PlaceCategoryAdapter());
    await Hive.openBox<User>(HiveBoxes.users);
    await Hive.openBox<Place>(HiveBoxes.places);
    await Hive.openBox<PlaceCategoryAdapter>(HiveBoxes.place_categories);
  }
}