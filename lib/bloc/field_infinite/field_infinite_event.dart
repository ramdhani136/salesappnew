// ignore_for_file: must_be_immutable

part of 'field_infinite_bloc.dart';

@immutable
abstract class FieldInfiniteEvent {}

class FieldInfiniteSetData extends FieldInfiniteEvent {
  List<FieldInfiniteData>? data;
  bool? hasMore;

  FieldInfiniteSetData({this.data, this.hasMore});
}

class FieldInfiniteSetLoading extends FieldInfiniteEvent {
  bool loading;
  FieldInfiniteSetLoading({required this.loading});
}
