import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:studio_partner_app/commons/controllers/shared_prefs_controller.dart';
import 'package:studio_partner_app/commons/views/providers/authprovider.dart';
import 'package:studio_partner_app/src/feature/auth/repo/auth_repo.dart';
import 'package:studio_partner_app/src/models/user_model.dart';
import 'package:studio_partner_app/src/res/strings.dart';
import 'package:studio_partner_app/utils/router.dart';
import 'package:studio_partner_app/utils/snackbar_service.dart';

import '../../../../commons/views/widgets/progressdialog.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  final authRepo = ref.watch(authRepoProvider);
  return AuthController(authRepo: authRepo, ref: ref);
});

class AuthController extends StateNotifier<bool> {
  AuthController({required AuthRepo authRepo, required Ref ref})
      : _authRepo = authRepo,
        _ref = ref,
        super(false);

  final AuthRepo _authRepo;
  final Ref _ref;

  Future<void> loginUsingPhone(
      {required String phone,
      required bool resend,
      required BuildContext context}) async {
    if (!state) {
      state = true;
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const ProgressDialog(
                status: 'Please wait...',
              ));
      _authRepo.loginUsingPhone(phone: phone).then((otpSentSuccess) {
        if (otpSentSuccess) {
          context.mounted
              ? SnackBarService.showSnackBar(
                  context: context,
                  message: AuthenticationMessages.otpSendSuccessfully,
                  backgroundColor: Colors.green)
              : null;
          if (!resend && context.mounted) {
            context.push(StudioRoutes.sendOtpScreen, extra: phone);
          }
          state = false;
        } else {
          context.mounted
              ? SnackBarService.showSnackBar(
                  context: context,
                  message: phone,
                  backgroundColor: const Color.fromARGB(255, 211, 98, 90))
              : null;
          state = false;
        }
      });
    }
  }

  Future<void> verifyOtp(
      {required String otp,
      required String phone,
      required BuildContext context}) async {
    state = true;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const ProgressDialog(
              status: 'Please wait...',
            ));
    _authRepo.verifyOTP(phone: phone, otp: otp).then((response) {
      if (response != null) {
        try {
          final data = jsonDecode(response.body);
          final otpVerifiedSuccess = data['success'];

          context.mounted
              ? SnackBarService.showSnackBar(
                  context: context,
                  message: otpVerifiedSuccess
                      ? AuthenticationMessages.otpVerificationSuccess
                      : AuthenticationMessages.otpVerificationFailed,
                  backgroundColor: otpVerifiedSuccess
                      ? Colors.green
                      : const Color.fromARGB(255, 215, 101, 93),
                )
              : null;
          final token = data['token'];
          final partnerDetails = data['partnerDetails'];
          // log(partnerDetails);
          if (token != null) {
            _ref.read(sharedPrefsControllerPovider).setCookie(cookie: token);
            _ref.read(authTokenProvider.notifier).update((state) => token);
          }
          final user = User.fromJson(partnerDetails);
          state = false;
          _ref.read(sharedPrefsControllerPovider).setUser(user: user);
          _ref.read(currentUserProvider.notifier).update((state) => user);
          context.mounted ? context.go(StudioRoutes.createProfileScreen) : null;
        } catch (e, stacktrace) {
          log('$e');
          log('$stacktrace');
          context.mounted
              ? SnackBarService.showSnackBar(
                  context: context,
                  message: AuthenticationMessages.otpVerificationFailed,
                  backgroundColor: const Color.fromARGB(255, 227, 121, 113))
              : null;
        }
      }
    });
    state = false;
  }

  Future<void> signUpUsingEmailPass(
      {required String email,
      required String password,
      required BuildContext context}) async {
    if (!state) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const ProgressDialog(
                status: 'Please wait...',
              ));
      state = true;
      _authRepo
          .signUpUsingEmailPass(email: email, password: password)
          .then((response) {
        if (response != null) {
          try {
            final data = jsonDecode(response.body);
            final success = data['success'];

            context.mounted
                ? SnackBarService.showSnackBar(
                    context: context,
                    message: success
                        ? AuthenticationMessages.signInSuccess
                        : AuthenticationMessages.signInFailed,
                    backgroundColor: success
                        ? Colors.green
                        : const Color.fromARGB(255, 215, 101, 93),
                  )
                : null;
            context.mounted
                ? context.go(StudioRoutes.loginViaEmailScreen)
                : null;
          } catch (e, stacktrace) {
            context.mounted ? context.pop() : null;
            log('$e');
            log('$stacktrace');
            context.mounted
                ? SnackBarService.showSnackBar(
                    context: context,
                    message: AuthenticationMessages.otpVerificationFailed,
                    backgroundColor: const Color.fromARGB(255, 227, 121, 113))
                : null;
          }
        }
      });
      state = false;
    }
  }

  Future<void> signInUsingEmailPass(
      {required String email,
      required String password,
      required BuildContext context}) async {
    state = true;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const ProgressDialog(
              status: 'Please wait...',
            ));
    _authRepo
        .signInUsingEmailPass(email: email, password: password)
        .then((response) {
      if (response != null) {
        try {
          final data = jsonDecode(response.body);
          final success = data['success'];

          context.mounted
              ? SnackBarService.showSnackBar(
                  context: context,
                  message: success
                      ? AuthenticationMessages.signInSuccess
                      : AuthenticationMessages.signInFailed,
                  backgroundColor: success
                      ? Colors.green
                      : const Color.fromARGB(255, 215, 101, 93),
                )
              : null;
          final token = data['token'];
          final partnerDetails = data['partnerDetails'];

          if (token != null) {
            _ref.read(sharedPrefsControllerPovider).setCookie(cookie: token);
            _ref.read(authTokenProvider.notifier).update((state) => token);
          }
          final user = User.fromJson(partnerDetails);
          state = false;
          _ref.read(sharedPrefsControllerPovider).setUser(user: user);
          _ref.read(currentUserProvider.notifier).update((state) => user);
          context.mounted ? context.go(StudioRoutes.createProfileScreen) : null;
        } catch (e, stacktrace) {
          context.mounted ? context.pop() : null;
          log('$e');
          log('$stacktrace');
          context.mounted
              ? SnackBarService.showSnackBar(
                  context: context,
                  message: AuthenticationMessages.signInFailed,
                  backgroundColor: const Color.fromARGB(255, 227, 121, 113))
              : null;
        }
      }
    });
    state = false;
  }

  Future<void> signOut(BuildContext context) async {
    // _ref.read(authTokenProvider.notifier).update((state) => null);
    // _ref.read(currentUserProvider.notifier).update((state) => null);
    final authTokenState = _ref.read(authTokenProvider);
    if (authTokenState != null) {
      _ref.read(authTokenProvider.notifier).update((_) => null);
    }
    _ref.read(sharedPrefsControllerPovider).clear();
    GoRouter.of(context).go(StudioRoutes.landingScreen);
  }
}
