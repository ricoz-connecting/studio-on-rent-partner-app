import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:studio_partner_app/src/feature/auth/controllers/auth_controller.dart';
import 'package:studio_partner_app/src/feature/profile/views/widgets/custom_edit_profile.dart';
import 'package:studio_partner_app/src/feature/profile/views/widgets/membership_card.dart';
import 'package:studio_partner_app/src/feature/profile/views/widgets/info_section.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/res/assets.dart';
import 'package:studio_partner_app/src/res/colors.dart';
import 'package:studio_partner_app/utils/router.dart';
import '../../../models/user_model.dart';

class ProfileScreen extends ConsumerWidget {
  final User currentUser;

  const ProfileScreen({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Profile',
          style: GoogleFonts.lato(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Stack(
                children: [
                  CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage: currentUser.avatar == null
                          ? const AssetImage(
                              ImageAssets.profile,
                            )
                          : NetworkImage(currentUser.avatar!)),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryBackgroundColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Icon(
                        Icons.check_circle,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const MembershipCard(),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF4F6F9),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hi, ${currentUser.name}',
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.phone_outlined, color: Colors.black54),
                        const SizedBox(width: 8),
                        Text(
                          currentUser.phone!,
                          style: GoogleFonts.lato(color: Colors.black54),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              InfoSection(
                businessName: currentUser.businessName ?? '',
                address: currentUser.address ?? '',
              ),
              const SizedBox(height: 10),
              CustomEditProfile(
                  label: "Customer Reviews",
                  icon: Icons.reviews_outlined,
                  onTap: () {
                    GoRouter.of(context).push(StudioRoutes.customerReview);
                  }),
              const SizedBox(height: 10),
              Row(
                children: [
                  Flexible(
                    child: CustomEditProfile(
                        requireLeadingIcon: false,
                        label: "Help",
                        icon: Icons.help_outline_outlined,
                        onTap: () {
                          GoRouter.of(context).push(StudioRoutes.helpScreen);
                        }),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: CustomEditProfile(
                        requireLeadingIcon: false,
                        label: "Edit Profile",
                        icon: Icons.edit_outlined,
                        onTap: () {
                          GoRouter.of(context).push(
                            StudioRoutes.editProfile,
                            extra: currentUser,
                          );
                        }),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Flexible(
                    child: CustomEditProfile(
                        requireLeadingIcon: false,
                        label: "History",
                        icon: Icons.history,
                        onTap: () {
                          GoRouter.of(context).push(StudioRoutes.historyScreen);
                        }),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: CustomEditProfile(
                        requireLeadingIcon: false,
                        label: "Bank Details",
                        icon: Icons.account_balance_wallet_outlined,
                        onTap: () {
                          GoRouter.of(context).push(StudioRoutes.bankDetails);
                        }),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              CustomEditProfile(
                label: 'KYC',
                icon: Icons.event_note_outlined,
                onTap: () {
                  GoRouter.of(context).push(StudioRoutes.kycPage);
                },
              ),
              const SizedBox(height: 10),
              CustomEditProfile(
                label: 'Logout',
                icon: Icons.logout,
                onTap: () async {
                  await ref
                      .read(authControllerProvider.notifier)
                      .signOut(context);
                },
              ),
              const SizedBox(height: 10),
              CustomEditProfile(
                color: Colors.red,
                label: 'Delete Account',
                icon: Icons.delete_outlined,
                onTap: () {},
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
