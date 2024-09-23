import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:google_fonts/google_fonts.dart';

import 'widgets/indi_studio_review.dart';
import 'widgets/rating_widget.dart';

class StudioReview extends StatelessWidget {
  const StudioReview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Studio 1 Reviews',
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
            child: const RatingWidget(
              label: 'Overall Raings',
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Color(0xFFF4F6F9),
              ),
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) => const IndiStudioReview()),
            ),
          ),
        ],
      ),
    );
  }
}
