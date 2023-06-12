part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class LoadUsers extends UserEvent {
  final List<Map> users;
  LoadUsers(this.users);
}
