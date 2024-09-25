import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studio_partner_app/commons/repo/get_profile.dart';
import 'package:studio_partner_app/commons/views/providers/authprovider.dart';
import 'package:studio_partner_app/commons/views/providers/profileprovider.dart';

class GetProfile {
  static Future<bool> getProfile(BuildContext context, WidgetRef ref) async {
    final authToken = ref.watch(authTokenProvider);
    final response = await GetProfileRepo.getProfile(authToken!, context);
    if (response.email != null || response.phone != null) {
      ref.read(profileProvider.notifier).setProfile(response);
      log('Profile fetched successfully', name: 'GetProfile');
      return true;
    }
    return false;
  }
}
