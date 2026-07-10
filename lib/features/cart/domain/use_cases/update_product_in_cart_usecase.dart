import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/cart/data/models/post/cart_update_data.dart';
import 'package:flowers_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateProductInCartUsecase {
  final CartRepository repo;

  UpdateProductInCartUsecase({required this.repo});

  Future<Result<void>> call(String id, CartUpdateDataModel data) =>
      repo.updateCartQuantity(id, data);
}
