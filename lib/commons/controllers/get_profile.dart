import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studio_partner_app/commons/repo/get_profile.dart';
import 'package:studio_partner_app/commons/views/providers/authprovider.dart';

class GetProfile {
  Future<void> getProfile(BuildContext context, WidgetRef ref) async {
    final authToken = ref.watch(authprovider);
    final response = await GetProfileRepo.getProfile(authToken, context);
    if (response == false) {
      context.mounted
          ? ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Failed to get profile'),
              ),
            )
          : null;
    } else {
      log('Profile fetched successfully', name: 'GetProfile');
    }
  }
}
