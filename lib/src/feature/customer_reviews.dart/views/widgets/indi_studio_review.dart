import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';

class IndiStudioReview extends StatelessWidget {
  final String name;
  final double rating;
  final String reviewText;
  const IndiStudioReview({
    super.key,
    required this.name,
    required this.rating,
    required this.reviewText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Row(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.grey,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontSize: 18),
                ),
                StarRating(
                  rating: rating,
                  size: 16,
                ),
              ],
            )
          ],
        ),
        const SizedBox(height: 10),
        Text(
          reviewText,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 10),
        const Text(
          'Jan 20, 2024 04:45pm',
          style: TextStyle(color: Color(0xFF868686)),
        ),
        const Divider(),
      ],
    );
  }
}
