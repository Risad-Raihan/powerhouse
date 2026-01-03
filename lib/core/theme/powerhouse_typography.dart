/// PowerHouse Typography System
///
/// Tablet-first, reading-friendly typography.
/// Designed for long reading sessions with comfortable line heights.
/// Uses system fonts (no external font dependencies).
library;

import 'package:flutter/material.dart';
import 'powerhouse_colors.dart';

/// Typography tokens for PowerHouse app.
///
/// All text styles are optimized for:
/// - Tablet reading comfort
/// - Long-form content
/// - Clear hierarchy without being overly condensed
class PowerHouseTypography {
  PowerHouseTypography._();

  /// Creates a TextTheme configured for PowerHouse design system.
  ///
  /// Uses system fonts with comfortable line heights for tablet reading.
  static TextTheme get textTheme {
    return TextTheme(
      // Dashboard titles and major headings
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.5,
        height: 1.2,
        color: PowerHouseColors.textPrimary,
      ),

      // Section headings and medium titles
      headlineMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.3,
        height: 1.3,
        color: PowerHouseColors.textPrimary,
      ),

      // Smaller headings
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.2,
        height: 1.3,
        color: PowerHouseColors.textPrimary,
      ),

      // Large body text - optimized for reading
      bodyLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.0,
        height: 1.6, // Comfortable line height for reading
        color: PowerHouseColors.textPrimary,
      ),

      // Standard body text
      bodyMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.0,
        height: 1.5,
        color: PowerHouseColors.textPrimary,
      ),

      // Small body text
      bodySmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.1,
        height: 1.4,
        color: PowerHouseColors.textSecondary,
      ),

      // Labels and metadata
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        height: 1.4,
        color: PowerHouseColors.textSecondary,
      ),

      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.2,
        height: 1.3,
        color: PowerHouseColors.textSecondary,
      ),

      // Small labels and metadata
      labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.3,
        height: 1.2,
        color: PowerHouseColors.textSecondary,
      ),

      // Display styles (for very large text if needed)
      displayLarge: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.8,
        height: 1.1,
        color: PowerHouseColors.textPrimary,
      ),

      displayMedium: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.6,
        height: 1.2,
        color: PowerHouseColors.textPrimary,
      ),

      displaySmall: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.5,
        height: 1.2,
        color: PowerHouseColors.textPrimary,
      ),

      // Title styles
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.2,
        height: 1.3,
        color: PowerHouseColors.textPrimary,
      ),

      titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.1,
        height: 1.4,
        color: PowerHouseColors.textPrimary,
      ),

      titleSmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.0,
        height: 1.4,
        color: PowerHouseColors.textPrimary,
      ),
    );
  }
}

