import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:studio_partner_app/src/feature/profile/repo/availabilityRepo.dart';
import 'package:studio_partner_app/src/models/partnerAvailability.dart';
import 'package:studio_partner_app/utils/snackbar_service.dart';

final availabilityControllerProvider =
    StateNotifierProvider<AvailabilityController, Availability?>(
  (ref) {
    final repo = ref.watch(availabilityRepoProvider);

    return AvailabilityController(
      repo: repo,
      ref: ref,
    );
  },
);

class AvailabilityController extends StateNotifier<Availability?> {
  final AvailabilityRepo _repo;
  final Ref _ref;
  AvailabilityController(
      {required AvailabilityRepo repo, required Ref ref, Availability? data})
      : _repo = repo,
        _ref = ref,
        super(data);

  void updateDayAvailability({
    required String day,
    required bool isAvailable,
    String? morningStart,
    String? morningEnd,
    String? eveningStart,
    String? eveningEnd,
  }) {
    if (state == null) return;

    // Day map
    final dayMap = {
      'Monday': state!.monday,
      'Tuesday': state!.tuesday,
      'Wednesday': state!.wednesday,
      'Thursday': state!.thursday,
      'Friday': state!.friday,
      'Saturday': state!.saturday,
      'Sunday': state!.sunday,
    };

    final currentDay = dayMap[day];
    if (currentDay == null) return;

    // If unavailable → empty strings
    final String effectiveMorningStart = isAvailable
        ? (morningStart ?? currentDay.morningShift?.startTime ?? "")
        : "";
    final String effectiveMorningEnd = isAvailable
        ? (morningEnd ?? currentDay.morningShift?.endTime ?? "")
        : "";
    final String effectiveEveningStart = isAvailable
        ? (eveningStart ?? currentDay.eveningShift?.startTime ?? "")
        : "";
    final String effectiveEveningEnd = isAvailable
        ? (eveningEnd ?? currentDay.eveningShift?.endTime ?? "")
        : "";

    // Update DayAvailability
    final updatedDay = currentDay.copyWith(
      isAvailable: isAvailable,
      morningShift: NingShift(
        startTime: effectiveMorningStart,
        endTime: effectiveMorningEnd,
      ),
      eveningShift: NingShift(
        startTime: effectiveEveningStart,
        endTime: effectiveEveningEnd,
      ),
    );

    // Set new state
    state = state!.copyWith(
      monday: day == 'Monday' ? updatedDay : state!.monday,
      tuesday: day == 'Tuesday' ? updatedDay : state!.tuesday,
      wednesday: day == 'Wednesday' ? updatedDay : state!.wednesday,
      thursday: day == 'Thursday' ? updatedDay : state!.thursday,
      friday: day == 'Friday' ? updatedDay : state!.friday,
      saturday: day == 'Saturday' ? updatedDay : state!.saturday,
      sunday: day == 'Sunday' ? updatedDay : state!.sunday,
    );

    print('$day updated: isAvailable=$isAvailable');
    print('Morning Shift: ${effectiveMorningStart} - ${effectiveMorningEnd}');
    print('Evening Shift: ${effectiveEveningStart} - ${effectiveEveningEnd}');
  }

  Future<void> getAvailability({
    required BuildContext context,
    required String partnerDocId,
  }) async {
    try {
      final result = await _repo.getAvailability(partnerDocId: partnerDocId);

      result.fold(
        (failure) {
          SnackBarService.showSnackBar(
            context: context,
            message: "Failed to fetch availability: ${failure.message}",
            backgroundColor: const Color.fromARGB(255, 227, 121, 113),
          );
        },
        (response) {
          final data = jsonDecode(response.body);
          final success = data['success'];

          if (success) {
            // Deserialize your availability model here
            final availabilityData = Availability.fromJson(data['data']);

            // ✅ Update the state
            state = availabilityData;

            SnackBarService.showSnackBar(
              context: context,
              message: "Availability fetched successfully",
              backgroundColor: Colors.green,
            );
          } else {
            SnackBarService.showSnackBar(
              context: context,
              message: "Failed to fetch availability",
              backgroundColor: const Color.fromARGB(255, 215, 101, 93),
            );
          }
        },
      );
    } catch (e, stacktrace) {
      log('Error: $e', name: 'AvailabilityControllerError');
      log('Stacktrace: $stacktrace', name: 'AvailabilityControllerStacktrace');

      if (context.mounted) {
        SnackBarService.showSnackBar(
          context: context,
          message: "An unexpected error occurred",
          backgroundColor: const Color.fromARGB(255, 227, 121, 113),
        );
      }
    }
  }

  Future<void> updateAvailability({
    required BuildContext context,
    required String partnerDocId,
  }) async {
    try {
      final result = await _repo.updateAvailability(
        availability: state!,
        partnerDocId: partnerDocId,
      );

      result.fold(
        (failure) {
          SnackBarService.showSnackBar(
            context: context,
            message: "Update failed: ${failure.message}",
            backgroundColor: const Color.fromARGB(255, 227, 121, 113),
          );
        },
        (response) {
          final responseData = jsonDecode(response.body);
          final success = responseData['success'];

          SnackBarService.showSnackBar(
            context: context,
            message: success ? "Updated successfully" : "Update failed",
            backgroundColor: success
                ? Colors.green
                : const Color.fromARGB(255, 215, 101, 93),
          );
          if (success) {
            context.pop();
          }
        },
      );
    } catch (e, stacktrace) {
      log('Error: $e', name: 'AvailabilityControllerError');
      log('Stacktrace: $stacktrace', name: 'AvailabilityControllerStacktrace');

      if (context.mounted) {
        SnackBarService.showSnackBar(
          context: context,
          message: "An unexpected error occurred",
          backgroundColor: const Color.fromARGB(255, 227, 121, 113),
        );
      }
    }
  }
}
