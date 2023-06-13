import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:salesappnew/config/Config.dart';
import 'package:salesappnew/models/User';
import 'package:salesappnew/utils/local_data.dart';

Config config = Config();
LocalData localData = LocalData();

class UserRepositiory {
  Future<String> loginUser(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse("${config.baseUri}users/login"),
        body: jsonEncode({'username': username, 'password': password}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        return jsonData['token'];
      } else {
        final jsonData = jsonDecode(response.body);
        throw jsonData['msg'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getUsers() async {
    try {
      String? token = await localData.getToken();

      final response = await http.get(
        Uri.parse("${config.baseUri}users"),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        List<dynamic> data = jsonData['data'];

        data.map((e) => {print(e['_id'])});

        return jsonData['data'].map((user) => User.fromJson(user)).toList();
      } else {
        final jsonData = jsonDecode(response.body);
        throw jsonData['msg'];
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> updateUser(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<Map<String, dynamic>> showUser(String id) async {
    return {};
  }
}
