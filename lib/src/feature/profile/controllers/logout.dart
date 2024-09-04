import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../auth/views/signup.dart';

class Logout {
  static Future<void> logout(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const Signup()),
        (route) => false);
  }
}
