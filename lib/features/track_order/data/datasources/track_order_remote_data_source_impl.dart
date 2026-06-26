import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flowers_app/features/track_order/data/datasources/track_order_remote_data_source.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: TrackOrderRemoteDataSource)
class TrackOrderRemoteDataSourceImpl implements TrackOrderRemoteDataSource {
  final FirebaseFirestore _firestore;

  TrackOrderRemoteDataSourceImpl(this._firestore);

  @override
  Stream<Map<String, dynamic>?> watchOrder(String orderId) {
    if (orderId.isEmpty) return const Stream.empty();
    return _firestore
        .collection('orders')
        .doc(orderId)
        .snapshots()
        .map((snapshot) => snapshot.data());
  }
}
