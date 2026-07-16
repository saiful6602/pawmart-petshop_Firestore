import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../core/constants/app_constants.dart';
import '../models/order.dart';

/// Handles Create and Read operations for customer orders in Firestore.
///
/// Every order is tagged with the current signed-in (anonymous) user's uid,
/// and reads are scoped to that uid via Firestore security rules — so each
/// person only ever sees their own order history, even though the app and
/// its source code are public.
class OrderRepository {
  final CollectionReference _ordersCollection =
      FirebaseFirestore.instance.collection(AppConstants.ordersCollection);

  String get _uid {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw StateError('No signed-in user. Sign-in should complete in main.dart.');
    }
    return user.uid;
  }

  /// CREATE: Places a new order.
  Future<void> placeOrder({
    required String productId,
    required String productName,
    required double unitPrice,
    required int quantity,
    required String customerName,
    required String phone,
    required String address,
  }) async {
    final order = PetShopOrder(
      id: '',
      userId: _uid,
      productId: productId,
      productName: productName,
      unitPrice: unitPrice,
      quantity: quantity,
      totalAmount: unitPrice * quantity,
      customerName: customerName,
      phone: phone,
      address: address,
    );
    await _ordersCollection.add(order.toMap());
  }

  /// READ: Real-time stream of the current user's own orders, newest first.
  Stream<List<PetShopOrder>> getMyOrders() {
    return _ordersCollection
        .where('userId', isEqualTo: _uid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => PetShopOrder.fromFirestore(doc)).toList());
  }
}
