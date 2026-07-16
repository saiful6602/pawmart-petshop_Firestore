import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// Displays a star rating with an optional review count, e.g. "4.5 (128)".
class RatingBar extends StatelessWidget {
  final double rating;
  final int reviewCount;
  final double starSize;

  const RatingBar({
    super.key,
    required this.rating,
    required this.reviewCount,
    this.starSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star_rounded, size: starSize, color: AppColors.starYellow),
        const SizedBox(width: 3),
        Text(
          rating.toStringAsFixed(1),
          style: textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        if (reviewCount > 0) ...[
          const SizedBox(width: 3),
          Text(
            '($reviewCount)',
            style: textTheme.labelSmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ],
    );
  }
}
