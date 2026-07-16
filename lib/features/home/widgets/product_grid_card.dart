import 'package:flutter/material.dart';
import '../../../data/models/product.dart';
import '../../../core/routes/app_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/widgets/product_image.dart';
import '../../../shared/widgets/rating_bar.dart';

/// Compact grid card for 2-column product display on the Home screen.
class ProductGridCard extends StatelessWidget {
  final Product product;

  const ProductGridCard({super.key, required this.product});

  void _navigateToDetails(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.productDetails, arguments: product);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => _navigateToDetails(context),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(AppConstants.radiusLG),
          border: Border.all(
            color: colorScheme.outlineVariant.withValues(alpha: 0.5),
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: Stack(
                children: [
                  ProductImage(
                    product: product,
                    height: double.infinity,
                    borderRadius: BorderRadius.zero,
                  ),
                  Positioned(
                    top: AppConstants.spacingXS,
                    left: AppConstants.spacingXS,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: colorScheme.surface.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(AppConstants.radiusSM),
                      ),
                      child: Text(
                        product.category,
                        style: textTheme.labelSmall?.copyWith(
                          color: product.categoryColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 9,
                        ),
                      ),
                    ),
                  ),
                  if (!product.inStock)
                    Positioned(
                      top: AppConstants.spacingXS,
                      right: AppConstants.spacingXS,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: colorScheme.error,
                          borderRadius: BorderRadius.circular(AppConstants.radiusSM),
                        ),
                        child: Text(
                          'Out of stock',
                          style: textTheme.labelSmall?.copyWith(
                            color: colorScheme.onError,
                            fontWeight: FontWeight.w700,
                            fontSize: 8,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.spacingSM),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.2,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppConstants.spacingXS),
                    RatingBar(
                      rating: product.rating,
                      reviewCount: product.reviewCount,
                      starSize: 12,
                    ),
                    const Spacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            product.formattedPrice,
                            style: textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: colorScheme.primary,
                              letterSpacing: -0.3,
                            ),
                          ),
                        ),
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: colorScheme.primary,
                            borderRadius: BorderRadius.circular(AppConstants.radiusSM),
                          ),
                          child: Icon(
                            Icons.arrow_forward_rounded,
                            size: 15,
                            color: colorScheme.onPrimary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
