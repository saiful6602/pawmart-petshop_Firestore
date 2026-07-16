import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// Product model representing a single item in the PawMart catalogue.
/// Stored in the Firestore `products` collection and managed from the
/// Firebase Console (see README "Add sample products" step).
///
/// Product photography is deliberately not used — each product instead
/// gets an icon + accent color derived from its category, which keeps the
/// catalogue visually consistent without bundling licensed images.
class Product {
  final String id;
  final String name;
  final String description;
  final String category;
  final double price;
  final double rating;
  final int reviewCount;
  final int stock;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.stock,
  });

  factory Product.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return Product(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      category: data['category'] ?? 'Other',
      price: (data['price'] ?? 0).toDouble(),
      rating: (data['rating'] ?? 0).toDouble(),
      reviewCount: (data['reviewCount'] ?? 0) as int,
      stock: (data['stock'] ?? 0) as int,
    );
  }

  String get formattedPrice => '৳${price.toStringAsFixed(0)}';

  String get shortDescription {
    if (description.length <= 80) return description;
    return '${description.substring(0, 80)}...';
  }

  bool get inStock => stock > 0;

  /// Icon representing this product's category.
  IconData get categoryIcon {
    switch (category) {
      case 'Dog Food':
        return Icons.pets_rounded;
      case 'Cat Food':
        return Icons.emoji_nature_rounded;
      case 'Toys':
        return Icons.sports_baseball_rounded;
      case 'Accessories':
        return Icons.checkroom_rounded;
      case 'Grooming':
        return Icons.content_cut_rounded;
      case 'Health & Wellness':
        return Icons.health_and_safety_rounded;
      case 'Bedding':
        return Icons.bed_rounded;
      case 'Aquarium':
        return Icons.water_rounded;
      default:
        return Icons.storefront_rounded;
    }
  }

  /// Accent color representing this product's category.
  Color get categoryColor {
    switch (category) {
      case 'Dog Food':
        return AppColors.accentAmber;
      case 'Cat Food':
        return AppColors.accentPlum;
      case 'Toys':
        return AppColors.accentBlue;
      case 'Accessories':
        return AppColors.accentTeal;
      case 'Grooming':
        return AppColors.accentGreen;
      case 'Health & Wellness':
        return AppColors.error;
      case 'Bedding':
        return AppColors.accentSlate;
      case 'Aquarium':
        return AppColors.accentBlue;
      default:
        return AppColors.primary;
    }
  }
}
