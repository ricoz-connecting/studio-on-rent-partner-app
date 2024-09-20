import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:studio_partner_app/src/core/api.dart';
import 'package:studio_partner_app/src/feature/auth/repo/signup.dart';
import 'package:studio_partner_app/utils/router.dart';

class SignupEmail {
  final String email;
  final String password;
  final String confirmPassword;
  final BuildContext context;
  API api = API(authToken: '');

  SignupEmail({
    required this.context,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  Future<void> signUpEmail() async {
    try {
      if (password != confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password does not match'),
          ),
        );
        return;
      }
      if (password.length < 6) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password must be at least 6 characters long'),
          ),
        );
        return;
      }
      final result = await SignupRepo.signup(email, password);
      if (result == false) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('An unexpected error occurred'),
            ),
          );
        }
      } else {
        if (context.mounted) {
          GoRouter.of(context).go(StudioRoutes.loginViaEmailScreen);
        }
      }
    } catch (e) {
      log(e.toString());
      context.mounted
          ? ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('An unexpected error occurred'),
              ),
            )
          : null;
    }
  }
}
