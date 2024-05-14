part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent {}

class RegisterAgent extends RegisterEvent {
  final RegisterParams params;

  RegisterAgent({required this.params});
}
