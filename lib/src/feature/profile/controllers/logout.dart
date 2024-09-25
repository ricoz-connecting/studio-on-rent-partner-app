import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studio_partner_app/src/feature/profile/repo/logout.dart';
import 'package:studio_partner_app/utils/router.dart';

class Logout {
  static Future<void> logout(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await LogoutRepo.logout();
    if (response == true) {
      await prefs.remove('token');
      context.mounted
          ? GoRouter.of(context).go(StudioRoutes.landingScreen)
          : null;
    } else {
      context.mounted
          ? ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Something went wrong'),
            ))
          : null;
    }
  }
}
