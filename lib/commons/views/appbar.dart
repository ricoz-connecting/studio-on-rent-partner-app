import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/commons/controllers/get_profile.dart';
import 'package:studio_partner_app/src/res/assets.dart';

class Appbar {
  static AppBar buildAppBar(BuildContext context, WidgetRef ref) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        children: [
          Image.asset(ImageAssets.home, height: 60, width: 60),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Book',
                style: GoogleFonts.lilitaOne(
                  fontSize: 16,
                  color: const Color(0xFFD60D8B),
                ),
              ),
              Text(
                'My Studio',
                style: GoogleFonts.lilitaOne(
                  fontSize: 16,
                  color: const Color(0xFFFF7100),
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: GestureDetector(
            onTap: () {
              GetProfile().getProfile(context, ref);
            },
            child: const CircleAvatar(
              backgroundImage: AssetImage(ImageAssets.profile),
              radius: 20,
            ),
          ),
        ),
      ],
    );
  }
}

