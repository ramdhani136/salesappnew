import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:salesappnew/config/Config.dart';
import 'package:salesappnew/utils/local_data.dart';

Config config = Config();
LocalData localData = LocalData();

class AuthRepository {
  Future<void> loginUser(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse("${config.baseUri}users/login"),
        body: jsonEncode({'username': username, 'password': password}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        await localData.setToken(jsonData['token']);
      } else {
        final jsonData = jsonDecode(response.body);
        throw jsonData['msg'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> isAuthenticated() async {
    String? token = await localData.getToken();
    return token != null;
  }

  Future<void> logout() async {}
}
