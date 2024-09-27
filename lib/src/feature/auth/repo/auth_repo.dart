import 'dart:convert';
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:studio_partner_app/src/core/core.dart';
import 'package:studio_partner_app/src/res/endpoints.dart';
import 'package:studio_partner_app/src/res/strings.dart';

final authRepoProvider = Provider((ref) {
  final api = ref.watch(apiProvider);
  return AuthRepo(api: api);
});

class AuthRepo {
  final API _api;

  AuthRepo({required API api}) : _api = api;

  Future<bool> loginUsingPhone({required String phone}) async {
    final body = {
      "otpType": "forLogin",
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
        return false;
      },
      (Response response) {
        try {
          final data = jsonDecode(response.body);
          return data['success'];
        } catch (e) {
          log(FailureMessage.failedToParseJson, name: LogLabel.auth);
        }
        return false;
      },
    );
  }

  Future<Response?> verifyOTP(
      {required String otp, required String phone}) async {
    final body = {
      "phone": "+91$phone",
      "otp": otp,
      "deviceType": "PartnerApp",
    };
    final result = await _api.postRequest(
        url: Endpoints.mobileLogin, body: body, requireAuth: false);
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

  Future<Response?> signUpUsingEmailPass(
      {required String email,
      // required String phone,
      required String password}) async {
    final body = {
      "email": email,
      "phone": "+919999999999",
      "password": password,
    };
    final result = await _api.postRequest(
        url: Endpoints.signupEmail, body: body, requireAuth: false);
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

  Future<Response?> signInUsingEmailPass(
      {required String email, required String password}) async {
    final body = {
      "email": email,
      "password": password,
      "deviceType": "PartnerApp",
    };
    final result = await _api.postRequest(
        url: Endpoints.loginEmail, body: body, requireAuth: false);
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
