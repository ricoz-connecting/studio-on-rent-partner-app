import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/commons/views/appbar.dart';
import 'package:studio_partner_app/src/feature/Home/views/widgets/recent_transaction_widget.dart';
import 'package:studio_partner_app/src/feature/Home/views/widgets/withdrawal_widget.dart';
import 'package:studio_partner_app/src/feature/Home/views/widgets/your_earnings_widget.dart';
import 'package:studio_partner_app/src/feature/auth/views/widgets/reusable_button.dart';
import 'package:studio_partner_app/src/res/colors.dart';
import 'package:studio_partner_app/utils/router.dart';

class EarningsPage extends ConsumerWidget {
  const EarningsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Appbar.buildAppBar(context, ref),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const WithdrawalWidget(),
            const SizedBox(height: 10),
            Text(
              'Your Earnings',
              style: GoogleFonts.lato(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            const YourEarningsWidget(
              label: 'All time Earning',
              earningLabel: '₹ 1000',
              width: double.infinity,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                YourEarningsWidget(
                  width: MediaQuery.of(context).size.width * 0.4,
                  label: 'Today’s\nEarning',
                  earningLabel: '₹ 1000',
                ),
                YourEarningsWidget(
                  width: MediaQuery.of(context).size.width * 0.4,
                  earningLabel: '₹ 5000',
                  label: 'This Month’s\nEarning',
                ),
              ],
            ),
            const SizedBox(height: 15),
            ReusableButton(
              label: 'View Upcoming Billings',
              onPressed: () {
                GoRouter.of(context).push(StudioRoutes.upcomingBills);
              },
              radius: 10,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Transactions',
                  style: GoogleFonts.lato(
                    fontSize: 16,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    GoRouter.of(context).push(StudioRoutes.transactionHistory);
                  },
                  child: Text(
                    'See All',
                    style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryBackgroundColor),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const RecentTransactionWidget(),
          ],
        ),
      ),
    );
  }
}
