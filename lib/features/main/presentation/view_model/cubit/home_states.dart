part of 'home_cubit.dart';

class HomeStates extends Equatable {
  final int bottomNavIndex;

  const HomeStates({this.bottomNavIndex = 0});

  HomeStates copyWith({int? bottomNavIndex}) {
    return HomeStates(
      bottomNavIndex: bottomNavIndex ?? this.bottomNavIndex,
    );
  }

  @override
  List<Object?> get props => [bottomNavIndex];
}
