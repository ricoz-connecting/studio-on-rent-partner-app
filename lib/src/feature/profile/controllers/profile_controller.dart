import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studio_partner_app/src/feature/file/controller/file_controller.dart';
import 'package:studio_partner_app/src/feature/profile/models/profile.dart';
import 'package:studio_partner_app/src/feature/profile/repo/edit_profile.dart';
import 'package:studio_partner_app/utils/snackbar_service.dart';

final profileController = StateNotifierProvider<ProfileController, Profile>(
  (ref) {
    final repo = ref.watch(profileRepoProvider);
    return ProfileController(repo: repo, ref: ref);
  },
);

class ProfileController extends StateNotifier<Profile> {
  final ProfileRepo _repo;
  final Ref _ref;
  ProfileController({required ProfileRepo repo, required Ref ref})
      : _repo = repo,
        _ref = ref,
        super(Profile()); // Initial state

  Future<void> updateProfile(
      {required BuildContext context,
      required Profile profile,
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

          if (success) {
            Navigator.of(context).pop();
          }
        },
      );
    } catch (e, stacktrace) {
      log('Error: $e');
      log('Stacktrace: $stacktrace');

      // Show error snackbar
      SnackBarService.showSnackBar(
        context: context,
        message: "An unexpected error occurred",
        backgroundColor: const Color.fromARGB(255, 227, 121, 113),
      );
    }
  }

  void selectFile(String imageType) async {
    final file = await _ref.read(fileControllerProvider).selectFile();

    if (file != null) {
      switch (imageType) {
        case 'avatar':
          state = state.copyWith(avatarFile: file);
          break;

        default:
          break;
      }
    }
  }
}
