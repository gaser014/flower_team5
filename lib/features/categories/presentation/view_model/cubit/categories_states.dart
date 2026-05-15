part of 'categories_cubit.dart';

class CategoriesStates extends Equatable {
  final PaginationState<AppFilterTabItemEntity> categoriesState;
  final AppFilterTabItemEntity? selectCategoryState;

  const CategoriesStates({
    this.categoriesState = const PaginationState(
      state: PaginationStateType.initial,
      data: [],
      query: CategoriesParams(),
    ),
    this.selectCategoryState = const AppFilterTabItemEntity(
      id: null,
      name: 'All',
    ),
  });

  CategoriesStates copyWith({
    PaginationState<AppFilterTabItemEntity>? categoriesState,
    AppFilterTabItemEntity? selectCategoryState,
  }) {
    return CategoriesStates(
      categoriesState: categoriesState ?? this.categoriesState,
      selectCategoryState: selectCategoryState ?? this.selectCategoryState,
    );
  }

  @override
  List<Object?> get props => [categoriesState, selectCategoryState];
}
