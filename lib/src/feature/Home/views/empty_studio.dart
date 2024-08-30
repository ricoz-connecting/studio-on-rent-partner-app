import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/commons/views/appbar.dart';

class EmptyStudio extends StatelessWidget {
  const EmptyStudio({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: Appbar.buildAppBar(context),
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Image.asset('assets/images/emptystudio.png')),
              const SizedBox(height: 20),
              Text(
                'No Listings Yet',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                  textAlign: TextAlign.center,
                  'A group easily allows you to share content,Inputs & templates.',
                  style: GoogleFonts.inter()),
            ],
          ),
        ),
      ),
    );
  }
}
