// ignore_for_file: must_be_immutable

part of 'field_infinite_bloc.dart';

@immutable
abstract class FieldInfiniteEvent {}

class FieldInfiniteSetData extends FieldInfiniteEvent {
  List<FieldInfiniteData>? data;
  bool? hasMore;
  bool? pageLoading;

  FieldInfiniteSetData({
    this.data,
    this.hasMore,
    this.pageLoading,
  });
}

class FieldInfiniteSetLoading extends FieldInfiniteEvent {
  bool loading;
  FieldInfiniteSetLoading({required this.loading});
}
