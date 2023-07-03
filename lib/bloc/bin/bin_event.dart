part of 'bin_bloc.dart';

@immutable
abstract class BinEvent {}

class GetBinByItem extends BinEvent {
  String itemId;
  GetBinByItem({
    required this.itemId,
  });
}
