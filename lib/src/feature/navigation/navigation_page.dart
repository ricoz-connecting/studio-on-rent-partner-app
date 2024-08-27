import 'package:studio_partner_app/src/feature/Home/pages/chat_screen.dart';
import 'package:studio_partner_app/src/feature/Home/pages/earnings.dart';
import 'package:studio_partner_app/src/feature/Home/pages/home_screen.dart';
import 'package:studio_partner_app/src/feature/Home/pages/store_screen.dart';
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
    HomeScreen(),
    ChatScreen(),
    StoreScreen(),
    EarningsPage(),
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
              Icons.home,
              size: 30,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat_bubble,
              size: 30,
            ),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.store,
              size: 30,
            ),
            label: 'Store',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_balance_wallet,
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
