part of 'dn_bloc.dart';

@immutable
abstract class DnEvent {}

class GetDnShow extends DnEvent {
  String id;
  GetDnShow({
    required this.id,
  });
}
