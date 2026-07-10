import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/config/uses_cases/use_cases.dart';
import 'package:flowers_app/features/checkout/domain/entities/credit_card_entity.dart';
import 'package:flowers_app/features/checkout/domain/repositories/checkout_repository.dart';
import 'package:flowers_app/features/checkout/domain/use_cases/checkout_params.dart';
import 'package:injectable/injectable.dart';

@injectable
class CheckoutWithCardUseCase
    extends UseCase<CreditCardEntity, CheckoutParams> {
  final CheckoutRepository _repository;

  CheckoutWithCardUseCase(this._repository);

  @override
  Future<Result<CreditCardEntity>> call(CheckoutParams params) {
    return _repository.checkoutWithCreditCard(params);
  }
}
