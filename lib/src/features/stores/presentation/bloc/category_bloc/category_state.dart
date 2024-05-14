part of 'category_bloc.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

class CategoryLoadingState extends CategoryState {}

class CategorySuccessState extends CategoryState {
  final List<CategoryEntity> categories;

  CategorySuccessState({required this.categories});
}

class CategoryFailureState extends CategoryState {
  final String message;

  CategoryFailureState({required this.message});
}
