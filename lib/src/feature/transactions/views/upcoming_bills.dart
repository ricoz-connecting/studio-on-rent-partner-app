import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
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
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Upcoming Bills',
            style: GoogleFonts.lato(),
          ),
        ),
        body: Center(
          child: Lottie.asset(
            AnimationAssets.noDataFound,
            width: 200,
            height: 200,
          ),
        )
        // ListView.builder(
        //     itemCount: upcomingBills.length,
        //     itemBuilder: (context, index) {
        //       return upcomingBills[index];
        //     }),
        );
  }
}
