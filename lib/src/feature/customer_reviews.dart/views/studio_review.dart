import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/review_details_controller.dart';
import 'widgets/indi_studio_review.dart';
import 'widgets/rating_widget.dart';

class StudioReview extends ConsumerStatefulWidget {
  final Map<String, dynamic> studioDetails;
  const StudioReview({
    super.key,
    required this.studioDetails,
  });

  @override
  ConsumerState<StudioReview> createState() => _StudioReviewState();
}

class _StudioReviewState extends ConsumerState<StudioReview> {
  @override
  void initState() {
    ref
        .read(reviewDetailsControllerProvider.notifier)
        .getReviews(studioDocId: widget.studioDetails['studioDocId']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final reviewDetails = ref.watch(reviewDetailsControllerProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '${widget.studioDetails['name']} Reviews',
          style: GoogleFonts.lato(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color(0xFFF4F6F9),
            ),
            child: RatingWidget(
              label: 'Overall Raings',
              reviewCount: widget.studioDetails['totalReviews'],
              rating: widget.studioDetails['averageRating'],
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Color(0xFFF4F6F9),
              ),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: reviewDetails.length,
                  itemBuilder: (context, index) => IndiStudioReview(
                        name: reviewDetails[index].customerName ?? "Anonymous",
                        rating: reviewDetails[index].rating ?? 0.0,
                        reviewText:
                            reviewDetails[index].feedback ?? "No feedback",
                      )),
            ),
          ),
        ],
      ),
    );
  }
}
