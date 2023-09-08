// ignore_for_file: constant_identifier_names, camel_case_types

import 'package:shared_preferences/shared_preferences.dart';

enum typeOf { Int, String, Bool, Double, StringList }

class LocalData {
  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    return token;
  }

  Future setToken(String token) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
    } catch (e) {
      rethrow;
    }
  }

  Future setData<T>(String name, String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await prefs.setString(name, data);
    } catch (e) {
      rethrow;
    }
  }

  Future getData<T>(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      return prefs.getString(name);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removeData(String name) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove(name);
    } catch (e) {
      rethrow;
    }
  }
}
