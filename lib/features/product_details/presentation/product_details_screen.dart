import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/routes/app_router.dart';
import '../../../data/models/product.dart';
import '../../../shared/widgets/product_image.dart';
import '../widgets/product_info_section.dart';

/// Product details screen — full product info with modern layout.
class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  void _navigateToPurchase(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.purchase, arguments: product);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: AppConstants.productDetailsImageHeight,
            pinned: true,
            backgroundColor: colorScheme.surfaceContainerLowest,
            surfaceTintColor: Colors.transparent,
            leading: Padding(
              padding: const EdgeInsets.all(AppConstants.spacingSM),
              child: _CircleButton(
                icon: Icons.arrow_back_rounded,
                onTap: () => Navigator.pop(context),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppConstants.spacingLG, 70, AppConstants.spacingLG, AppConstants.spacingLG,
                ),
                child: ProductImage(
                  product: product,
                  height: double.infinity,
                  iconSize: 96,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(AppConstants.radiusXL)),
              ),
              child: ProductInfoSection(product: product),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _BottomBuyBar(
        price: product.formattedPrice,
        inStock: product.inStock,
        onBuyNow: () => _navigateToPurchase(context),
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _CircleButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: colorScheme.surface.withValues(alpha: 0.92),
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: colorScheme.shadow.withValues(alpha: 0.1), blurRadius: 8)],
        ),
        child: Icon(icon, size: 18, color: colorScheme.onSurface),
      ),
    );
  }
}

class _BottomBuyBar extends StatelessWidget {
  final String price;
  final bool inStock;
  final VoidCallback onBuyNow;
  const _BottomBuyBar({required this.price, required this.inStock, required this.onBuyNow});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(top: BorderSide(color: colorScheme.outlineVariant.withValues(alpha: 0.5))),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppConstants.spacingMD, AppConstants.spacingSM, AppConstants.spacingMD, AppConstants.spacingMD,
          ),
          child: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Total price', style: textTheme.labelSmall?.copyWith(color: colorScheme.onSurfaceVariant)),
                  const SizedBox(height: 2),
                  Text(price,
                      style: textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800, color: colorScheme.primary, letterSpacing: -0.5)),
                ],
              ),
              const SizedBox(width: AppConstants.spacingMD),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: inStock ? onBuyNow : null,
                  icon: const Icon(Icons.shopping_bag_outlined, size: 18),
                  label: Text(inStock ? 'Buy Now' : 'Out of Stock'),
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
