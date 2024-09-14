import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studio_partner_app/commons/controllers/get_profile.dart';
import 'package:studio_partner_app/commons/repo/get_image_url.dart';
import 'package:studio_partner_app/commons/views/providers/image_upload_url.dart';
import 'package:studio_partner_app/src/feature/auth/repo/signin.dart';
import 'package:studio_partner_app/src/feature/navigation/navigation_page.dart';

import '../../../../commons/controllers/checkauth.dart';

class Signin {
  final String email;
  final String password;
  final BuildContext context;

  Signin({
    required this.context,
    required this.email,
    required this.password,
  });

  Future<void> signInEmail(WidgetRef ref) async {
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
        String token = await Checkauth.checkAuth(ref);
        Map<String, dynamic> url = await GetImageUrl.getUploadUrl();
        ref.read(imageUploadUrl.notifier).setImageUploadUrl(url['uploadUrl']);
        ref.read(keyProvider.notifier).setKey(url['key']);
        if (token != '') {
          context.mounted ? await GetProfile.getProfile(context, ref) : null;
          context.mounted
              ? Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const BottomNavBar()),
                  (route) => false)
              : null;
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
