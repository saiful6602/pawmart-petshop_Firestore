import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/validators.dart';
import '../../../shared/widgets/section_title.dart';

/// Delivery information + quantity input form for checkout.
class PurchaseForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController addressController;
  final TextEditingController quantityController;
  final VoidCallback onQuantityChanged;

  const PurchaseForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.phoneController,
    required this.addressController,
    required this.quantityController,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: AppStrings.deliveryInfo),
          const SizedBox(height: AppConstants.spacingMD),
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: AppStrings.fullNameLabel,
              hintText: AppStrings.fullNameHint,
              prefixIcon: Icon(Icons.person_outline_rounded),
            ),
            textInputAction: TextInputAction.next,
            validator: Validators.validateName,
          ),
          const SizedBox(height: AppConstants.spacingMD),
          TextFormField(
            controller: phoneController,
            decoration: const InputDecoration(
              labelText: AppStrings.phoneLabel,
              hintText: AppStrings.phoneHint,
              prefixIcon: Icon(Icons.phone_outlined),
            ),
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            validator: Validators.validatePhone,
          ),
          const SizedBox(height: AppConstants.spacingMD),
          TextFormField(
            controller: addressController,
            decoration: const InputDecoration(
              labelText: AppStrings.addressLabel,
              hintText: AppStrings.addressHint,
              prefixIcon: Icon(Icons.location_on_outlined),
              alignLabelWithHint: true,
            ),
            maxLines: 3,
            textInputAction: TextInputAction.next,
            validator: Validators.validateAddress,
          ),
          const SizedBox(height: AppConstants.spacingMD),
          TextFormField(
            controller: quantityController,
            decoration: const InputDecoration(
              labelText: AppStrings.quantityLabel,
              hintText: AppStrings.quantityHint,
              prefixIcon: Icon(Icons.numbers_rounded),
            ),
            keyboardType: TextInputType.number,
            validator: Validators.validateQuantity,
            onChanged: (_) => onQuantityChanged(),
          ),
        ],
      ),
    );
  }
}
