// ignore_for_file: public_member_api_docs, sort_constructors_first
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

class GetInvoiceShow extends InvoiceEvent {
  String invoiceID;
  GetInvoiceShow({
    required this.invoiceID,
  });
}

class InvoiceGetAll extends InvoiceEvent {
  int status = 0;
  bool getRefresh = false;
  String? search;

  InvoiceGetAll({this.status = 0, this.getRefresh = false, this.search});
}

class InvoiceChangeSearch extends InvoiceEvent {
  String search = "";

  InvoiceChangeSearch(this.search);
}
