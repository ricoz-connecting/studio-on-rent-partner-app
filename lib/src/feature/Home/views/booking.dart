import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studio_partner_app/src/feature/Home/views/service_card.dart';
import 'package:flutter/material.dart';
import 'package:studio_partner_app/src/res/colors.dart';

import '../../../../commons/views/appbar.dart';

class Bookings extends ConsumerWidget {
  const Bookings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: Appbar.buildAppBar(context, ref),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Navigate to Active screen
                    },
                    child: Column(
                      children: [
                        Text(
                          'Active (3)',
                          style: TextStyle(
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate to Delivered screen
                    },
                    child: const Column(
                      children: [
                        Text(
                          'Delivered (4)',
                          style: TextStyle(
                            color: AppColors.primaryBackgroundColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate to New Requests screen
                    },
                    child: Column(
                      children: [
                        Text(
                          'New Requests (2)',
                          style: TextStyle(
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0), // Added padding
                  children: const [
                    SizedBox(height: 20),
                    ServiceCard(
                      id: "12333",
                      serviceName: "Warehouse Service",
                      nextServiceDate: "04/11/2023",
                      noOfPeople: "100",
                      address: "123, XYZ Apt. New Delhi, Delhi, 123456",
                      isBilling: true,
                    ),
                    SizedBox(height: 10),
                    ServiceCard(
                      id: "12363",
                      serviceName: "Warehouse Service",
                      nextServiceDate: "04/11/2023",
                      noOfPeople: "100",
                      address: "123, XYZ Apt. New Delhi, Delhi, 123456",
                      isBilling: true,
                    ),
                    SizedBox(height: 10),
                    ServiceCard(
                      id: "12349",
                      serviceName: "Kitchen Cleaner",
                      nextServiceDate: "05/11/2023 09:00AM - 12:00PM",
                      noOfPeople: "1",
                      address: "123, XYZ Apt. New Delhi, Delhi, 123456",
                      isBilling: false,
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}