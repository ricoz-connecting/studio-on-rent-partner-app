import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/commons/views/appbar.dart';
import 'package:studio_partner_app/src/feature/Home/views/widgets/onboarding_card.dart';

class EmptyEarning extends ConsumerWidget {
  const EmptyEarning({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        appBar: Appbar.buildAppBar(context, ref),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: Image.asset('assets/images/emptyearning.png')),
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
            Positioned(
                bottom: 0,
                child:
                    OnboardingCard(width: MediaQuery.of(context).size.width)),
          ],
        ),
      ),
    );
  }
}
