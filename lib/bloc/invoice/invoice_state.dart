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
  List<ActionModel> workflow;
  InvoiceShowIsLoaded({
    required this.data,
    required this.workflow,
  });
}

class InvoiceFailure extends InvoiceState {
  String error;
  InvoiceFailure(this.error);
}
