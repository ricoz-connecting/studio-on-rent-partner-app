import 'package:flutter/material.dart';
import 'package:studio_partner_app/src/core/themes/theme.dart';
import 'package:studio_partner_app/src/res/assets.dart';

class Register5 extends StatelessWidget {
  const Register5({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 300,
          width: 300,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ImageAssets.verficationWaiting)),
          ),
          child: Icon(
            Icons.hourglass_top_sharp,
            size: 100,
            color: ColorAssets.white,
          ),
        ),
        Text(
          "Your details are sent for",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        Text(
          " verification",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        Text("you’ll be notified once verification is complete")
      ],
    );
  }
}
