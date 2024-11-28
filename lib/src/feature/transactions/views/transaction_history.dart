import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/feature/Home/views/widgets/recent_transaction_widget.dart';
import 'package:studio_partner_app/src/models/earnings_withdrawal.dart';

class TransactionHistory extends StatelessWidget {
  final List<EarningsHistory> recentTransaction;
  const TransactionHistory({required this.recentTransaction, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Transaction History',
          style: GoogleFonts.lato(),
        ),
      ),
      body: ListView.builder(
          itemCount: recentTransaction.length,
          itemBuilder: (context, index) {
            return RecentTransactionWidget(
              recentTransaction: recentTransaction[index],
            );
          }),
    );
  }
}
