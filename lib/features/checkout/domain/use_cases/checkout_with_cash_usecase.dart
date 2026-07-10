import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/checkout/domain/entities/cash_on_delivery_entity.dart';
import 'package:flowers_app/features/checkout/domain/repositories/checkout_repository.dart';
import 'package:flowers_app/features/checkout/domain/use_cases/checkout_params.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/uses_cases/use_cases.dart';

@injectable
class CheckoutWithCashUseCase
    extends UseCase<CashOnDeliveryEntity, CheckoutParams> {
  final CheckoutRepository _repository;

  CheckoutWithCashUseCase(this._repository);

  @override
  Future<Result<CashOnDeliveryEntity>> call(CheckoutParams params) {
    return _repository.checkoutWithCashOnDelivery(params);
  }
}
