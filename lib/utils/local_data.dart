import 'package:shared_preferences/shared_preferences.dart';

enum typeOf { Int, String, Bool, Double, StringList }

class LocalData {
  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    return token;
  }

  Future setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future setData<T>(typeOf type, String name, T data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      switch (type) {
        case typeOf.Bool:
          await prefs.setBool(name, data as bool);
          break;
        case typeOf.Int:
          await prefs.setInt(name, data as int);
          break;
        case typeOf.Double:
          await prefs.setDouble(name, data as double);
          break;
        case typeOf.StringList:
          await prefs.setStringList(name, data as List<String>);
          break;
        default:
          await prefs.setString(name, data as String);
          break;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future getData<T>(typeOf type, String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      if (type == typeOf.Bool) {
        return prefs.getBool(name);
      }
      if (type == typeOf.Int) {
        return prefs.getInt(name);
      }
      if (type == typeOf.Double) {
        return prefs.getDouble(name);
      }
      if (type == typeOf.String) {
        return prefs.getString(name);
      }
      if (type == typeOf.StringList) {
        return prefs.getString(name);
      }
    } catch (e) {
      rethrow;
    }
  }
}
