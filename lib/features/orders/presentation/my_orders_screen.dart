import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../data/models/order.dart';
import '../../../data/sources/order_repository.dart';

/// Shows the current (anonymous) user's own past orders — READ operation,
/// scoped by Firestore security rules to their own uid.
class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderRepository = OrderRepository();
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.myOrdersTitle)),
      body: StreamBuilder<List<PetShopOrder>>(
        stream: orderRepository.getMyOrders(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final orders = snapshot.data ?? [];

          if (orders.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.spacingXL),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.receipt_long_outlined,
                        size: 56, color: colorScheme.onSurfaceVariant.withValues(alpha: 0.4)),
                    const SizedBox(height: AppConstants.spacingSM),
                    Text(AppStrings.noOrders,
                        style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
                        textAlign: TextAlign.center),
                  ],
                ),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(AppConstants.spacingMD),
            itemCount: orders.length,
            separatorBuilder: (_, __) => const SizedBox(height: AppConstants.spacingSM),
            itemBuilder: (context, index) {
              final order = orders[index];
              final date = order.createdAt != null
                  ? DateFormat('MMM d, h:mm a').format(order.createdAt!.toDate())
                  : '';

              return Container(
                padding: const EdgeInsets.all(AppConstants.spacingMD),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(AppConstants.radiusLG),
                  border: Border.all(color: colorScheme.outlineVariant.withValues(alpha: 0.5)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(order.productName,
                              style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
                        ),
                        Text(
                          CurrencyFormatter.format(order.totalAmount),
                          style: textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w800, color: colorScheme.primary),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text('Qty: ${order.quantity}  ·  ${order.address}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant)),
                    if (date.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(date,
                          style: textTheme.labelSmall?.copyWith(color: colorScheme.onSurfaceVariant)),
                    ],
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
