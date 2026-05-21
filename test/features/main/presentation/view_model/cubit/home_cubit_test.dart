import 'package:bloc_test/bloc_test.dart';
import 'package:flowers_app/config/base_state/base_state.dart';
import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/home/domain/entities/home_entity.dart';
import 'package:flowers_app/features/home/domain/use_cases/get_home_use_case.dart';
import 'package:flowers_app/features/main/presentation/view_model/cubit/home_cubit.dart';
import 'package:flowers_app/features/main/presentation/view_model/cubit/home_events.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_cubit_test.mocks.dart';

@GenerateMocks([GetHomeUseCase])
void main() {
  late HomeCubit homeCubit;
  late MockGetHomeUseCase mockGetHomeUseCase;

  provideDummy<Result<HomeEntity>>(const Success(data: null));

  setUp(() {
    mockGetHomeUseCase = MockGetHomeUseCase();
    homeCubit = HomeCubit(mockGetHomeUseCase);
  });

  tearDown(() {
    homeCubit.close();
  });

  group('HomeCubit - getHomeData', () {
    const tHomeEntity = HomeEntity(
      products: [],
      categories: [],
      bestSeller: [],
      occasions: [],
    );

    blocTest<HomeCubit, HomeStates>(
      'emits [Loading, Success] when data is fetched successfully',
      build: () {
        when(
          mockGetHomeUseCase.call(any),
        ).thenAnswer((_) async => const Success(data: tHomeEntity));
        return homeCubit;
      },
      act: (cubit) => cubit.doIndented(GetAllHomeDataEvent()),
      expect: () => [
        const HomeStates(getAllHomeDataState: BaseState.loading()),
        const HomeStates(getAllHomeDataState: BaseState.success(tHomeEntity)),
      ],
      verify: (_) {
        verify(mockGetHomeUseCase.call(any)).called(1);
      },
    );

    blocTest<HomeCubit, HomeStates>(
      'emits [Loading, Error] when fetching data fails',
      build: () {
        final tException = Exception('Failed to fetch home data');
        when(
          mockGetHomeUseCase.call(any),
        ).thenAnswer((_) async => Error(exception: tException));
        return homeCubit;
      },
      act: (cubit) => cubit.doIndented(GetAllHomeDataEvent()),
      expect: () => [
        const HomeStates(getAllHomeDataState: BaseState.loading()),
        isA<HomeStates>().having(
          (s) => s.getAllHomeDataState.isError,
          'isError',
          true,
        ),
      ],
      verify: (_) {
        verify(mockGetHomeUseCase.call(any)).called(1);
      },
    );
  });

  group('HomeCubit - Navigation', () {
    blocTest<HomeCubit, HomeStates>(
      'emits new bottomNavIndex when ChangeBottomNavIndexEvent is triggered',
      build: () => homeCubit,
      act: (cubit) => cubit.doIndented(ChangeBottomNavIndexEvent(1)),
      expect: () => [const HomeStates(bottomNavIndex: 1)],
    );
  });
}
