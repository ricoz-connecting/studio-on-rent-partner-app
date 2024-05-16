part of 'request_bloc.dart';

@immutable
sealed class RequestState {}

final class RequestInitial extends RequestState {}

class RequestLoadingState extends RequestState {}

class RequestSuccessState extends RequestState {
  final StudioEntity studioEntity;

  RequestSuccessState({required this.studioEntity});
}

class RequestFailureState extends RequestState {
  final String message;

  RequestFailureState({required this.message});
}
