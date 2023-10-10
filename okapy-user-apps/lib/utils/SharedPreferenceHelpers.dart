import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelpers {
  static saveBool(String name, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(name, value);
  }

  static Future<bool> getBool(String name) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(name) ?? false;
  }

  static saveString(String name, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(name, value);
  }

  static getString(String name) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(name);
  }

  static saveInt(String name, int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(name, value);
  }

  static getInt(String name) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(name);
  }

  static removeValue(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(name);
  }
}
