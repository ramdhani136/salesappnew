import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 30),
              height: 150,
              child: Image.asset(
                "assets/images/logo.png",
              ),
            ),
            const SizedBox(height: 30),
            Container(
              child: Column(
                children: [
                  TextField(
                    controller: _usernameController,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      labelText: "Username",
                      hintText: "Cth : ramdhaniit",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                      labelText: "Password",
                      hintText: "",
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        onPressed: () {
                          // callsheetP.getPhoneContact(context);
                        },
                        icon: const Icon(
                          Icons.remove_red_eye,
                          color: Colors.grey,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                backgroundColor: Colors.grey[300],
              ),
              child: const Text(
                "Login",
                style: TextStyle(
                  color: Color(0xFF747D8C),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
