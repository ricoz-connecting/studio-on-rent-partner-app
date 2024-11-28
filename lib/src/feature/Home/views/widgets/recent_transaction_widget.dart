import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/models/earnings_withdrawal.dart';

class RecentTransactionWidget extends StatelessWidget {
  final EarningsHistory recentTransaction;
  final List<EarningsHistory>? recentTransactions;
  const RecentTransactionWidget({
    this.recentTransactions,
    required this.recentTransaction,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F6F9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: const Color(0xFFD9D9D9),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                recentTransaction.title,
                style: GoogleFonts.lato(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                recentTransaction.orderId,
                style: GoogleFonts.lato(
                  color: const Color(0xFF656565),
                ),
              ),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '+ ₹${recentTransaction.amount}',
                style: GoogleFonts.lato(
                    color: const Color(0xFF16BF27),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                '${recentTransaction.date.day}/${recentTransaction.date.month}/${recentTransaction.date.year}',
                style: GoogleFonts.lato(
                  color: const Color(0xFF656565),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
