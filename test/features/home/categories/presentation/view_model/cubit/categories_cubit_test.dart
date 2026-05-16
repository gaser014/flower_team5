import 'package:bloc_test/bloc_test.dart';
import 'package:flowers_app/categories/domain/entities/categories_params.dart';
import 'package:flowers_app/categories/domain/entities/category_entity.dart';
import 'package:flowers_app/categories/domain/use_cases/get_all_categories.dart';
import 'package:flowers_app/categories/presentation/view_model/cubit/categories_cubit.dart';
import 'package:flowers_app/config/base_response/entity/base_pagination_entity.dart';
import 'package:flowers_app/config/base_response/entity/meta_entity.dart';
import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/config/base_state/pagination_state.dart';
import 'package:flowers_app/config/base_state/state_types.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'categories_cubit_test.mocks.dart';

@GenerateNiceMocks([MockSpec<GetAllCategoriesUseCase>()])
void main() {
  provideDummy<Result<BasePaginationEntity<CategoryEntity>>>(
    const Success<BasePaginationEntity<CategoryEntity>>(),
  );
  late CategoriesCubit cubit;
  late MockGetAllCategoriesUseCase mockGetAllCategoriesUseCase;

  setUp(() {
    mockGetAllCategoriesUseCase = MockGetAllCategoriesUseCase();
    cubit = CategoriesCubit(
      getAllCategoriesUseCase: mockGetAllCategoriesUseCase,
    );
  });

  tearDown(() {
    cubit.close();
  });

  final tCategory = CategoryEntity(id: '1', name: 'Category 1');
  final tCategoriesList = [tCategory];
  final tMeta = MetaEntity(
    total: 1,
    limit: 500,
    currentPage: 1,
    numberOfPages: 1,
  );
  final tPaginationEntity = BasePaginationEntity(
    meta: tMeta,
    data: tCategoriesList,
  );
  final tParams = CategoriesParams(page: 1);

  group('CategoriesCubit', () {
    test('initial state should be CategoriesStates', () {
      expect(cubit.state, const CategoriesStates());
    });

    blocTest<CategoriesCubit, CategoriesStates>(
      'emits [loading, success] when GetAllCategoriesEvent is successful',
      build: () {
        when(
          mockGetAllCategoriesUseCase.call(any),
        ).thenAnswer((_) async => Success(data: tPaginationEntity));
        return cubit;
      },
      act: (cubit) => cubit.doIntent(GetAllCategoriesEvent(params: tParams)),
      expect: () => [
        isA<CategoriesStates>().having(
          (s) => s.categoriesState.state,
          'loading state',
          PaginationStateType.loading,
        ),
        isA<CategoriesStates>()
            .having(
              (s) => s.categoriesState.state,
              'success state',
              PaginationStateType.success,
            )
            .having((s) => s.categoriesState.data, 'data', tCategoriesList)
            .having(
              (s) => s.selectCategoryState?.name,
              'default selected category',
              'All',
            ),
      ],
    );

    blocTest<CategoriesCubit, CategoriesStates>(
      'emits [loading, error] when GetAllCategoriesEvent fails',
      build: () {
        when(
          mockGetAllCategoriesUseCase.call(any),
        ).thenAnswer((_) async => Error(exception: Exception('Server Error')));
        return cubit;
      },
      act: (cubit) => cubit.doIntent(GetAllCategoriesEvent(params: tParams)),
      expect: () => [
        isA<CategoriesStates>().having(
          (s) => s.categoriesState.state,
          'loading state',
          PaginationStateType.loading,
        ),
        isA<CategoriesStates>().having(
          (s) => s.categoriesState.state,
          'error state',
          PaginationStateType.error,
        ),
      ],
    );

    blocTest<CategoriesCubit, CategoriesStates>(
      'emits [loadingMore, success] when LoadMoreCategoriesEvent is successful',
      build: () {
        // First set initial state to success to allow loading more
        when(
          mockGetAllCategoriesUseCase.call(any),
        ).thenAnswer((_) async => Success(data: tPaginationEntity));
        return cubit;
      },
      seed: () => CategoriesStates(
        categoriesState: PaginationState(
          state: PaginationStateType.success,
          data: tCategoriesList,
          meta: MetaEntity(
            total: 10,
            limit: 5,
            currentPage: 1,
            numberOfPages: 2,
          ),
          query: tParams,
        ),
      ),
      act: (cubit) => cubit.doIntent(
        LoadMoreCategoriesEvent(params: tParams.copyWith(page: 2)),
      ),
      expect: () => [
        isA<CategoriesStates>().having(
          (s) => s.categoriesState.state,
          'loadingMore state',
          PaginationStateType.loadingMore,
        ),
        isA<CategoriesStates>().having(
          (s) => s.categoriesState.state,
          'success state',
          PaginationStateType.success,
        ),
      ],
    );

    blocTest<CategoriesCubit, CategoriesStates>(
      'updates selectCategoryState when SelectCategoryEvent is added',
      build: () => cubit,
      act: (cubit) => cubit.doIntent(SelectCategoryEvent(category: tCategory)),
      expect: () => [
        isA<CategoriesStates>().having(
          (s) => s.selectCategoryState,
          'selected category',
          tCategory,
        ),
      ],
    );

    test('reset should emit initial state', () {
      cubit.reset();
      expect(cubit.state, const CategoriesStates());
    });
    group('clearError', () {
      blocTest<CategoriesCubit, CategoriesStates>(
        'clears error when categoriesState is in error state',
        build: () => cubit,
        seed: () => CategoriesStates(
          categoriesState: PaginationState(
            state: PaginationStateType.error,
            data: const [],
            query: tParams,
            exception: Exception('error'),
          ),
        ),
        act: (cubit) => cubit.clearError(),
        expect: () => [
          isA<CategoriesStates>().having(
            (s) => s.categoriesState.state,
            'initial state',
            PaginationStateType.initial,
          ),
        ],
      );
    });
  });
}
