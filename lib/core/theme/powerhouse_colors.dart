/// PowerHouse Color System
///
/// Token-based color palette following the design direction:
/// - Calm, paper-like base colors
/// - Funky accent colors (softened, not aggressive)
/// - No pure black or white
/// - Tablet-first, reading-friendly
library;

import 'package:flutter/material.dart';

/// Centralized color tokens for PowerHouse app.
///
/// All colors are designed to be:
/// - Calm and soothing for reading
/// - Playful where accents are used
/// - Tablet-optimized for long sessions
class PowerHouseColors {
  PowerHouseColors._();

  // ============================================================================
  // BASE COLORS (Calm foundation)
  // ============================================================================

  /// Background color - paper-like off-white, warm and soft
  /// Used for: main app background, reading surfaces
  static const Color background = Color(0xFFFAF8F5);

  /// Surface color - cards and elevated surfaces
  /// Used for: dashboard cards, content containers
  static const Color surface = Color(0xFFFFFFFF);

  /// Alternative surface - subtle tinted cards for visual hierarchy
  /// Used for: secondary cards, nested surfaces
  static const Color surfaceAlt = Color(0xFFF5F3F0);

  /// Primary text color - calm, readable, not pure black
  /// Used for: main content, headings, important text
  static const Color textPrimary = Color(0xFF2C2C2C);

  /// Secondary text color - softer, less emphasis
  /// Used for: metadata, captions, secondary information
  static const Color textSecondary = Color(0xFF6B6B6B);

  /// Divider color - subtle separation
  /// Used for: list dividers, section separators
  static const Color divider = Color(0xFFE0DDD8);

  // ============================================================================
  // FUNKY ACCENT COLORS (Controlled usage)
  // ============================================================================

  /// Teal accent - playful but softened
  /// Used for: progress indicators, highlights, badges
  static const Color accentTeal = Color(0xFF4ECDC4);

  /// Violet accent - vibrant but muted
  /// Used for: primary actions, important highlights
  static const Color accentViolet = Color(0xFF9B7EDE);

  /// Coral accent - warm and inviting
  /// Used for: gamification elements, achievements
  static const Color accentCoral = Color(0xFFFF8A80);

  /// Lime accent - fresh and energetic
  /// Used for: success states, positive feedback
  static const Color accentLime = Color(0xFFC5E1A5);

  /// Amber accent - warm and friendly
  /// Used for: warnings, attention (non-punitive)
  static const Color accentAmber = Color(0xFFFFB74D);

  // ============================================================================
  // SEMANTIC COLORS (Non-aggressive)
  // ============================================================================

  /// Success color - soft green, encouraging
  /// Used for: completed tasks, positive states
  static const Color success = Color(0xFF81C784);

  /// Warning color - warm amber, not alarming
  /// Used for: gentle reminders, optional actions
  static const Color warning = Color(0xFFFFB74D);

  /// Error color - muted red, not aggressive or shaming
  /// Used for: errors that need attention, but without guilt UX
  static const Color error = Color(0xFFE57373);
}

