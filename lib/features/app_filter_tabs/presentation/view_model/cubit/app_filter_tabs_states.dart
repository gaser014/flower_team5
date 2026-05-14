part of 'app_filter_tabs_cubit.dart';

class AppFilterTabsStates extends Equatable {
  final PaginationState<AppFilterTabItemEntity> categoriesState;
  final AppFilterTabItemEntity? selectCategoryState;

  const AppFilterTabsStates({
    this.categoriesState = const PaginationState.initial(),
    this.selectCategoryState,
  });

  AppFilterTabsStates copyWith({
    PaginationState<AppFilterTabItemEntity>? categoriesState,
    AppFilterTabItemEntity? selectCategoryState,
  }) {
    return AppFilterTabsStates(
      categoriesState: categoriesState ?? this.categoriesState,
      selectCategoryState: selectCategoryState ?? this.selectCategoryState,
    );
  }

  @override
  List<Object?> get props => [categoriesState, selectCategoryState];
}
