import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/feature/bookings/views/active.dart';
import 'package:studio_partner_app/src/feature/bookings/views/completed.dart';
import 'package:studio_partner_app/src/res/colors.dart';

import '../../../../commons/views/appbar.dart';

class Bookings extends ConsumerStatefulWidget {
  const Bookings({super.key});

  @override
  ConsumerState<Bookings> createState() => _BookingsState();
}

class _BookingsState extends ConsumerState<Bookings> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void _onTabTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Appbar.buildAppBar(context, ref),
      body: Column(
        children: [
          Container(
            color: AppColors.appbarColor,
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildTabButton("New Request", 0),
                  _buildTabButton("Active", 1),
                  _buildTabButton("Completed", 2),
                ],
              ),
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              children: const [
                _ComingSoonPage(),
                ActiveRequests(),
                CompletedRequests(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, int index) {
    bool isSelected = _currentPage == index;
    return GestureDetector(
      onTap: () => _onTabTapped(index),
      child: Column(
        children: [
          const SizedBox(height: 5),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color:
                  isSelected ? AppColors.primaryBackgroundColor : Colors.black,
            ),
          ),
          const SizedBox(height: 5),
          if (isSelected)
            Container(
              height: 2,
              width: title.length * 12.0,
              color: AppColors.primaryBackgroundColor,
            ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class _ComingSoonPage extends StatelessWidget {
  const _ComingSoonPage();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Coming Soon",
        style: TextStyle(
            fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey),
      ),
    );
  }
}
