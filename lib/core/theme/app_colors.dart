import 'package:flutter/material.dart';

/// Brand color palette for PawMart.
/// Deep navy conveys trust/professionalism; warm amber adds warmth
/// appropriate for a pet-care brand, while staying formal/industry-level.
class AppColors {
  AppColors._();

  // Brand seeds
  static const Color primary = Color(0xFF1E3A5F);   // Deep navy blue
  static const Color secondary = Color(0xFFC97A3D);  // Warm amber / terracotta

  // Category accent palette (used for icon-card backgrounds)
  static const Color accentBlue = Color(0xFF3B6EA5);
  static const Color accentGreen = Color(0xFF3E7C5C);
  static const Color accentAmber = Color(0xFFC97A3D);
  static const Color accentPlum = Color(0xFF6B4E71);
  static const Color accentTeal = Color(0xFF2C7A7B);
  static const Color accentSlate = Color(0xFF54617A);

  // Star / Rating
  static const Color starYellow = Color(0xFFF59E0B);

  // Status
  static const Color success = Color(0xFF16A34A);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFDC2626);

  // Neutral
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
}
