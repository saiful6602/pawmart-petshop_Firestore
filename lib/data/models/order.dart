import 'package:cloud_firestore/cloud_firestore.dart';

/// Represents a single customer order stored in the Firestore
/// `orders` collection. Created when a customer completes checkout.
class PetShopOrder {
  final String id;
  final String userId;
  final String productId;
  final String productName;
  final double unitPrice;
  final int quantity;
  final double totalAmount;
  final String customerName;
  final String phone;
  final String address;
  final Timestamp? createdAt;

  const PetShopOrder({
    required this.id,
    required this.userId,
    required this.productId,
    required this.productName,
    required this.unitPrice,
    required this.quantity,
    required this.totalAmount,
    required this.customerName,
    required this.phone,
    required this.address,
    this.createdAt,
  });

  factory PetShopOrder.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return PetShopOrder(
      id: doc.id,
      userId: data['userId'] ?? '',
      productId: data['productId'] ?? '',
      productName: data['productName'] ?? '',
      unitPrice: (data['unitPrice'] ?? 0).toDouble(),
      quantity: (data['quantity'] ?? 1) as int,
      totalAmount: (data['totalAmount'] ?? 0).toDouble(),
      customerName: data['customerName'] ?? '',
      phone: data['phone'] ?? '',
      address: data['address'] ?? '',
      createdAt: data['createdAt'] as Timestamp?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'productId': productId,
      'productName': productName,
      'unitPrice': unitPrice,
      'quantity': quantity,
      'totalAmount': totalAmount,
      'customerName': customerName,
      'phone': phone,
      'address': address,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}
