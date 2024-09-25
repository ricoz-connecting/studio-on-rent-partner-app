import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';

class IndiStudioReview extends StatelessWidget {
  const IndiStudioReview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
                const Text(
                  'John Doe',
                  style: TextStyle(fontSize: 18),
                ),
                StarRating(
                  rating: 4,
                  size: 16,
                ),
              ],
            )
          ],
        ),
        const SizedBox(height: 10),
        const Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. '),
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
