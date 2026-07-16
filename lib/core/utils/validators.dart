import '../constants/app_constants.dart';

/// Static utility class for form field validation.
class Validators {
  Validators._();

  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppConstants.validationNameEmpty;
    }
    if (value.trim().length < 3) {
      return AppConstants.validationNameShort;
    }
    return null;
  }

  /// Validates Bangladeshi phone number (11 digits starting with 01).
  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppConstants.validationPhoneEmpty;
    }
    final cleaned = value.replaceAll(RegExp(r'\s+'), '');
    if (!RegExp(r'^01[3-9]\d{8}$').hasMatch(cleaned)) {
      return AppConstants.validationPhoneInvalid;
    }
    return null;
  }

  static String? validateAddress(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppConstants.validationAddressEmpty;
    }
    if (value.trim().length < 10) {
      return AppConstants.validationAddressShort;
    }
    return null;
  }

  static String? validateQuantity(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppConstants.validationQuantityEmpty;
    }
    final qty = int.tryParse(value.trim());
    if (qty == null || qty < 1) {
      return AppConstants.validationQuantityInvalid;
    }
    return null;
  }
}
