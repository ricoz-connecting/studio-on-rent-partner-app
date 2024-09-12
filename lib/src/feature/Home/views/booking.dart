import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studio_partner_app/src/feature/Home/views/service_card.dart';
import 'package:flutter/material.dart';
import 'package:studio_partner_app/src/res/colors.dart';

import '../../../../commons/views/appbar.dart';
import 'widgets/filter_widget.dart';

class Bookings extends ConsumerWidget {
  const Bookings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: Appbar.buildAppBar(context, ref),
      resizeToAvoidBottomInset: false,
      body: const SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: PropertySearchWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
