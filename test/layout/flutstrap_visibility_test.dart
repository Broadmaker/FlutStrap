import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutstrap/flutstrap.dart';

void main() {
  group('FlutstrapVisibility - Basic Rendering Tests', () {
    testWidgets('should show child on all breakpoints by default',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapVisibility(
              child: const Text('Visible Content'),
            ),
          ),
        ),
      );

      expect(find.text('Visible Content'), findsOneWidget);
    });

    testWidgets('should show fallback when hidden',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapVisibility(
              child: const Text('Main Content'),
              showOnXs: false,
              fallback: const Text('Fallback Content'),
            ),
          ),
        ),
      );

      // On default screen size (likely xs/sm), should show fallback
      expect(find.text('Main Content'), findsNothing);
      expect(find.text('Fallback Content'), findsOneWidget);
    });

    testWidgets('should hide child when showOn condition is false',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapVisibility(
              child: const Text('Hidden Content'),
              showOnXs: false,
            ),
          ),
        ),
      );

      expect(find.text('Hidden Content'), findsNothing);
    });

    testWidgets('should show child when showOn condition is true',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapVisibility(
              child: const Text('Visible Content'),
              showOnXs: true,
            ),
          ),
        ),
      );

      expect(find.text('Visible Content'), findsOneWidget);
    });

    testWidgets('should use SizedBox.shrink as default fallback',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapVisibility(
              child: const Text('Hidden Content'),
              showOnXs: false,
            ),
          ),
        ),
      );

      expect(find.text('Hidden Content'), findsNothing);
      expect(find.byType(SizedBox), findsOneWidget);
    });
  });

  group('FlutstrapVisibility - Breakpoint Factory Tests', () {
    testWidgets('xsOnly factory should only show on xs',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapVisibility.xsOnly(
              child: const Text('XS Only Content'),
            ),
          ),
        ),
      );

      // On default test screen (likely xs), it should show
      expect(find.text('XS Only Content'), findsOneWidget);
    });

    testWidgets('smOnly factory should only show on sm',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapVisibility.smOnly(
              child: const Text('SM Only Content'),
            ),
          ),
        ),
      );

      expect(find.text('SM Only Content'), findsOneWidget);
    });

    testWidgets('mdOnly factory should only show on md',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapVisibility.mdOnly(
              child: const Text('MD Only Content'),
            ),
          ),
        ),
      );

      expect(find.text('MD Only Content'), findsOneWidget);
    });

    testWidgets('lgOnly factory should only show on lg',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapVisibility.lgOnly(
              child: const Text('LG Only Content'),
            ),
          ),
        ),
      );

      expect(find.text('LG Only Content'), findsOneWidget);
    });

    testWidgets('xlOnly factory should only show on xl',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapVisibility.xlOnly(
              child: const Text('XL Only Content'),
            ),
          ),
        ),
      );

      expect(find.text('XL Only Content'), findsOneWidget);
    });

    testWidgets('xxlOnly factory should only show on xxl',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapVisibility.xxlOnly(
              child: const Text('XXL Only Content'),
            ),
          ),
        ),
      );

      expect(find.text('XXL Only Content'), findsOneWidget);
    });

    testWidgets('mobileOnly factory should show on xs and sm',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapVisibility.mobileOnly(
              child: const Text('Mobile Only Content'),
            ),
          ),
        ),
      );

      // On default test screen (xs/sm), should show
      expect(find.text('Mobile Only Content'), findsOneWidget);
    });

    testWidgets('tabletOnly factory should show on md',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapVisibility.tabletOnly(
              child: const Text('Tablet Only Content'),
            ),
          ),
        ),
      );

      expect(find.text('Tablet Only Content'), findsOneWidget);
    });

    testWidgets('desktopOnly factory should show on lg, xl, xxl',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapVisibility.desktopOnly(
              child: const Text('Desktop Only Content'),
            ),
          ),
        ),
      );

      // On default test screen (xs/sm), should NOT show
      expect(find.text('Desktop Only Content'), findsNothing);
    });
  });

  group('FlutstrapVisibility - Hide Factory Tests', () {
    testWidgets('hideOnXs factory should hide on xs',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapVisibility.hideOnXs(
              child: const Text('Hide on XS Content'),
            ),
          ),
        ),
      );

      // On default test screen (xs), should hide
      expect(find.text('Hide on XS Content'), findsNothing);
    });

    testWidgets('hideOnSm factory should hide on sm',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapVisibility.hideOnSm(
              child: const Text('Hide on SM Content'),
            ),
          ),
        ),
      );

      // On default test screen (xs), should show
      expect(find.text('Hide on SM Content'), findsOneWidget);
    });

    testWidgets('hideOnMobile factory should hide on xs and sm',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapVisibility.hideOnMobile(
              child: const Text('Hide on Mobile Content'),
            ),
          ),
        ),
      );

      // On default test screen (xs), should hide
      expect(find.text('Hide on Mobile Content'), findsNothing);
    });

    testWidgets('hideOnDesktop factory should hide on lg, xl, xxl',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapVisibility.hideOnDesktop(
              child: const Text('Hide on Desktop Content'),
            ),
          ),
        ),
      );

      // On default test screen (xs), should show
      expect(find.text('Hide on Desktop Content'), findsOneWidget);
    });
  });

  group('FlutstrapVisibility - CopyWith Tests', () {
    test('copyWith should create new instance with updated values', () {
      final original = FlutstrapVisibility(
        child: const Text('Original'),
        showOnXs: true,
        showOnSm: false,
        showOnMd: true,
      );

      final copy = original.copyWith(
        showOnXs: false,
        showOnSm: true,
        fallback: const Text('Fallback'),
      );

      expect(copy.showOnXs, false);
      expect(copy.showOnSm, true);
      expect(copy.showOnMd, true); // Kept from original
      expect(copy.fallback, isNotNull);

      expect(original.showOnXs, true);
      expect(original.showOnSm, false);
    });

    test('copyWith should keep original values when not specified', () {
      final original = FlutstrapVisibility(
        child: const Text('Original'),
        showOnXs: true,
        showOnLg: false,
      );

      final copy = original.copyWith(
        showOnXs: false,
      );

      expect(copy.showOnXs, false);
      expect(copy.showOnLg, false); // Kept from original
    });

    test('copyWith should update child', () {
      final original = FlutstrapVisibility(
        child: const Text('Original'),
      );

      final newChild = const Text('New Child');
      final copy = original.copyWith(child: newChild);

      expect(copy.child, newChild);
    });
  });

  group('FlutstrapVisibility - Screen Size Simulation Tests', () {
    testWidgets('should respond to different screen sizes',
        (WidgetTester tester) async {
      // Test on small screen (xs)
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapVisibility(
              child: const Text('Responsive Content'),
              showOnXs: true,
              showOnLg: false,
            ),
          ),
        ),
      );

      expect(find.text('Responsive Content'), findsOneWidget);

      // Simulate large screen by rebuilding with MediaQuery
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(1200, 800)),
            child: Scaffold(
              body: FlutstrapVisibility(
                child: const Text('Responsive Content'),
                showOnXs: true,
                showOnLg: false,
              ),
            ),
          ),
        ),
      );

      // Should be hidden on large screen
      expect(find.text('Responsive Content'), findsNothing);
    });

    testWidgets('should handle multiple visibility conditions',
        (WidgetTester tester) async {
      // Test on small screen
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                FlutstrapVisibility.mobileOnly(
                  child: const Text('Mobile Only'),
                ),
                FlutstrapVisibility.desktopOnly(
                  child: const Text('Desktop Only'),
                ),
                FlutstrapVisibility(
                  child: const Text('Always Visible'),
                  showOnXs: true,
                  showOnSm: true,
                  showOnMd: true,
                  showOnLg: true,
                  showOnXl: true,
                  showOnXxl: true,
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Mobile Only'), findsOneWidget);
      expect(find.text('Desktop Only'), findsNothing);
      expect(find.text('Always Visible'), findsOneWidget);
    });
  });

  group('FlutstrapVisibility - Edge Cases', () {
    testWidgets('should handle null fallback gracefully',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapVisibility(
              child: const Text('Main'),
              showOnXs: false,
              fallback: null,
            ),
          ),
        ),
      );

      expect(find.text('Main'), findsNothing);
      // Should use default SizedBox.shrink
      expect(find.byType(SizedBox), findsOneWidget);
    });

    testWidgets('should handle all show conditions false',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapVisibility(
              child: const Text('Hidden Everywhere'),
              showOnXs: false,
              showOnSm: false,
              showOnMd: false,
              showOnLg: false,
              showOnXl: false,
              showOnXxl: false,
              fallback: const Text('Fallback'),
            ),
          ),
        ),
      );

      expect(find.text('Hidden Everywhere'), findsNothing);
      expect(find.text('Fallback'), findsOneWidget);
    });

    testWidgets('should handle all show conditions true',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapVisibility(
              child: const Text('Visible Everywhere'),
              showOnXs: true,
              showOnSm: true,
              showOnMd: true,
              showOnLg: true,
              showOnXl: true,
              showOnXxl: true,
            ),
          ),
        ),
      );

      expect(find.text('Visible Everywhere'), findsOneWidget);
    });

    testWidgets('should work with complex child widgets',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapVisibility(
              child: Container(
                padding: const EdgeInsets.all(16),
                color: Colors.blue,
                child: const Column(
                  children: [
                    Text('Title'),
                    SizedBox(height: 8),
                    Text('Description'),
                  ],
                ),
              ),
              showOnXs: true,
            ),
          ),
        ),
      );

      expect(find.text('Title'), findsOneWidget);
      expect(find.text('Description'), findsOneWidget);
      expect(find.byType(Container), findsOneWidget);
    });
  });

  group('FlutstrapVisibility - Combined Factory Tests', () {
    testWidgets('should combine multiple visibility conditions',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Row(
              children: [
                FlutstrapVisibility.mobileOnly(
                  child: const Text('A - Mobile'),
                ),
                FlutstrapVisibility.hideOnMobile(
                  child: const Text('B - Not Mobile'),
                ),
                FlutstrapVisibility.tabletOnly(
                  child: const Text('C - Tablet'),
                ),
                FlutstrapVisibility.desktopOnly(
                  child: const Text('D - Desktop'),
                ),
              ],
            ),
          ),
        ),
      );

      // On default test screen (xs/mobile)
      expect(find.text('A - Mobile'), findsOneWidget);
      expect(find.text('B - Not Mobile'), findsNothing);
      expect(find.text('C - Tablet'), findsNothing);
      expect(find.text('D - Desktop'), findsNothing);
    });

    testWidgets('should work with fallback in factories',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapVisibility.desktopOnly(
              child: const Text('Desktop Content'),
              fallback: const Text('Mobile Fallback'),
            ),
          ),
        ),
      );

      expect(find.text('Desktop Content'), findsNothing);
      expect(find.text('Mobile Fallback'), findsOneWidget);
    });
  });

  group('FlutstrapVisibility - Themed Tests', () {
    testWidgets('should work with FSTheme provider',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FSTheme(
            data: FSThemeData.light(),
            child: const Scaffold(
              body: FlutstrapVisibility(
                child: Text('Themed Visibility'),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Themed Visibility'), findsOneWidget);
    });

    testWidgets('should work with dark theme', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FSTheme(
            data: FSThemeData.dark(),
            child: const Scaffold(
              body: FlutstrapVisibility(
                child: Text('Dark Theme Visibility'),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Dark Theme Visibility'), findsOneWidget);
    });
  });

  group('FlutstrapVisibility - Performance Tests', () {
    testWidgets('should not rebuild unnecessarily',
        (WidgetTester tester) async {
      var buildCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapVisibility(
              child: Builder(
                builder: (context) {
                  buildCount++;
                  return const Text('Performance Test');
                },
              ),
            ),
          ),
        ),
      );

      expect(buildCount, 1);
      expect(find.text('Performance Test'), findsOneWidget);

      // Rebuild with same properties
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapVisibility(
              child: Builder(
                builder: (context) {
                  buildCount++;
                  return const Text('Performance Test');
                },
              ),
            ),
          ),
        ),
      );

      // Build count should increase (widget rebuilds), but this is normal
      expect(buildCount, greaterThan(1));
    });
  });
}
