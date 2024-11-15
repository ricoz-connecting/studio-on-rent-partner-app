import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:studio_partner_app/src/models/studio_model.dart';

import '../../../../utils/router.dart';
import '../../../../utils/snackbar_service.dart';
import '../repo/studio_list_repo.dart';

final studioListControllerProvider =
    StateNotifierProvider<StudioListController, List<Studio>>(
  (ref) {
    final repo = ref.watch(studioListRepoProvider);
    return StudioListController(repo: repo, ref: ref);
  },
);

class StudioListController extends StateNotifier<List<Studio>> {
  final StudioListRepo _repo;

  StudioListController({required StudioListRepo repo, required Ref ref})
      : _repo = repo,
        super([]);

  Future<void> getStudioList({required String type}) async {
    // state = [];
    final result = await _repo.getstudioList(type: type);
    if (result != null && result.statusCode == 200) {
      final data = jsonDecode(result.body);
      final studioData = data['data'] as List<dynamic>;
      List<Studio> studios = studioData
          .map((studio) => Studio.fromJson(studio as Map<String, dynamic>))
          .toList();
      state = studios;
    } else {
      throw Exception('Failed to fetch products');
    }
  }

  Future<void> updatestudioStatus(String studioId, bool isActive) async {
    // Step 1: Update the status in MongoDB
    final result = await _repo.updateStudio(id: studioId, isActive: isActive);
    if (result != null && result.statusCode == 200) {
      // Step 2: Update the status in the state
    } else {
      throw Exception('Failed to update studio status');
    }
  }

  Future<void> deleteStudio({
    required BuildContext context,
    required String studioId,
  }) async {
    try {
      final result = await _repo.deleteStudio(studioId: studioId);
      result.fold(
        (failure) {
          SnackBarService.showSnackBar(
            context: context,
            message: "Studio Delete failed: ${failure.message}",
            backgroundColor: const Color.fromARGB(255, 227, 121, 113),
          );
        },
        (response) {
          final data = jsonDecode(response!.body);
          final success = data['success'];

          SnackBarService.showSnackBar(
            context: context,
            message: success
                ? "Studio Deleted Successfully"
                : "Studio Delete Failed",
            backgroundColor: success
                ? Colors.green
                : const Color.fromARGB(255, 215, 101, 93),
          );

          if (success) {
            GoRouter.of(context).replace(StudioRoutes.bookings);
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
