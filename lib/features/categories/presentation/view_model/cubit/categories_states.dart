part of 'categories_cubit.dart';

class CategoriesStates extends Equatable {
  final PaginationState<CategoryEntity> categoriesState;
  final CategoryEntity? selectCategoryState;

  const CategoriesStates({
    this.categoriesState = const PaginationState.initial(),
    this.selectCategoryState,
  });

  CategoriesStates copyWith({
    PaginationState<CategoryEntity>? categoriesState,
    CategoryEntity? selectCategoryState,
  }) {
    return CategoriesStates(
      categoriesState: categoriesState ?? this.categoriesState,
      selectCategoryState: selectCategoryState ?? this.selectCategoryState,
    );
  }

  @override
  List<Object?> get props => [categoriesState, selectCategoryState];
}
