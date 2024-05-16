// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:studio_partner_app/src/commons/globals/agent_details.dart';
import 'package:studio_partner_app/src/commons/globals/studio_details.dart';
import 'package:studio_partner_app/src/commons/views/widgets/simple_app_bar.dart';
import 'package:studio_partner_app/src/core/models/agent_model.dart';
import 'package:studio_partner_app/src/core/themes/theme.dart';
import 'package:studio_partner_app/src/features/stores/presentation/bloc/studio_bloc/studio_bloc.dart';
import 'package:studio_partner_app/src/features/stores/presentation/widgets/about_tab.dart';
import 'package:studio_partner_app/src/features/stores/presentation/widgets/gallery_tab.dart';
import 'package:studio_partner_app/src/features/stores/presentation/widgets/review_tab.dart';
import 'package:studio_partner_app/src/features/stores/presentation/widgets/sliver_app_bar_delegate.dart';
import 'package:studio_partner_app/src/res/data.dart';
import 'package:studio_partner_app/src/utils/widgets/customElevatedContainer.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_tab_builder.dart';

class BookingView extends StatefulWidget {
  final String id;
  static String routePath = '/booking-view';

  const BookingView({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<BookingView> createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView>
    with SingleTickerProviderStateMixin {
  late TabController _tabBarController;

  num rent = 1111;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (kDebugMode) {
      print(widget.id);
    }
    context.read<StudioBloc>().add(GetStudioDataEvent(studioId: widget.id));

    _tabBarController = TabController(length: 3, vsync: this);
  }

  bool isLiked = false;

  toggleLikeButton() {
    setState(() {
      isLiked = !isLiked;
    });
  }

  PageController carouselController = PageController();
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Scaffold(
        extendBodyBehindAppBar: true,
        // backgroundColor: ColorAssets.white,
        // appBar: AppBar(
        //   forceMaterialTransparency: true,
        //   backgroundColor: Colors.transparent,
        //   leading: Padding(
        //     padding: const EdgeInsets.all(12.0),
        //     child: Container(
        //       width: 20,
        //       height: 20,
        //       decoration: BoxDecoration(
        //           shape: BoxShape.circle,
        //           color: ColorAssets.white,
        //           boxShadow: [
        //             BoxShadow(
        //                 color: ColorAssets.lightGray.withOpacity(0.5),
        //                 blurRadius: 1)
        //           ]),
        //       child: GestureDetector(
        //         onTap: () {
        //           context.pop();
        //         },
        //         child: const Icon(
        //           Icons.arrow_back,
        //           size: 20,
        //         ),
        //       ),
        //     ),
        //   ),
        //   actions: [
        //     Container(
        //       width: 30,
        //       height: 30,
        //       decoration: BoxDecoration(
        //           shape: BoxShape.circle,
        //           color: color.background,
        //           boxShadow: [
        //             BoxShadow(
        //                 color: ColorAssets.lightGray.withOpacity(0.5),
        //                 blurRadius: 1)
        //           ]),
        //       child: const Icon(
        //         Icons.share,
        //         size: 20,
        //       ),
        //     ).onTap(() {
        //       SharingUtils.shareStudioScrenshotContent(
        //           context: context,
        //           text: "CaptureVision Studios",
        //           subject: "Aram Cottage,Pune ,Maharastra");
        //     }),
        //     const SizedBox(width: 10),
        //     Container(
        //       width: 30,
        //       height: 30,
        //       decoration: BoxDecoration(
        //           shape: BoxShape.circle,
        //           color:color.background,
        //           boxShadow: [
        //             BoxShadow(
        //                 color: ColorAssets.lightGray.withOpacity(0.5),
        //                 blurRadius: 1)
        //           ]),
        //       child: Icon(
        //         isLiked ? Icons.favorite : Icons.favorite_border_rounded,
        //         color:
        //             isLiked ? color.primary:null,
        //         size: 16,
        //       ),
        //     ).onTap(() {
        //       toggleLikeButton();
        //     }),
        //     const SizedBox(width: 20),
        //   ],
        // ),
        appBar: const SimpleAppBar(
          title: "",
          titleWidget: null,
        ),
        body: RefreshIndicator(
            onRefresh: () async {},
            child: BlocBuilder<StudioBloc, StudioState>(
              builder: (context, state) {
                if (state is StudioLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is StudioSuccessState) {
                  return DefaultTabController(
                      length: 3,
                      child: NestedScrollView(
                          headerSliverBuilder: (context, innerBoxIsScrolled) {
                            return [
                              _imageCarouselBuilder(
                                  state.studioDetails, context),
                              _descriptionBuilder(state.studioDetails),
                              SliverPersistentHeader(
                                delegate: SliverAppBarDelegate(
                                  TabBar(
                                    controller: _tabBarController,
                                    indicatorSize: TabBarIndicatorSize.label,
                                    indicatorColor: color.primary,
                                    indicator: UnderlineTabIndicator(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            width: 6.0, color: color.primary),
                                        insets: const EdgeInsets.symmetric(
                                            horizontal: 60)),
                                    // indicatorWeight: 6,
                                    unselectedLabelColor: ColorAssets.lightGray,
                                    labelColor: color.primary,
                                    tabs: const [
                                      Tab(text: " About "),
                                      Tab(text: " Gallery"),
                                      Tab(text: " Review "),
                                    ],
                                  ),
                                ),

                                pinned: true,
                                // floating: true,
                              ),
                            ];
                          },
                          body: TabBarView(
                              controller: _tabBarController,
                              children: [
                                AboutTab(
                                  agentModels: [
                                    globalAgentModel ?? AgentModel.empty()
                                  ],
                                  studioDetails: state.studioDetails,
                                ),
                                GalleryTab(studioDetails: state.studioDetails),
                                ReviewTab(
                                  reviewModels: AppData.reviewModels,
                                  studioDetails: state.studioDetails,
                                ),
                              ])));
                } else {
                  return SizedBox();
                }
              },
            )));
  }

  SliverToBoxAdapter _imageCarouselBuilder(
      StudioDetails data, BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return SliverToBoxAdapter(
      child: Container(
        height: 270,
        width: double.maxFinite,
        color: color.primary,
        child: Stack(
          fit: StackFit.expand,
          children: [
            PageView(
              scrollDirection: Axis.horizontal,
              controller: carouselController,
              children: [
                for (var i in data.frontImage)
                  Image.memory(
                    i,
                    fit: BoxFit.cover,
                  ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: SmoothPageIndicator(
                    effect: WormEffect(
                        dotWidth: 10,
                        dotHeight: 10,
                        activeDotColor: ColorAssets.white,
                        dotColor: color.secondary.withOpacity(0.5)),
                    controller: carouselController,
                    count: 2),
              ),
            )
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _descriptionBuilder(StudioDetails data) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
        width: double.maxFinite,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTagBuilder(tag: data.category),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 12,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '${data.rating} (${AppData.reviewModels.length} reviews)',
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: ColorAssets.lightGray),
                  ),
                  const SizedBox(width: 5),
                ],
              )
            ],
          ),
          const SizedBox(height: 15),
          Text(
            data.name,
            style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: ColorAssets.blackFaded),
          ),
          const SizedBox(height: 12),
          Text(
            data.address,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: ColorAssets.blackFaded),
          ),
        ]),
      ),
    );
  }

  void showTourBookingModel(BuildContext context, AgentModel agentModel,
      StudioDetails studioDetails) {
    showModalBottomSheet(
        backgroundColor: ColorAssets.white,
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) {
          return Container(
            // padding: EdgeInsets.symmetric(horizontal: 20),
            height: MediaQuery.of(context).size.height - 200,
            decoration: const BoxDecoration(
                color: ColorAssets.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0))),
          );
        });
  }
}
