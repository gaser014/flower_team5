part of 'categories_cubit.dart';

class CategoriesStates extends Equatable {
  final PaginationState<CategoryEntity> categoriesState;

  const CategoriesStates({
    this.categoriesState = const PaginationState.initial(),
  });

  CategoriesStates copyWith({
    PaginationState<CategoryEntity>? categoriesState,
  }) {
    return CategoriesStates(
      categoriesState: categoriesState ?? this.categoriesState,
    );
  }

  @override
  List<Object?> get props => [categoriesState];
}
