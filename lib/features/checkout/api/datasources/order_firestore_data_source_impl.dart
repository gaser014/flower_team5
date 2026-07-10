import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flowers_app/features/checkout/data/datasources/order_firestore_data_source_contract.dart';
import 'package:flowers_app/features/checkout/domain/use_cases/checkout_params.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OrderFirestoreDataSourceContract)
class OrderFirestoreDataSourceImpl implements OrderFirestoreDataSourceContract {
  final FirebaseFirestore _firestore;

  OrderFirestoreDataSourceImpl(this._firestore);

  @override
  Future<void> createOrder({
    required Map<String, dynamic> order,
    CheckoutParams? params,
    String? userId,
    String? userName,
  }) async {
    final orderId = (order['_id'] ?? order['id'] ?? '').toString();
    if (orderId.isEmpty) return;

    await _firestore.collection('orders').doc(orderId).set({
      'orderId': orderId,
      'orderNumber': (order['orderNumber'] ?? '').toString(),
      'userId': userId ?? (order['user'] ?? '').toString(),
      'status': (order['status'] ?? 'pending').toString(),
      'paymentType': (order['paymentType'] ?? 'cash').toString(),
      'totalPrice': order['totalPrice'] ?? order['totalOrderPrice'] ?? 0,
      'customer': {
        'name': userName ?? '',
        'address': _buildAddress(order, params),
        'phone': _buildPhone(order, params),
      },
      'items': _buildItems(order),
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Map<String, dynamic> _shippingAddress(Map<String, dynamic> order) {
    return order['shippingAddress'] is Map
        ? (order['shippingAddress'] as Map).cast<String, dynamic>()
        : const {};
  }

  String _buildAddress(Map<String, dynamic> order, CheckoutParams? params) {
    final shipping = _shippingAddress(order);
    final street = (shipping['street'] ?? params?.street ?? '').toString();
    final city = (shipping['city'] ?? params?.city ?? '').toString();
    final parts = [street, city].where((part) => part.trim().isNotEmpty);
    return parts.join(', ');
  }

  String _buildPhone(Map<String, dynamic> order, CheckoutParams? params) {
    final shipping = _shippingAddress(order);
    return (shipping['phone'] ?? params?.phone ?? '').toString();
  }

  List<Map<String, dynamic>> _buildItems(Map<String, dynamic> order) {
    final rawItems =
        order['orderItems'] ?? order['cartItems'] ?? order['items'];
    if (rawItems is! List) return const [];

    return rawItems
        .whereType<Map>()
        .map((raw) {
          final item = raw.cast<String, dynamic>();
          final product = item['product'] is Map
              ? (item['product'] as Map).cast<String, dynamic>()
              : const <String, dynamic>{};
          return {
            'name': (product['title'] ?? product['name'] ?? item['name'] ?? '')
                .toString(),
            'description': (product['description'] ?? '').toString(),
            'image':
                (product['imgCover'] ??
                        product['image'] ??
                        product['imageCover'] ??
                        '')
                    .toString(),
            'price': item['price'] ?? product['price'] ?? 0,
            'quantity': item['quantity'] ?? item['count'] ?? 1,
          };
        })
        .toList(growable: false);
  }
}
