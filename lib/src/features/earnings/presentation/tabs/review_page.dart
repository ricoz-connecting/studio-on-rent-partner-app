import 'package:flutter/material.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
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
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("OverallRatings "),
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    Text("4.2 (Based on 345 reviews) "),
                  ],
                ),
                Reviews(),
                Reviews(),
                Reviews(),
                Reviews(),
              ],
            )),
      ),
    );
  }
}

class Reviews extends StatelessWidget {
  const Reviews({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        ListTile(
            leading: CircleAvatar(),
            title: Text("John Doe"),
            subtitle: Text("Ratings")),
        Padding(
          padding: EdgeInsets.all(18.0),
          child: Text(
              "*******************************************************************************************************************************************************"),
        )
      ],
    );
  }
}
