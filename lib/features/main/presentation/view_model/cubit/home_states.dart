part of 'home_cubit.dart';

class HomeStates extends Equatable {
  final int bottomNavIndex;
  final BaseState getAllHomeDataState;

  const HomeStates({
    this.bottomNavIndex = 0,
    this.getAllHomeDataState = const BaseState.initial(),
  });

  HomeStates copyWith({int? bottomNavIndex, BaseState? getAllHomeDataState}) {
    return HomeStates(
      bottomNavIndex: bottomNavIndex ?? this.bottomNavIndex,
      getAllHomeDataState: getAllHomeDataState ?? this.getAllHomeDataState,
    );
  }

  @override
  List<Object?> get props => [bottomNavIndex, getAllHomeDataState];
}
