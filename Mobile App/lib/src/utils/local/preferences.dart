 import 'package:shared_preferences/shared_preferences.dart';


class Preferences {
  const Preferences(this._prefs);
  final SharedPreferences _prefs;

  Future<bool> insert(String key, String value) async {
    return await _prefs.setString(key, value);
  }
  Future<bool> update(String key, String value) async {
    await delete(key);
    return await insert(key, value);
  }
  Future<bool> delete(String key) async {
    return await _prefs.remove(key);
  }

  Object? get(String key)  {
    return _prefs.get(key);
  }
}