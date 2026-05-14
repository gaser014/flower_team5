import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/core/entities/product_entity.dart';
import 'package:flowers_app/features/product_details/data/datasources/product_details_remote_data_source_contract.dart';
import 'package:flowers_app/features/product_details/domain/repositories/product_details_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProductDetailsRepository)
class ProductDetailsRepositoryImpl implements ProductDetailsRepository {
  final ProductDetailsRemoteDataSourceContract _remoteDataSource;

  ProductDetailsRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<ProductEntity>> getProductDetails(String id) async {
    try {
      final result = await _remoteDataSource.getProductDetails(id);
      return Result.success(result);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
