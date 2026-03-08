import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutstrap/flutstrap.dart';

void main() {
  group('FSThemeData - Light Theme Tests', () {
    test('light theme should create default light theme', () {
      final theme = FSThemeData.light();

      expect(theme.brightness, Brightness.light);
      expect(theme.colors, isNotNull);
      expect(theme.typography, isNotNull);
      expect(theme.spacing, isNotNull);
      expect(theme.animation, isNotNull);
      expect(theme.breakpoints, isNotNull);
    });

    test('light theme with custom seed color should use that color', () {
      const seedColor = Colors.purple;
      final theme = FSThemeData.light(seedColor: seedColor);

      expect(theme.colors.primary, seedColor);
    });

    test('light theme should cache default instance', () {
      final theme1 = FSThemeData.light();
      final theme2 = FSThemeData.light();

      expect(identical(theme1, theme2), true);
    });

    test('light theme with custom seed should not use cache', () {
      final theme1 = FSThemeData.light(seedColor: Colors.blue);
      final theme2 = FSThemeData.light(seedColor: Colors.red);

      expect(identical(theme1, theme2), false);
    });
  });

  group('FSThemeData - Dark Theme Tests', () {
    test('dark theme should create default dark theme', () {
      final theme = FSThemeData.dark();

      expect(theme.brightness, Brightness.dark);
      expect(theme.colors, isNotNull);
      expect(theme.typography, isNotNull);
      expect(theme.spacing, isNotNull);
      expect(theme.animation, isNotNull);
      expect(theme.breakpoints, isNotNull);
    });

    test('dark theme with custom seed color should use that color', () {
      const seedColor = Colors.teal;
      final theme = FSThemeData.dark(seedColor: seedColor);

      expect(theme.colors.primary, seedColor);
    });

    test('dark theme should cache default instance', () {
      final theme1 = FSThemeData.dark();
      final theme2 = FSThemeData.dark();

      expect(identical(theme1, theme2), true);
    });

    test('dark theme with custom seed should not use cache', () {
      final theme1 = FSThemeData.dark(seedColor: Colors.blue);
      final theme2 = FSThemeData.dark(seedColor: Colors.red);

      expect(identical(theme1, theme2), false);
    });
  });

  group('FSThemeData - Material3 Theme Tests', () {
    test('material3 theme should create theme from seed', () {
      const seedColor = Colors.deepPurple;
      final theme = FSThemeData.material3(
        seedColor: seedColor,
        brightness: Brightness.light,
      );

      expect(theme.colors.primary, isNotNull);
      expect(theme.colors.secondary, isNotNull);
    });

    test('material3 dark theme should have dark brightness', () {
      const seedColor = Colors.deepOrange;
      final theme = FSThemeData.material3(
        seedColor: seedColor,
        brightness: Brightness.dark,
      );

      expect(theme.brightness, Brightness.dark);
    });
  });

  group('FSColorScheme Tests', () {
    test('fromSeed should create color scheme with correct brightness', () {
      const seedColor = Colors.blue;

      final lightScheme = FSColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: Brightness.light,
      );

      final darkScheme = FSColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: Brightness.dark,
      );

      expect(lightScheme.primary, seedColor);
      expect(darkScheme.primary, seedColor);
      expect(lightScheme.background, isNot(darkScheme.background));
    });

    test('material3 should create Material 3 compliant scheme', () {
      const seedColor = Colors.purple;

      final scheme = FSColorScheme.material3(
        seedColor: seedColor,
        brightness: Brightness.light,
      );

      expect(scheme.primary, isNotNull);
      expect(scheme.secondary, isNotNull);
    });

    test('copyWith should update specified colors', () {
      final original = FSColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.light,
      );

      final copied = original.copyWith(
        primary: Colors.red,
        success: Colors.green,
      );

      expect(copied.primary, Colors.red);
      expect(copied.success, Colors.green);
      expect(copied.secondary, original.secondary);
    });

    test('error getter should return danger color', () {
      final scheme = FSColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.light,
      );

      expect(scheme.error, scheme.danger);
    });

    test('equality should work correctly', () {
      final scheme1 = FSColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.light,
      );

      final scheme2 = FSColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.light,
      );

      final scheme3 = FSColorScheme.fromSeed(
        seedColor: Colors.red,
        brightness: Brightness.light,
      );

      expect(scheme1 == scheme2, true);
      expect(scheme1 == scheme3, false);
    });
  });

  group('FSTypography Tests', () {
    test('fromBaseTextStyle should create typography scale', () {
      const baseStyle = TextStyle(
        fontFamily: 'Roboto',
        color: Colors.black,
      );

      final typography = FSTypography.fromBaseTextStyle(baseStyle);

      expect(typography.displayLarge, isNotNull);
      expect(typography.displayMedium, isNotNull);
      expect(typography.displaySmall, isNotNull);
      expect(typography.headlineLarge, isNotNull);
      expect(typography.headlineMedium, isNotNull);
      expect(typography.headlineSmall, isNotNull);
      expect(typography.titleLarge, isNotNull);
      expect(typography.titleMedium, isNotNull);
      expect(typography.titleSmall, isNotNull);
      expect(typography.bodyLarge, isNotNull);
      expect(typography.bodyMedium, isNotNull);
      expect(typography.bodySmall, isNotNull);
      expect(typography.labelLarge, isNotNull);
      expect(typography.labelMedium, isNotNull);
      expect(typography.labelSmall, isNotNull);
    });

    test('copyWith should update specified styles', () {
      final original = FSTypography.fromBaseTextStyle(const TextStyle());

      final newStyle = const TextStyle(fontSize: 20);
      final copied = original.copyWith(
        displayLarge: newStyle,
        bodyMedium: newStyle,
      );

      expect(copied.displayLarge, newStyle);
      expect(copied.bodyMedium, newStyle);
      expect(copied.displayMedium, original.displayMedium);
    });

    test('equality should work correctly', () {
      final typography1 = FSTypography.fromBaseTextStyle(const TextStyle());
      final typography2 = FSTypography.fromBaseTextStyle(const TextStyle());

      expect(typography1 == typography2, true);
    });
  });

  group('FSTheme - Inherited Widget Tests', () {
    testWidgets('FSTheme.of should throw when no theme found',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                FSTheme.of(context);
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );

      expect(tester.takeException(), isFlutterError);
    });

    testWidgets('FSTheme.of should return theme when wrapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FSTheme(
            data: FSThemeData.light(),
            child: Scaffold(
              body: Builder(
                builder: (context) {
                  final theme = FSTheme.of(context);
                  expect(theme, isNotNull);
                  return SizedBox.shrink();
                },
              ),
            ),
          ),
        ),
      );
    });

    testWidgets('updateShouldNotify should return true when data changes',
        (WidgetTester tester) async {
      final theme1 = FSThemeData.light();
      final theme2 = FSThemeData.dark();

      final widget1 = FSTheme(data: theme1, child: const SizedBox.shrink());
      final widget2 = FSTheme(data: theme2, child: const SizedBox.shrink());

      expect(widget1.updateShouldNotify(widget2), true);
    });

    testWidgets('updateShouldNotify should return false when data same',
        (WidgetTester tester) async {
      final theme = FSThemeData.light();

      final widget1 = FSTheme(data: theme, child: const SizedBox.shrink());
      final widget2 = FSTheme(data: theme, child: const SizedBox.shrink());

      expect(widget1.updateShouldNotify(widget2), false);
    });
  });

  group('FSThemeExtensions - Context Extensions', () {
    testWidgets('extensions should provide access to theme properties',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FSTheme(
            data: FSThemeData.light(),
            child: Scaffold(
              body: Builder(
                builder: (context) {
                  expect(FSTheme.of(context), isNotNull);
                  expect(FSTheme.of(context).colors, isNotNull);
                  expect(FSTheme.of(context).typography, isNotNull);
                  expect(FSTheme.of(context).spacing, isNotNull);
                  expect(FSTheme.of(context).animation, isNotNull);
                  expect(FSTheme.of(context).breakpoints, isNotNull);
                  return SizedBox.shrink();
                },
              ),
            ),
          ),
        ),
      );
    });

    testWidgets('should check brightness correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FSTheme(
            data: FSThemeData.light(),
            child: Scaffold(
              body: Builder(
                builder: (context) {
                  expect(FSTheme.of(context).brightness, Brightness.light);
                  return SizedBox.shrink();
                },
              ),
            ),
          ),
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: FSTheme(
            data: FSThemeData.dark(),
            child: Scaffold(
              body: Builder(
                builder: (context) {
                  expect(FSTheme.of(context).brightness, Brightness.dark);
                  return SizedBox.shrink();
                },
              ),
            ),
          ),
        ),
      );
    });

    testWidgets('color shortcuts should return correct colors',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FSTheme(
            data: FSThemeData.light(),
            child: Scaffold(
              body: Builder(
                builder: (context) {
                  final colors = FSTheme.of(context).colors;
                  expect(colors.primary, colors.primary);
                  expect(colors.danger, colors.danger);
                  expect(colors.success, colors.success);
                  expect(colors.warning, colors.warning);
                  expect(colors.info, colors.info);
                  return SizedBox.shrink();
                },
              ),
            ),
          ),
        ),
      );
    });
  });

  group('FlutstrapTheme - Constants', () {
    test('should have correct color constants', () {
      expect(FlutstrapTheme.defaultPrimary, const Color(0xFF0D6EFD));
      expect(FlutstrapTheme.defaultSuccess, const Color(0xFF198754));
      expect(FlutstrapTheme.defaultDanger, const Color(0xFFDC3545));
      expect(FlutstrapTheme.defaultWarning, const Color(0xFFFFC107));
      expect(FlutstrapTheme.defaultInfo, const Color(0xFF0DCAF0));
    });

    test('should have correct borderRadius constants', () {
      expect(FlutstrapTheme.borderRadiusSm, 4.0);
      expect(FlutstrapTheme.borderRadiusMd, 6.0);
      expect(FlutstrapTheme.borderRadiusLg, 8.0);
      expect(FlutstrapTheme.borderRadiusXl, 12.0);
    });

    test('should have correct shadow constants', () {
      expect(FlutstrapTheme.shadowSm, isA<List<BoxShadow>>());
      expect(FlutstrapTheme.shadowMd, isA<List<BoxShadow>>());
      expect(FlutstrapTheme.shadowLg, isA<List<BoxShadow>>());
    });

    test('should have correct duration constants', () {
      expect(FlutstrapTheme.transitionFast, const Duration(milliseconds: 150));
      expect(
          FlutstrapTheme.transitionNormal, const Duration(milliseconds: 300));
      expect(FlutstrapTheme.transitionSlow, const Duration(milliseconds: 500));
    });
  });

  group('FlutstrapThemeLight - Pre-configured Themes', () {
    test('defaultTheme should be light theme with blue primary', () {
      final theme = FlutstrapThemeLight.defaultTheme;

      expect(theme.brightness, Brightness.light);
      expect(theme.colors.primary, FlutstrapTheme.defaultPrimary);
    });

    test('custom should create theme with specified primary color', () {
      const customColor = Colors.amber;
      final theme = FlutstrapThemeLight.custom(customColor);

      expect(theme.colors.primary, customColor);
    });

    test('success should create success-colored theme', () {
      final theme = FlutstrapThemeLight.success;

      expect(theme.colors.primary, FlutstrapTheme.defaultSuccess);
    });

    test('danger should create danger-colored theme', () {
      final theme = FlutstrapThemeLight.danger;

      expect(theme.colors.primary, FlutstrapTheme.defaultDanger);
    });

    test('warning should create warning-colored theme', () {
      final theme = FlutstrapThemeLight.warning;

      expect(theme.colors.primary, FlutstrapTheme.defaultWarning);
    });

    test('info should create info-colored theme', () {
      final theme = FlutstrapThemeLight.info;

      expect(theme.colors.primary, FlutstrapTheme.defaultInfo);
    });

    test('purple should create purple-colored theme', () {
      final theme = FlutstrapThemeLight.purple;

      expect(theme.colors.primary, const Color(0xFF6F42C1));
    });

    test('pink should create pink-colored theme', () {
      final theme = FlutstrapThemeLight.pink;

      expect(theme.colors.primary, const Color(0xFFD63384));
    });

    test('orange should create orange-colored theme', () {
      final theme = FlutstrapThemeLight.orange;

      expect(theme.colors.primary, const Color(0xFFFD7E14));
    });

    test('teal should create teal-colored theme', () {
      final theme = FlutstrapThemeLight.teal;

      expect(theme.colors.primary, const Color(0xFF20C997));
    });

    test('indigo should create indigo-colored theme', () {
      final theme = FlutstrapThemeLight.indigo;

      expect(theme.colors.primary, const Color(0xFF6610F2));
    });
  });

  group('FlutstrapThemeDark - Pre-configured Themes', () {
    test('defaultTheme should be dark theme with blue primary', () {
      final theme = FlutstrapThemeDark.defaultTheme;

      expect(theme.brightness, Brightness.dark);
      expect(theme.colors.primary, FlutstrapTheme.defaultPrimary);
    });

    test('custom should create dark theme with specified primary color', () {
      const customColor = Colors.amber;
      final theme = FlutstrapThemeDark.custom(customColor);

      expect(theme.colors.primary, customColor);
    });

    test('success should create dark success-colored theme', () {
      final theme = FlutstrapThemeDark.success;

      expect(theme.colors.primary, FlutstrapTheme.defaultSuccess);
    });

    test('danger should create dark danger-colored theme', () {
      final theme = FlutstrapThemeDark.danger;

      expect(theme.colors.primary, FlutstrapTheme.defaultDanger);
    });

    test('warning should create dark warning-colored theme', () {
      final theme = FlutstrapThemeDark.warning;

      expect(theme.colors.primary, FlutstrapTheme.defaultWarning);
    });

    test('info should create dark info-colored theme', () {
      final theme = FlutstrapThemeDark.info;

      expect(theme.colors.primary, FlutstrapTheme.defaultInfo);
    });

    test('purple should create dark purple-colored theme', () {
      final theme = FlutstrapThemeDark.purple;

      expect(theme.colors.primary, const Color(0xFF6F42C1));
    });

    test('pink should create dark pink-colored theme', () {
      final theme = FlutstrapThemeDark.pink;

      expect(theme.colors.primary, const Color(0xFFD63384));
    });

    test('orange should create dark orange-colored theme', () {
      final theme = FlutstrapThemeDark.orange;

      expect(theme.colors.primary, const Color(0xFFFD7E14));
    });

    test('teal should create dark teal-colored theme', () {
      final theme = FlutstrapThemeDark.teal;

      expect(theme.colors.primary, const Color(0xFF20C997));
    });

    test('indigo should create dark indigo-colored theme', () {
      final theme = FlutstrapThemeDark.indigo;

      expect(theme.colors.primary, const Color(0xFF6610F2));
    });
  });

  group('Theme Integration Tests', () {
    testWidgets('should work with MaterialApp theme',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light().copyWith(
            primaryColor: FlutstrapTheme.defaultPrimary,
          ),
          home: const Scaffold(
            body: Center(
              child: Text('Theme Integration'),
            ),
          ),
        ),
      );

      expect(find.text('Theme Integration'), findsOneWidget);
    });

    testWidgets('should allow theme switching', (WidgetTester tester) async {
      var isDark = false;

      await tester.pumpWidget(
        MaterialApp(
          home: StatefulBuilder(
            builder: (context, setState) {
              return FSTheme(
                data: isDark
                    ? FlutstrapThemeDark.defaultTheme
                    : FlutstrapThemeLight.defaultTheme,
                child: Scaffold(
                  appBar: AppBar(
                    title: const Text('Theme Switch Test'),
                  ),
                  body: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isDark = !isDark;
                        });
                      },
                      child: const Text('Switch Theme'),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );

      expect(find.text('Switch Theme'), findsOneWidget);

      await tester.tap(find.text('Switch Theme'));
      await tester.pump();

      expect(tester.takeException(), isNull);
    });

    testWidgets('should maintain theme properties across rebuilds',
        (WidgetTester tester) async {
      final theme = FSThemeData.light();
      final key = GlobalKey();

      await tester.pumpWidget(
        MaterialApp(
          home: FSTheme(
            key: key,
            data: theme,
            child: const Scaffold(
              body: Center(
                child: Text('Theme Test'),
              ),
            ),
          ),
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: FSTheme(
            key: key,
            data: theme,
            child: const Scaffold(
              body: Center(
                child: Text('Theme Test'),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Theme Test'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });

  group('FSThemeData - CopyWith Tests', () {
    test('copyWith should create new instance with updated values', () {
      final original = FSThemeData.light();

      final copied = original.copyWith(
        brightness: Brightness.dark,
      );

      expect(copied.brightness, Brightness.dark);
      expect(copied.colors, original.colors);
    });

    test('copyWith should keep original values when not specified', () {
      final original = FSThemeData.light(seedColor: Colors.blue);

      final copied = original.copyWith();

      expect(copied.brightness, original.brightness);
      expect(copied.colors.primary, original.colors.primary);
    });
  });

  group('Theme Equality Tests', () {
    test('identical themes should be equal', () {
      final theme1 = FSThemeData.light();
      final theme2 = FSThemeData.light();

      expect(theme1 == theme2, true);
      expect(theme1.hashCode, theme2.hashCode);
    });

    test('different themes should not be equal', () {
      final theme1 = FSThemeData.light(seedColor: Colors.blue);
      final theme2 = FSThemeData.light(seedColor: Colors.red);

      expect(theme1 == theme2, false);
    });

    test('light and dark themes should not be equal', () {
      final lightTheme = FSThemeData.light();
      final darkTheme = FSThemeData.dark();

      expect(lightTheme == darkTheme, false);
    });
  });
}
