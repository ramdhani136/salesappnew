part of 'field_infinite_bloc.dart';

@immutable
abstract class FieldInfiniteEvent {}

class FieldInfiniteSetData extends FieldInfiniteEvent {
  List<FieldInfiniteData>? data;

  FieldInfiniteSetData({this.data});
}
