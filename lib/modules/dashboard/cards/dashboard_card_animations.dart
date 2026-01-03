/// Shared animation constants and utilities for dashboard cards
///
/// Centralizes animation durations, curves, and transition builders
/// to ensure consistent, calm animations across all cards.
library;

import 'package:flutter/material.dart';

/// Duration for UI state transitions (icon changes, color updates)
const Duration kUiAnimDuration = Duration(milliseconds: 300);

/// Duration for progress bar/ring animations (smoother, longer)
const Duration kProgressAnimDuration = Duration(milliseconds: 700);

/// Curve for UI state animations (quick, responsive)
const Curve kUiCurve = Curves.easeOut;

/// Curve for progress animations (smooth, calming)
const Curve kProgressCurve = Curves.easeInOut;

/// Shared AnimatedSwitcher transition builder
///
/// Provides a consistent fade + slight scale transition for icon/content changes.
/// Calm and subtle, avoiding aggressive motion.
Widget Function(Widget child, Animation<double> animation)
    dashboardCardTransitionBuilder = (
  Widget child,
  Animation<double> animation,
) {
  return FadeTransition(
    opacity: animation,
    child: ScaleTransition(
      scale: Tween<double>(begin: 0.9, end: 1.0).animate(
        CurvedAnimation(
          parent: animation,
          curve: kUiCurve,
        ),
      ),
      child: child,
    ),
  );
};

