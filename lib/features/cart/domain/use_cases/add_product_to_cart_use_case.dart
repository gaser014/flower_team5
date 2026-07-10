import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/cart/data/models/post/cart_product_post_data.dart';
import 'package:flowers_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddProductToCartUseCase {
  final CartRepository repo;

  AddProductToCartUseCase({required this.repo});

  Future<Result<void>> call(CartProductPostData data) =>
      repo.addProductToCart(data);
}
