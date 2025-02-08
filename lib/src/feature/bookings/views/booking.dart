import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studio_partner_app/commons/views/providers/authprovider.dart';
import 'package:studio_partner_app/src/feature/bookings/views/active.dart';
import 'package:studio_partner_app/src/feature/bookings/views/completed.dart';
import 'package:flutter/material.dart';
import 'package:studio_partner_app/src/feature/bookings/views/widgets/active_completed.dart';
import 'package:studio_partner_app/src/res/colors.dart';

import '../../../../commons/views/appbar.dart';

class Bookings extends ConsumerWidget {
  const Bookings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(statusProvider);
    final isActive = ref.watch(activeProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Appbar.buildAppBar(context, ref),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: CustomActiveCompletedToggle(
              initialValue: isActive,
              onChanged: (value) {
                ref.read(activeProvider.notifier).state = value;
              },
            ),
          ),
          Expanded(
            child:
                isActive ? const ActiveRequests() : const CompletedRequests(),
          ),
        ],
      ),
    );
  }
}
