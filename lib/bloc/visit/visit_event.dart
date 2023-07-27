// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: must_be_immutable

part of 'visit_bloc.dart';

@immutable
abstract class VisitEvent {}

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

class VisitChangeImage extends VisitEvent {
  String id;

  VisitChangeImage({
    required this.id,
  });
}

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
  VisitSetForm({this.data, this.naming, this.group, this.customer});
}

class VisitResetForm extends VisitEvent {
  bool data;
  bool naming;
  bool group;
  bool customer;
  VisitResetForm({
    this.data = false,
    this.naming = false,
    this.group = false,
    this.customer = false,
  });
}
