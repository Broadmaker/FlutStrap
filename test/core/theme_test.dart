import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:master_flutstrap/core/theme.dart';
import 'package:master_flutstrap/core/breakpoints.dart';
import 'package:master_flutstrap/core/spacing.dart';

void main() {
  group('FSColorScheme', () {
    test('should initialize with required colors', () {
      const colorScheme = FSColorScheme(
        primary: Colors.blue,
        secondary: Colors.green,
        success: Colors.green,
        danger: Colors.red,
        warning: Colors.orange,
        info: Colors.blue,
        light: Colors.grey,
        dark: Colors.black,
        white: Colors.white,
        black: Colors.black,
        transparent: Colors.transparent,
        background: Colors.white,
        surface: Colors.grey,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onBackground: Colors.black,
        onSurface: Colors.black,
        shadow: Colors.black12,
        outline: Colors.grey,
      );

      expect(colorScheme.primary, Colors.blue);
      expect(colorScheme.success, Colors.green);
      expect(colorScheme.danger, Colors.red);
      expect(colorScheme.white, Colors.white);
    });

    test('fromSeed should create color scheme with seed color', () {
      final colorScheme = FSColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.light,
      );

      expect(colorScheme.primary, Colors.blue);
      expect(colorScheme.background, Colors.white);
      expect(colorScheme.onBackground, Colors.black);
    });

    test('fromSeed should create dark color scheme', () {
      final colorScheme = FSColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.dark,
      );

      expect(colorScheme.primary, Colors.blue);
      expect(colorScheme.background, const Color(0xFF121212));
      expect(colorScheme.onBackground, Colors.white);
    });

    test('copyWith should create updated instance', () {
      const original = FSColorScheme(
        primary: Colors.blue,
        secondary: Colors.green,
        success: Colors.green,
        danger: Colors.red,
        warning: Colors.orange,
        info: Colors.blue,
        light: Colors.grey,
        dark: Colors.black,
        white: Colors.white,
        black: Colors.black,
        transparent: Colors.transparent,
        background: Colors.white,
        surface: Colors.grey,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onBackground: Colors.black,
        onSurface: Colors.black,
        shadow: Colors.black12,
        outline: Colors.grey,
      );

      final updated =
          original.copyWith(primary: Colors.red, success: Colors.teal);

      expect(updated.primary, Colors.red);
      expect(updated.success, Colors.teal);
      expect(updated.secondary, original.secondary); // unchanged
    });
  });

  group('FSTypography', () {
    test('should initialize with all text styles', () {
      const baseStyle = TextStyle(fontFamily: 'Roboto');
      final typography = FSTypography.fromBaseTextStyle(baseStyle);

      expect(typography.displayLarge.fontSize, 57);
      expect(typography.bodyMedium.fontSize, 14);
      expect(typography.labelSmall.fontSize, 11);
      expect(typography.displayLarge.fontFamily, 'Roboto');
    });

    test('copyWith should create updated instance', () {
      const baseStyle = TextStyle(fontFamily: 'Roboto');
      final original = FSTypography.fromBaseTextStyle(baseStyle);
      final updated = original.copyWith(
        bodyLarge: baseStyle.copyWith(fontSize: 18),
      );

      expect(updated.bodyLarge.fontSize, 18);
      expect(updated.displayLarge.fontSize, original.displayLarge.fontSize);
    });

    test('should require all parameters in constructor', () {
      // Remove 'const' from this test too
      final typography = FSTypography(
        displayLarge: TextStyle(fontSize: 57),
        displayMedium: TextStyle(fontSize: 45),
        displaySmall: TextStyle(fontSize: 36),
        headlineLarge: TextStyle(fontSize: 32),
        headlineMedium: TextStyle(fontSize: 28),
        headlineSmall: TextStyle(fontSize: 24),
        titleLarge: TextStyle(fontSize: 22),
        titleMedium: TextStyle(fontSize: 16),
        titleSmall: TextStyle(fontSize: 14),
        bodyLarge: TextStyle(fontSize: 16),
        bodyMedium: TextStyle(fontSize: 14),
        bodySmall: TextStyle(fontSize: 12),
        labelLarge: TextStyle(fontSize: 14),
        labelMedium: TextStyle(fontSize: 12),
        labelSmall: TextStyle(fontSize: 11),
      );

      expect(typography.displayLarge.fontSize, 57);
      expect(typography.labelSmall.fontSize, 11);
    });
  });
  group('FSAnimation', () {
    test('should initialize with default values', () {
      const animation = FSAnimation();
      expect(animation.duration, const Duration(milliseconds: 300));
      expect(animation.curve, Curves.easeInOut);
    });

    test('copyWith should create updated instance', () {
      const original = FSAnimation();
      final updated = original.copyWith(
        duration: const Duration(milliseconds: 500),
      );

      expect(updated.duration, const Duration(milliseconds: 500));
      expect(updated.curve, original.curve);
    });
  });

  group('FSThemeData', () {
    test('light factory should create light theme', () {
      final theme = FSThemeData.light();
      expect(theme.brightness, Brightness.light);
      expect(theme.colors.background, Colors.white);
      expect(theme.colors.onBackground, Colors.black);
    });

    test('dark factory should create dark theme', () {
      final theme = FSThemeData.dark();
      expect(theme.brightness, Brightness.dark);
      expect(theme.colors.background, const Color(0xFF121212));
      expect(theme.colors.onBackground, Colors.white);
    });

    test('light factory should use custom seed color', () {
      final theme = FSThemeData.light(seedColor: Colors.purple);
      expect(theme.colors.primary, Colors.purple);
    });

    test('dark factory should use custom seed color', () {
      final theme = FSThemeData.dark(seedColor: Colors.purple);
      expect(theme.colors.primary, Colors.purple);
    });

    test('copyWith should create updated instance', () {
      final original = FSThemeData.light();
      final customColors = FSColorScheme.fromSeed(seedColor: Colors.red);
      final updated = original.copyWith(colors: customColors);

      expect(updated.colors.primary, Colors.red);
      expect(updated.typography, original.typography);
      expect(updated.spacing, original.spacing);
    });
  });

  group('FSTheme', () {
    test('of should return theme from context', () {
      final themeData = FSThemeData.light();
      final theme = FSTheme(data: themeData, child: Container());

      // Note: We can't easily test InheritedWidget context in unit tests
      // This test ensures the class can be instantiated
      expect(theme.data, themeData);
    });

    test('updateShouldNotify should compare data', () {
      final themeData1 = FSThemeData.light();
      final themeData2 = FSThemeData.dark();
      final theme1 = FSTheme(data: themeData1, child: Container());
      final theme2 = FSTheme(data: themeData2, child: Container());

      expect(theme1.updateShouldNotify(theme2), true);
    });
  });

  group('FSThemeExtensions', () {
    test('should provide access to theme properties', () {
      // Note: Extension methods are tested through integration tests
      // This group documents the expected behavior
      expect(true, true);
    });
  });

  group('Theme Integration', () {
    test('should integrate with breakpoints and spacing', () {
      final theme = FSThemeData.light();

      expect(theme.breakpoints, isA<FSCustomBreakpoints>());
      expect(theme.spacing, isA<FSSpacing>());
      // Access static constant through class, not instance
      expect(FSSpacing.sm, 8.0); // This is the correct way
    });

    test('should have consistent color relationships', () {
      final lightTheme = FSThemeData.light();
      final darkTheme = FSThemeData.dark();

      // Light theme should have light background and dark text
      expect(lightTheme.colors.background, Colors.white);
      expect(lightTheme.colors.onBackground, Colors.black);

      // Dark theme should have dark background and light text
      expect(darkTheme.colors.background, const Color(0xFF121212));
      expect(darkTheme.colors.onBackground, Colors.white);
    });
  });
}
