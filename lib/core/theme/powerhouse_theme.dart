/// PowerHouse Theme Configuration
///
/// Central theme definition for the PowerHouse app.
/// Material 3 baseline with custom color scheme and typography.
library;

import 'package:flutter/material.dart';
import 'powerhouse_colors.dart';
import 'powerhouse_typography.dart';
import 'theme_extensions.dart';

/// PowerHouse theme configuration.
///
/// Provides a complete ThemeData setup with:
/// - Material 3 design system
/// - Custom color scheme (calm + playful accents)
/// - Tablet-optimized typography
/// - Theme extensions for consistent styling
class PowerHouseTheme {
  PowerHouseTheme._();

  /// Light theme for PowerHouse app.
  ///
  /// Uses Material 3 with a calm, paper-like base and funky accent colors
  /// applied intentionally for progress indicators, highlights, and gamification.
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,

      // Color scheme - calm base with funky accents
      colorScheme: ColorScheme.light(
        // Primary - violet accent for main actions
        primary: PowerHouseColors.accentViolet,
        onPrimary: Colors.white,

        // Secondary - teal accent for secondary actions
        secondary: PowerHouseColors.accentTeal,
        onSecondary: Colors.white,

        // Tertiary - coral accent for tertiary elements
        tertiary: PowerHouseColors.accentCoral,
        onTertiary: Colors.white,

        // Surface colors - paper-like base
        surface: PowerHouseColors.surface,
        onSurface: PowerHouseColors.textPrimary,
        surfaceContainerHighest: PowerHouseColors.surfaceAlt,

        // Error - muted red, non-aggressive
        error: PowerHouseColors.error,
        onError: Colors.white,

        // Outline and divider
        outline: PowerHouseColors.divider,
        outlineVariant: PowerHouseColors.divider.withValues(alpha: 0.5),
      ),

      // Typography - tablet-optimized, reading-friendly
      textTheme: PowerHouseTypography.textTheme,

      // Card theme - consistent card styling
      cardTheme: CardThemeData(
        elevation: PowerHouseCardTokens.light.elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            PowerHouseCardTokens.light.radius,
          ),
        ),
        color: PowerHouseColors.surface,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),

      // Divider theme - subtle separation
      dividerTheme: DividerThemeData(
        color: PowerHouseColors.divider,
        thickness: 1.0,
        space: 1.0,
      ),

      // App bar theme - calm, minimal
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 1,
        backgroundColor: PowerHouseColors.background,
        foregroundColor: PowerHouseColors.textPrimary,
        titleTextStyle: PowerHouseTypography.textTheme.titleLarge,
        centerTitle: false,
      ),

      // Scaffold background - paper-like
      scaffoldBackgroundColor: PowerHouseColors.background,

      // Theme extensions - custom tokens
      extensions: <ThemeExtension<dynamic>>[
        PowerHouseCardTokens.light,
        PowerHouseAccentTokens.light,
      ],
    );
  }
}

