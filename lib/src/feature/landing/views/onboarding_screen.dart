import 'package:flutter/material.dart';
import 'package:studio_partner_app/src/feature/landing/views/onboarding_one.dart';
import 'package:studio_partner_app/src/res/colors.dart';

import 'onboarding_three.dart';
import 'onboarding_two.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPages() {
    return [
      const OnboardingOne(),
      const OnboardingTwo(),
      const OnboardingThree(),
    ];
  }

  Widget buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: _currentPage == index ? 12 : 10,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: _currentPage == index
            ? AppColors.primaryBackgroundColor
            : Colors.grey,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
              controller: _pageController,
              onPageChanged: (value) {
                setState(() {
                  _currentPage = value;
                });
              },
              itemBuilder: (context, index) {
                return _buildPages()[index];
              }),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return buildDot(index, context);
              }),
            ),
          ),
        ],
      ),
    );
  }
}
