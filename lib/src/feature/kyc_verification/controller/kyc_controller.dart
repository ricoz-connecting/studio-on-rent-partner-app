import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studio_partner_app/src/feature/file/controller/file_controller.dart';
import 'package:studio_partner_app/src/feature/kyc_verification/repo/kyc_repo.dart';
import 'package:studio_partner_app/utils/snackbar_service.dart';

import '../models/kyc_models.dart';

final kycControllerProvider = StateNotifierProvider<KycController, KYC>(
  (ref) {
    final repo = ref.watch(kycRepoProvider);
    return KycController(repo: repo, ref: ref, kyc: KYC());
  },
);

class KycController extends StateNotifier<KYC> {
  final KycRepo _repo;
  final Ref _ref;

  KycController({required KycRepo repo, required Ref ref, required KYC kyc})
      : _repo = repo,
        _ref = ref,
        super(kyc);

  Future<void> uploadKyc({
    required BuildContext context,
  }) async {
    print('Uploading KYC');

    try {
      final result = await _repo.uploadKyc(
        type: state.documentType!,
        name: state.nameOnDocument!,
        number: state.documentNumber!,
        frontImage: state.frontFile!,
        backImage: state.backFile!,
      );
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
      print('File selected: ${file.path}');
      switch (imageType) {
        case 'front':
          state = state.copyWith(frontFile: file);
          print('Updated frontFile: ${state.frontFile?.path}');
          break;
        case 'back':
          state = state.copyWith(backFile: file);
          print('Updated backFile: ${state.backFile?.path}');
          break;
      }
      print('Current KYC State: ${state.toJson()}');
    } else {
      print('No file selected');
    }
  }

  void updateKyc({
    String? name,
    String? number,
    String? type,
    File? frontFile,
    File? backFile,
  }) {
    state = state.copyWith(
      nameOnDocument: name ?? state.nameOnDocument,
      documentNumber: number ?? state.documentNumber,
      documentType: type ?? state.documentType,
    );
    print('Updated KYC State: ${state.toJson()}');
  }
}
