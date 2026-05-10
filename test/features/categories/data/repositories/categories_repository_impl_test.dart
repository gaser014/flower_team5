import 'package:flowers_app/config/base_response/entity/base_pagination_entity.dart';
import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/categories/data/datasources/categories_remote_data_source_contract.dart';
import 'package:flowers_app/features/categories/data/models/categories_response_dto.dart';
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

  late CategoriesRepositoryImpl categoriesRepositoryImpl;
  late MockCategoriesRemoteDataSourceContract mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockCategoriesRemoteDataSourceContract();
    categoriesRepositoryImpl = CategoriesRepositoryImpl(
      categoriesRemoteDataSourceContract: mockRemoteDataSource,
    );
  });

  group('getAllCategories - type: categories', () {
    const tParams = CategoriesParams(type: CategoriesType.categories);

    final tResponseDto = CategoriesResponseDto(
      message: 'success',
      categories: [],
    );

    test('should return Success when getAllCategories succeeds', () async {
      when(
        mockRemoteDataSource.getAllCategories(params: anyNamed('params')),
      ).thenAnswer(
        (_) async => Success<CategoriesResponseDto>(data: tResponseDto),
      );

      final result = await categoriesRepositoryImpl.getAllCategories(
        params: tParams,
      );
      expect(result, isA<Success<BasePaginationEntity<CategoryEntity>>>());

      verify(
        mockRemoteDataSource.getAllCategories(params: anyNamed('params')),
      ).called(1);
      verifyNever(
        mockRemoteDataSource.getAllOccasions(params: anyNamed('params')),
      );
    });

    test('should return Error when getAllCategories fails', () async {
      final tException = Exception('network error');

      when(
        mockRemoteDataSource.getAllCategories(params: anyNamed('params')),
      ).thenAnswer(
        (_) async => Error<CategoriesResponseDto>(exception: tException),
      );

      final result = await categoriesRepositoryImpl.getAllCategories(
        params: tParams,
      );
      expect(result, isA<Error<BasePaginationEntity<CategoryEntity>>>());

      final errorResult = result as Error<BasePaginationEntity<CategoryEntity>>;
      expect(errorResult.exception, tException);

      verify(
        mockRemoteDataSource.getAllCategories(params: anyNamed('params')),
      ).called(1);
    });
  });

  group('getAllCategories - type: occasions', () {
    const tParams = CategoriesParams(type: CategoriesType.occasions);

    final tResponseDto = OccasionsResponseDto(
      message: 'success',
      occasions: [],
    );

    test('should return Success when getAllOccasions succeeds', () async {
      when(
        mockRemoteDataSource.getAllOccasions(params: anyNamed('params')),
      ).thenAnswer(
        (_) async => Success<OccasionsResponseDto>(data: tResponseDto),
      );
      final result = await categoriesRepositoryImpl.getAllCategories(
        params: tParams,
      );
      expect(result, isA<Success<BasePaginationEntity<CategoryEntity>>>());

      verify(
        mockRemoteDataSource.getAllOccasions(params: anyNamed('params')),
      ).called(1);
      verifyNever(
        mockRemoteDataSource.getAllCategories(params: anyNamed('params')),
      );
    });

    test('should return Error when getAllOccasions fails', () async {
      final tException = Exception('occasions error');

      when(
        mockRemoteDataSource.getAllOccasions(params: anyNamed('params')),
      ).thenAnswer(
        (_) async => Error<OccasionsResponseDto>(exception: tException),
      );
      final result = await categoriesRepositoryImpl.getAllCategories(
        params: tParams,
      );
      expect(result, isA<Error<BasePaginationEntity<CategoryEntity>>>());

      final errorResult = result as Error<BasePaginationEntity<CategoryEntity>>;
      expect(errorResult.exception, tException);

      verify(
        mockRemoteDataSource.getAllOccasions(params: anyNamed('params')),
      ).called(1);
    });
  });
}
