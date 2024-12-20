import 'dart:convert';
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studio_partner_app/src/feature/banks/repo/bank_repo.dart';

class BankDetailsNotifier extends StateNotifier<Map<String, String>> {
  final BankRepo bankRepo;

  BankDetailsNotifier(this.bankRepo) : super({});

  // Method to fetch bank details by IFSC code
  Future<void> fetchBankDetails(String ifsc) async {
    try {
      final result = await bankRepo.fetchBankDetailsByIFSC(ifsc);

      result.fold(
        (failure) {
          // Handle failure (Left case)
          log('Failed to fetch bank details: $failure');
        },
        (response) {
          // Handle success (Right case)
          if (response.statusCode == 200) {
            final data = json.decode(response.body);
            if (data['success']) {
              state = {
                'IFSC': data['data']['IFSC'] ?? '',
                'BRANCH': data['data']['BRANCH'] ?? '',
                'BANK': data['data']['BANK'] ?? '',
              };
            } else {
              log('Bank details fetch unsuccessful: ${data['message']}');
            }
          } else {
            log(
                'Failed to fetch bank details. Status code: ${response.statusCode}');
          }
        },
      );
    } catch (e) {
      log('Error while fetching bank details: $e');
    }
  }

  void resetBankDetails() {
    state = {
      'IFSC': '',
      'BRANCH': '',
      'BANK': '',
    };
  }
}

final bankDetailsProvider =
    StateNotifierProvider<BankDetailsNotifier, Map<String, String>>((ref) {
  final bankRepo = ref.watch(bankRepoProvider);
  return BankDetailsNotifier(bankRepo);
});
