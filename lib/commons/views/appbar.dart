import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:studio_partner_app/commons/views/providers/profileprovider.dart';
import 'package:studio_partner_app/src/res/assets.dart';
import 'package:studio_partner_app/src/res/colors.dart';
import 'package:studio_partner_app/utils/router.dart';

class Appbar {
  static AppBar buildAppBar(BuildContext context, WidgetRef ref) {
    final userProfile = ref.watch(profileProvider);
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.appbarColor,
      elevation: 0,
      title: Image.asset(
        ImageAssets.appbarImage,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: GestureDetector(
            onTap: () {
              context.mounted
                  ? GoRouter.of(context).push(
                      StudioRoutes.profileScreen,
                      extra: userProfile,
                    )
                  : null;
            },
            child: CircleAvatar(
              backgroundImage: userProfile.avatar == null
                  ? const AssetImage(ImageAssets.profile)
                  : NetworkImage(userProfile.avatar!),
              radius: 20,
            ),
          ),
        ),
      ],
    );
  }
}
