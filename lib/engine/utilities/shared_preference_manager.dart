import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceManager {
  static SharedPreferenceManager _instance;
  SharedPreferences _preference;

  String _isFirstInstall = "is_first_install";

  static Future<SharedPreferenceManager> getInstance() async {
    if (_instance == null) {
      _instance = SharedPreferenceManager();
    }
    if (_instance._preference == null) {
      _instance._preference = await SharedPreferences.getInstance();
    }
    return _instance;
  }

  // Is First Install
  //

  bool getIsFirstInstall() {
    final data = _preference.getBool(_isFirstInstall);
    return data ?? true;
  }

  Future setIsFirstInstall({@required bool value}) async {
    return await _preference.setBool(_isFirstInstall, value); 
  }

}
