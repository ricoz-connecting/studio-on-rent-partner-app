// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studio_partner_app/src/commons/globals/agent_details.dart';
import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:studio_partner_app/src/commons/globals/studio_details.dart';
import 'package:studio_partner_app/src/features/earnings/presentation/bloc/review_bloc/review_bloc.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    context.read<ReviewBloc>().add(GetReviewEvent(agentId: globalAgentId));
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      child: Center(
        child: Container(
            padding: const EdgeInsets.all(9),
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: color.secondary,
              borderRadius: BorderRadius.circular(15),
            ),
            child: BlocConsumer<ReviewBloc, ReviewState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is ReviewSuccessState) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("OverallRatings "),
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          Text(
                              "${average(state.reviews.map((e) => e.rating.toDouble()).toList())} (Based on ${state.reviews.map((e) => e.rating.toDouble()).length} reviews) "),
                        ],
                      ),
                      for (var i in state.reviews) Reviews(reviewModel: i)
                    ],
                  );
                } else if (state is ReviewLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return const SizedBox();
                }
              },
            )),
      ),
    );
  }

  average(List<double> reviews) {
    double sum = reviews.map((number) => number).reduce((a, b) => a + b);
    double average = sum / reviews.length;
    return average;
  }
}

class Reviews extends StatelessWidget {
  const Reviews({
    Key? key,
    required this.reviewModel,
  }) : super(key: key);
  final ReviewModel reviewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: MemoryImage(reviewModel.photoUrl),
          ),
          title: Text(reviewModel.name),
          subtitle: AnimatedRatingStars(
            initialRating: reviewModel.rating.toDouble(),
            minRating: 0.0,
            maxRating: 5.0,
            filledColor: Colors.amber,
            emptyColor: Colors.grey,
            filledIcon: Icons.star,
            halfFilledIcon: Icons.star_half,
            emptyIcon: Icons.star_border,
            displayRatingValue: true,
            onChanged: (val) {},
            interactiveTooltips: true,
            customFilledIcon: Icons.star,
            customHalfFilledIcon: Icons.star_half,
            customEmptyIcon: Icons.star_border,
            starSize: 10.0,
            animationDuration: Duration(milliseconds: 300),
            animationCurve: Curves.easeInOut,
            readOnly: true,
          ),
        ),
        // Container(
        //   alignment: Alignment.centerLeft,
        //   child:
        // ),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.all(18.0),
          child: Text(reviewModel.review),
        )
      ],
    );
  }
}
