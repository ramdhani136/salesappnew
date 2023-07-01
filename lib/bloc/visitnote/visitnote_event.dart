part of 'visitnote_bloc.dart';

@immutable
abstract class VisitnoteEvent {}

class GetVisitNote extends VisitnoteEvent {
  String visitId;
  bool refresh;
  GetVisitNote({
    required this.visitId,
    this.refresh = true,
  });
}

class ShowVisitNote extends VisitnoteEvent {
  String id;
  bool isLoading;
  ShowVisitNote({
    required this.id,
    this.isLoading = true,
  });
}

class DeleteVisitNote extends VisitnoteEvent {
  String id;
  DeleteVisitNote({
    required this.id,
  });
}

class UpdateVisitNote extends VisitnoteEvent {
  String id;
  Map<String, dynamic> data;
  UpdateVisitNote({
    required this.id,
    required this.data,
  });
}

class InsertVisitNote extends VisitnoteEvent {
  Map<String, dynamic> data;
  InsertVisitNote({
    required this.data,
  });
}
