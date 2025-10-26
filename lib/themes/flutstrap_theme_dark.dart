import 'package:flutter/material.dart';
import 'flutstrap_theme.dart';
import '../core/theme.dart';

/// Flutstrap Dark Theme
///
/// Pre-configured dark theme with Bootstrap-inspired design tokens.
class FlutstrapThemeDark {
  /// Default dark theme with Bootstrap blue as primary color
  static FSThemeData get defaultTheme => FSThemeData.dark();

  /// Dark theme with custom primary color
  static FSThemeData custom(Color primaryColor) =>
      FSThemeData.dark(seedColor: primaryColor);

  /// Dark theme with success color scheme (green)
  static FSThemeData get success =>
      FSThemeData.dark(seedColor: FlutstrapTheme.defaultSuccess);

  /// Dark theme with danger color scheme (red)
  static FSThemeData get danger =>
      FSThemeData.dark(seedColor: FlutstrapTheme.defaultDanger);

  /// Dark theme with warning color scheme (yellow)
  static FSThemeData get warning =>
      FSThemeData.dark(seedColor: FlutstrapTheme.defaultWarning);

  /// Dark theme with info color scheme (cyan)
  static FSThemeData get info =>
      FSThemeData.dark(seedColor: FlutstrapTheme.defaultInfo);

  /// Dark theme with purple color scheme
  static FSThemeData get purple =>
      FSThemeData.dark(seedColor: const Color(0xFF6F42C1));

  /// Dark theme with pink color scheme
  static FSThemeData get pink =>
      FSThemeData.dark(seedColor: const Color(0xFFD63384));

  /// Dark theme with orange color scheme
  static FSThemeData get orange =>
      FSThemeData.dark(seedColor: const Color(0xFFFD7E14));

  /// Dark theme with teal color scheme
  static FSThemeData get teal =>
      FSThemeData.dark(seedColor: const Color(0xFF20C997));

  /// Dark theme with indigo color scheme
  static FSThemeData get indigo =>
      FSThemeData.dark(seedColor: const Color(0xFF6610F2));
}
