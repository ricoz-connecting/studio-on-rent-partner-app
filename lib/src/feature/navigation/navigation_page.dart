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

  @override
  ConsumerState<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends ConsumerState<BottomNavBar> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Bookings(),
    ChatScreen(),
    StoreScreen(),
    EarningsPage(),
  ];

  @override
  void initState() {
    ref.read(statusControllerProvider.notifier).getStatus(context: context);
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:  _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomAppBar(
        height: MediaQuery.of(context).size.height * 0.1,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildNavItem(IconAssets.bookings, 'Bookings', 0),
            _buildNavItem(IconAssets.chat, 'Chat', 1),
            _buildNavItem(IconAssets.studio, 'Studio', 2),
            _buildNavItem(IconAssets.earnings, 'Earnings', 3),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String icon, String label, int index) {
    final bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AnimatedContainer(
            curve: Curves.easeOutSine,
            duration: const Duration(milliseconds: 500),
            height: 3,
            width: 30,
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primaryBackgroundColor
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 5),
          SvgPicture.asset(
            icon,
            colorFilter: isSelected
                ? const ColorFilter.mode(
                    AppColors.primaryBackgroundColor, BlendMode.srcIn)
                : const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              color:
                  isSelected ? AppColors.primaryBackgroundColor : Colors.grey,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
