// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'branch_bloc.dart';

@immutable
abstract class BranchState {}

class BranchInitial extends BranchState {}

class BranchIsLoading extends BranchState {}

class BranchIsLoaded extends BranchState {
  List data;
  BranchIsLoaded({
    required this.data,
  });
}

class BranchIsFailure extends BranchState {
  String error;
  BranchIsFailure({
    required this.error,
  });
}
