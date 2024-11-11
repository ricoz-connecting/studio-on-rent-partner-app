import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studio_partner_app/src/feature/addstudio/repo/studio_repo.dart';
import 'package:studio_partner_app/src/models/studio_model.dart';
import 'package:studio_partner_app/utils/snackbar_service.dart';

final studioControllerProvider =
    StateNotifierProvider<StudioController, Studio?>(
  (ref) {
    final repo = ref.watch(studioRepoProvider);
    return StudioController(repo: repo, ref: ref);
  },
);

class StudioController extends StateNotifier<Studio?> {
  final StudioRepo _repo;
  final Ref _ref;
  StudioController({required StudioRepo repo, required Ref ref})
      : _repo = repo,
        _ref = ref,
        super(null);

  Future<void> addNewStudio({
    required BuildContext context,
    required Studio studio,
    required File? thumbnail,
    required List<File?> images,
  }) async {
    try {
      final result = await _repo.createStudio(
          body: studio.toJson(),
          thumbnail: thumbnail ?? File(''),
          images: images);
      result.fold(
        (failure) {
          SnackBarService.showSnackBar(
            context: context,
            message: "Studio Added failed: ${failure.message}",
            backgroundColor: const Color.fromARGB(255, 227, 121, 113),
          );
        },
        (response) {
          final data = jsonDecode(response!.body);
          final success = data['success'];

          SnackBarService.showSnackBar(
            context: context,
            message: success
                ? "Warehouse Added Successfully"
                : "Warehouse Added Failed",
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
      context.mounted
          ? SnackBarService.showSnackBar(
              context: context,
              message: "An unexpected error occurred",
              backgroundColor: const Color.fromARGB(255, 227, 121, 113),
            )
          : null;
    }
  }
}
