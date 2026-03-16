import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SharedKeys { firstLaunch }

@lazySingleton
class LocalStorageManager {
  LocalStorageManager(this._sharedPreferences);
  final SharedPreferences _sharedPreferences;

  ///* First Launch
  Future<void> saveFirstLaunch() async {
    await _sharedPreferences.setBool(SharedKeys.firstLaunch.name, false);
  }

  bool getFirstLaunch() {
    return _sharedPreferences.getBool(SharedKeys.firstLaunch.name) ?? true;
  }

  Future<void> removeFirstLaunch() async {
    await _sharedPreferences.remove(SharedKeys.firstLaunch.name);
  }
}
