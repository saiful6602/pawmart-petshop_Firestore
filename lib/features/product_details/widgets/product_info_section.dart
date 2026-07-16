import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../data/models/product.dart';
import '../../../shared/widgets/rating_bar.dart';
import '../../../shared/widgets/section_title.dart';

/// Full product info panel rendered inside the details screen.
class ProductInfoSection extends StatelessWidget {
  final Product product;

  const ProductInfoSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppConstants.spacingMD, AppConstants.spacingLG, AppConstants.spacingMD, AppConstants.spacingXXL,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category + stock row
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: AppConstants.spacingSM, vertical: 3),
                decoration: BoxDecoration(
                  color: product.categoryColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppConstants.radiusSM),
                ),
                child: Text(
                  product.category,
                  style: textTheme.labelSmall?.copyWith(
                    color: product.categoryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: AppConstants.spacingSM),
              Container(
                width: 7,
                height: 7,
                decoration: BoxDecoration(
                  color: product.inStock ? const Color(0xFF22C55E) : colorScheme.error,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                product.inStock ? 'In Stock (${product.stock})' : 'Out of Stock',
                style: textTheme.labelSmall?.copyWith(
                  color: product.inStock ? const Color(0xFF16A34A) : colorScheme.error,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: AppConstants.spacingMD),

          Text(
            product.name,
            style: textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
              height: 1.2,
            ),
          ),

          const SizedBox(height: AppConstants.spacingSM),

          RatingBar(rating: product.rating, reviewCount: product.reviewCount, starSize: 16),

          const SizedBox(height: AppConstants.spacingLG),

          // Price block
          Container(
            padding: const EdgeInsets.all(AppConstants.spacingMD),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer.withValues(alpha: 0.35),
              borderRadius: BorderRadius.circular(AppConstants.radiusMD),
              border: Border.all(color: colorScheme.primary.withValues(alpha: 0.15)),
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Price', style: textTheme.labelSmall?.copyWith(color: colorScheme.onSurfaceVariant)),
                    const SizedBox(height: 2),
                    Text(
                      product.formattedPrice,
                      style: textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: colorScheme.primary,
                        letterSpacing: -1,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Icon(product.categoryIcon, size: 40, color: product.categoryColor.withValues(alpha: 0.5)),
              ],
            ),
          ),

          const SizedBox(height: AppConstants.spacingLG),
          Divider(color: colorScheme.outlineVariant.withValues(alpha: 0.5)),
          const SizedBox(height: AppConstants.spacingMD),

          const SectionTitle(title: 'About this product'),
          const SizedBox(height: AppConstants.spacingMD),
          Text(
            product.description,
            style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant, height: 1.75),
          ),

          const SizedBox(height: AppConstants.spacingLG),
          _SpecsGrid(product: product),
        ],
      ),
    );
  }
}

class _SpecsGrid extends StatelessWidget {
  final Product product;
  const _SpecsGrid({required this.product});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final specs = [
      ('Category', product.category),
      ('Rating', '${product.rating} / 5.0'),
      ('Reviews', '${product.reviewCount} verified'),
      ('Delivery', 'Free & Fast'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: 'Specifications', barColor: colorScheme.secondary),
        const SizedBox(height: AppConstants.spacingMD),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConstants.radiusMD),
            border: Border.all(color: colorScheme.outlineVariant.withValues(alpha: 0.5)),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: List.generate(specs.length, (i) {
              final isLast = i == specs.length - 1;
              return Container(
                decoration: BoxDecoration(
                  color: i.isEven ? colorScheme.surfaceContainerLowest : colorScheme.surface,
                  border: isLast
                      ? null
                      : Border(bottom: BorderSide(color: colorScheme.outlineVariant.withValues(alpha: 0.4))),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.spacingMD, vertical: AppConstants.spacingSM + 2,
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(specs[i].$1,
                          style: textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant, fontWeight: FontWeight.w500)),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(specs[i].$2,
                          style: textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
