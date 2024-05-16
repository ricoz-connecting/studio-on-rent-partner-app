// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:studio_partner_app/src/commons/globals/studio_details.dart';
import 'package:studio_partner_app/src/core/themes/theme.dart';
import 'package:studio_partner_app/src/features/stores/presentation/widgets/filter_option_dialogue.dart';
import 'package:studio_partner_app/src/features/stores/presentation/widgets/filter_option_widget.dart';
import 'package:studio_partner_app/src/res/data.dart';

class ReviewTab extends StatefulWidget {
  const ReviewTab({
    Key? key,
    required this.reviewModels,
    required this.studioDetails,
  }) : super(key: key);
  final List<ReviewModel> reviewModels;
  final StudioDetails studioDetails;

  @override
  State<ReviewTab> createState() => _ReviewTabState();
}

class _ReviewTabState extends State<ReviewTab> {
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return SingleChildScrollView(
        child: Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Reviews",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: ColorAssets.blackFaded),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  FilterOptionsWidget(
                    label: 'Filter',
                    onTap: () => _showFilterOptionsDialog(context),
                    isSelected: selectedFilter != ReviewFilterEnum.all,
                  ),
                  const SizedBox(width: 15),
                  FilterOptionsWidget(
                    label: 'All',
                    onTap: () {
                      setState(() {
                        selectedFilter = ReviewFilterEnum.all;
                      });
                    },
                    isSelected: selectedFilter == ReviewFilterEnum.all,
                  ),
                ],
              ),
            ],
          ),
        ),
        // reviews

        const Divider(height: 1),
      ],
    ));
  }

  ReviewFilterEnum selectedFilter = ReviewFilterEnum.all;
  void _showFilterOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FilterOptionsDialog(
          onOptionSelected: (option) {
            setState(() {
              selectedFilter = option;
              switch (option) {
                case ReviewFilterEnum.lowRating:
                  AppData.reviewModels
                      .sort((a, b) => a.rating.compareTo(b.rating));
                  break;
                case ReviewFilterEnum.highRating:
                  AppData.reviewModels
                      .sort((a, b) => b.rating.compareTo(a.rating));
                  break;
                case ReviewFilterEnum.newReviews:
                  AppData.reviewModels.sort((a, b) => b.time.compareTo(a.time));
                  break;
                case ReviewFilterEnum.oldReviews:
                  AppData.reviewModels.sort((a, b) => a.time.compareTo(b.time));
                  break;
                case ReviewFilterEnum.all:
                  AppData.reviewModels.sort((a, b) => a.name.compareTo(b.name));
              }
            });
          },
        );
      },
    );
  }

  _reviewBuilder({required ReviewFilterEnum filter, review}) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        final color = Theme.of(context).colorScheme;

        return _container(color, review, index, context);
      },
      itemCount: review.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
    );
  }

  Container _container(ColorScheme color, List<ReviewModel> review, int index,
      BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: ColorAssets.lightGray))),
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 17, top: 17),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: color.secondary,
            radius: 15,
            child: FadeInImage(
              image: NetworkImage(review[index].photoUrl),
              placeholder: MemoryImage(Uint8List.fromList([])),
              imageErrorBuilder: (context, error, stackTrace) =>
                  Image.memory(Uint8List.fromList([])),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        review[index].name,
                        style: const TextStyle(
                          color: ColorAssets.blackFaded,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        DateFormat("dd-MM-yyyy").format(review[index].time),
                        style: const TextStyle(
                          color: ColorAssets.lightGray,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  review[index].review,
                  softWrap: true,
                  style: const TextStyle(
                    color: ColorAssets.lightGray,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                //raiting
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.star_rate,
                      size: 16,
                      color: ColorAssets.yellow,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      review[index].rating.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: ColorAssets.lightGray),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
