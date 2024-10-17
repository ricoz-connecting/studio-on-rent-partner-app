import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studio_partner_app/commons/repo/status_repo.dart';
import 'package:studio_partner_app/commons/views/providers/authprovider.dart';
import 'package:studio_partner_app/src/models/status_model.dart';
import 'package:studio_partner_app/utils/snackbar_service.dart';

final statusControllerProvider = StateNotifierProvider<StatusController, bool>(
  (ref) {
    final repo = ref.watch(statusRepoProvider);
    return StatusController(
      repo: repo,
      ref: ref,
    );
  },
);

class StatusController extends StateNotifier<bool> {
  final StatusRepo _repo;
  final Ref _ref;

  StatusController({required StatusRepo repo, required Ref ref})
      : _repo = repo,
        _ref = ref,
        super(false);

  Future<void> getStatus({
    required BuildContext context,
  }) async {
    try {
      final result = await _repo.getStatus();
      result.fold(
        (failure) {
          SnackBarService.showSnackBar(
            context: context,
            message: "failed: ${failure.message}",
            backgroundColor: const Color.fromARGB(255, 227, 121, 113),
          );
        },
        (response) {
          // Handle the success case
          final data = jsonDecode(response.body);
          // log('Data: $data');
          final success = data['success'];
          final status = data['data'];

          final statusData = Status.fromJson(status);
          _ref.read(statusProvider.notifier).update((state) => statusData);
          // SnackBarService.showSnackBar(
          //   context: context,
          //   message: success ? "Successfully" : "Failed",
          //   backgroundColor: success
          //       ? Colors.green
          //       : const Color.fromARGB(255, 215, 101, 93),
          // );
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
}
