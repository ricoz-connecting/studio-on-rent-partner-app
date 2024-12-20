import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studio_partner_app/src/feature/transactions/repo/earnings_history_repo.dart';
import '../../../models/earnings_withdrawal.dart';

final earningsHistoryControllerProvider =
    StateNotifierProvider<EarningHistoryController, List<EarningsHistory>>(
  (ref) {
    final repo = ref.watch(earningsHistoryRepoProvider);
    return EarningHistoryController(repo: repo, ref: ref);
  },
);

class EarningHistoryController extends StateNotifier<List<EarningsHistory>> {
  final EarningsHistoryRepo _repo;
  final Ref _ref;
  EarningHistoryController(
      {required EarningsHistoryRepo repo, required Ref ref})
      : _repo = repo,
        _ref = ref,
        super([]);

  Future<void> getEarningsHistory({required BuildContext context}) async {
    try {
      final result = await _repo.getEarningHistory();
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
            final result = data['data'];
            state = result
                .map<EarningsHistory>(
                  (e) => EarningsHistory.fromJson(e),
                )
                .toList();
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
