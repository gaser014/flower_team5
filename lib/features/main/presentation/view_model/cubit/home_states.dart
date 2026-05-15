part of 'home_cubit.dart';

class HomeStates extends Equatable {
  final int bottomNavIndex;
  final AppFilterTabItemEntity? selectedCategory;
  final BaseState getAllHomeDataState;

  const HomeStates({
    this.bottomNavIndex = 0,
    this.selectedCategory,
    this.getAllHomeDataState = const BaseState.initial(),
  });

  HomeStates copyWith({
    int? bottomNavIndex,
    BaseState? getAllHomeDataState,
    AppFilterTabItemEntity? selectedCategory,
    bool clearSelectedCategory = false,
  }) {
    return HomeStates(
      bottomNavIndex: bottomNavIndex ?? this.bottomNavIndex,
      getAllHomeDataState: getAllHomeDataState ?? this.getAllHomeDataState,
      selectedCategory: clearSelectedCategory
          ? selectedCategory
          : selectedCategory ?? this.selectedCategory,
    );
  }

  @override
  List<Object?> get props => [bottomNavIndex, getAllHomeDataState];
}
