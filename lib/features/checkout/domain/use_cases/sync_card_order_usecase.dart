import 'package:flowers_app/features/checkout/domain/repositories/checkout_repository.dart';
import 'package:flowers_app/features/checkout/domain/use_cases/checkout_params.dart';
import 'package:injectable/injectable.dart';

@injectable
class SyncCardOrderUseCase {
  final CheckoutRepository _repository;

  SyncCardOrderUseCase(this._repository);

  Future<void> call(CheckoutParams params) => _repository.syncCardOrder(params);
}
