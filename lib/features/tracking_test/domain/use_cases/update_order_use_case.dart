import 'package:injectable/injectable.dart';

import '../entities/order_entity.dart';
import '../repositories/tracking_repository.dart';

@Injectable()
class UpdateOrderUseCase {
  final TrackingRepository repository;

  UpdateOrderUseCase(this.repository);

  Future<void> call(OrderEntity order) {
    return repository.updateOrder(order);
  }
}
