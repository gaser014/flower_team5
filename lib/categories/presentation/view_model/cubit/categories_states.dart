part of 'categories_cubit.dart';

class CategoriesStates extends Equatable {
  final PaginationState<CategoryEntity> categoriesState;
  final CategoryEntity? selectCategoryState;

  const CategoriesStates({
    this.categoriesState = const PaginationState(
      state: PaginationStateType.initial,
      data: [],
      query: CategoriesParams(),
    ),
    this.selectCategoryState = const CategoryEntity(id: null, name: 'All'),
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
