import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:studio_partner_app/src/features/stores/domain/entity/category_entity.dart';
import 'package:studio_partner_app/src/features/stores/domain/usecase/get_category_data.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetCategoryData _getCategoryData;
  CategoryBloc({required GetCategoryData getCategoryData})
      : _getCategoryData = getCategoryData,
        super(CategoryInitial()) {
    on<CategoryEvent>((event, emit) {
      // TODO: implement event handler
      emit(CategoryLoadingState());
    });
    on<GetCategory>(
      (event, emit) async {
        final res = await _getCategoryData.call(null);
        res.fold((l) => emit(CategoryFailureState(message: l.message)),
            (r) => emit(CategorySuccessState(categories: r)));
      },
    );
  }
}
