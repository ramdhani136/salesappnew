// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: must_be_immutable

part of 'contact_bloc.dart';

@immutable
abstract class ContactEvent {}

class GetListInput extends ContactEvent {
  String customerId;
  bool isLoading;

  GetListInput({required this.customerId, this.isLoading = true});
}

class ContactInsertData extends ContactEvent {
  bool callBackValue;
  Map<String, dynamic> data;
  ContactInsertData({required this.data, this.callBackValue = false});
}

class ContactGetPhone extends ContactEvent {}

class EventChangeData extends ContactEvent {}

class ContactFilterPhone extends ContactEvent {
  String filter;
  ContactFilterPhone({this.filter = ""});
}

class ContactSelectPhone extends ContactEvent {
  Map<String, dynamic> data;
  ContactSelectPhone({required this.data});
}
