import 'package:injectable/injectable.dart';

import '../entities/order_entity.dart';
import '../repositories/tracking_repository.dart';

@Injectable()
class AddOrderUseCase {
  final TrackingRepository repository;

  AddOrderUseCase(this.repository);

  Future<String> call(OrderEntity order) {
    return repository.addOrder(order);
  }
}
