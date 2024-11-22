import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:studio_partner_app/commons/views/appbar.dart';
import 'package:studio_partner_app/commons/views/providers/authprovider.dart';
import 'package:studio_partner_app/src/feature/Home/views/widgets/custom_fab.dart';
import 'package:flutter/material.dart';
import 'package:studio_partner_app/utils/router.dart';
import '../controller/studio_list_controller.dart';
import 'empty_studio.dart';
import 'widgets/studio_card.dart';

class StoreScreen extends ConsumerStatefulWidget {
  const StoreScreen({super.key});

  @override
  ConsumerState<StoreScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<StoreScreen> {
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
    return isLoading == true
        ? Scaffold(
            backgroundColor: Colors.white,
            appBar: Appbar.buildAppBar(context, ref),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: Appbar.buildAppBar(context, ref),
            body:
                // status?.kycStatus != 'Success'
                //     ? const EmptyStudio()
                //     :
                Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.02),
                  Expanded(
                    child: ListView.builder(
                      itemCount: studioList.length,
                      itemBuilder: (context, index) {
                        return StudioCard(
                          onTapEdit: () {
                            GoRouter.of(context).push(
                                StudioRoutes.addStudioRequest,
                                extra: studioList[index]);
                          },
                          setStatus: () {
                            ref
                                .read(studioListControllerProvider.notifier)
                                .updatestudioStatus(
                                  studioList[index].id!,
                                  !studioList[index].isActive!,
                                );
                            setState(() {
                              studioList[index].isActive =
                                  !studioList[index].isActive!;
                            });
                          },
                          onTap: () {
                            ref
                                .read(studioListControllerProvider.notifier)
                                .deleteStudio(
                                  context: context,
                                  studioId: studioList[index].id!,
                                );
                          },
                          status: studioList[index].isActive!,
                          title: studioList[index].name!,
                          price: studioList[index].price!,
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
            floatingActionButton: CustomFAB(
              onPressed: () {
                GoRouter.of(context).push(StudioRoutes.addStudioRequest);
              },
            ),
          );
  }
}
