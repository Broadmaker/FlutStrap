import 'package:flutter/material.dart';
import 'flutstrap_theme.dart';
import '../core/theme.dart';

/// Flutstrap Light Theme
///
/// Pre-configured light theme with Bootstrap-inspired design tokens.
class FlutstrapThemeLight {
  /// Default light theme with Bootstrap blue as primary color
  static FSThemeData get defaultTheme => FSThemeData.light();

  /// Light theme with custom primary color
  static FSThemeData custom(Color primaryColor) =>
      FSThemeData.light(seedColor: primaryColor);

  /// Light theme with success color scheme (green)
  static FSThemeData get success =>
      FSThemeData.light(seedColor: FlutstrapTheme.defaultSuccess);

  /// Light theme with danger color scheme (red)
  static FSThemeData get danger =>
      FSThemeData.light(seedColor: FlutstrapTheme.defaultDanger);

  /// Light theme with warning color scheme (yellow)
  static FSThemeData get warning =>
      FSThemeData.light(seedColor: FlutstrapTheme.defaultWarning);

  /// Light theme with info color scheme (cyan)
  static FSThemeData get info =>
      FSThemeData.light(seedColor: FlutstrapTheme.defaultInfo);

  /// Light theme with purple color scheme
  static FSThemeData get purple =>
      FSThemeData.light(seedColor: const Color(0xFF6F42C1));

  /// Light theme with pink color scheme
  static FSThemeData get pink =>
      FSThemeData.light(seedColor: const Color(0xFFD63384));

  /// Light theme with orange color scheme
  static FSThemeData get orange =>
      FSThemeData.light(seedColor: const Color(0xFFFD7E14));

  /// Light theme with teal color scheme
  static FSThemeData get teal =>
      FSThemeData.light(seedColor: const Color(0xFF20C997));

  /// Light theme with indigo color scheme
  static FSThemeData get indigo =>
      FSThemeData.light(seedColor: const Color(0xFF6610F2));
}
