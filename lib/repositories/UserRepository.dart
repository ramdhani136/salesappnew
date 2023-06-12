import 'package:http/http.dart' as http;
import 'dart:convert';

class UserRepositiory {
  Future<List<dynamic>> getUsers() async {
    final response = await http.get(Uri.parse("http://localhost:5000/users"));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as List<dynamic>;
      print(jsonData);
      return jsonData;
      // return jsonData.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<void> updateUser(String id) async {
    await Future.delayed(Duration(milliseconds: 500));
  }

  Future<Map<String, dynamic>> showUser(String id) async {
    return {};
  }
}
