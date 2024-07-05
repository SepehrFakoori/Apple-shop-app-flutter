import 'package:ecommerce_flutter_application/di/di.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthManager {

  static final ValueNotifier<String?> authChangeNotifier = ValueNotifier(null);
  static final  SharedPreferences _sharedPreferences = locator.get();

  static void saveToken (String token) async {
    _sharedPreferences.setString("access_token", token);
    authChangeNotifier.value = token;
  }

  static String readAuth() {
    return _sharedPreferences.getString("access_token") ?? "";
  }

  static void logout() {
    _sharedPreferences.clear();
    authChangeNotifier.value = null;
  }

  static bool isLoggedIn() {
    String token = readAuth();
    return token.isNotEmpty;
  //   If it's not empty --> true
  //   If it's empty --> false
  }

  static void saveId (String id) async {
    _sharedPreferences.setString("user_id", id);
  }

  static String getId () {
    return _sharedPreferences.getString("user_id") ?? "";
  }
}