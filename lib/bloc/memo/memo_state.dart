// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'memo_bloc.dart';

@immutable
abstract class MemoState {}

class MemoInitial extends MemoState {}

class MemoIsLoading extends MemoState {}

class MemoIsLoaded extends MemoState {
  List data = [];
  int total = 0;
  bool hasMore = false;
  bool pageLoading = false;
  MemoIsLoaded({
    required this.data,
    required this.total,
    required this.hasMore,
    required this.pageLoading,
  });

  MemoIsLoaded copyWith({
    List? data,
    int? total,
    bool? hasMore,
    bool? pageLoading,
  }) {
    return MemoIsLoaded(
      data: data ?? this.data,
      total: total ?? this.total,
      hasMore: hasMore ?? this.hasMore,
      pageLoading: pageLoading ?? this.pageLoading,
    );
  }
}

class MemoIsFailure extends MemoState {
  String error;
  MemoIsFailure({
    required this.error,
  });
}
