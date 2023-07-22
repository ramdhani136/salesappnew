// ignore_for_file: must_be_immutable

part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final List<dynamic> users;

  UserLoaded(this.users);
}

class UserLoginLoaded extends UserState {
  UserModel data;
  UserLoginLoaded({required this.data});
}

class UserFailure extends UserState {
  final String error;

  UserFailure(this.error);
}
