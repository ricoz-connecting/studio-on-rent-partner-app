import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:studio_partner_app/src/commons/views/widgets/simple_app_bar.dart';
import 'package:studio_partner_app/src/features/home/presentation/pages/home_view.dart';
import 'package:studio_partner_app/src/features/register/presentation/tabs/register_1.dart';
import 'package:studio_partner_app/src/features/register/presentation/tabs/register_2.dart';
import 'package:studio_partner_app/src/features/register/presentation/tabs/register_3.dart';
import 'package:studio_partner_app/src/features/register/presentation/tabs/register_4.dart';
import 'package:studio_partner_app/src/features/register/presentation/tabs/register_5.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_text_button.dart';

class Register extends StatefulWidget {
  static const routePath = '/register-page';
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController(initialPage: 0);
  TabController? tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme color = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: SimpleAppBar(
        title: 'Register',
        centerTitle: false,
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(8),
        height: 75,
        child: CustomTextButton(
          ontap: () async {
            if (_pageController.page != 4) {
              await _pageController.nextPage(
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.linear);
            } else {
              context.push(HomeView.routePath);
            }
          },
          bgColor: color.primary,
          text: 'Continue',
          textColor: color.onPrimary,
        ),
      ),
      body: Stack(
        children: [
          PageView(
            scrollBehavior: ScrollBehavior().copyWith(scrollbars: true),
            controller: _pageController,
            children: [
              Register1(),
              Register2(),
              Register3(),
              Register4(),
              Register5()
            ],
          ),
          Align(
            child: SmoothPageIndicator(
              controller: _pageController,
              count: 5,
              effect: ExpandingDotsEffect(
                  dotHeight: 10,
                  dotWidth: 10,
                  activeDotColor: color.onSecondaryContainer),
            ),
            alignment: Alignment.bottomCenter,
          )
        ],
      ),
    );
  }
}
