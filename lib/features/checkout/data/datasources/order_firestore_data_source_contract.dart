import 'package:flowers_app/features/checkout/domain/use_cases/checkout_params.dart';

abstract interface class OrderFirestoreDataSourceContract {
  Future<void> createOrder({
    required Map<String, dynamic> order,
    CheckoutParams? params,
    String? userId,
    String? userName,
  });
}
