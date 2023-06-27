part of 'contact_bloc.dart';

@immutable
abstract class ContactEvent {}

class GetListInput extends ContactEvent {
  String customerId;
  bool isLoading;

  GetListInput({required this.customerId, this.isLoading = true});
}

class EventChangeData extends ContactEvent {}
