import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studio_partner_app/commons/views/providers/authprovider.dart';
import 'package:studio_partner_app/src/feature/Home/views/empyt_bookings.dart';
import 'package:studio_partner_app/src/feature/Home/views/widgets/service_card.dart';
import 'package:flutter/material.dart';
import 'package:studio_partner_app/src/res/colors.dart';

import '../../../../commons/views/appbar.dart';

class Bookings extends ConsumerWidget {
  const Bookings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(statusProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Appbar.buildAppBar(context, ref),
      body: status?.kycStatus != 'Success'
          ? const EmpytBookings()
          : Column(
              children: [
                DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: TabBar(
                          indicatorPadding: const EdgeInsets.all(5),
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicator: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.grey,
                          labelStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          unselectedLabelStyle: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                          ),
                          tabs: const [
                            Tab(
                              text: 'Active',
                            ),
                            Tab(
                              text: 'Completed',
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.72,
                        width: double.infinity,
                        child: const TabBarView(
                          children: <Widget>[
                            ActiveRequests(),
                            CompletedRequests()
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

class ActiveRequests extends StatelessWidget {
  const ActiveRequests({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      children: const [
        SizedBox(height: 20),
        ServiceCard(
          isComingFromActive: true,
          id: "12333",
          address: "123, XYZ Apt. New Delhi, Delhi, 123456",
          customerName: 'Shreya',
          daysLeft: '(19/30 Days)',
          nextBillingDate: '04/11/2023',
          studioName: 'Studio A',
          bookingStartDate: '31/08/2024',
          bookingEndDate: '31/10/2024',
          duration: '1 Month',
        ),
      ],
    );
  }
}

class CompletedRequests extends StatelessWidget {
  const CompletedRequests({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      children: const [
        SizedBox(height: 20),
        ServiceCard(
          isComingFromActive: false,
          id: "12333",
          address: "123, XYZ Apt. New Delhi, Delhi, 123456",
          customerName: 'Shreya',
          daysLeft: 'Completed',
          nextBillingDate: '\$550',
          studioName: 'Studio A',
          bookingStartDate: '31/08/2024',
          bookingEndDate: '31/10/2024',
          duration: '1 Month',
        ),
      ],
    );
  }
}
