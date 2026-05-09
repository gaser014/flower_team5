import 'package:bloc_test/bloc_test.dart';
import 'package:flowers_app/config/base_response/entity/base_pagination_entity.dart';
import 'package:flowers_app/config/base_response/entity/meta_entity.dart';
import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/config/base_state/state_types.dart';
import 'package:flowers_app/features/categories/domain/entities/category_entity.dart';
import 'package:flowers_app/features/categories/domain/entities/categories_params.dart';
import 'package:flowers_app/features/categories/domain/use_cases/get_all_categories.dart';
import 'package:flowers_app/features/categories/presentation/view_model/cubit/categories_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

// Manual Mock
class MockGetAllCategoriesUseCase extends Mock implements GetAllCategoriesUseCase {
  @override
  Future<Result<BasePaginationEntity<CategoryEntity>>> call(CategoriesParams? params) =>
      super.noSuchMethod(
        Invocation.method(#call, [params]),
        returnValue: Future.value(Success(data: BasePaginationEntity<CategoryEntity>(
          meta: const MetaEntity(currentPage: 1, numberOfPages: 1, limit: 20, total: 0),
          data: [],
        ))),
      );
}

void main() {
  late MockGetAllCategoriesUseCase mockUseCase;
  late CategoriesCubit cubit;

  setUp(() {
    mockUseCase = MockGetAllCategoriesUseCase();
    cubit = CategoriesCubit(getAllCategoriesUseCase: mockUseCase);
  });

  tearDown(() {
    cubit.close();
  });

  final tCategory = const CategoryEntity(id: '1', name: 'Occasion');
  final tPaginationEntity = BasePaginationEntity<CategoryEntity>(
    meta: const MetaEntity(currentPage: 1, numberOfPages: 1, limit: 20, total: 1),
    data: [tCategory],
  );

  group('CategoriesCubit', () {
    test('initial state should have initial pagination and no selection', () {
      expect(cubit.state.categoriesState.state, PaginationStateType.initial);
      expect(cubit.state.selectCategoryState, isNull);
    });

    blocTest<CategoriesCubit, CategoriesStates>(
      'emits [loading, success] when GetAllCategoriesEvent is successful',
      build: () {
        when(mockUseCase.call(any)).thenAnswer((_) async => Success(data: tPaginationEntity));
        return cubit;
      },
      act: (cubit) => cubit.doIntent(const GetAllCategoriesEvent(params: CategoriesParams())),
      expect: () => [
        isA<CategoriesStates>().having((s) => s.categoriesState.state, 'state', PaginationStateType.loading),
        isA<CategoriesStates>().having((s) => s.categoriesState.state, 'state', PaginationStateType.success),
      ],
    );

    blocTest<CategoriesCubit, CategoriesStates>(
      'emits state with new selection when SelectCategoryEvent is called',
      build: () => cubit,
      act: (cubit) => cubit.doIntent(SelectCategoryEvent(category: tCategory)),
      expect: () => [
        isA<CategoriesStates>().having((s) => s.selectCategoryState, 'selected', tCategory),
      ],
    );
  });
}
