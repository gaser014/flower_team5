import 'package:flowers_app/config/base_response/entity/base_pagination_entity.dart';
import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/config/uses_cases/use_cases.dart';
import 'package:flowers_app/features/products/domain/entities/product_entity.dart';
import 'package:flowers_app/features/products/domain/entities/products_params.dart';
import 'package:flowers_app/features/products/domain/repositories/products_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetAllProductsUseCase extends UseCase<BasePaginationEntity<ProductEntity>, ProductsParams> {
  final ProductsRepository repository;

  GetAllProductsUseCase(this.repository);

  @override
  Future<Result<BasePaginationEntity<ProductEntity>>> call(ProductsParams parm) {
    return repository.getAllProducts(params: parm);
  }
}
