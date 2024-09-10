import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/commons/controllers/get_profile.dart';
import 'package:studio_partner_app/commons/views/providers/profileprovider.dart';
import 'package:studio_partner_app/src/feature/profile/views/profile_screen.dart';
import 'package:studio_partner_app/src/res/assets.dart';

class Appbar {
  static AppBar buildAppBar(BuildContext context, WidgetRef ref) {
    final userProfile = ref.watch(profileProvider);
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
            onTap: () async {
              if (await GetProfile.getProfile(context, ref)) {
                final userProfile = ref.watch(profileProvider);
                context.mounted
                    ? Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                        return ProfileScreen(
                          profile: userProfile,
                        );
                      }))
                    : null;
              }
            },
            child: CircleAvatar(
              backgroundImage: NetworkImage(userProfile.avatar!),
              radius: 20,
            ),
          ),
        ),
      ],
    );
  }
}
