import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studio_partner_app/utils/router.dart';

class Logout {
  static Future<void> logout(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    context.mounted
        ? GoRouter.of(context).go(StudioRoutes.landingScreen)
        : null;
  }
}
