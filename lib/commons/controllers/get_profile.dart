import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:studio_partner_app/commons/controllers/shared_prefs_controller.dart';
import 'package:studio_partner_app/commons/views/providers/authprovider.dart';
import 'package:studio_partner_app/commons/views/providers/profileprovider.dart';
import 'package:studio_partner_app/src/core/api.dart';
import 'package:studio_partner_app/src/feature/profile/models/profile.dart';
import 'package:studio_partner_app/src/models/user_model.dart';
import 'package:studio_partner_app/src/res/endpoints.dart';
import 'package:studio_partner_app/utils/router.dart';

// class GetProfile {
//   static Future<bool> getProfile(BuildContext context, WidgetRef ref) async {
//     final authToken = ref.watch(authTokenProvider);
//     final response = await GetProfileRepo.getProfile(authToken!, context);
//     if (response.email != null || response.phone != null) {
//       ref.read(profileProvider.notifier).setProfile(response);
//       log('Profile fetched successfully', name: 'GetProfile');
//       return true;
//     }
//     return false;
//   }
// }

class GetProfile {
  static Future<void> getProfile(
      BuildContext context, WidgetRef ref, Ref _ref) async {
    final api = ref.watch(apiProvider);
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
        ref.read(profileProvider.notifier).setProfile(profile);
        final user = User.fromJson(responseBody['data']);
        _ref.read(sharedPrefsControllerPovider).setUser(user: user);
        _ref.read(currentUserProvider.notifier).update((state) => user);
        context.go(StudioRoutes.bottomNavBar, extra: profile);
      }
    });
  }
}
