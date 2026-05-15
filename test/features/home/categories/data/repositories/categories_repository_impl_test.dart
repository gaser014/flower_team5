import 'package:flowers_app/config/base_response/entity/base_pagination_entity.dart';
import 'package:flowers_app/config/base_response/model/meta_dto.dart';
import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/categories/data/datasources/categories_remote_data_source_contract.dart';
import 'package:flowers_app/features/categories/data/models/categories_response_dto.dart';
import 'package:flowers_app/features/categories/data/models/category_dto.dart';
import 'package:flowers_app/features/categories/data/models/occasions_response_dto.dart';
import 'package:flowers_app/features/categories/data/repositories/categories_repository_impl.dart';
import 'package:flowers_app/features/categories/domain/entities/categories_params.dart';
import 'package:flowers_app/features/categories/domain/entities/category_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'categories_repository_impl_test.mocks.dart';

@GenerateMocks([CategoriesRemoteDataSourceContract])
void main() {
  provideDummy<Result<CategoriesResponseDto>>(
    const Success<CategoriesResponseDto>(),
  );
  provideDummy<Result<OccasionsResponseDto>>(
    const Success<OccasionsResponseDto>(),
  );
  late CategoriesRepositoryImpl repository;
  late MockCategoriesRemoteDataSourceContract mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockCategoriesRemoteDataSourceContract();
    repository = CategoriesRepositoryImpl(
      categoriesRemoteDataSourceContract: mockRemoteDataSource,
    );
  });

  final tParams = CategoriesParams(page: 1, type: CategoriesType.categories);
  final tOccasionsParams = CategoriesParams(
    page: 1,
    type: CategoriesType.occasions,
  );

  final tCategoryDto = CategoryDto(id: '1', name: 'Category 1');
  final tCategoriesResponseDto = CategoriesResponseDto(
    categories: [tCategoryDto],
    metadata: MetaDto(total: 1, limit: 500, currentPage: 1, numberOfPages: 1),
  );

  final tOccasionsResponseDto = OccasionsResponseDto(
    occasions: [tCategoryDto], // Occasions often use same DTO or similar
    metadata: MetaDto(total: 1, limit: 500, currentPage: 1, numberOfPages: 1),
  );

  group('getAllCategories', () {
    test(
      'should return categories when remote data source is successful',
      () async {
        // arrange
        when(
          mockRemoteDataSource.getAllCategories(params: anyNamed('params')),
        ).thenAnswer((_) async => Success(data: tCategoriesResponseDto));

        // act
        final result = await repository.getAllCategories(params: tParams);

        // assert
        expect(result, isA<Success<BasePaginationEntity<CategoryEntity>>>());
        verify(mockRemoteDataSource.getAllCategories(params: tParams));
      },
    );

    test(
      'should return occasions when type is occasions and remote data source is successful',
      () async {
        // arrange
        when(
          mockRemoteDataSource.getAllOccasions(params: anyNamed('params')),
        ).thenAnswer((_) async => Success(data: tOccasionsResponseDto));

        // act
        final result = await repository.getAllCategories(
          params: tOccasionsParams,
        );

        // assert
        expect(result, isA<Success<BasePaginationEntity<CategoryEntity>>>());
        verify(mockRemoteDataSource.getAllOccasions(params: tOccasionsParams));
      },
    );

    test('should return error when remote data source fails', () async {
      // arrange
      final tException = Exception('Server Error');
      when(
        mockRemoteDataSource.getAllCategories(params: anyNamed('params')),
      ).thenAnswer((_) async => Error(exception: tException));

      // act
      final result = await repository.getAllCategories(params: tParams);

      // assert
      expect(result, isA<Error<BasePaginationEntity<CategoryEntity>>>());
      final errorResult = result as Error<BasePaginationEntity<CategoryEntity>>;
      expect(errorResult.exception, tException);
    });
  });
}
