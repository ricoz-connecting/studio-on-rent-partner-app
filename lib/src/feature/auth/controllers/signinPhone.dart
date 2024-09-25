import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:studio_partner_app/utils/router.dart';

import '../repo/signin_phone.dart';

class Signinphone {
  final String phoneNumber;
  final BuildContext context;

  Signinphone({
    required this.context,
    required this.phoneNumber,
  });

  Future<void> signInPhone(WidgetRef ref) async {
    try {
      final result = await SignInPhoneRepo.signIn(phoneNumber);
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
            ? GoRouter.of(context)
                .push(StudioRoutes.sendOtpScreen, extra: phoneNumber)
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
