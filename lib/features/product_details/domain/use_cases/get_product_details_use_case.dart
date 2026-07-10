import 'package:flowers_app/core/entities/product_entity.dart';
import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/product_details/domain/repositories/product_details_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProductDetailsUseCase {
  final ProductDetailsRepository _repository;

  GetProductDetailsUseCase(this._repository);

  Future<Result<ProductEntity>> execute(String id) {
    return _repository.getProductDetails(id);
  }
}
