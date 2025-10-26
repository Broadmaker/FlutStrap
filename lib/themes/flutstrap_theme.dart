import 'package:flutter/material.dart';

/// Flutstrap Theme System
///
/// Main theme entry point that exports all theme-related classes and utilities.
/// Provides light and dark theme variants with consistent design tokens.

export '../core/theme.dart';

/// Pre-defined theme constants and shortcuts
class FlutstrapTheme {
  /// Default primary color (Bootstrap blue)
  static const Color defaultPrimary = Color(0xFF0D6EFD);

  /// Default success color (Bootstrap green)
  static const Color defaultSuccess = Color(0xFF198754);

  /// Default danger color (Bootstrap red)
  static const Color defaultDanger = Color(0xFFDC3545);

  /// Default warning color (Bootstrap yellow)
  static const Color defaultWarning = Color(0xFFFFC107);

  /// Default info color (Bootstrap cyan)
  static const Color defaultInfo = Color(0xFF0DCAF0);

  /// Common border radius values
  static const double borderRadiusSm = 4.0;
  static const double borderRadiusMd = 6.0;
  static const double borderRadiusLg = 8.0;
  static const double borderRadiusXl = 12.0;

  /// Common shadow values
  static const List<BoxShadow> shadowSm = [
    BoxShadow(
      blurRadius: 2,
      offset: Offset(0, 1),
      color: Color(0x1A000000),
    ),
  ];

  static const List<BoxShadow> shadowMd = [
    BoxShadow(
      blurRadius: 8,
      offset: Offset(0, 2),
      color: Color(0x1A000000),
    ),
  ];

  static const List<BoxShadow> shadowLg = [
    BoxShadow(
      blurRadius: 16,
      offset: Offset(0, 4),
      color: Color(0x1A000000),
    ),
  ];

  /// Common transition durations
  static const Duration transitionFast = Duration(milliseconds: 150);
  static const Duration transitionNormal = Duration(milliseconds: 300);
  static const Duration transitionSlow = Duration(milliseconds: 500);
}
