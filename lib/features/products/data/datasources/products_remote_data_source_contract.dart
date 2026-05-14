import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/products/data/models/products_response_dto.dart';
import 'package:flowers_app/features/products/domain/entities/products_params.dart';


abstract interface  class ProductsRemoteDataSourceContract {
  Future<Result<ProductsResponseDto>> getAllProducts({required ProductsParams params});
}
