import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studio_partner_app/src/core/api.dart';
import 'package:studio_partner_app/src/feature/profile/views/profile_screen.dart';
import 'package:studio_partner_app/src/res/endpoints.dart';
import 'package:studio_partner_app/commons/views/providers/authprovider.dart';
import '../../src/feature/profile/models/profile.dart';

class GetProfile {
  Future<void> getProfile(BuildContext context, WidgetRef ref) async {
    final authToken = ref.watch(authprovider);
    API api = API(authToken: authToken);
    final response = await api.getRequest(url: Endpoints.getProfile);
    response.fold((error) {
      log(error.toString(), name: 'GetProfile');
    }, (response) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (responseBody['success'] == false) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(responseBody['message']),
          ),
        );
      } else {
        Profile profile = Profile.fromJson(responseBody['data']);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileScreen(
              profile: profile,
            ),
          ),
        );
      }
    });
  }
}
