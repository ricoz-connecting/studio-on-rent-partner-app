import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studio_partner_app/commons/views/providers/authprovider.dart';
import 'package:studio_partner_app/commons/views/widgets/custom_appbar.dart';
import 'package:studio_partner_app/src/feature/addstudio/views/widgets/custom_rent_sell_toggel.dart';
import 'package:studio_partner_app/src/feature/bookings/views/widgets/active_completed.dart';
import 'rent.dart';
import 'sell.dart';

class AddStudioRequest extends ConsumerStatefulWidget {
  const AddStudioRequest({super.key});

  @override
  ConsumerState<AddStudioRequest> createState() => _AddStudioRequestState();
}

class _AddStudioRequestState extends ConsumerState<AddStudioRequest>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isRent = ref.watch(isRentProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: 'Add Studio Request'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: CustomRentSellToggle(
              initialValue: isRent,
              onChanged: (value) {
                ref.read(isRentProvider.notifier).state = value;
              },
            ),
          ),
          Expanded(
            child: isRent ? const Rent() : const Sell(),
          ),
        ],
      ),
    );
  }
}
