import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/cart/domain/entities/cart_entity.dart';
import 'package:flowers_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCartDataUseCase {
  final CartRepository repo;

  GetCartDataUseCase({required this.repo});

  Future<Result<CartEntity>> call() => repo.getCartData();
}
