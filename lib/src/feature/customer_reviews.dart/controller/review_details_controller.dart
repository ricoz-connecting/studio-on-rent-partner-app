import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studio_partner_app/src/feature/customer_reviews.dart/repo/review_repo.dart';

import '../../../models/review_model.dart';

final reviewDetailsControllerProvider =
    StateNotifierProvider<ReviewDetailsController, List<ReviewsModel>>(
  (ref) {
    final repo = ref.watch(reviewRepoProvider);
    return ReviewDetailsController(repo: repo, ref: ref);
  },
);

class ReviewDetailsController extends StateNotifier<List<ReviewsModel>> {
  final ReviewRepo _repo;
  ReviewDetailsController({required ReviewRepo repo, required Ref ref})
      : _repo = repo,
        super([]);

  Future<void> getReviews({required String studioDocId}) async {
    final result =
        await _repo.getStudioReviews(studioDocId: studioDocId);
    if (result != null && result.statusCode == 200) {
      final data = jsonDecode(result.body);
      final reviewData = data['data'] as List<dynamic>;
      List<ReviewsModel> reviews =
          reviewData.map((review) => ReviewsModel.fromJson(review)).toList();
      state = reviews;
    } else {
      throw Exception('Failed to fetch products');
    }
  }
}
