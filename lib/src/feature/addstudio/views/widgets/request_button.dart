import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/res/colors.dart';

class AddStudioRequestButton extends StatelessWidget {
  const AddStudioRequestButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: MediaQuery.of(context).size.height * 0.07,
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(15),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.primaryBackgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          textAlign: TextAlign.center,
          'Post Add Studio Request',
          style: GoogleFonts.inter(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
