import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static saveClientServerData(dynamic details) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("ClientServerData", jsonEncode(details));
  }

  static getClientServerData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String details = prefs.getString("ClientServerData") ?? "";
    if(details.isEmpty) {
      return null;
    }
    dynamic data = jsonDecode(details);
    return data;
  }

  static saveAcceessToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("AccessToken", token);
  }

  static Future<String> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic token = prefs.get("AccessToken");
    return token ?? "";
  }


  static saveIsFirstTimeLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("IsFirstTimeLaunch", false);
  }

  static Future<bool> isFirstTimeLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic isLaunch = prefs.get("IsFirstTimeLaunch") ?? true;
    return isLaunch;
  }

  static saveLoginUsername(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("LoginUsername", username);
  }

  static getLoginUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString("LoginUsername") ?? "";
    return username;
  }

  static clearAllData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("AccessToken");
    prefs.remove("UserDetails");
  }

  static saveUserDetails(dynamic details) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("UserDetails", jsonEncode(details));
  }

  static getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String details = prefs.getString("UserDetails") ?? "";
    if(details.isEmpty) {
      return null;
    }
    dynamic data = jsonDecode(details);
    return data;
  }
}