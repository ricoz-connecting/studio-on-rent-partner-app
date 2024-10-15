import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/feature/transactions/views/widgets/withdrawal_hitsory_widget.dart';

class WithdrawalHistory extends StatelessWidget {
  final withdrawalHistory = [
    const WithdrawalHitsoryWidget(),
    const WithdrawalHitsoryWidget(),
  ];
  WithdrawalHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Withdrawal History',
          style: GoogleFonts.lato(),
        ),
      ),
      body: ListView.builder(
          itemCount: withdrawalHistory.length,
          itemBuilder: (context, index) {
            return withdrawalHistory[index];
          }),
    );
  }
}
