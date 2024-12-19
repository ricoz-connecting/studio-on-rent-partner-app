import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:studio_partner_app/src/feature/bookings/controller/bookings_controller.dart';
import 'package:studio_partner_app/src/res/assets.dart';
import 'widgets/service_card.dart';

class ActiveRequests extends ConsumerStatefulWidget {
  const ActiveRequests({super.key});

  @override
  ConsumerState<ActiveRequests> createState() => _ActiveRequestsState();
}

class _ActiveRequestsState extends ConsumerState<ActiveRequests> {
  bool isLoading = true;

  @override
  void initState() {
    _getBookings();
    super.initState();
  }

  Future<void> _getBookings() async {
    await ref.read(bookingsControllerProvider.notifier).getBookings();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bookings = ref.watch(bookingsControllerProvider);
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : bookings.isEmpty
            ? Center(
                child: SizedBox(
                  width: 300,
                  height: 300,
                  child: Lottie.asset(AnimationAssets.noDataFound),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                itemCount: bookings.length,
                itemBuilder: (context, index) => ServiceCard(
                  booking: bookings[index],
                  isComingFromActive: true,
                ),
              );
  }
}
