import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rive/rive.dart';
import 'package:studio_partner_app/src/commons/views/widgets/simple_app_bar.dart';
import 'package:studio_partner_app/src/features/home/presentation/tabs/earning_page.dart';
import 'package:studio_partner_app/src/features/home/presentation/tabs/chat_tab.dart';
import 'package:studio_partner_app/src/features/home/presentation/tabs/stores_page.dart';
import 'package:studio_partner_app/src/features/profile/views/profile_page.dart';
import 'package:studio_partner_app/src/features/profile/widgets/complete_profile_info.dart';
import 'package:studio_partner_app/src/features/stores/presentation/pages/add_store_page.dart';
import 'package:studio_partner_app/src/res/assets.dart';

class HomeView extends StatefulWidget {
  static const routePath = "/";
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: [
        SimpleAppBar(
          title: 'Chat',
          centerTitle: false,
          bgColor: color.secondary,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                  onTap: () {
                    context.push(ProfilePage.routePath);
                  },
                  child: CircleAvatar()),
            )
          ],
        ),
        SimpleAppBar(
          title: 'Chat',
          centerTitle: false,
          bgColor: color.secondary,
        ),
        SimpleAppBar(
          title: 'Chat',
          centerTitle: false,
          bgColor: color.secondary,
        ),
        SimpleAppBar(
          title: 'Chat',
          centerTitle: false,
          bgColor: color.secondary,
        ),
        SimpleAppBar(
          title: 'Earnings',
          centerTitle: false,
          bgColor: color.secondary,
        ),
      ][selectedIndex],
      backgroundColor: color.surface,
      body: [
        ChatTab(),
        ChatTab(),
        ChatTab(),
        StoresPage(),
        EarningPage()
      ][selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: color.onSecondary,
        unselectedLabelStyle: TextStyle(color: color.primary),
        currentIndex: selectedIndex,
        selectedItemColor: color.primary,
        showUnselectedLabels: true,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset(ImageAssets.home), label: "Bookings"),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(ImageAssets.createStudio),
              label: "Create Studio"),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(ImageAssets.chat), label: "Chat"),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(ImageAssets.stores), label: "Stores"),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(ImageAssets.wallet), label: "Earnings"),
        ],
      ),
      floatingActionButton: selectedIndex == 3
          ? FloatingActionButton(
              onPressed: () {
                context.push(AddStorePage.routePath);
              },
              shape: CircleBorder(),
              backgroundColor: color.primary,
              child: Icon(
                Icons.add,
                color: color.surface,
              ),
            )
          : null,
    );
  }
}
