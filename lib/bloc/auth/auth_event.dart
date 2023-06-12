part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class OnLogin extends AuthEvent {
  final String username;
  final String password;

  OnLogin({required this.username, required this.password});
}

class ShowPassword extends AuthEvent {}
