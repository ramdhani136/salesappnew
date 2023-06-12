import 'package:http/http.dart' as http;
import 'dart:convert';

class UserRepositiory {
  final String apiUrl = 'http://192.168.100.28:5000/users/login';

  Future<String> loginUser(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
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
      throw e;
    }
  }

  Future<dynamic> getUsers() async {
    // ignore: avoid_print
    print('dddddddddddddddddddddddd');
    try {
      final response = await http.get(Uri.parse("http://localhost:5000/users"));
      print(response);
      // if (response.statusCode == 200) {
      //   final jsonData = jsonDecode(response.body) as List<dynamic>;
      //   // print(jsonData);
      //   return jsonData;
      //   // return jsonData.map((user) => User.fromJson(user)).toList();
      // }
      return response;
    } catch (e) {
      return e;
    }
  }

  Future<void> updateUser(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<Map<String, dynamic>> showUser(String id) async {
    return {};
  }
}
