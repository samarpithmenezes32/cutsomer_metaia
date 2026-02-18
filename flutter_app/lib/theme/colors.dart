import 'package:flutter/material.dart';

class AppColors {
  // Primary colors - Matching Figma design
  static const Color primary = Color(0xFF7A1F1F); // Dark maroon (richer)
  static const Color primaryLight = Color(0xFF9E3030);
  static const Color primaryDark = Color(0xFF5A0F0F);

  // Background colors - Vibrant warm sandy gold
  static const Color background = Color(0xFFF0D9A8); // Rich warm golden sand
  static const Color backgroundTop = Color(0xFFF5E4BF); // Lighter top gradient
  static const Color backgroundBottom = Color(
    0xFFDAB96A,
  ); // Deeper golden bottom
  static const Color cardBackground = Color(0xFFFFFBF2); // Warm cream cards
  static const Color surfaceLight = Color(0xFFFDF0D5);

  // Text colors
  static const Color textPrimary = Color(0xFF333333);
  static const Color textSecondary = Color(0xFF666666);
  static const Color textLight = Color(0xFF999999);
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);

  // Accent colors
  static const Color gold = Color(0xFFD4AF37);
  static const Color goldLight = Color(0xFFF5E6D3);
  static const Color goldDark = Color(0xFFC5A028);
  static const Color accentCyan = Color(0xFF00BCD4);

  // Status colors
  static const Color success = Color(0xFF2E7D32);
  static const Color error = Color(0xFFD32F2F);
  static const Color danger = Color(0xFFD32F2F);
  static const Color warning = Color(0xFFFFC107);

  // Legacy colors for compatibility
  static const Color maroon = Color(0xFF7A1F1F);
  static const Color maroonDark = Color(0xFF1A0A0A);
  static const Color surface = Color.fromRGBO(255, 255, 255, 0.9);

  // Border and divider
  static const Color border = Color(0xFFE0E0E0);
  static const Color borderGold = Color.fromRGBO(212, 175, 55, 0.3);
  static const Color divider = Color(0xFFF0F0F0);

  // Shadow and muted
  static const Color shadow = Color(0x1A000000);
  static const Color muted = Color.fromRGBO(122, 31, 31, 0.7);
  static const Color mutedLight = Color.fromRGBO(122, 31, 31, 0.4);
}
