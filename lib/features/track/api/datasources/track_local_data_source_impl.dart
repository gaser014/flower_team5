import 'package:flowers_app/config/database/cache_helper.dart';
import 'package:flowers_app/features/track/data/datasources/track_local_data_source_contract.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: TrackLocalDataSourceContract)
class TrackLocalDataSourceImpl implements TrackLocalDataSourceContract {
  static const String _lastTrackedOrderIdKey = 'last_tracked_order_id';

  @override
  Future<String?> getLastTrackedOrderId() =>
      AppSharedPreferences.getString(key: _lastTrackedOrderIdKey);

  @override
  Future<void> saveLastTrackedOrderId(String orderId) async {
    if (orderId.isEmpty) return;
    await AppSharedPreferences.setString(
      key: _lastTrackedOrderIdKey,
      value: orderId,
    );
  }
}
