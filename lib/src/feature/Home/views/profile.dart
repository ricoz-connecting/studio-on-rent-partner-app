import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studio_partner_app/commons/views/providers/profileprovider.dart';
import 'package:studio_partner_app/src/feature/Home/views/widgets/profile.dart';
import 'package:studio_partner_app/src/feature/Home/views/widgets/refer_and_earn.dart';
import 'package:studio_partner_app/src/feature/profile/views/profile_screen.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});
  @override
  ConsumerState<Profile> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  @override
  Widget build(BuildContext context) {
    final userProfile = ref.watch(profileProvider);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Center(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(userProfile.avatar!),
                  radius: 50,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                userProfile.name!,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                userProfile.email!,
                style: const TextStyle(fontSize: 20, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 20),
              ProfileWidgets(
                icon: Icons.person,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ProfileScreen(
                        profile: userProfile,
                      );
                    },
                  ),
                ),
                title: 'Personal Details',
              ),
              const SizedBox(height: 20),
              ProfileWidgets(
                onTap: () {},
                icon: Icons.settings,
                title: 'Settings',
              ),
              const SizedBox(height: 20),
              ProfileWidgets(
                onTap: () {},
                icon: Icons.wallet,
                title: 'Recent Orders',
              ),
              const SizedBox(height: 20),
              ProfileWidgets(
                onTap: () {},
                icon: Icons.question_answer,
                title: 'FAQ',
              ),
              const SizedBox(height: 20),
              const ReferAndEarnWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
