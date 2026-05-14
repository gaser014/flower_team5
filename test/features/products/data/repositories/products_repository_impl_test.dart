import 'package:flowers_app/config/base_response/entity/base_pagination_entity.dart';
import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/products/data/datasources/products_remote_data_source_contract.dart';
import 'package:flowers_app/features/products/data/models/products_response_dto.dart';
import 'package:flowers_app/features/products/data/repositories/products_repository_impl.dart';
import 'package:flowers_app/features/products/domain/entities/product_entity.dart';
import 'package:flowers_app/features/products/domain/entities/products_params.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'products_repository_impl_test.mocks.dart';

@GenerateMocks([ProductsRemoteDataSourceContract])
void main() {
  provideDummy<Result<ProductsResponseDto>>(
    const Success<ProductsResponseDto>(),
  );

  late ProductsRepositoryImpl productsRepositoryImpl;
  late MockProductsRemoteDataSourceContract mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockProductsRemoteDataSourceContract();
    productsRepositoryImpl = ProductsRepositoryImpl(
      productsRemoteDataSourceContract: mockRemoteDataSource,
    );
  });

  group('getAllProducts', () {
    const tParams = ProductsParams();

    final tResponseDto = ProductsResponseDto(message: 'success', products: []);

    test('should return Success when getAllProducts succeeds', () async {
      when(
        mockRemoteDataSource.getAllProducts(params: anyNamed('params')),
      ).thenAnswer(
        (_) async => Success<ProductsResponseDto>(data: tResponseDto),
      );
      final result = await productsRepositoryImpl.getAllProducts(
        params: tParams,
      );
      expect(result, isA<Success<BasePaginationEntity<ProductEntity>>>());

      verify(
        mockRemoteDataSource.getAllProducts(params: anyNamed('params')),
      ).called(1);
    });

    test(
      'should return Success with dummy data when getAllProducts fails in debug mode',
      () async {
        final tException = Exception('network error');

        when(
          mockRemoteDataSource.getAllProducts(params: anyNamed('params')),
        ).thenAnswer(
          (_) async => Error<ProductsResponseDto>(exception: tException),
        );

        final result = await productsRepositoryImpl.getAllProducts(
          params: tParams,
        );
        expect(result, isA<Success<BasePaginationEntity<ProductEntity>>>());
        verify(
          mockRemoteDataSource.getAllProducts(params: anyNamed('params')),
        ).called(1);
      },
    );
  });
}
