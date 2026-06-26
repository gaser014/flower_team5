import '../entities/order_entity.dart';
import '../entities/user_entity.dart';

abstract interface class TrackingRepository {
  Future<void> addUser(UserEntity user);
  Future<String> addOrder(OrderEntity order);
  Future<void> updateOrder(OrderEntity order);
  Stream<OrderEntity?> getOrderStream(String orderId);
}
