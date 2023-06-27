part of 'invoice_bloc.dart';

@immutable
abstract class InvoiceState {}

class InvoiceInitial extends InvoiceState {}

class InvoiceLoading extends InvoiceState {}

class InvoiceLoadedOverdue extends InvoiceState {
  List data;
  bool hasMore;
  bool loadingList;

  InvoiceLoadedOverdue({
    required this.data,
    this.hasMore = false,
    this.loadingList = false,
  });
}

class InvoiceFailure extends InvoiceState {
  String error;
  InvoiceFailure(this.error);
}
