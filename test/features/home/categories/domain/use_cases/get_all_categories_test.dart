import 'package:flowers_app/config/base_response/entity/base_pagination_entity.dart';
import 'package:flowers_app/config/base_response/entity/meta_entity.dart';
import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/categories/domain/entities/categories_params.dart';
import 'package:flowers_app/features/categories/domain/entities/category_entity.dart';
import 'package:flowers_app/features/categories/domain/repositories/categories_repository.dart';
import 'package:flowers_app/features/categories/domain/use_cases/get_all_categories.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_all_categories_test.mocks.dart';

@GenerateMocks([CategoriesRepository])
void main() {
  provideDummy<Result<BasePaginationEntity<CategoryEntity>>>(
    const Success<BasePaginationEntity<CategoryEntity>>(),
  );
  late GetAllCategoriesUseCase useCase;
  late MockCategoriesRepository mockRepository;

  setUp(() {
    mockRepository = MockCategoriesRepository();
    useCase = GetAllCategoriesUseCase(mockRepository);
  });

  final tParams = CategoriesParams(page: 1);
  final tCategory = CategoryEntity(id: '1', name: 'Category 1');
  final tCategoriesList = [tCategory];
  final tMeta = MetaEntity(
    total: 1,
    limit: 500,
    currentPage: 1,
    numberOfPages: 1,
  );
  final tPaginationEntity = BasePaginationEntity(meta: tMeta, data: tCategoriesList);

  test('should get categories from the repository', () async {
    // arrange
    when(mockRepository.getAllCategories(params: anyNamed('params')))
        .thenAnswer((_) async => Success(data: tPaginationEntity));

    // act
    final result = await useCase.call(tParams);

    // assert
    expect(result, isA<Success<BasePaginationEntity<CategoryEntity>>>());
    final successResult = result as Success<BasePaginationEntity<CategoryEntity>>;
    expect(successResult.data, tPaginationEntity);
    verify(mockRepository.getAllCategories(params: tParams));
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return error when repository fails', () async {
    // arrange
    final tException = Exception('Server Failure');
    when(mockRepository.getAllCategories(params: anyNamed('params')))
        .thenAnswer((_) async => Error(exception: tException));

    // act
    final result = await useCase.call(tParams);

    // assert
    expect(result, isA<Error<BasePaginationEntity<CategoryEntity>>>());
    final errorResult = result as Error<BasePaginationEntity<CategoryEntity>>;
    expect(errorResult.exception, tException);
    verify(mockRepository.getAllCategories(params: tParams));
    verifyNoMoreInteractions(mockRepository);
  });
}
