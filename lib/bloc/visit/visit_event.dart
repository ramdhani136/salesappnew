// ignore_for_file: public_member_api_docs, sort_constructors_first, camel_case_types
// ignore_for_file: must_be_immutable

part of 'visit_bloc.dart';

@immutable
abstract class VisitEvent {}

class SetFilterData extends VisitEvent {
  List<String> filter;

  SetFilterData({
    required this.filter,
  });
}

class SetFilter extends VisitEvent {
  FilterModel filter;

  SetFilter({
    required this.filter,
  });
}

class RemoveFilter extends VisitEvent {
  List<String> data;

  RemoveFilter({
    required this.data,
  });
}

class GetData extends VisitEvent {
  int status = 0;
  bool getRefresh = false;
  String? search;
  List<List<String>>? filters;

  GetData({
    this.status = 0,
    this.getRefresh = false,
    this.search,
    this.filters,
  });
}

class ChangeSearch extends VisitEvent {
  String search = "";

  ChangeSearch(this.search);
}

class ShowData extends VisitEvent {
  String id;
  bool isLoading;

  ShowData({required this.id, this.isLoading = true});
}

class DeleteOne extends VisitEvent {
  String id;

  DeleteOne(this.id);
}

class ChangeWorkflow extends VisitEvent {
  String id;
  String nextStateId;
  ChangeWorkflow({required this.id, required this.nextStateId});
}

class UpdateSignature extends VisitEvent {
  String id;
  final SignatureController controller;

  UpdateSignature({
    required this.id,
    required this.controller,
  });
}

class VisitUpdateData extends VisitEvent {
  String id;
  Map<String, dynamic> data;

  VisitUpdateData({
    required this.id,
    required this.data,
  });
}

class VisitChangeImage extends VisitEvent {}

class ClearSignature extends VisitEvent {
  String id;
  ClearSignature({
    required this.id,
  });
}

class InsertVisit extends VisitEvent {
  Map<String, dynamic> data;
  BuildContext context;
  VisitBloc? visitBloc;
  InsertVisit({required this.data, required this.context, this.visitBloc});
}

class SetCheckOut extends VisitEvent {
  String id;
  SetCheckOut({
    required this.id,
  });
}

class VisitGetNaming extends VisitEvent {}

class VisitSetForm extends VisitEvent {
  KeyValue? data;
  KeyValue? naming;
  KeyValue? group;
  KeyValue? customer;
  KeyValue? branch;
  KeyValue? contact;
  VisitSetForm(
      {this.data,
      this.naming,
      this.group,
      this.customer,
      this.branch,
      this.contact});
}

class VisitResetForm extends VisitEvent {
  bool data;
  bool naming;
  bool group;
  bool customer;
  bool branch;
  bool contact;
  VisitResetForm({
    this.data = false,
    this.naming = false,
    this.group = false,
    this.customer = false,
    this.branch = false,
    this.contact = false,
  });
}
