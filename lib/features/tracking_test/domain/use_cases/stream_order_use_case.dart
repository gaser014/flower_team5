import 'package:injectable/injectable.dart';

import '../entities/order_entity.dart';
import '../repositories/tracking_repository.dart';

@Injectable()
class StreamOrderUseCase {
  final TrackingRepository repository;

  StreamOrderUseCase(this.repository);

  Stream<OrderEntity?> call(String orderId) {
    return repository.getOrderStream(orderId);
  }
}
