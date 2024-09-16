import 'package:flutter/material.dart';
import 'package:studio_partner_app/src/res/assets.dart';

class LoginViaGoogleOrApple extends StatelessWidget {
  const LoginViaGoogleOrApple({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          onPressed: () {},
          icon: Image.asset(ImageAssets.googleimage),
        ),
        IconButton(
          onPressed: () {},
          icon: Image.asset(
            ImageAssets.appleimage,
            height: 70,
            width: 70,
          ),
        ),
      ],
    );
  }
}
