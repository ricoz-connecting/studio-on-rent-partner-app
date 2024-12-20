import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studio_partner_app/src/feature/complains/repo/complaint_repo.dart';
import 'package:studio_partner_app/src/models/previous_complaint_model.dart';

final previousComplaintControllerProvider = StateNotifierProvider<
    PreviousComplaintController, List<PreviousComplaintModel>>((ref) {
  final complaintRepo = ref.read(complaintRepoProvider);
  return PreviousComplaintController(PreviousComplaintModel(), complaintRepo);
});

class PreviousComplaintController
    extends StateNotifier<List<PreviousComplaintModel>> {
  final ComplaintRepo _repo;

  PreviousComplaintController(
      PreviousComplaintModel previousComplaint, this._repo)
      : super([]);

  Future<void> getComplaintDetails(String id) async {
    try {
      final result = await _repo.getComplaintDetails(id);
      result.fold(
        (failure) {
          log('Failure: $failure');
        },
        (response) {
          final data = jsonDecode(response.body);
          final complaintList = data['data'] as List;
          final complaints = complaintList
              .map((complaint) => PreviousComplaintModel.fromJson(complaint))
              .toList();
          state = complaints;
        },
      );
    } catch (e, stacktrace) {
      log('Error: $e');
      log('Stacktrace: $stacktrace');
    }
  }
}
