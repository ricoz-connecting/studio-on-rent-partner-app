import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:studio_partner_app/src/feature/customer_reviews.dart/controller/review_controller.dart';
import 'package:studio_partner_app/src/res/assets.dart';
import 'package:studio_partner_app/utils/router.dart';
import 'widgets/customer_review_card.dart';

class CustomerReview extends ConsumerStatefulWidget {
  const CustomerReview({super.key});

  @override
  ConsumerState<CustomerReview> createState() => _CustomerReviewState();
}

class _CustomerReviewState extends ConsumerState<CustomerReview> {
  bool isLoading = true;
  @override
  void initState() {
    _fetchCustomerReviews();
    super.initState();
  }

  Future<void> _fetchCustomerReviews() async {
    await ref.read(reviewControllerProvider.notifier).getCustomerReviews();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final reviews = ref.watch(reviewControllerProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Customer Reviews',
          style: GoogleFonts.lato(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : reviews.isEmpty
              ? Center(
                  child: Lottie.asset(
                    AnimationAssets.noDataFound,
                    width: 200,
                    height: 200,
                  ),
                )
              : ListView.builder(
                  itemCount: reviews.length,
                  itemBuilder: (context, index) => CustomerReviewCard(
                    title: reviews[index].name,
                    rating: reviews[index].averageRating,
                    reviewsCount: reviews[index].totalRatings,
                    imageUrl: reviews[index].thumbnail,
                    status: reviews[index].rentOrSell,
                    onTap: () {
                      GoRouter.of(context)
                          .push(StudioRoutes.studioReview, extra: {
                        'name': reviews[index].name,
                        'studioDocId': reviews[index].id,
                        'averageRating': reviews[index].averageRating,
                        'totalReviews': reviews[index].totalRatings,
                      });
                    },
                  ),
                ),
    );
  }
}
