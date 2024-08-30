import 'package:studio_partner_app/src/feature/Home/views/chat_screen.dart';
import 'package:studio_partner_app/src/feature/Home/views/earnings.dart';
import 'package:studio_partner_app/src/feature/Home/views/booking.dart';
import 'package:studio_partner_app/src/feature/Home/views/empty_chat.dart';
import 'package:studio_partner_app/src/feature/Home/views/empty_earning.dart';
import 'package:studio_partner_app/src/feature/Home/views/empty_studio.dart';
import 'package:studio_partner_app/src/feature/Home/views/empyt_bookings.dart';
import 'package:studio_partner_app/src/feature/Home/views/store_screen.dart';
import 'package:flutter/material.dart';
import 'package:studio_partner_app/src/res/colors.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    // Bookings(),
    // ChatScreen(),
    // StoreScreen(),
    // EarningsPage(),
    EmpytBookings(),
    EmptyChat(),
    EmptyStudio(),
    EmptyEarning(),
  ];

  void _onItemTapped(int index) {
    setState(() {
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
              Icons.event_note,
              size: 30,
            ),
            label: 'Bookings',
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
              Icons.store_outlined,
              size: 30,
            ),
            label: 'Studio',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_balance_wallet_outlined,
              size: 30,
            ),
            label: 'Eearnings',
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
