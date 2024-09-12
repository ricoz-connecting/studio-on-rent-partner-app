import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studio_partner_app/commons/controllers/get_profile.dart';
import 'package:studio_partner_app/src/feature/Home/views/chat_screen.dart';
import 'package:studio_partner_app/src/feature/Home/views/earnings.dart';
import 'package:studio_partner_app/src/feature/Home/views/booking.dart';
import 'package:studio_partner_app/src/feature/Home/views/empty_chat.dart';
import 'package:studio_partner_app/src/feature/Home/views/saved_studios.dart';
import 'package:studio_partner_app/src/feature/Home/views/empty_studio.dart';
import 'package:studio_partner_app/src/feature/Home/views/empyt_bookings.dart';
import 'package:studio_partner_app/src/feature/Home/views/profile.dart';
import 'package:flutter/material.dart';
import 'package:studio_partner_app/src/res/colors.dart';

class BottomNavBar extends ConsumerStatefulWidget {
  const BottomNavBar({super.key});

  @override
  ConsumerState<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends ConsumerState<BottomNavBar> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Bookings(),
    // StoreScreen(),
    // EarningsPage(),
    // EmpytBookings(),
    // EmptyChat(),
    EmptyStudio(),
    ChatScreen(),
    SavedStudios(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      if (index == 4) {
        GetProfile.getProfile(context, ref);
      }
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              size: 30,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.explore_outlined,
              size: 30,
            ),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat_bubble_outline_rounded,
              size: 30,
            ),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite_border,
              size: 30,
            ),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline,
              size: 30,
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.primaryBackgroundColor,
        unselectedItemColor: const Color(0xFF7D8588),
        showUnselectedLabels: true,
        onTap: _onItemTapped,
      ),
    );
  }
}
