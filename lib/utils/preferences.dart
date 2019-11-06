import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  setBool(String key, bool val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, val);
  }

  Future<bool> getBool(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }
}
