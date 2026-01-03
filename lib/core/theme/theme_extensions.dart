/// PowerHouse Theme Extensions
///
/// Custom ThemeExtension classes to avoid hardcoding values in widgets.
/// These tokens ensure consistent styling across the app.
library;

import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';
import 'powerhouse_colors.dart';

/// Card styling tokens for consistent card appearance.
///
/// Used by dashboard cards, content containers, and elevated surfaces.
/// Values are optimized for tablet-first layouts.
class PowerHouseCardTokens extends ThemeExtension<PowerHouseCardTokens> {
  /// Border radius for cards
  final double radius;

  /// Elevation/shadow depth for cards
  final double elevation;

  /// Padding inside cards
  final EdgeInsets padding;

  /// Alternative padding for smaller cards
  final EdgeInsets paddingSmall;

  const PowerHouseCardTokens({
    required this.radius,
    required this.elevation,
    required this.padding,
    required this.paddingSmall,
  });

  /// Default card tokens for PowerHouse design system
  static const PowerHouseCardTokens light = PowerHouseCardTokens(
    radius: 16.0,
    elevation: 1.0,
    padding: EdgeInsets.all(20.0),
    paddingSmall: EdgeInsets.all(12.0),
  );

  @override
  ThemeExtension<PowerHouseCardTokens> copyWith({
    double? radius,
    double? elevation,
    EdgeInsets? padding,
    EdgeInsets? paddingSmall,
  }) {
    return PowerHouseCardTokens(
      radius: radius ?? this.radius,
      elevation: elevation ?? this.elevation,
      padding: padding ?? this.padding,
      paddingSmall: paddingSmall ?? this.paddingSmall,
    );
  }

  @override
  ThemeExtension<PowerHouseCardTokens> lerp(
    ThemeExtension<PowerHouseCardTokens>? other,
    double t,
  ) {
    if (other is! PowerHouseCardTokens) {
      return this;
    }

    return PowerHouseCardTokens(
      radius: lerpDouble(radius, other.radius, t) ?? radius,
      elevation: lerpDouble(elevation, other.elevation, t) ?? elevation,
      padding: EdgeInsets.lerp(padding, other.padding, t) ?? padding,
      paddingSmall:
          EdgeInsets.lerp(paddingSmall, other.paddingSmall, t) ?? paddingSmall,
    );
  }
}

/// Accent and progress styling tokens.
///
/// Controls how funky accent colors are applied to progress indicators,
/// highlights, badges, and gamification elements.
/// Designed to be extensible for gradients in the future.
class PowerHouseAccentTokens extends ThemeExtension<PowerHouseAccentTokens> {
  /// Primary accent color (used for main progress/actions)
  final Color primaryAccent;

  /// Secondary accent color (used for secondary progress/actions)
  final Color secondaryAccent;

  /// Tertiary accent color (used for tertiary elements)
  final Color tertiaryAccent;

  /// Progress indicator intensity (0.0 to 1.0)
  /// Controls how vibrant progress indicators appear
  final double progressIntensity;

  /// Badge/highlight intensity (0.0 to 1.0)
  /// Controls how vibrant badges and highlights appear
  final double badgeIntensity;

  const PowerHouseAccentTokens({
    required this.primaryAccent,
    required this.secondaryAccent,
    required this.tertiaryAccent,
    required this.progressIntensity,
    required this.badgeIntensity,
  });

  /// Default accent tokens for PowerHouse design system
  static const PowerHouseAccentTokens light = PowerHouseAccentTokens(
    primaryAccent: PowerHouseColors.accentViolet,
    secondaryAccent: PowerHouseColors.accentTeal,
    tertiaryAccent: PowerHouseColors.accentCoral,
    progressIntensity: 0.8,
    badgeIntensity: 0.7,
  );

  @override
  ThemeExtension<PowerHouseAccentTokens> copyWith({
    Color? primaryAccent,
    Color? secondaryAccent,
    Color? tertiaryAccent,
    double? progressIntensity,
    double? badgeIntensity,
  }) {
    return PowerHouseAccentTokens(
      primaryAccent: primaryAccent ?? this.primaryAccent,
      secondaryAccent: secondaryAccent ?? this.secondaryAccent,
      tertiaryAccent: tertiaryAccent ?? this.tertiaryAccent,
      progressIntensity: progressIntensity ?? this.progressIntensity,
      badgeIntensity: badgeIntensity ?? this.badgeIntensity,
    );
  }

  @override
  ThemeExtension<PowerHouseAccentTokens> lerp(
    ThemeExtension<PowerHouseAccentTokens>? other,
    double t,
  ) {
    if (other is! PowerHouseAccentTokens) {
      return this;
    }

    return PowerHouseAccentTokens(
      primaryAccent: Color.lerp(primaryAccent, other.primaryAccent, t) ??
          primaryAccent,
      secondaryAccent:
          Color.lerp(secondaryAccent, other.secondaryAccent, t) ??
              secondaryAccent,
      tertiaryAccent:
          Color.lerp(tertiaryAccent, other.tertiaryAccent, t) ??
              tertiaryAccent,
      progressIntensity:
          lerpDouble(progressIntensity, other.progressIntensity, t) ??
              progressIntensity,
      badgeIntensity:
          lerpDouble(badgeIntensity, other.badgeIntensity, t) ?? badgeIntensity,
    );
  }
}

