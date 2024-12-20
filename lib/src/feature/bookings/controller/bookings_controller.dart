import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studio_partner_app/src/feature/bookings/repo/bookings_repo.dart';
import 'package:studio_partner_app/src/models/bookings.dart';

final bookingsControllerProvider =
    StateNotifierProvider<BookingsController, List<Booking>>(
  (ref) {
    final repo = ref.watch(bookingsRepoProvider);
    return BookingsController(repo: repo);
  },
);

class BookingsController extends StateNotifier<List<Booking>> {
  final BookingsRepo _repo;

  BookingsController({required BookingsRepo repo})
      : _repo = repo,
        super([]);

  Future<void> getBookings() async {
    final result = await _repo.getBookings();
    if (result != null && result.statusCode == 200) {
      final data = jsonDecode(result.body);
      final bookingsData = data['data'] as List<dynamic>;
      List<Booking> bookings = bookingsData
          .map((booking) => Booking.fromJson(booking as Map<String, dynamic>))
          .toList();
      state = bookings;
    } else {
      throw Exception('Failed to fetch bookings');
    }
  }
}
