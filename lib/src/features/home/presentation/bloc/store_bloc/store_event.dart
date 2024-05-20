part of 'store_bloc.dart';

@immutable
sealed class StoreEvent {}

class GetStoreEvent extends StoreEvent {
  final String agentId;

  GetStoreEvent({required this.agentId});
}
