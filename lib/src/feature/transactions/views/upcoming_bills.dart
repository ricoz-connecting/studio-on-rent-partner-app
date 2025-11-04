import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:studio_partner_app/commons/views/widgets/custom_appbar.dart';
import 'package:studio_partner_app/src/feature/transactions/views/widgets/upcoming_bills.dart';

import '../../../res/assets.dart';

class UpcomingBills extends StatelessWidget {
  final upcomingBills = [
    const UpcomingBillsWidget(),
    const UpcomingBillsWidget(),
  ];
  UpcomingBills({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(title: 'Upcoming Bills'),
        body: Center(
          child: Lottie.asset(
            AnimationAssets.noDataFound,
            width: 200,
            height: 200,
          ),
        )
        // body:ListView.builder(
        //     itemCount: upcomingBills.length,
        //     itemBuilder: (context, index) {
        //       return upcomingBills[index];
        //     }),
        );
  }
}
