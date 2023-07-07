// ignore_for_file: must_be_immutable

part of 'invoice_bloc.dart';

@immutable
abstract class InvoiceState {}

class InvoiceInitial extends InvoiceState {}

class InvoiceLoading extends InvoiceState {}

class InvoiceInfiniteLoading extends InvoiceState {}

class InvoiceLoadedOverdue extends InvoiceState {
  List data;
  bool hasMore;
  int page;

  InvoiceLoadedOverdue({
    required this.data,
    this.hasMore = false,
    this.page = 1,
  });
}

class InvoiceShowIsLoaded extends InvoiceState {
  InvoiceModel data;
  List<dynamic> workflow;
  InvoiceShowIsLoaded({
    required this.data,
    required this.workflow,
  });
}

class InvoiceFailure extends InvoiceState {
  String error;
  InvoiceFailure(this.error);
}

class InvoiceIsLoaded extends InvoiceState {
  List data;
  bool hasMore;
  bool pageLoading;

  InvoiceIsLoaded({
    required this.data,
    this.hasMore = false,
    this.pageLoading = false,
  });
}

class InvoiceTokenExpired extends InvoiceState {
  String error;

  InvoiceTokenExpired(this.error);
}
