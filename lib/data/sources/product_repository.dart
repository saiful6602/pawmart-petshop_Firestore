import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/constants/app_constants.dart';
import '../models/product.dart';

/// Handles all reads of the product catalogue from Cloud Firestore.
///
/// Products are managed centrally by the shop (added/edited from the
/// Firebase Console — see README), so this app only ever *reads* them.
/// Every customer sees the same real-time catalogue.
class ProductRepository {
  final CollectionReference _productsCollection =
      FirebaseFirestore.instance.collection(AppConstants.productsCollection);

  /// Real-time stream of every product in the catalogue, newest first.
  Stream<List<Product>> getProducts() {
    return _productsCollection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Product.fromFirestore(doc)).toList());
  }
}
