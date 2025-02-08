import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:studio_partner_app/commons/controllers/status_controller.dart';
import 'package:studio_partner_app/src/feature/Home/views/chat_screen.dart';
import 'package:studio_partner_app/src/feature/Home/views/earnings.dart';
import 'package:studio_partner_app/src/feature/bookings/views/booking.dart';
import 'package:studio_partner_app/src/feature/Home/views/store_screen.dart';
import 'package:flutter/material.dart';
import 'package:studio_partner_app/src/res/assets.dart';
import 'package:studio_partner_app/src/res/colors.dart';

class BottomNavBar extends ConsumerStatefulWidget {
  const BottomNavBar({super.key});
  static const routePath = '/bottomNavBar';

  @override
  ConsumerState<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends ConsumerState<BottomNavBar> {
  @override
  void initState() {
    super.initState();
    ref.read(statusControllerProvider.notifier).getStatus(context: context);
  }

  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Bookings(),
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
      backgroundColor: Colors.white,
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Stack(
        clipBehavior: Clip.none,
        children: [
          BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.textBackgroundColor,
            currentIndex: _selectedIndex,
            items: <BottomNavigationBarItem>[
              _buildBottomNavigationItem('Bookings', IconAssets.bookings, 0),
              _buildBottomNavigationItem('Chat', IconAssets.chat, 1),
              _buildBottomNavigationItem('Studio', IconAssets.studio, 2),
              _buildBottomNavigationItem('Earnings', IconAssets.earnings, 3),
            ],
            selectedItemColor: AppColors.primaryBackgroundColor,
            unselectedItemColor: const Color(0xFF7D8588),
            showUnselectedLabels: true,
            selectedFontSize: 14,
            showSelectedLabels: true,
            elevation: 5,
            onTap: _onItemTapped,
          ),
          Positioned(
            top: 0,
            left: MediaQuery.of(context).size.width / 4 * _selectedIndex + 15,
            child: Container(
              height: 3,
              width: 70,
              color: AppColors.primaryBackgroundColor,
            ),
          ),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationItem(
      String label, String assetPath, int index) {
    return BottomNavigationBarItem(
      icon: Column(
        children: [
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              _selectedIndex == index
                  ? AppColors.primaryBackgroundColor
                  : const Color(0xFF7D8588),
              BlendMode.srcIn,
            ),
            child: SvgPicture.asset(
              assetPath,
              width: 20,
              height: 20,
            ),
          ),
        ],
      ),
      label: label,
    );
  }
}
