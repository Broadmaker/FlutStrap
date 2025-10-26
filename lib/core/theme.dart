/// Flutstrap Theming System
///
/// Provides a comprehensive theming system with light/dark mode support,
/// color schemes, typography, and component-specific themes.

import 'package:flutter/material.dart';
import 'breakpoints.dart';
import 'spacing.dart';

/// Flutstrap Color Scheme
///
/// Defines the color palette for the Flutstrap theme system
class FSColorScheme {
  final Color primary;
  final Color secondary;
  final Color success;
  final Color danger;
  final Color warning;
  final Color info;
  final Color light;
  final Color dark;
  final Color white;
  final Color black;
  final Color transparent;
  final Color background;
  final Color surface;
  final Color onPrimary;
  final Color onSecondary;
  final Color onBackground;
  final Color onSurface;
  final Color shadow;
  final Color outline;

  const FSColorScheme({
    required this.primary,
    required this.secondary,
    required this.success,
    required this.danger,
    required this.warning,
    required this.info,
    required this.light,
    required this.dark,
    required this.white,
    required this.black,
    required this.transparent,
    required this.background,
    required this.surface,
    required this.onPrimary,
    required this.onSecondary,
    required this.onBackground,
    required this.onSurface,
    required this.shadow,
    required this.outline,
  });

  /// Create a color scheme from seed color
  factory FSColorScheme.fromSeed({
    required Color seedColor,
    Brightness brightness = Brightness.light,
  }) {
    final isLight = brightness == Brightness.light;

    return FSColorScheme(
      primary: seedColor,
      secondary: isLight
          ? Color.alphaBlend(seedColor.withOpacity(0.7), Colors.white)
          : Color.alphaBlend(seedColor.withOpacity(0.7), Colors.black),
      success: isLight ? const Color(0xFF198754) : const Color(0xFF20C997),
      danger: isLight ? const Color(0xFFDC3545) : const Color(0xFFE74C3C),
      warning: isLight ? const Color(0xFFFFC107) : const Color(0xFFFFD43B),
      info: isLight ? const Color(0xFF0DCAF0) : const Color(0xFF339AF0),
      light: isLight ? const Color(0xFFF8F9FA) : const Color(0xFF2D333B),
      dark: isLight ? const Color(0xFF212529) : const Color(0xFFE9ECEF),
      white: Colors.white,
      black: Colors.black,
      transparent: Colors.transparent,
      background: isLight ? Colors.white : const Color(0xFF121212),
      surface: isLight ? const Color(0xFFF8F9FA) : const Color(0xFF1E1E1E),
      onPrimary: isLight ? Colors.white : Colors.black,
      onSecondary: isLight ? Colors.white : Colors.black,
      onBackground: isLight ? Colors.black : Colors.white,
      onSurface: isLight ? Colors.black : Colors.white,
      shadow: isLight
          ? Colors.black.withOpacity(0.1)
          : Colors.black.withOpacity(0.3),
      outline: isLight ? const Color(0xFFDEE2E6) : const Color(0xFF495057),
    );
  }

  /// Create a copy with updated colors
  FSColorScheme copyWith({
    Color? primary,
    Color? secondary,
    Color? success,
    Color? danger,
    Color? warning,
    Color? info,
    Color? light,
    Color? dark,
    Color? white,
    Color? black,
    Color? transparent,
    Color? background,
    Color? surface,
    Color? onPrimary,
    Color? onSecondary,
    Color? onBackground,
    Color? onSurface,
    Color? shadow,
    Color? outline,
  }) {
    return FSColorScheme(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      success: success ?? this.success,
      danger: danger ?? this.danger,
      warning: warning ?? this.warning,
      info: info ?? this.info,
      light: light ?? this.light,
      dark: dark ?? this.dark,
      white: white ?? this.white,
      black: black ?? this.black,
      transparent: transparent ?? this.transparent,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      onPrimary: onPrimary ?? this.onPrimary,
      onSecondary: onSecondary ?? this.onSecondary,
      onBackground: onBackground ?? this.onBackground,
      onSurface: onSurface ?? this.onSurface,
      shadow: shadow ?? this.shadow,
      outline: outline ?? this.outline,
    );
  }
}

/// Flutstrap Typography System
class FSTypography {
  final TextStyle displayLarge;
  final TextStyle displayMedium;
  final TextStyle displaySmall;
  final TextStyle headlineLarge;
  final TextStyle headlineMedium;
  final TextStyle headlineSmall;
  final TextStyle titleLarge;
  final TextStyle titleMedium;
  final TextStyle titleSmall;
  final TextStyle bodyLarge;
  final TextStyle bodyMedium;
  final TextStyle bodySmall;
  final TextStyle labelLarge;
  final TextStyle labelMedium;
  final TextStyle labelSmall;

  // Remove 'const' from constructor
  FSTypography({
    required this.displayLarge,
    required this.displayMedium,
    required this.displaySmall,
    required this.headlineLarge,
    required this.headlineMedium,
    required this.headlineSmall,
    required this.titleLarge,
    required this.titleMedium,
    required this.titleSmall,
    required this.bodyLarge,
    required this.bodyMedium,
    required this.bodySmall,
    required this.labelLarge,
    required this.labelMedium,
    required this.labelSmall,
  });

  /// Create typography from base text style
  factory FSTypography.fromBaseTextStyle(TextStyle base) {
    return FSTypography(
      displayLarge: base.copyWith(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        height: 1.12,
        letterSpacing: -0.25,
      ),
      displayMedium: base.copyWith(
        fontSize: 45,
        fontWeight: FontWeight.w400,
        height: 1.16,
        letterSpacing: 0,
      ),
      displaySmall: base.copyWith(
        fontSize: 36,
        fontWeight: FontWeight.w400,
        height: 1.22,
        letterSpacing: 0,
      ),
      headlineLarge: base.copyWith(
        fontSize: 32,
        fontWeight: FontWeight.w400,
        height: 1.25,
        letterSpacing: 0,
      ),
      headlineMedium: base.copyWith(
        fontSize: 28,
        fontWeight: FontWeight.w400,
        height: 1.29,
        letterSpacing: 0,
      ),
      headlineSmall: base.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        height: 1.33,
        letterSpacing: 0,
      ),
      titleLarge: base.copyWith(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        height: 1.27,
        letterSpacing: 0,
      ),
      titleMedium: base.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.5,
        letterSpacing: 0.15,
      ),
      titleSmall: base.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.43,
        letterSpacing: 0.1,
      ),
      bodyLarge: base.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.5,
        letterSpacing: 0.5,
      ),
      bodyMedium: base.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.43,
        letterSpacing: 0.25,
      ),
      bodySmall: base.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.33,
        letterSpacing: 0.4,
      ),
      labelLarge: base.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.43,
        letterSpacing: 0.1,
      ),
      labelMedium: base.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.33,
        letterSpacing: 0.5,
      ),
      labelSmall: base.copyWith(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        height: 1.45,
        letterSpacing: 0.5,
      ),
    );
  }

  /// Create a copy with updated text styles
  FSTypography copyWith({
    TextStyle? displayLarge,
    TextStyle? displayMedium,
    TextStyle? displaySmall,
    TextStyle? headlineLarge,
    TextStyle? headlineMedium,
    TextStyle? headlineSmall,
    TextStyle? titleLarge,
    TextStyle? titleMedium,
    TextStyle? titleSmall,
    TextStyle? bodyLarge,
    TextStyle? bodyMedium,
    TextStyle? bodySmall,
    TextStyle? labelLarge,
    TextStyle? labelMedium,
    TextStyle? labelSmall,
  }) {
    return FSTypography(
      displayLarge: displayLarge ?? this.displayLarge,
      displayMedium: displayMedium ?? this.displayMedium,
      displaySmall: displaySmall ?? this.displaySmall,
      headlineLarge: headlineLarge ?? this.headlineLarge,
      headlineMedium: headlineMedium ?? this.headlineMedium,
      headlineSmall: headlineSmall ?? this.headlineSmall,
      titleLarge: titleLarge ?? this.titleLarge,
      titleMedium: titleMedium ?? this.titleMedium,
      titleSmall: titleSmall ?? this.titleSmall,
      bodyLarge: bodyLarge ?? this.bodyLarge,
      bodyMedium: bodyMedium ?? this.bodyMedium,
      bodySmall: bodySmall ?? this.bodySmall,
      labelLarge: labelLarge ?? this.labelLarge,
      labelMedium: labelMedium ?? this.labelMedium,
      labelSmall: labelSmall ?? this.labelSmall,
    );
  }
}

/// Flutstrap Animation Configuration
class FSAnimation {
  final Duration duration;
  final Curve curve;

  const FSAnimation({
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
  });

  FSAnimation copyWith({
    Duration? duration,
    Curve? curve,
  }) {
    return FSAnimation(
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
    );
  }
}

/// Main Flutstrap Theme Data
class FSThemeData {
  final FSColorScheme colors;
  final FSTypography typography;
  final FSSpacing spacing;
  final FSAnimation animation;
  final FSCustomBreakpoints breakpoints;
  final Brightness brightness;

  const FSThemeData({
    required this.colors,
    required this.typography,
    required this.spacing,
    required this.animation,
    required this.breakpoints,
    required this.brightness,
  });

  /// Create light theme
  factory FSThemeData.light({Color? seedColor}) {
    final colors = FSColorScheme.fromSeed(
      seedColor: seedColor ?? const Color(0xFF0D6EFD),
      brightness: Brightness.light,
    );

    final baseTextStyle = TextStyle(
      color: colors.onBackground,
      fontFamily: 'Inter',
      package: 'flutstrap',
    );

    return FSThemeData(
      colors: colors,
      typography: FSTypography.fromBaseTextStyle(baseTextStyle),
      spacing: FSSpacing(), // Remove const
      animation: const FSAnimation(),
      breakpoints: const FSCustomBreakpoints(),
      brightness: Brightness.light,
    );
  }

  /// Create dark theme
  factory FSThemeData.dark({Color? seedColor}) {
    final colors = FSColorScheme.fromSeed(
      seedColor: seedColor ?? const Color(0xFF0D6EFD),
      brightness: Brightness.dark,
    );

    final baseTextStyle = TextStyle(
      color: colors.onBackground,
      fontFamily: 'Inter',
      package: 'flutstrap',
    );

    return FSThemeData(
      colors: colors,
      typography: FSTypography.fromBaseTextStyle(baseTextStyle),
      spacing: FSSpacing(), // Remove const
      animation: const FSAnimation(),
      breakpoints: const FSCustomBreakpoints(),
      brightness: Brightness.dark,
    );
  }

  /// Create a copy with updated properties
  FSThemeData copyWith({
    FSColorScheme? colors,
    FSTypography? typography,
    FSSpacing? spacing,
    FSAnimation? animation,
    FSCustomBreakpoints? breakpoints,
    Brightness? brightness,
  }) {
    return FSThemeData(
      colors: colors ?? this.colors,
      typography: typography ?? this.typography,
      spacing: spacing ?? this.spacing,
      animation: animation ?? this.animation,
      breakpoints: breakpoints ?? this.breakpoints,
      brightness: brightness ?? this.brightness,
    );
  }
}

/// Flutstrap Theme Inherited Widget
class FSTheme extends InheritedWidget {
  final FSThemeData data;

  const FSTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  /// Get the current theme from context
  static FSThemeData of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<FSTheme>();
    if (theme != null) {
      return theme.data;
    }

    // Fallback to default light theme
    return FSThemeData.light();
  }

  @override
  bool updateShouldNotify(FSTheme oldWidget) {
    return data != oldWidget.data;
  }
}

/// Theme extension methods for easy access
extension FSThemeExtensions on BuildContext {
  /// Get the current Flutstrap theme
  FSThemeData get fsTheme => FSTheme.of(this);

  /// Get the current color scheme
  FSColorScheme get fsColors => fsTheme.colors;

  /// Get the current typography
  FSTypography get fsTypography => fsTheme.typography;

  /// Get the current spacing
  FSSpacing get fsSpacing => fsTheme.spacing;

  /// Get the current animation configuration
  FSAnimation get fsAnimation => fsTheme.animation;

  /// Get the current breakpoints
  FSCustomBreakpoints get fsBreakpoints => fsTheme.breakpoints;

  /// Check if current theme is dark mode
  bool get isDarkMode => fsTheme.brightness == Brightness.dark;

  /// Check if current theme is light mode
  bool get isLightMode => fsTheme.brightness == Brightness.light;
}
