import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:studio_partner_app/src/features/earnings/presentation/tabs/earning_page.dart';
import 'package:studio_partner_app/src/features/earnings/presentation/tabs/review_page.dart';
import 'package:studio_partner_app/src/features/earnings/presentation/widgets/amount_tile.dart';
import 'package:studio_partner_app/src/features/earnings/presentation/widgets/money_box.dart';

class EarningPage extends StatefulWidget {
  static const routePath = '/earning-page';

  const EarningPage({super.key});

  @override
  State<EarningPage> createState() => _EarningPageState();
}

class _EarningPageState extends State<EarningPage> {
  int initialPage = 0;
  PageController controller = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    return Stack(
      children: [
        PageView(
          controller: controller,
          children: [
            EarningPages(
              callback: () {
                controller.animateToPage(1,
                    duration: Durations.short1, curve: Curves.bounceIn);
              },
            ),
            ReviewPage()
          ],
        ),
      ],
    );
  }
}
