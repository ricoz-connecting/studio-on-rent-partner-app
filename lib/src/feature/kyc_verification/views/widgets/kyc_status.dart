
import 'package:flutter/material.dart';
import 'package:studio_partner_app/src/res/assets.dart';

class KycStatusScreen extends StatelessWidget {
  final String status;
  const KycStatusScreen({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    String imagePath;
    String title;
    String subtitle;
    switch (status) {
      case 'Success':
        imagePath = ImageAssets.kycVerified;
        title = "Your KYC details are verified";
        subtitle = "Your verification is complete";
        break;
      case 'Pending':
      default:
        imagePath = ImageAssets.iconCheckMark;
        title = "Your KYC details are sent for verification";
        subtitle = "You’ll be notified once verification is complete";
        break;
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                imagePath,
                height: 250,
                width: 250,
              ),
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
