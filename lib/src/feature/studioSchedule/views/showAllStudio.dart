import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:studio_partner_app/commons/views/appbar.dart';
import 'package:studio_partner_app/commons/views/providers/authprovider.dart';
import 'package:studio_partner_app/commons/views/widgets/custom_appbar.dart';
import 'package:studio_partner_app/src/feature/Home/controller/studio_list_controller.dart';
import 'package:studio_partner_app/src/feature/Home/views/empty_studio.dart';
import 'package:flutter/material.dart';
import 'package:studio_partner_app/src/feature/studioSchedule/views/studioAvailability.dart';
import 'package:studio_partner_app/src/feature/studioSchedule/views/widgets/reusableCard.dart';
import 'package:studio_partner_app/src/res/assets.dart';

class StudioSelectionScreen extends ConsumerStatefulWidget {
  const StudioSelectionScreen({super.key});

  @override
  ConsumerState<StudioSelectionScreen> createState() =>
      _StudioSelectionScreenState();
}

class _StudioSelectionScreenState extends ConsumerState<StudioSelectionScreen> {
  bool isLoading = true;
  bool firstSwitchValue = false;

  @override
  void initState() {
    super.initState();
    _fetchCustomerReviews(firstSwitchValue ? 'Rent' : 'Sell');
  }

  Future<void> _fetchCustomerReviews(String type) async {
    await ref
        .read(studioListControllerProvider.notifier)
        .getStudioList(type: type);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final status = ref.watch(statusProvider);
    final studioList = ref.watch(studioListControllerProvider);
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: "Select Studio"),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : studioList.isEmpty
              ? Center(
                  child: Lottie.asset(
                    AnimationAssets.noDataFound,
                    width: 200,
                    height: 200,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: height * 0.02),
                      Expanded(
                        child: ListView.builder(
                          itemCount: studioList.length,
                          itemBuilder: (context, index) {
                            return ReusableStudioCard(
                              onCardTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return StudioAvailabilityPage(
                                      studioDocId: studioList[index].id!,
                                    );
                                  },
                                ));
                              },
                              status: studioList[index].isActive!,
                              title: studioList[index].name!,
                              price: studioList[index].price!,
                              basePricePerHour:
                                  studioList[index].basePricePerHour!,
                              fullDayPrice: studioList[index].fullPricePerDay!,
                              street: studioList[index].address!,
                              city: studioList[index].city!,
                              state: studioList[index].state!,
                              pincode: studioList[index].pincode!,
                              imageUrl: studioList[index].thumbnail!,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
