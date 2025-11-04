import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/feature/banks/controller/bank_controller.dart';
import 'package:studio_partner_app/src/res/colors.dart';
import 'package:studio_partner_app/utils/router.dart';

class WithdrawMoneyWidget extends ConsumerWidget {
  const WithdrawMoneyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(bankControllerProvider.notifier).getBankDetails();
    final selectedBank = ref.watch(selectedBankProvider);
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                'Withdraw Money',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  GoRouter.of(context).push(StudioRoutes.bankDetails);
                },
                child: Text(
                  'Change',
                  style: GoogleFonts.inter(
                    color: AppColors.primaryBackgroundColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'A/C Holder\'s Name: ',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF7D7D7D),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: selectedBank?.accountHolderName ?? 'Not Selected',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF7D7D7D),
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Bank Name: ',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF7D7D7D),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: selectedBank?.bankName ?? 'Not Selected',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF7D7D7D),
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Account number: ',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF7D7D7D),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: selectedBank?.accountNumber ?? 'Not Selected',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF7D7D7D),
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'IFSC code: ',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF7D7D7D),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: selectedBank?.ifscCode ?? 'Not Selected',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF7D7D7D),
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFFD9D9D9),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Text(
                  '₹',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(width: 10),
                Container(
                  height: 20,
                  width: 1,
                  color: const Color(0xFFD9D9D9),
                ),
                const SizedBox(width: 10),
                Card(
                  margin: const EdgeInsets.all(0),
                  elevation: 0,
                  child: Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: const TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter Amount',
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    context.pop();
                  },
                  child: const Icon(
                    Icons.send,
                    color: AppColors.primaryBackgroundColor,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
