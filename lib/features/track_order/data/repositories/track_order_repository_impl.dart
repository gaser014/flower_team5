import 'package:flowers_app/features/track_order/data/datasources/track_order_remote_data_source.dart';
import 'package:flowers_app/features/track_order/data/mapper/track_order_mapper.dart';
import 'package:flowers_app/features/track_order/data/models/track_order_model.dart';
import 'package:flowers_app/features/track_order/domain/entities/track_order_entity.dart';
import 'package:flowers_app/features/track_order/domain/repositories/track_order_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: TrackOrderRepository)
class TrackOrderRepositoryImpl implements TrackOrderRepository {
  final TrackOrderRemoteDataSource _remoteDataSource;

  TrackOrderRepositoryImpl(this._remoteDataSource);

  @override
  Stream<TrackOrderEntity?> watchOrder(String orderId) {
    return _remoteDataSource.watchOrder(orderId).map((data) {
      if (data == null || data.isEmpty) return null;
      return TrackOrderModel.fromMap(orderId, data).toEntity();
    });
  }
}
