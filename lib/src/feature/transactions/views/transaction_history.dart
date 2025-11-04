import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:studio_partner_app/commons/views/widgets/custom_appbar.dart';
import 'package:studio_partner_app/src/feature/Home/views/widgets/recent_transaction_widget.dart';
import 'package:studio_partner_app/src/models/earnings_withdrawal.dart';
import 'package:studio_partner_app/src/res/assets.dart';

class TransactionHistory extends StatelessWidget {
  final List<EarningsHistory> recentTransaction;
  const TransactionHistory({required this.recentTransaction, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: 'Transaction History'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: recentTransaction.isEmpty
            ? Center(
                child: Lottie.asset(
                  AnimationAssets.noDataFound,
                  width: 200,
                  height: 200,
                ),
              )
            : ListView.builder(
                itemCount: recentTransaction.length,
                itemBuilder: (context, index) {
                  return RecentTransactionWidget(
                    recentTransaction: recentTransaction[index],
                  );
                }),
      ),
    );
  }
}
