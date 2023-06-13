part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final List<dynamic> users;

  UserLoaded(this.users);
}

class UserFailure extends UserState {
  final String error;

  UserFailure(this.error);
}
