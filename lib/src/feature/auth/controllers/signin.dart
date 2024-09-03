import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studio_partner_app/src/core/api.dart';
import 'package:studio_partner_app/src/feature/navigation/navigation_page.dart';
import 'package:studio_partner_app/src/res/endpoints.dart';

class Signin {
  final String email;
  final String password;
  final BuildContext context;
  API api = API(authToken: '');

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
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final result = await api.postRequest(
        url: Endpoints.loginEmail,
        body: {
          "email": email,
          "password": password,
          "deviceType": "PartnerApp",
        },
        requireAuth: false,
      );
      result.fold(
        (failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(failure.message),
            ),
          );
        },
        (response) async {
          final Map<String, dynamic> responseBody = jsonDecode(response.body);
          if (responseBody['success'] == false) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(responseBody['message']),
              ),
            );
          } else {
            await prefs.setString("token", responseBody['token']);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const BottomNavBar(),
              ),
            );
          }
        },
      );
    } catch (e) {
      log(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An unexpected error occurred'),
        ),
      );
    }
  }
}
