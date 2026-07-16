import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/app_strings.dart';
import '../../../data/models/product.dart';
import '../../../data/sources/order_repository.dart';
import '../widgets/checkout_summary.dart';
import '../widgets/purchase_form.dart';

/// Checkout screen — collects delivery info and places the order in
/// Cloud Firestore (CREATE operation).
class PurchaseScreen extends StatefulWidget {
  final Product product;

  const PurchaseScreen({super.key, required this.product});

  @override
  State<PurchaseScreen> createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen> {
  final _formKey = GlobalKey<FormState>();
  final OrderRepository _orderRepository = OrderRepository();

  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _addressController;
  late final TextEditingController _quantityController;

  bool _isPlacingOrder = false;
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _addressController = TextEditingController();
    _quantityController = TextEditingController(text: '1');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  void _onQuantityChanged() {
    final qty = int.tryParse(_quantityController.text.trim());
    if (qty != null && qty > 0) {
      setState(() => _quantity = qty);
    }
  }

  Future<void> _placeOrder() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isPlacingOrder = true);

    try {
      await _orderRepository.placeOrder(
        productId: widget.product.id,
        productName: widget.product.name,
        unitPrice: widget.product.price,
        quantity: _quantity,
        customerName: _nameController.text.trim(),
        phone: _phoneController.text.trim(),
        address: _addressController.text.trim(),
      );

      if (!mounted) return;
      _showSuccessDialog();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to place order: $e')),
      );
    } finally {
      if (mounted) setState(() => _isPlacingOrder = false);
    }
  }

  void _showSuccessDialog() {
    final colorScheme = Theme.of(context).colorScheme;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        icon: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: colorScheme.primary.withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.check_circle_rounded, color: colorScheme.primary, size: 32),
        ),
        title: const Text('Order Placed!', textAlign: TextAlign.center),
        content: const Text(
          AppConstants.orderSuccessMessage,
          textAlign: TextAlign.center,
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(ctx).popUntil((route) => route.isFirst);
              },
              child: const Text('Back to Home'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.checkoutTitle)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.spacingMD),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CheckoutSummary(product: widget.product, quantity: _quantity),
            const SizedBox(height: AppConstants.spacingLG),
            PurchaseForm(
              formKey: _formKey,
              nameController: _nameController,
              phoneController: _phoneController,
              addressController: _addressController,
              quantityController: _quantityController,
              onQuantityChanged: _onQuantityChanged,
            ),
            const SizedBox(height: AppConstants.spacingLG),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isPlacingOrder ? null : _placeOrder,
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                child: _isPlacingOrder
                    ? const SizedBox(
                        height: 20, width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : const Text(AppStrings.placeOrder, style: TextStyle(fontWeight: FontWeight.w700)),
              ),
            ),
            const SizedBox(height: AppConstants.spacingLG),
          ],
        ),
      ),
    );
  }
}
