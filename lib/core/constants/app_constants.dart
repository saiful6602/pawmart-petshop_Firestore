/// Central location for all app-wide constants.
class AppConstants {
  AppConstants._();

  static const String appName = 'PawMart';
  static const String tagline = 'Everything Your Pet Needs';

  // Firestore collection names
  static const String productsCollection = 'products';
  static const String ordersCollection = 'orders';

  // Spacing
  static const double spacingXS = 4.0;
  static const double spacingSM = 8.0;
  static const double spacingMD = 16.0;
  static const double spacingLG = 24.0;
  static const double spacingXL = 32.0;
  static const double spacingXXL = 48.0;

  // Border radius
  static const double radiusSM = 8.0;
  static const double radiusMD = 12.0;
  static const double radiusLG = 16.0;
  static const double radiusXL = 24.0;

  // Product card
  static const double productImageHeight = 180.0;
  static const double productDetailsImageHeight = 260.0;

  // Snackbar duration
  static const Duration snackbarDuration = Duration(seconds: 3);

  // Validation messages
  static const String validationNameEmpty = 'Please enter your full name';
  static const String validationNameShort = 'Name must be at least 3 characters';
  static const String validationPhoneEmpty = 'Please enter your phone number';
  static const String validationPhoneInvalid = 'Please enter a valid 11-digit phone number';
  static const String validationAddressEmpty = 'Please enter your delivery address';
  static const String validationAddressShort = 'Address must be at least 10 characters';
  static const String validationQuantityEmpty = 'Please enter quantity';
  static const String validationQuantityInvalid = 'Quantity must be at least 1';

  // Success message
  static const String orderSuccessMessage = 'Order placed successfully! 🐾';
}
