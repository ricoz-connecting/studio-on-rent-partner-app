import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:studio_partner_app/commons/views/providers/authprovider.dart';
import 'package:studio_partner_app/src/feature/file/controller/file_controller.dart';
import 'package:studio_partner_app/src/feature/profile/models/profile.dart';
import 'package:studio_partner_app/src/feature/profile/repo/edit_profile.dart';
import 'package:studio_partner_app/utils/router.dart';
import 'package:studio_partner_app/utils/snackbar_service.dart';

import '../../../models/user_model.dart';

final profileController = StateNotifierProvider<ProfileController, User?>(
  (ref) {
    final repo = ref.watch(profileRepoProvider);
    final user = ref.watch(currentUserProvider);
    return ProfileController(repo: repo, ref: ref, user: user);
  },
);

class ProfileController extends StateNotifier<User?> {
  final ProfileRepo _repo;
  final Ref _ref;
  ProfileController(
      {required ProfileRepo repo, required Ref ref, User? user})
      : _repo = repo,
        _ref = ref,
        super(user); // Initial state

  Future<void> updateProfile(
      {required BuildContext context,
      required Profile profile,
      WidgetRef? ref,
      File? file}) async {
    try {
      final result = await _repo.updateProfile(profile: profile, file: file);
      result.fold(
        (failure) {
          SnackBarService.showSnackBar(
            context: context,
            message: "Profile update failed: ${failure.message}",
            backgroundColor: const Color.fromARGB(255, 227, 121, 113),
          );
        },
        (response) {
          // Handle the success case
          final data = jsonDecode(response.body);
          final success = data['success'];

          SnackBarService.showSnackBar(
            context: context,
            message: success
                ? "Profile updated successfully"
                : "Profile update failed",
            backgroundColor: success
                ? Colors.green
                : const Color.fromARGB(255, 215, 101, 93),
          );

          if (success)  {
            final partnerDetails = data['partner'];
            log('Partner Details: $partnerDetails', name: 'partnerDetails');
            final user = User.fromJson(partnerDetails);
            log('User: $user', name: 'ProfileController');
            // _ref.read(currentUserProvider.notifier).update((state) => user);
            // Navigator.of(context).pop();
            // GetProfile.getProfile(context, ref!, _ref);
            GoRouter.of(context).go(StudioRoutes.bottomNavBar);
          }
        },
      );
    } catch (e, stacktrace) {
      log('Error: $e');
      log('Stacktrace: $stacktrace');

      // Show error snackbar
      context.mounted
          ? SnackBarService.showSnackBar(
              context: context,
              message: "An unexpected error occurred",
              backgroundColor: const Color.fromARGB(255, 227, 121, 113),
            )
          : null;
    }
  }

  void selectFile(String imageType) async {
    final file = await _ref.read(fileControllerProvider).selectFile();

    if (file != null) {
      switch (imageType) {
        case 'avatar':
          state = state?.copyWith(avatarFile: file);
          break;

        default:
          break;
      }
    }
  }
}
