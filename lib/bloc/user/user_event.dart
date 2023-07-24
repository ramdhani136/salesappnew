// ignore_for_file: must_be_immutable, camel_case_types

part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class GetUserLogin extends UserEvent {}

class UserSetImage extends UserEvent {
  ImageSource source;
  UserSetImage({required this.source});
}

class UserSetUpdate extends UserEvent {
  Map<String, dynamic> data;
  UserSetUpdate({required this.data});
}
