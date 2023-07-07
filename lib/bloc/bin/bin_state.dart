// ignore_for_file: must_be_immutable

part of 'bin_bloc.dart';

@immutable
abstract class BinState {}

class BinInitial extends BinState {}

class BinIsLoading extends BinState {}

class BinInfiniteLoading extends BinState {}

class BinByItemIsLoaded extends BinState {
  List<BinModel> data;

  BinByItemIsLoaded({
    required this.data,
  });
}

class BinIsFailure extends BinState {
  String error;
  BinIsFailure(this.error);
}
