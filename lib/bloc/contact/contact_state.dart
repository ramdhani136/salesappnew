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

class ContactIsLoaded extends ContactState {
  List data;
  ContactIsLoaded({
    required this.data,
  });
}

class ContactPhoneIsloaded extends ContactState {
  List<Contact> current;
  List<Contact> data;
  ContactPhoneIsloaded({
    required this.current,
    required this.data,
  });
}

class ContactSelectedPhone extends ContactState {
  Map<String, dynamic> data;
  ContactSelectedPhone({required this.data});
}

class ContactSavedIsSuccess extends ContactState {
  Map<String, dynamic> data;
  ContactSavedIsSuccess({required this.data});
}
