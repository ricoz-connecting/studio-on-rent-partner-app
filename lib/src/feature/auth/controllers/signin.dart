import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:studio_partner_app/src/feature/auth/repo/signin.dart';
import 'package:studio_partner_app/src/feature/auth/views/register_one.dart';
import 'package:studio_partner_app/src/feature/profile/views/complete_profile.dart';

class Signin {
  final String email;
  final String password;
  final BuildContext context;

  Signin({
    required this.context,
    required this.email,
    required this.password,
  });

  Future<void> signInEmail() async {
    try {
      if (password.length < 6) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password must be at least 6 characters long'),
          ),
        );
        return;
      }
      final result = await SignInRepo.signIn(email, password);
      if (result == false) {
        context.mounted
            ? ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('An unexpected error occurred'),
                ),
              )
            : null;
      } else {
        context.mounted
            ? Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => CompleteProfileScreen(),
                ),
              )
            : null;
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
