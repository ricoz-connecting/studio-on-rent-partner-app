import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/feature/customer_reviews.dart/views/widgets/rating_widget.dart';
import 'package:studio_partner_app/src/res/colors.dart';

class CustomerReviewCard extends StatelessWidget {
  final String title;
  final double rating;
  final int reviewsCount;
  final String imageUrl;
  final String status;
  final VoidCallback onTap;
  const CustomerReviewCard({
    super.key,
    required this.title,
    required this.rating,
    required this.reviewsCount,
    required this.imageUrl,
    required this.status,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFF4F6F9),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Center(
                child: Image.network(
                  imageUrl,
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    color: AppColors.primaryBackgroundColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    status,
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          RatingWidget(
            label: title,
            reviewCount: reviewsCount,
            rating: rating,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ButtonStyle(
                padding: WidgetStateProperty.all(
                  const EdgeInsets.all(10),
                ),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                backgroundColor: const WidgetStatePropertyAll(Colors.white),
                elevation: WidgetStateProperty.all(3),
              ),
              onPressed: onTap,
              child: Row(
                children: [
                  Text(
                    'View All Reviews',
                    style: GoogleFonts.inter(
                        fontSize: 16, color: const Color(0xFF444444)),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Color(0xFF444444),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
