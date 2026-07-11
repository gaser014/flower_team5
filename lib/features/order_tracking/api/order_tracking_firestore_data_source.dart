import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flowers_app/features/order_tracking/data/datasources/order_tracking_remote_data_source_contract.dart';
import 'package:flowers_app/features/order_tracking/data/models/tracking_order_model.dart';
import 'package:flowers_app/features/order_tracking/domain/entities/order_tracking_args.dart';
import 'package:flowers_app/features/order_tracking/domain/entities/tracking_order_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OrderTrackingRemoteDataSourceContract)
class OrderTrackingFirestoreDataSource
    implements OrderTrackingRemoteDataSourceContract {
  final FirebaseFirestore _firestore;

  OrderTrackingFirestoreDataSource(this._firestore);

  static const String _ordersCollection = 'orders';

  CollectionReference<Map<String, dynamic>> get _orders =>
      _firestore.collection(_ordersCollection);

  @override
  Stream<TrackingOrderEntity> watchOrder(OrderTrackingArgs args) {
    if (args.orderId.isNotEmpty) {
      return _orders.doc(args.orderId).snapshots().map((snapshot) {
        final data = snapshot.data();
        if (data == null) {
          return TrackingOrderEntity(orderId: args.orderId);
        }
        return TrackingOrderModel.fromFirestore(data, snapshot.id);
      });
    }

    if (args.orderNumber.isNotEmpty) {
      return _orders
          .where('orderNumber', isEqualTo: args.orderNumber)
          .limit(1)
          .snapshots()
          .map((query) {
            if (query.docs.isEmpty) {
              return TrackingOrderEntity(orderNumber: args.orderNumber);
            }
            final doc = query.docs.first;
            return TrackingOrderModel.fromFirestore(doc.data(), doc.id);
          });
    }

    return const Stream.empty();
  }
}
