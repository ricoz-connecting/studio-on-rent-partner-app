import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:studio_partner_app/src/feature/auth/forgotpassword/repo/recover_password_repo.dart';
import 'package:studio_partner_app/src/feature/auth/forgotpassword/views/setnewpass.dart';
import 'package:studio_partner_app/src/feature/auth/forgotpassword/views/verify_otp.dart';
import 'package:studio_partner_app/src/feature/auth/views/widgets/reset_dialog.dart';
import 'package:studio_partner_app/src/res/colors.dart';
import 'package:studio_partner_app/src/res/strings.dart';
import 'package:studio_partner_app/utils/config.dart';
import 'package:studio_partner_app/utils/snackbar_service.dart';

final recoverControllerProvider =
    StateNotifierProvider<RecoverController, bool>((ref) {
  final authRepo = ref.watch(recoverRepoProvider);
  return RecoverController(authRepo: authRepo, ref: ref);
});

class RecoverController extends StateNotifier<bool> {
  RecoverController({required RecoveryRepo authRepo, required Ref ref})
      : _authRepo = authRepo,
        _ref = ref,
        super(false);

  final RecoveryRepo _authRepo;
  final Ref _ref;

  Future<void> sendOTPForRecover(
      {required String phone, required BuildContext context}) async {
    if (!state) {
      state = true;
      _authRepo.sendOTPForRecover(phone: phone).then((response) {
        if (response != null) {
          final data = jsonDecode(response.body);
          final otpSentSuccess = data['success'];
          if (otpSentSuccess) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => VerifyOtp(
                          phoneNumber: phone,
                        )));
            SnackBarService.showSnackBar(
                context: context,
                message: data['message'],
                backgroundColor: Colors.green);

            state = false;
          } else {
            SnackBarService.showSnackBar(
                context: context,
                message: data['message'],
                backgroundColor: const Color.fromARGB(255, 211, 98, 90));
            state = false;
          }
        }
      });
    }
  }

  Future<void> verifyOTPForRecovery(
      {required String otp,
      required String phone,
      required BuildContext context}) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          backgroundColor: Colors.white,
          content: Row(
            children: [
              CircularProgressIndicator(
                color: AppColors.primaryBackgroundColor,
              ),
              SizedBox(width: 20),
              Text("Verifying..."),
            ],
          ),
        );
      },
    );
    state = true;
    _authRepo.verifyOTPForRecovery(phone: phone, otp: otp).then((response) {
      if (response != null) {
        try {
          final data = jsonDecode(response.body);
          final otpVerifiedSuccess = data['success'];

          SnackBarService.showSnackBar(
            context: context,
            message: data['message'],
            backgroundColor: otpVerifiedSuccess
                ? AppColors.primaryBackgroundColor
                : const Color.fromARGB(255, 215, 101, 93),
          );
          if (otpVerifiedSuccess) {
            context.pop();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Setnewpass(),
              ),
            );
          }
        } catch (e, stacktrace) {
          if (AppConfig.logHttp) {
            log('$e');
            log('$stacktrace');
          }
          context.pop();
          SnackBarService.showSnackBar(
              context: context,
              message: AuthenticationMessages.otpVerificationFailed,
              backgroundColor: const Color.fromARGB(255, 227, 121, 113));
        }
      }
    });
    state = false;
  }

  Future<void> setNewPassword(
      {required String newPassword,
      required String phone,
      required BuildContext context}) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          backgroundColor: Colors.white,
          content: Row(
            children: [
              CircularProgressIndicator(
                color: AppColors.primaryBackgroundColor,
              ),
              SizedBox(width: 20),
              Text("Verifying..."),
            ],
          ),
        );
      },
    );
    state = true;
    _authRepo
        .updatePassword(phone: phone, newPassword: newPassword)
        .then((response) {
      if (response != null) {
        try {
          final data = jsonDecode(response.body);
          final isSuccess = data['success'];

          SnackBarService.showSnackBar(
            context: context,
            message: data['message'],
            backgroundColor: isSuccess
                ? AppColors.primaryBackgroundColor
                : const Color.fromARGB(255, 215, 101, 93),
          );
          if (isSuccess) {
            context.pop();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Setnewpass(),
              ),
            );
          }
        } catch (e, stacktrace) {
          if (AppConfig.logHttp) {
            log('$e');
            log('$stacktrace');
          }
          context.pop();
          SnackBarService.showSnackBar(
            context: context,
            message: AuthenticationMessages.otpVerificationFailed,
            backgroundColor: const Color.fromARGB(255, 227, 121, 113),
          );
        }
      }
    });
    state = false;
  }

  Future<void> sentResetLinkOnEmail({
    required String email,
    required BuildContext context,
  }) async {
    state = true;
    _authRepo.sentResetLinkOnEmail(email: email).then((response) {
      if (response != null) {
        try {
          final data = jsonDecode(response.body);
          final isSuccess = data['success'];

          SnackBarService.showSnackBar(
            context: context,
            message: data['message'],
            backgroundColor: isSuccess
                ? AppColors.primaryBackgroundColor
                : const Color.fromARGB(255, 215, 101, 93),
          );
          if (isSuccess) {
            ResetDialog.resetDialog(context);
          }
        } catch (e, stacktrace) {
          if (AppConfig.logHttp) {
            log('$e');
            log('$stacktrace');
          }
          SnackBarService.showSnackBar(
            context: context,
            message: AuthenticationMessages.otpVerificationFailed,
            backgroundColor: const Color.fromARGB(255, 227, 121, 113),
          );
        }
      }
    });
    state = false;
  }
}
