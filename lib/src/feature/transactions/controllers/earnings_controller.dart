import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/earnings_withdrawal.dart';
import '../repo/earnings_repo.dart';

final earningsControllerProvider =
    StateNotifierProvider<EarningsController, Earnings?>(
  (ref) {
    final repo = ref.watch(earningsRepoProvider);
    return EarningsController(repo: repo, ref: ref);
  },
);

class EarningsController extends StateNotifier<Earnings?> {
  final EarningsRepo _repo;
  final Ref _ref;
  EarningsController({required EarningsRepo repo, required Ref ref})
      : _repo = repo,
        _ref = ref,
        super(null);

  Future<void> getEarnings({required BuildContext context}) async {
    try {
      final result = await _repo.getEarnings();
      result.fold(
        (failure) {
          // SnackBarService.showSnackBar(
          //   context: context,
          //   message: "Earnings Fetching failed: ${failure.message}",
          //   backgroundColor: const Color.fromARGB(255, 227, 121, 113),
          // );
        },
        (response) {
          final data = jsonDecode(response!.body);
          final success = data['success'];
          if (success) {
            
            state = Earnings.fromJson(data['data']);
          }

          // SnackBarService.showSnackBar(
          //   context: context,
          //   message:
          //       success ? "Earnings Fetched Successfully" : "Earnings Fetching failed",
          //   backgroundColor: success
          //       ? Colors.green
          //       : const Color.fromARGB(255, 215, 101, 93),
          // );
        },
      );
    } catch (e, stacktrace) {
      log('Error: $e');
      log('Stacktrace: $stacktrace');
    }
  }
}
