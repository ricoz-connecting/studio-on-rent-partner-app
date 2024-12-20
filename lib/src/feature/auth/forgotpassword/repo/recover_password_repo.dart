import 'dart:convert';
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:studio_partner_app/src/core/api.dart';
import 'package:studio_partner_app/src/core/core.dart';
import 'package:studio_partner_app/src/res/endpoints.dart';
import 'package:studio_partner_app/src/res/strings.dart';

final recoverRepoProvider = Provider((ref) {
  final api = ref.watch(apiProvider);
  return RecoveryRepo(api: api);
});

class RecoveryRepo {
  final API _api;

  RecoveryRepo({required API api}) : _api = api;

  Future<Response?> sendOTPForRecover({required String phone}) async {
    final body = {
      "otpType": "forChangePassword",
      "phone": "+91$phone",
    };
    final result = await _api.postRequest(
      url: Endpoints.sendOtp,
      body: body,
      requireAuth: false,
    );
    return result.fold(
      (Failure failure) {
        log(
          failure.message,
          name: LogLabel.auth,
        );
        return null;
      },
      (Response response) => response,
    );
  }

  Future<Response?> verifyOTPForRecovery(
      {required String otp, required String phone}) async {
    final body = {
      "phone": "+91$phone",
      "otp": otp,
    };
    final result = await _api.postRequest(
        url: Endpoints.verifyOTPForRecovery, body: body, requireAuth: false);
    return result.fold(
      (Failure failure) {
        log(
          failure.message,
          name: LogLabel.auth,
        );
        return null;
      },
      (Response response) => response,
    );
  }

  Future<Response?> updatePassword(
      {required String newPassword, required String phone}) async {
    final body = {
      "phone": "+91$phone",
      "newPassword": newPassword,
    };
    final result = await _api.postRequest(
        url: Endpoints.updatePassword, body: body, requireAuth: false);
    return result.fold(
      (Failure failure) {
        log(
          failure.message,
          name: LogLabel.auth,
        );
        return null;
      },
      (Response response) => response,
    );
  }

  Future<Response?> sentResetLinkOnEmail({required String email}) async {
    final body = {
      "email": email,
    };
    final result = await _api.postRequest(
        url: Endpoints.resetLinkOnEmail, body: body, requireAuth: false);
    return result.fold(
      (Failure failure) {
        log(
          failure.message,
          name: LogLabel.auth,
        );
        return null;
      },
      (Response response) => response,
    );
  }
}
