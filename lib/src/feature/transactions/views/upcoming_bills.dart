import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/feature/transactions/views/widgets/upcoming_bills.dart';

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
      body: ListView.builder(
          itemCount: upcomingBills.length,
          itemBuilder: (context, index) {
            return upcomingBills[index];
          }),
    );
  }
}
