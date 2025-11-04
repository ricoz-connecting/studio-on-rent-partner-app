import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studio_partner_app/src/feature/complains/repo/complaint_repo.dart';
import 'package:studio_partner_app/utils/snackbar_service.dart';

import '../../../models/complaint_model.dart';

final complaintControllerProvider =
    StateNotifierProvider<ComplaintController, Complaint>((ref) {
  final complaintRepo = ref.read(complaintRepoProvider);
  return ComplaintController(
      complaint: Complaint(), repo: complaintRepo, ref: ref);
});

class ComplaintController extends StateNotifier<Complaint> {
  final ComplaintRepo _repo;

  ComplaintController(
      {required Complaint complaint,
      required ComplaintRepo repo,
      required Ref ref})
      : _repo = repo,
        super(Complaint());
  Future<void> getComplaintsDetails(String complaintDocId) async {
    try {
      final result = await _repo.getComplaintDetails(complaintDocId);
      result.fold(
        (failure) {
          log('Failure: $failure');
        },
        (response) {
          final data = jsonDecode(response.body);
          final complaintData = data['data'];
          final complaint = Complaint.fromJson(complaintData);
          state = complaint;
        },
      );
    } catch (e, stacktrace) {
      log('Error: $e');
      log('Stacktrace: $stacktrace');
    }
  }

  Future<void> addComplaint({
    required BuildContext context,
    required String title,
    required String description,
    File? file,
  }) async {
    try {
      final result = await _repo.addComplaint(
          title: title, description: description, file: file);
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
                ? "Complaint Added successfully"
                : " Complaint Added failed",
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
