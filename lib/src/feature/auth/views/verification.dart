import 'package:flutter/material.dart';
import 'package:studio_partner_app/src/feature/navigation/navigation_page.dart';

class Verification extends StatelessWidget {
  const Verification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Stack(
            children: [
              Image.asset('assets/images/verification-waiting.png'),
              Transform.translate(
                offset: const Offset(60, 50),
                child: GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BottomNavBar())),
                  child: const Icon(
                    Icons.hourglass_top_outlined,
                    color: Colors.white,
                    size: 110,
                  ),
                ),
              ),
            ],
          )),
          const Text(
            'Your Details Are Sent For Verification',
            textAlign: TextAlign.center,
            softWrap: true,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'You\'ll be notified once Verification is done',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
