import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/feature/Home/views/widgets/recent_transaction_widget.dart';

class TransactionHistory extends StatelessWidget {
  final List<Widget> recentTransaction = [
    const RecentTransactionWidget(),
    const RecentTransactionWidget(),
  ];
  TransactionHistory({super.key});

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
            return recentTransaction[index];
          }),
    );
  }
}
