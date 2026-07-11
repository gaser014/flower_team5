abstract interface class TrackLocalDataSourceContract {
  /// Returns the id of the last order the customer tracked, if any.
  Future<String?> getLastTrackedOrderId();

  /// Persists [orderId] as the last order the customer tracked.
  Future<void> saveLastTrackedOrderId(String orderId);
}
