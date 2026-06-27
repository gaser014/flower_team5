import '../entities/order_entity.dart';
import '../entities/user_entity.dart';

abstract interface class TrackingRepository {
  Future<void> addUser(UserEntity user);
  Future<void> removeUserToken(String userId, String token);
  Future<void> updateUserTokenLang(String userId, String token, String lang);
  Future<String> addOrder(OrderEntity order);
  Future<void> updateOrder(OrderEntity order);
  Stream<OrderEntity?> getOrderStream(String orderId);
}
