import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salesappnew/bloc/auth/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        bloc: authBloc,
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (state is AuthUnauthenticated) {
            Navigator.pushReplacementNamed(context, '/');
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          bloc: authBloc,
          builder: (context, state) {
            if (state is AuthLoading) {
              return SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(color: Colors.grey[400]),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Expanded(
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
                        Column(
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
                              obscureText: !authBloc.isPasswordVisible,
                              enableSuggestions: false,
                              autocorrect: false,
                              decoration: InputDecoration(
                                labelText: "Password",
                                hintText: "",
                                border: const OutlineInputBorder(),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    authBloc.add(
                                      TogglePasswordVisibility(),
                                    );
                                  },
                                  icon: Icon(
                                    authBloc.isPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                          ],
                        ),
                        state is AuthLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.grey),
                                ),
                              )
                            : ElevatedButton(
                                onPressed: () {
                                  final username = _usernameController.text;
                                  final password = _passwordController.text;

                                  authBloc.add(
                                    OnLogin(
                                        username: username, password: password),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  backgroundColor: Colors.grey[300],
                                ),
                                child: const Text(
                                  "Login",
                                  style: TextStyle(
                                    color: Color(0xFF747D8C),
                                  ),
                                ),
                              )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Version Beta 1.0.0",
                    style: TextStyle(
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
