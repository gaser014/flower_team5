abstract class TrackOrderRemoteDataSource {
  Stream<Map<String, dynamic>?> watchOrder(String orderId);
}
