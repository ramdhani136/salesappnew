part of 'invoice_bloc.dart';

@immutable
abstract class InvoiceState {}

class InvoiceInitial extends InvoiceState {}

class InvoiceLoading extends InvoiceState {}

class InvoiceLoadedOverdue extends InvoiceState {
  List data;
  InvoiceLoadedOverdue({required this.data});
}

class InvoiceFailure extends InvoiceState {
  String error;
  InvoiceFailure(this.error);
}
