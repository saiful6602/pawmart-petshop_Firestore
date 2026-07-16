import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../data/models/product.dart';
import '../../../shared/widgets/product_image.dart';
import '../../../shared/widgets/section_title.dart';

/// Displays the product being purchased with live quantity/total.
class CheckoutSummary extends StatelessWidget {
  final Product product;
  final int quantity;

  const CheckoutSummary({super.key, required this.product, required this.quantity});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final total = product.price * quantity;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: AppStrings.orderSummary),
        const SizedBox(height: AppConstants.spacingMD),
        Container(
          padding: const EdgeInsets.all(AppConstants.spacingSM),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(AppConstants.radiusMD),
            border: Border.all(color: colorScheme.outlineVariant.withValues(alpha: 0.5)),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 64,
                height: 64,
                child: ProductImage(product: product, height: 64, iconSize: 28),
              ),
              const SizedBox(width: AppConstants.spacingSM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
                    const SizedBox(height: 4),
                    Text(
                      '${AppStrings.unitPrice}: ${product.formattedPrice} × $quantity',
                      style: textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppConstants.spacingMD),
        Container(
          padding: const EdgeInsets.all(AppConstants.spacingMD),
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(AppConstants.radiusMD),
          ),
          child: Row(
            children: [
              Text(AppStrings.totalAmount,
                  style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
              const Spacer(),
              Text(
                CurrencyFormatter.format(total),
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800, color: colorScheme.primary, letterSpacing: -0.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
