part of 'review_bloc.dart';

@immutable
sealed class ReviewState {}

final class ReviewInitial extends ReviewState {}

class ReviewLoadingState extends ReviewState {}

class ReviewSuccessState extends ReviewState {
  final List<ReviewModel> reviews;

  ReviewSuccessState({required this.reviews});
}

class ReviewFailureState extends ReviewState {
  final String message;

  ReviewFailureState({required this.message});
}
