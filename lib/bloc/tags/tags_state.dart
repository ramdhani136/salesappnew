// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'tags_bloc.dart';

@immutable
abstract class TagsState {}

class TagsInitial extends TagsState {}

class TagsIsLoading extends TagsState {}

class TagsIsLoaded extends TagsState {
  List data;
  bool hasMore;
  int page;
  int total;
  bool pageLoading;
  TagsIsLoaded({
    required this.data,
    required this.hasMore,
    required this.page,
    required this.total,
    required this.pageLoading,
  });
}

class tagsIsFailure extends TagsState {
  final String error;
  tagsIsFailure({
    required this.error,
  });
}
