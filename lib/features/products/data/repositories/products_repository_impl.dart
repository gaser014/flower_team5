import 'package:flowers_app/config/base_response/entity/base_pagination_entity.dart';
import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/products/data/datasources/products_remote_data_source_contract.dart';
import 'package:flowers_app/features/products/data/fixtures/product_fixtures.dart';
import 'package:flowers_app/features/products/domain/entities/product_entity.dart';
import 'package:flowers_app/features/products/domain/entities/products_params.dart';
import 'package:flowers_app/features/products/domain/repositories/products_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProductsRepository)
class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsRemoteDataSourceContract productsRemoteDataSourceContract;

  ProductsRepositoryImpl({required this.productsRemoteDataSourceContract});

  @override
  Future<Result<BasePaginationEntity<ProductEntity>>> getAllProducts({
    required ProductsParams params,
  }) async {
    final result = await productsRemoteDataSourceContract.getAllProducts(
      params: params,
    );
    return result.makeDummyData(
      dummyData: BasePaginationEntity.dummyData<ProductEntity>(
        params: params,
        allData: ProductFixtures.dummyProducts,
      ),
      success: (data) => Success(data: data?.toEntity()),
      error: (exception) => Error(exception: exception),
    );
  }
}
