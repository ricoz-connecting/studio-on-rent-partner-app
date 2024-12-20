import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studio_partner_app/src/feature/transactions/repo/earnings_history_repo.dart';
import '../../../models/earnings_withdrawal.dart';
import '../repo/withdrawal_history_repo.dart';

final withdrawalHistoryControllerProvider =
    StateNotifierProvider<WithdrawalHistoryController, List<WithdrawalHistory>>(
  (ref) {
    final repo = ref.watch(withdrawalHistoryRepoProvider);
    return WithdrawalHistoryController(repo: repo, ref: ref);
  },
);

class WithdrawalHistoryController extends StateNotifier<List<WithdrawalHistory>> {
  final WithdrawalHistoryRepo _repo;
  final Ref _ref;
  WithdrawalHistoryController(
      {required WithdrawalHistoryRepo repo, required Ref ref})
      : _repo = repo,
        _ref = ref,
        super([]);

  Future<void> getWithdrawHistory({required BuildContext context}) async {
    try {
      final result = await _repo.getWithdrawalHistory();
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
                .map<WithdrawalHistory>(
                  (e) => WithdrawalHistory.fromJson(e),
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
