import 'package:flutter/material.dart';
import '../../data/models/product.dart';

/// Renders a product's visual as a soft gradient tile with a category
/// icon centered on top. Used instead of photography so the catalogue
/// never depends on bundled/licensed images.
class ProductImage extends StatelessWidget {
  final Product product;
  final double height;
  final double iconSize;
  final BorderRadius? borderRadius;

  const ProductImage({
    super.key,
    required this.product,
    this.height = 160,
    this.iconSize = 56,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final color = product.categoryColor;

    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: 0.16),
            color.withValues(alpha: 0.06),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      alignment: Alignment.center,
      child: Icon(
        product.categoryIcon,
        size: iconSize,
        color: color,
      ),
    );
  }
}
