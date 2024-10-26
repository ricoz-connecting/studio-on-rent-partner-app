import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studio_partner_app/src/models/studio_review_model.dart';

import '../repo/review_repo.dart';

final reviewControllerProvider =
    StateNotifierProvider<ReviewController, List<StudioReviewsModel>>(
  (ref) {
    final repo = ref.watch(reviewRepoProvider);
    return ReviewController(repo: repo, ref: ref);
  },
);

class ReviewController extends StateNotifier<List<StudioReviewsModel>> {
  final ReviewRepo _repo;
  ReviewController({required ReviewRepo repo, required Ref ref})
      : _repo = repo,
        super([]);

  Future<void> getCustomerReviews() async {
    final result = await _repo.getReview();
    if (result != null && result.statusCode == 200) {
      final data = jsonDecode(result.body);
      final reviewData = data['data'] as List<dynamic>;
      List<StudioReviewsModel> products = reviewData
          .map((product) => StudioReviewsModel.fromJson(product))
          .toList();
      state = products;
    } else {
      throw Exception('Failed to fetch products');
    }
  }
}
