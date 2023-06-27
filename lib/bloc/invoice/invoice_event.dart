// ignore_for_file: must_be_immutable

part of 'invoice_bloc.dart';

@immutable
abstract class InvoiceEvent {}

class InvoiceGetOverDue extends InvoiceEvent {
  String customerId;
  bool loadingPage;

  InvoiceGetOverDue({
    required this.customerId,
    this.loadingPage = true,
  });
}
