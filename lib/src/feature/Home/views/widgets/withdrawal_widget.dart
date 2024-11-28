import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/feature/Home/views/widgets/withdraw_money_widget.dart';
import 'package:studio_partner_app/src/feature/auth/views/widgets/reusable_button.dart';
import 'package:studio_partner_app/src/res/colors.dart';
import 'package:studio_partner_app/utils/router.dart';

class WithdrawalWidget extends StatelessWidget {
  final String totalWithdrawal;
  final String availableWithdrawal;
  const WithdrawalWidget({
    required this.totalWithdrawal,
    required this.availableWithdrawal,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F6F9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                '₹ $totalWithdrawal',
                style: GoogleFonts.inter(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryBackgroundColor,
                ),
              ),
              const Spacer(),
              Text(
                '₹ $availableWithdrawal',
                style: GoogleFonts.inter(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryBackgroundColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'Total\nWithdrawable',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  color: const Color(0xFF5F5F5F),
                ),
              ),
              const Spacer(),
              Text(
                'Available to\nWithdraw',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  color: const Color(0xFF5F5F5F),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ReusableButton(
            label: 'Withdraw',
            radius: 10,
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  insetPadding: const EdgeInsets.all(10),
                  contentPadding: EdgeInsets.zero,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  content: const WithdrawMoneyWidget(),
                ),
              );
            },
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              GoRouter.of(context).push(StudioRoutes.withdrawalHistory);
            },
            child: Text(
              'Withdrawal History',
              style: GoogleFonts.lato(
                color: const Color(0xFF5F5F5F),
              ),
            ),
          )
        ],
      ),
    );
  }
}
