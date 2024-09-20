import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:studio_partner_app/src/core/api.dart';
import 'package:studio_partner_app/src/feature/auth/views/register_one.dart';
import 'package:studio_partner_app/src/res/endpoints.dart';

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
      final result = await api.postRequest(
        url: Endpoints.signupEmail,
        body: {
          "email": email,
          "password": password,
          "phone": "+919999999999",
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
        (response) {
          final Map<String, dynamic> responseBody = jsonDecode(response.body);
          if (responseBody['success'] == false) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(responseBody['message']),
              ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const RegisterScreen(),
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