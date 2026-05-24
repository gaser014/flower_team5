part of 'home_cubit.dart';

class HomeState extends Equatable {
  final int bottomNavIndex;
  final AppFilterTabItemEntity? selectedCategory;
  final BaseState getAllHomeDataState;

  const HomeState({
    this.bottomNavIndex = 0,
    this.selectedCategory,
    this.getAllHomeDataState = const BaseState.initial(),
  });

  HomeState copyWith({
    int? bottomNavIndex,
    BaseState? getAllHomeDataState,
    AppFilterTabItemEntity? selectedCategory,
    bool clearSelectedCategory = false,
  }) {
    return HomeState(
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
