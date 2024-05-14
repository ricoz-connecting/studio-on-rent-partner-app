import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:http/http.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:studio_partner_app/src/features/auth/domain/usecase/get_otp.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // final ManualLocation _manualLocation;
  // final CreateUserWithEmailAndPassword _createUserWithEmailAndPassword;
  // final LoginUserWithEmailAndPassword _loginUserWithEmailAndPassword;
  // final GetLocation _getLocation;
  // final LoginWithOtp _loginWithOtp;
  final GetOtp _getOtp;
  final IsVerified _isVerified;
  AuthBloc({required GetOtp getOtp, required IsVerified isVerified})
      : _getOtp = getOtp,
        _isVerified = isVerified,
        super(AuthInitial()) {
    on<AuthEvent>((event, emit) {
      emit(LoadingState());
    });

    // LoggingIn user
//     on<LoginEvent>(
//       (event, emit) async {
//         final res = await _loginUserWithEmailAndPassword.call(event.params);

//         res.fold((l) => emit(AuthFailure(message: l.message)),
//             (r) => emit(AuthSuccess(user: r)));
//       },
//     );
//     // SigningUp User
//     on<SignUpEvent>(
//       (event, emit) async {
//         final res = await _createUserWithEmailAndPassword.call(event.params);

//         res.fold((l) => emit(AuthFailure(message: l.message)), (r) {
//           return emit(AuthSuccess(user: r));
//         });
//       },
//     );
// // Fetching User Location Automatically
//     on<FetchUserLocation>(
//       (event, emit) async {

//         final res = await _getLocation.call(event.params);

//         res.fold((l) => emit(LocationFailure(message: l.message)),
//             (r) => emit(LocationSuccess(city: r)));
//       },
//     );
// // Fetching User Location Manually
//     on<ManualLocationEvent>((event, emit) async {
//       final res = await _manualLocation.call(event.params);

//       res.fold((l) => emit(ManualLocationFailureState(message: l.message)),
//           (r) => emit(ManualLocationSuccessState(models: r)));
//     });

//     // Login using OTP
//     on<LoginWithOtpEvent>(
//       (event, emit) async {
//         final res = await _loginWithOtp.call(event.emailOrPhone);
//         res.fold((l) => emit(AuthFailure(message: l.message)),
//             (r) => emit(AuthSuccess(user: r)));
//       },
//     );

    on<GetOTP>(
      (event, emit) async {
        final res = await _getOtp.call(event.emailOrPhone);
        res.fold((l) => emit(AuthFailure(message: l.message)),
            (r) => emit(OtpSuccessState(otp: r)));
      },
    );
    on<Verification>(
      (event, emit) async {
        emit(LoadingState());
        final res = await isVerified.call(event.agentId);
        res.fold((l) => emit(AuthFailure(message: l.message)),
            (r) => emit(VerificationSuccess(status: r)));
      },
    );
  }
}
