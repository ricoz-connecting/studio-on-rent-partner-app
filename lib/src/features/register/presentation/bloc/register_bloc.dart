// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:studio_partner_app/src/commons/params/register_params.dart';
import 'package:studio_partner_app/src/features/register/domain/usecase/resgister_usecase.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUsecase _registerUsecase;
  RegisterBloc({
    required RegisterUsecase registerUsecase,
  })  : _registerUsecase = registerUsecase,
        super(RegisterInitial()) {
    on<RegisterEvent>((event, emit) {
      // TODO: implement event handler
      emit(LoadingState());
    });
    on<RegisterAgent>(
      (event, emit) async {
        final res = await _registerUsecase.call(event.params);
        res.fold((l) => RegisterFailure(message: l.message),
            (r) => RegisterPending());
      },
    );
  }
}
