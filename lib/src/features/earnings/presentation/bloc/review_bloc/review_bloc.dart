import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:studio_partner_app/src/commons/globals/studio_details.dart';
import 'package:studio_partner_app/src/features/earnings/domain/usecase/review_usecase.dart';
import 'package:studio_partner_app/src/features/earnings/presentation/tabs/review_page.dart';

part 'review_event.dart';
part 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final ReviewUsecase _reviewUsecase;
  ReviewBloc({required ReviewUsecase reviewUsecase})
      : _reviewUsecase = reviewUsecase,
        super(ReviewInitial()) {
    on<ReviewEvent>((event, emit) {
      emit(ReviewLoadingState());
    });
    on<GetReviewEvent>(
      (event, emit) async {
        final res = await _reviewUsecase.call(event.agentId);
        res.fold((l) => emit(ReviewFailureState(message: l.message)),
            (r) => emit(ReviewSuccessState(reviews: r)));
      },
    );
  }
}
