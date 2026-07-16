/// Utility for formatting currency values in Bangladeshi Taka (BDT).
class CurrencyFormatter {
  CurrencyFormatter._();

  static const String _symbol = '৳';

  /// Formats a double as a Taka string with thousands separator.
  /// Example: 1500.0 → '৳1,500'
  static String format(double amount) {
    final rounded = amount.round();
    final formatted = _addThousandSeparator(rounded);
    return '$_symbol$formatted';
  }

  static String _addThousandSeparator(int value) {
    final str = value.toString();
    final buffer = StringBuffer();
    final length = str.length;
    for (int i = 0; i < length; i++) {
      if (i > 0 && (length - i) % 3 == 0) {
        buffer.write(',');
      }
      buffer.write(str[i]);
    }
    return buffer.toString();
  }
}
