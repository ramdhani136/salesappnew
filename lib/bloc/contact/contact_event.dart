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
  Map<String, dynamic> data;
  ContactInsertData({required this.data});
}

class EventChangeData extends ContactEvent {}
