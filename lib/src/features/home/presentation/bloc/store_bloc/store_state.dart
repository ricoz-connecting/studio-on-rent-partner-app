part of 'store_bloc.dart';

@immutable
sealed class StoreState {}

final class StoreInitial extends StoreState {}

class StoreLoadingState extends StoreState {}

class StoreFailureState extends StoreState {
  final String message;

  StoreFailureState({required this.message});
}

class StoreSuccessState extends StoreState {
  final List<StudioEntity> studios;

  StoreSuccessState({required this.studios});
}
