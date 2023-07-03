part of 'item_bloc.dart';

@immutable
abstract class ItemEvent {}

class GetItemShow extends ItemEvent {
  String id;
  GetItemShow({
    required this.id,
  });
}
