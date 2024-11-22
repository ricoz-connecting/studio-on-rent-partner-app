import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studio_partner_app/src/models/bank_details_model.dart';
import 'package:studio_partner_app/utils/snackbar_service.dart';

import '../repo/bank_repo.dart';

final bankControllerProvider =
    StateNotifierProvider<BankController, List<Banks>>((ref) {
  final bankRepo = ref.read(bankRepoProvider);
  return BankController(repo: bankRepo, ref: ref);
});

class BankController extends StateNotifier<List<Banks>> {
  final BankRepo _repo;
  final Ref _ref;

  BankController({required BankRepo repo, required Ref ref})
      : _repo = repo,
        _ref = ref,
        super([]);

  // Fetch bank details
  Future<void> getBankDetails() async {
    try {
      final result = await _repo.getBankDetails();
      result.fold(
        (failure) {
          log('Failure: $failure');
        },
        (response) {
          final data = jsonDecode(response.body);
          if (data['success'] == false) {
            return state = [];
          }
          final bankList = data['data'] as List;
          final bankDetails =
              bankList.map((bank) => Banks.fromJson(bank)).toList();
          state = bankDetails;
        },
      );
    } catch (e, stacktrace) {
      log('Error: $e');
      log('Stacktrace: $stacktrace');
    }
  }

  // Add a new bank detail
  Future<void> addBankDetail({
    required BuildContext context,
    required String bankName,
    required String accountHolderName,
    required String accountNumber,
    required String ifscCode,
    required bool primary,
  }) async {
    try {
      final result = await _repo.addBankDetail(
        bankName: bankName,
        accountHolderName: accountHolderName,
        accountNumber: accountNumber,
        ifscCode: ifscCode,
        primary: primary,
      );
      result.fold(
        (failure) {
          SnackBarService.showSnackBar(
            context: context,
            message: "Failed to add bank detail: ${failure.message}",
            backgroundColor: const Color.fromARGB(255, 227, 121, 113),
          );
        },
        (response) {
          final data = jsonDecode(response.body);
          final success = data['success'];

          SnackBarService.showSnackBar(
            context: context,
            message: success
                ? "Bank detail added successfully"
                : "Failed to add bank detail",
            backgroundColor: success
                ? Colors.green
                : const Color.fromARGB(255, 215, 101, 93),
          );

          if (success) {
            Navigator.of(context).pop();
            getBankDetails(); // Refresh the list after adding
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

  // Delete a bank detail by ID
  Future<void> deleteBankDetail({
    required BuildContext context,
    required String bankId,
  }) async {
    try {
      final result = await _repo.deleteBankDetail(bankId);
      result.fold(
        (failure) {
          SnackBarService.showSnackBar(
            context: context,
            message: "Failed to delete bank detail: ${failure.message}",
            backgroundColor: const Color.fromARGB(255, 227, 121, 113),
          );
        },
        (response) {
          final data = jsonDecode(response.body);
          final success = data['success'];
          if (success) {
            getBankDetails(); // Refresh the list after deleting
          }

          SnackBarService.showSnackBar(
            context: context,
            message: success
                ? "Bank detail deleted successfully"
                : "Failed to delete bank detail",
            backgroundColor: success
                ? Colors.green
                : const Color.fromARGB(255, 215, 101, 93),
          );
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

  // Update a bank detail by ID
  Future<void> updateBankDetail({
    required BuildContext context,
    required String bankId,
    String? bankName,
    String? accountHolderName,
    String? accountNumber,
    String? ifscCode,
    bool? primary,
  }) async {
    try {
      final Map<String, dynamic> payload = {
        if (bankName != null) 'bankName': bankName,
        if (accountHolderName != null) 'accountHolderName': accountHolderName,
        if (accountNumber != null) 'accountNumber': accountNumber,
        if (ifscCode != null) 'IFSCcode': ifscCode,
        if (primary != null) 'primary': primary,
      };

      final result =
          await _repo.updateBankDetail(bankId: bankId, payload: payload);
      result.fold(
        (failure) {
          SnackBarService.showSnackBar(
            context: context,
            message: "Failed to update bank detail: ${failure.message}",
            backgroundColor: const Color.fromARGB(255, 227, 121, 113),
          );
        },
        (response) {
          final data = jsonDecode(response.body);
          final success = data['success'];

          SnackBarService.showSnackBar(
            context: context,
            message: success
                ? "Bank detail updated successfully"
                : "Failed to update bank detail",
            backgroundColor: success
                ? Colors.green
                : const Color.fromARGB(255, 215, 101, 93),
          );

          if (success) {
            Navigator.of(context).pop();
            getBankDetails();
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
}
