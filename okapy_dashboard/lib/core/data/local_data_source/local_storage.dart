import 'package:okapy_dashboard/core/data/local_data_source/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static saveLoginState(bool isLoggedIn) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(LocalStorageConstants.isLoggedIn, isLoggedIn);
  }

  static Future<bool> getLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(LocalStorageConstants.isLoggedIn) ?? false;
  }

  static saveUserToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(LocalStorageConstants.token, token);
  }

  static getUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(LocalStorageConstants.token);
  }

  static saveUserPhoneNumber(String phoneNumber) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(LocalStorageConstants.phoneNumber, phoneNumber);
  }

  static getUserPhoneNumber() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(LocalStorageConstants.phoneNumber);
  }

  static saveIsPartner(bool isPartner) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(LocalStorageConstants.isPartner, isPartner);
  }

  static getIsPartner() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(LocalStorageConstants.isPartner);
  }

  static saveUserEmail(String userEmail) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(LocalStorageConstants.userEmail, userEmail);
  }

  static getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(LocalStorageConstants.userEmail);
  }

  static saveUserName(String userName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(LocalStorageConstants.userName, userName);
  }

  static getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(LocalStorageConstants.userName);
  }

  static savePartnerId(String partnerId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(LocalStorageConstants.partnerId, partnerId);
  }

  static getPartnerId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(LocalStorageConstants.partnerId);
  }
  static clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }
}
