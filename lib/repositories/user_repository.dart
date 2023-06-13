import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:salesappnew/config/Config.dart';
import 'package:salesappnew/models/User';

Config config = Config();

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
      final response = await http.get(
        Uri.parse("${config.baseUri}users"),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader:
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NDgwMGU2MWNjMTlhZmYzOWY2MmQ0ZWEiLCJuYW1lIjoiQWRtaW5pc3RyYXRvciIsInVzZXJuYW1lIjoiYWRtaW5pc3RyYXRvciIsInN0YXR1cyI6IjEiLCJpYXQiOjE2ODY2MTc1ODUsImV4cCI6MTY4NjcwMzk4NX0.JMAV0syDLYtRIl1qvKuxXSruBWlLbxmEcD7hI6WUuDd',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        return jsonData['data'].map((user) => User.fromJson(user)).toList();
      } else {
        final jsonData = jsonDecode(response.body);
        throw jsonData['msg'];
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateUser(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<Map<String, dynamic>> showUser(String id) async {
    return {};
  }
}
