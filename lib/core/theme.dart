// Flutstrap Theming System
//
// {@category Theming}
// {@category Foundation}
//
// Provides a comprehensive theming system with:
// - 🎨 Color schemes (light/dark, seed-based)
// - 📝 Typography scale (Material 3 compliant)
// - 📏 Consistent spacing system
// - 🎬 Animation configurations
// - 📱 Responsive breakpoints
//
// ## Usage
//
// {@tool snippet}
// ### Basic Usage
//
// ```dart
// // Simple light theme
// FSTheme(
//   data: FSThemeData.light(),
//   child: MyApp(),
// )
//
// // Custom seed color with dark mode
// FSTheme(
//   data: FSThemeData.dark(seedColor: Colors.blue),
//   child: MyApp(),
// )
//
// // Material 3 theming
// FSTheme(
//   data: FSThemeData.material3(seedColor: Colors.purple),
//   child: MyApp(),
// )
// ```
// {@end-tool}
//
// ## Theming Principles
// - **Consistency**: Uniform design tokens across components
// - **Accessibility**: WCAG compliant color contrasts
// - **Flexibility**: Easy customization and extension
// - **Performance**: Efficient theme propagation and caching

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'breakpoints.dart';
import 'spacing.dart';

// ✅ IMPORT: Use the animation system's FSAnimation to avoid conflicts
import '../animations/animation_types.dart';

/// Flutstrap Color Scheme
///
/// Defines the color palette for the Flutstrap theme system with
/// Bootstrap-inspired semantics and Material 3 compatibility.
class FSColorScheme {
  // ✅ CONST COLOR DEFINITIONS FOR BETTER PERFORMANCE
  static const Color _lightSuccess = Color(0xFF198754);
  static const Color _darkSuccess = Color(0xFF20C997);
  static const Color _lightDanger = Color(0xFFDC3545);
  static const Color _darkDanger = Color(0xFFE74C3C);
  static const Color _lightWarning = Color(0xFFFFC107);
  static const Color _darkWarning = Color(0xFFFFD43B);
  static const Color _lightInfo = Color(0xFF0DCAF0);
  static const Color _darkInfo = Color(0xFF339AF0);
  static const Color _lightBackground = Color(0xFFF8F9FA);
  static const Color _darkBackground = Color(0xFF121212);
  static const Color _lightSurface = Color(0xFFF8F9FA);
  static const Color _darkSurface = Color(0xFF1E1E1E);
  static const Color _lightOutline = Color(0xFFDEE2E6);
  static const Color _darkOutline = Color(0xFF495057);

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

  // ✅ ADD SEMANTIC ALIASES FOR BETTER UX
  Color get error => danger;

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

  /// Create a color scheme from seed color using perceptually uniform HSV blending
  factory FSColorScheme.fromSeed({
    required Color seedColor,
    Brightness brightness = Brightness.light,
  }) {
    final isLight = brightness == Brightness.light;

    // ✅ USE HSV FOR PERCEPTUALLY UNIFORM COLOR GENERATION
    final hsvColor = HSVColor.fromColor(seedColor);
    final secondary = HSVColor.fromAHSV(
      1.0,
      hsvColor.hue,
      hsvColor.saturation * 0.8,
      isLight ? 0.7 : 0.3,
    ).toColor();

    return FSColorScheme(
      primary: seedColor,
      secondary: secondary,
      success: isLight ? _lightSuccess : _darkSuccess,
      danger: isLight ? _lightDanger : _darkDanger,
      warning: isLight ? _lightWarning : _darkWarning,
      info: isLight ? _lightInfo : _darkInfo,
      light: isLight ? const Color(0xFFF8F9FA) : const Color(0xFF2D333B),
      dark: isLight ? const Color(0xFF212529) : const Color(0xFFE9ECEF),
      white: Colors.white,
      black: Colors.black,
      transparent: Colors.transparent,
      background: isLight ? Colors.white : _darkBackground,
      surface: isLight ? _lightSurface : _darkSurface,
      onPrimary: isLight ? Colors.white : Colors.black,
      onSecondary: isLight ? Colors.white : Colors.black,
      onBackground: isLight ? Colors.black : Colors.white,
      onSurface: isLight ? Colors.black : Colors.white,
      shadow: isLight
          ? Colors.black.withOpacity(0.1)
          : Colors.black.withOpacity(0.3),
      outline: isLight ? _lightOutline : _darkOutline,
    );
  }

  /// Create a Material 3 compliant color scheme
  factory FSColorScheme.material3({
    required Color seedColor,
    Brightness brightness = Brightness.light,
  }) {
    final materialScheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: brightness,
    );

    return FSColorScheme(
      primary: materialScheme.primary,
      secondary: materialScheme.secondary,
      success: materialScheme.tertiary,
      danger: materialScheme.error,
      warning: const Color(0xFFFFC107),
      info: materialScheme.primaryContainer,
      light: materialScheme.surfaceVariant,
      dark: materialScheme.inverseSurface,
      white: materialScheme.surface,
      black: materialScheme.onSurface,
      transparent: Colors.transparent,
      background: materialScheme.background,
      surface: materialScheme.surface,
      onPrimary: materialScheme.onPrimary,
      onSecondary: materialScheme.onSecondary,
      onBackground: materialScheme.onBackground,
      onSurface: materialScheme.onSurface,
      shadow: materialScheme.shadow,
      outline: materialScheme.outline,
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

  // ✅ SIMPLIFIED EQUALITY AND HASHCODE FOR PROPER THEME COMPARISON
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is FSColorScheme &&
            runtimeType == other.runtimeType &&
            primary == other.primary &&
            secondary == other.secondary &&
            background == other.background &&
            onBackground == other.onBackground;
  }

  @override
  int get hashCode => Object.hash(primary, secondary, background, onBackground);

  // ✅ SIMPLIFIED toString WITHOUT DIAGNOSTICABLE COMPLEXITY
  @override
  String toString() {
    final brightness = onBackground.computeLuminance() > 0.5 ? 'light' : 'dark';
    return 'FSColorScheme(primary: $primary, brightness: $brightness)';
  }
}

/// Flutstrap Typography System
///
/// Provides a comprehensive typography scale following Material 3 guidelines
/// with Bootstrap-inspired semantic naming.
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

  const FSTypography({
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

  /// Create typography from base text style with font fallbacks
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

  // ✅ SIMPLIFIED EQUALITY AND HASHCODE
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FSTypography &&
          runtimeType == other.runtimeType &&
          bodyMedium == other.bodyMedium &&
          bodyLarge == other.bodyLarge;

  @override
  int get hashCode => Object.hash(bodyMedium, bodyLarge);

  @override
  String toString() => 'FSTypography()';
}

// ✅ REMOVED: Local FSAnimation class - using imported version from animation system

/// Main Flutstrap Theme Data
///
/// Aggregates all theme aspects (colors, typography, spacing, animations, breakpoints)
/// into a single cohesive theme object.
class FSThemeData {
  final FSColorScheme colors;
  final FSTypography typography;
  final FSSpacing spacing;
  final FSAnimation animation; // ✅ USING IMPORTED FSAnimation
  final FSCustomBreakpoints breakpoints;
  final Brightness brightness;

  const FSThemeData._internal({
    required this.colors,
    required this.typography,
    required this.spacing,
    required this.animation,
    required this.breakpoints,
    required this.brightness,
  });

  // ✅ SIMPLIFIED CACHING STRATEGY
  static FSThemeData? _cachedLight;
  static FSThemeData? _cachedDark;

  /// Create light theme with optional seed color
  factory FSThemeData.light({Color? seedColor}) {
    if (seedColor == null) {
      return _cachedLight ??= _createLightTheme();
    }
    return _createLightTheme(seedColor: seedColor);
  }

  /// Create dark theme with optional seed color
  factory FSThemeData.dark({Color? seedColor}) {
    if (seedColor == null) {
      return _cachedDark ??= _createDarkTheme();
    }
    return _createDarkTheme(seedColor: seedColor);
  }

  /// Create a Material 3 compliant theme
  factory FSThemeData.material3({
    required Color seedColor,
    Brightness brightness = Brightness.light,
  }) {
    final colors = FSColorScheme.material3(
      seedColor: seedColor,
      brightness: brightness,
    );

    final baseTextStyle = TextStyle(
      color: colors.onBackground,
    );

    return FSThemeData._internal(
      colors: colors,
      typography: FSTypography.fromBaseTextStyle(baseTextStyle),
      spacing: const FSSpacing(),
      animation: const FSAnimation(), // ✅ USING IMPORTED FSAnimation
      breakpoints: const FSCustomBreakpoints(),
      brightness: brightness,
    );
  }

  // ✅ PRIVATE HELPER METHODS FOR THEME CREATION
  static FSThemeData _createLightTheme({Color? seedColor}) {
    final colors = FSColorScheme.fromSeed(
      seedColor: seedColor ?? const Color(0xFF0D6EFD),
      brightness: Brightness.light,
    );

    final baseTextStyle = TextStyle(
      color: colors.onBackground,
    );

    return FSThemeData._internal(
      colors: colors,
      typography: FSTypography.fromBaseTextStyle(baseTextStyle),
      spacing: const FSSpacing(),
      animation: const FSAnimation(), // ✅ USING IMPORTED FSAnimation
      breakpoints: const FSCustomBreakpoints(),
      brightness: Brightness.light,
    );
  }

  static FSThemeData _createDarkTheme({Color? seedColor}) {
    final colors = FSColorScheme.fromSeed(
      seedColor: seedColor ?? const Color(0xFF0D6EFD),
      brightness: Brightness.dark,
    );

    final baseTextStyle = TextStyle(
      color: colors.onBackground,
    );

    return FSThemeData._internal(
      colors: colors,
      typography: FSTypography.fromBaseTextStyle(baseTextStyle),
      spacing: const FSSpacing(),
      animation: const FSAnimation(), // ✅ USING IMPORTED FSAnimation
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
    return FSThemeData._internal(
      colors: colors ?? this.colors,
      typography: typography ?? this.typography,
      spacing: spacing ?? this.spacing,
      animation: animation ?? this.animation,
      breakpoints: breakpoints ?? this.breakpoints,
      brightness: brightness ?? this.brightness,
    );
  }

  // ✅ EQUALITY AND HASHCODE FOR EFFICIENT REBUILDS
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FSThemeData &&
          runtimeType == other.runtimeType &&
          colors == other.colors &&
          typography == other.typography &&
          brightness == other.brightness;

  @override
  int get hashCode => Object.hash(colors, typography, brightness);

  @override
  String toString() => 'FSThemeData(brightness: $brightness)';
}

/// Flutstrap Theme Inherited Widget
///
/// Provides theme data to the widget tree and handles efficient theme updates.
class FSTheme extends InheritedWidget {
  final FSThemeData data;

  const FSTheme({
    super.key,
    required this.data,
    required super.child,
  });

  /// Get the current theme from context with helpful error messaging
  static FSThemeData of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<FSTheme>();

    if (theme == null) {
      throw FlutterError('''
No FSTheme found in context. 
          
To fix this, please wrap your app with FSTheme:

FSTheme(
  data: FSThemeData.light(), // or FSThemeData.dark()
  child: MaterialApp(...),
)

If you're using MaterialApp, make sure FSTheme is above it in the widget tree.
''');
    }

    return theme.data;
  }

  @override
  bool updateShouldNotify(FSTheme oldWidget) {
    return data != oldWidget.data;
  }
}

/// Theme extension methods for easy access throughout the widget tree
extension FSThemeExtensions on BuildContext {
  /// Get the current Flutstrap theme
  FSThemeData get fsTheme => FSTheme.of(this);

  /// Get the current color scheme
  FSColorScheme get fsColors => fsTheme.colors;

  /// Get the current typography
  FSTypography get fsTypography => fsTheme.typography;

  /// Get the current spacing system
  FSSpacing get fsSpacing => fsTheme.spacing;

  /// Get the current animation configuration
  FSAnimation get fsAnimation => fsTheme.animation;

  /// Get the current breakpoints
  FSCustomBreakpoints get fsBreakpoints => fsTheme.breakpoints;

  /// Check if current theme is dark mode
  bool get isDarkMode => fsTheme.brightness == Brightness.dark;

  /// Check if current theme is light mode
  bool get isLightMode => fsTheme.brightness == Brightness.light;

  /// Quick access to commonly used colors with semantic aliases
  Color get primaryColor => fsColors.primary;
  Color get errorColor => fsColors.danger;
  Color get successColor => fsColors.success;
  Color get warningColor => fsColors.warning;
  Color get infoColor => fsColors.info;
}
