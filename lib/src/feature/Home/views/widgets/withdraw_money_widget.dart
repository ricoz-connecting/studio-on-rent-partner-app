import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/res/colors.dart';

class WithdrawMoneyWidget extends StatelessWidget {
  const WithdrawMoneyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Withdraw Money',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            color: const Color(0xFFF7F7F7),
            child: Row(
              children: [
                Text(
                  'Account number:5500 xxx 05050',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF7D7D7D),
                  ),
                ),
                const Spacer(),
                Text(
                  'Change',
                  style: GoogleFonts.inter(
                    color: AppColors.primaryBackgroundColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFFD9D9D9),
              ),
              borderRadius: BorderRadius.circular(5),
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
                  onTap: () {},
                  child: const Icon(Icons.send),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
