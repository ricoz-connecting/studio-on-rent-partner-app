part of 'review_bloc.dart';

@immutable
sealed class ReviewEvent {}

class GetReviewEvent extends ReviewEvent {
  final String agentId;

  GetReviewEvent({required this.agentId});
}
