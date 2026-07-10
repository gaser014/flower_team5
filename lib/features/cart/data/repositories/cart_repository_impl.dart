import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/config/error_handling/failures.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/features/cart/data/datasources/cart_remote_data_source_contract.dart';
import 'package:flowers_app/features/cart/data/models/cart_response.dart';
import 'package:flowers_app/features/cart/data/models/post/cart_product_post_data.dart';
import 'package:flowers_app/features/cart/data/models/post/cart_update_data.dart';
import 'package:flowers_app/features/cart/domain/entities/cart_entity.dart';
import 'package:flowers_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CartRepository)
class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSourceContract cartRemoteDataSourceContract;

  CartRepositoryImpl({required this.cartRemoteDataSourceContract});
  Failures _toFailure(Exception? exception) {
    if (exception is Failures) return exception;
    return ServerFailure(
      errorMessage: exception?.toString() ?? AppStrings.unexpectedError,
    );
  }

  @override
  Future<Result<CartEntity>> getCartData() async {
    final response = await cartRemoteDataSourceContract.getCartData();
    return switch (response) {
      Success<CartResponse>() => Success<CartEntity>(
        data: response.data?.toCartEntity(),
      ),
      Error<CartResponse>() => Error<CartEntity>(
        exception: _toFailure(response.exception),
      ),
    };
  }

  @override
  Future<Result<void>> addProductToCart(CartProductPostData data) async {
    final response = await cartRemoteDataSourceContract.addProductToCart(data);
    return switch (response) {
      Success<void>() => const Success<void>(),
      Error<void>() => Error<void>(exception: _toFailure(response.exception)),
    };
  }

  @override
  Future<Result<void>> removeProductFromCart(String id) async {
    final response = await cartRemoteDataSourceContract.removeProductFromCart(
      id,
    );
    return switch (response) {
      Success<void>() => const Success<void>(),
      Error<void>() => Error<void>(exception: _toFailure(response.exception)),
    };
  }

  @override
  Future<Result<void>> clearUserCart() async {
    final response = await cartRemoteDataSourceContract.clearUserCart();
    return switch (response) {
      Success<void>() => const Success<void>(),
      Error<void>() => Error<void>(exception: _toFailure(response.exception)),
    };
  }

  @override
  Future<Result<void>> updateCartQuantity(
    String id,
    CartUpdateDataModel data,
  ) async {
    final response = await cartRemoteDataSourceContract.updateCartQuantity(
      id,
      data,
    );
    return switch (response) {
      Success<void>() => const Success<void>(),
      Error<void>() => Error<void>(exception: _toFailure(response.exception)),
    };
  }
}
