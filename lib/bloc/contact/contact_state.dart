// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'contact_bloc.dart';

@immutable
abstract class ContactState {}

class ContactInitial extends ContactState {}

class ContactIsLoading extends ContactState {}

class ContactIsFailure extends ContactState {
  String error;
  ContactIsFailure(
    this.error,
  );
}

class ContactInput extends ContactState {
  List data;
  ContactInput({
    required this.data,
  });
}
