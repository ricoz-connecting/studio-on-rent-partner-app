import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'widgets/customer_review_card.dart';

class CustomerReview extends StatelessWidget {
  const CustomerReview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Customer Reviews',
          style: GoogleFonts.lato(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) => const CustomerReviewCard()),
    );
  }
}

