import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/UI/controller/model_class.dart';

class AuthController {
  static final String _token = 'token';
  static final String _userData = 'userModel';

  static String? accessToken;
  static UserModel? userData;

  static Future<void> saveLoginData(String token, UserModel userModel) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_token, token);
    sharedPreferences.setString(_userData, jsonEncode(userModel.toJson()));
  }

  static Future<void> getLoginData(String token, UserModel user) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(_token);
    if (token != null) {
      accessToken = token;
      userData = UserModel.fromJson(
        jsonDecode(sharedPreferences.getString(_userData)!),
      );
    }
  }

  static Future<bool> isUserLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(_token);
    return token != null;
  }

  static Future<void> logOutUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }
}
