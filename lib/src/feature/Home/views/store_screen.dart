import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:studio_partner_app/commons/views/appbar.dart';
import 'package:studio_partner_app/src/feature/Home/views/widgets/custom_fab.dart';
import 'package:studio_partner_app/src/feature/addstudio/views/add_studio_request.dart';
import 'package:flutter/material.dart';
import 'package:studio_partner_app/src/res/colors.dart';
import 'package:studio_partner_app/utils/router.dart';

class StoreScreen extends ConsumerStatefulWidget {
  const StoreScreen({super.key});

  @override
  ConsumerState<StoreScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<StoreScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Appbar.buildAppBar(context, ref),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.02),
              const WarehouseCard(
                status: Status.active,
                title: 'Studio',
                price: '₹ 50000/- Per Month',
                address:
                    'No. of Days 123, XYZ Apt., New Delhi, Delhi Pin - 123456',
                imageUrl: 'assets/images/frame.png',
              ),
              const WarehouseCard(
                status: Status.active,
                title: 'Studio',
                price: '₹ 50000/- Per Month',
                address:
                    'No. of Days 123, XYZ Apt., New Delhi, Delhi Pin - 123456',
                imageUrl: 'assets/images/frame.png',
              ),
              const WarehouseCard(
                status: Status.close,
                title: 'Studio',
                price: '₹ 50000/- Per Month',
                address:
                    'No. of Days 123, XYZ Apt., New Delhi, Delhi Pin - 123456',
                imageUrl: 'assets/images/frame.png',
              ),
              const WarehouseCard(
                status: Status.active,
                title: 'Studio',
                price: '₹ 50000/- Per Month',
                address:
                    'No. of Days 123, XYZ Apt., New Delhi, Delhi Pin - 123456',
                imageUrl: 'assets/images/frame.png',
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: CustomFAB(
        onPressed: () {
          GoRouter.of(context).push(StudioRoutes.addStudioRequest);
        },
      ),
    );
  }
}

enum Status { active, close }

class WarehouseCard extends StatelessWidget {
  final String title;
  final String price;
  final String address;
  final String imageUrl;
  final Status status;

  const WarehouseCard({
    super.key,
    required this.status,
    required this.title,
    required this.price,
    required this.address,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        padding: const EdgeInsets.only(bottom: 5.0),
        decoration: BoxDecoration(
          color: const Color(0xFFF4F6F9),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imageUrl,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: status == Status.active
                              ? const Color(0xFF2B9721)
                              : const Color(0xFFA71414),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          status == Status.active ? 'Active' : 'Close',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    price,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    address,
                    style: const TextStyle(
                      color: Colors.black45,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
