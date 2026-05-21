part of 'home_cubit.dart';

class HomeState extends Equatable {
  final int bottomNavIndex;
  final BaseState getAllHomeDataState;

  const HomeState({
    this.bottomNavIndex = 0,
    this.getAllHomeDataState = const BaseState.initial(),
  });

  HomeState copyWith({int? bottomNavIndex, BaseState? getAllHomeDataState}) {
    return HomeState(
      bottomNavIndex: bottomNavIndex ?? this.bottomNavIndex,
      getAllHomeDataState: getAllHomeDataState ?? this.getAllHomeDataState,
    );
  }

  @override
  List<Object?> get props => [bottomNavIndex, getAllHomeDataState];
}
