import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/commons/views/appbar.dart';
import 'package:studio_partner_app/commons/views/providers/authprovider.dart';
import 'package:studio_partner_app/src/feature/Home/views/empty_earning.dart';
import 'package:studio_partner_app/src/feature/Home/views/widgets/recent_transaction_widget.dart';
import 'package:studio_partner_app/src/feature/Home/views/widgets/withdrawal_widget.dart';
import 'package:studio_partner_app/src/feature/Home/views/widgets/your_earnings_widget.dart';
import 'package:studio_partner_app/src/feature/auth/views/widgets/reusable_button.dart';
import 'package:studio_partner_app/src/feature/transactions/controllers/earning_history_controller.dart';
import 'package:studio_partner_app/src/feature/transactions/controllers/earnings_controller.dart';
import 'package:studio_partner_app/src/res/colors.dart';
import 'package:studio_partner_app/utils/router.dart';

class EarningsPage extends ConsumerStatefulWidget {
  const EarningsPage({super.key});
  @override
  ConsumerState<EarningsPage> createState() => _EarningsPageState();
}

class _EarningsPageState extends ConsumerState<EarningsPage> {
  bool isLoading = true;
  @override
  void initState() {
    _getEarnings();
    super.initState();
  }

  Future<void> _getEarnings() async {
    await ref
        .read(earningsControllerProvider.notifier)
        .getEarnings(context: context);
    mounted
        ? await ref
            .read(earningsHistoryControllerProvider.notifier)
            .getEarningsHistory(context: context)
        : null;
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final earnings = ref.watch(earningsControllerProvider);
    final earnigsHistory = ref.watch(earningsHistoryControllerProvider);
    // final status = ref.watch(statusProvider);
    return isLoading == true
        ? Scaffold(
            backgroundColor: Colors.white,
            appBar: Appbar.buildAppBar(context, ref),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: Appbar.buildAppBar(context, ref),
            body:
                // status?.kycStatus != 'Success'
                //     ? const EmptyEarning()
                //     :
                SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WithdrawalWidget(
                    totalWithdrawal: earnings!.todayWithdrawal.toString(),
                    availableWithdrawal: earnings.availableBalance.toString(),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Your Earnings',
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  YourEarningsWidget(
                    label: 'All time Earning',
                    earningLabel: '₹ ${earnings.totalEarning}',
                    width: double.infinity,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      YourEarningsWidget(
                        width: MediaQuery.of(context).size.width * 0.4,
                        label: 'Today’s\nEarning',
                        earningLabel: '₹ ${earnings.todayEarning}',
                      ),
                      YourEarningsWidget(
                        width: MediaQuery.of(context).size.width * 0.4,
                        earningLabel: '₹ ${earnings.thisMonthEarning}',
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
                          GoRouter.of(context).push(
                              StudioRoutes.transactionHistory,
                              extra: earnigsHistory);
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
                  earnigsHistory.isNotEmpty
                      ? RecentTransactionWidget(
                          recentTransaction: earnigsHistory[0],
                        )
                      : const SizedBox(),
                  earnigsHistory.length > 1
                      ? RecentTransactionWidget(
                          recentTransaction: earnigsHistory[1],
                        )
                      : const SizedBox(),
                  earnigsHistory.length > 2
                      ? RecentTransactionWidget(
                          recentTransaction: earnigsHistory[2],
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          );
  }
}
