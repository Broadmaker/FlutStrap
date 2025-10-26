import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:master_flutstrap/layout/flutstrap_visibility.dart';
import 'package:master_flutstrap/core/breakpoints.dart';
import 'package:master_flutstrap/core/responsive.dart';

void main() {
  group('FlutstrapVisibility', () {
    testWidgets('should show child when conditions are met',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                // Set all breakpoints to true to ensure visibility
                return FlutstrapVisibility(
                  child: const Text('Visible'),
                  showOnXs: true,
                  showOnSm: true,
                  showOnMd: true,
                  showOnLg: true,
                  showOnXl: true,
                  showOnXxl: true,
                );
              },
            ),
          ),
        ),
      );

      expect(find.text('Visible'), findsOneWidget);
    });

    testWidgets('should hide child when all conditions are false',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                // Set ALL breakpoints to false to ensure hiding
                return FlutstrapVisibility(
                  child: const Text('Hidden'),
                  showOnXs: false,
                  showOnSm: false,
                  showOnMd: false,
                  showOnLg: false,
                  showOnXl: false,
                  showOnXxl: false,
                );
              },
            ),
          ),
        ),
      );

      expect(find.text('Hidden'), findsNothing);
    });

    testWidgets('should show fallback when child is hidden',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                // Set ALL breakpoints to false to ensure hiding
                return FlutstrapVisibility(
                  child: const Text('Hidden'),
                  showOnXs: false,
                  showOnSm: false,
                  showOnMd: false,
                  showOnLg: false,
                  showOnXl: false,
                  showOnXxl: false,
                  fallback: const Text('Fallback'),
                );
              },
            ),
          ),
        ),
      );

      expect(find.text('Hidden'), findsNothing);
      expect(find.text('Fallback'), findsOneWidget);
    });

    testWidgets('should use SizedBox.shrink when no fallback provided',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                // Set ALL breakpoints to false to ensure hiding
                return FlutstrapVisibility(
                  child: const Text('Hidden'),
                  showOnXs: false,
                  showOnSm: false,
                  showOnMd: false,
                  showOnLg: false,
                  showOnXl: false,
                  showOnXxl: false,
                  fallback: null,
                );
              },
            ),
          ),
        ),
      );

      expect(find.text('Hidden'), findsNothing);
      final sizedBoxFinder = find.byType(SizedBox);
      expect(sizedBoxFinder, findsOneWidget);
    });

    // Helper function to get screen width from context
    double _getScreenWidth(WidgetTester tester) {
      final element = tester.element(find.byType(FlutstrapVisibility));
      final mediaQuery = MediaQuery.of(element);
      return mediaQuery.size.width;
    }

    // Test the factory constructors with conditional expectations
    testWidgets('xsOnly should show only on xs breakpoint',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapVisibility.xsOnly(
              child: const Text('XS Only'),
            ),
          ),
        ),
      );

      final screenWidth = _getScreenWidth(tester);
      final responsive = FSResponsive.of(screenWidth);

      if (responsive.breakpoint == FSBreakpoint.xs) {
        expect(find.text('XS Only'), findsOneWidget);
      } else {
        expect(find.text('XS Only'), findsNothing);
      }
    });

    testWidgets('smOnly should show only on sm breakpoint',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapVisibility.smOnly(
              child: const Text('SM Only'),
            ),
          ),
        ),
      );

      final screenWidth = _getScreenWidth(tester);
      final responsive = FSResponsive.of(screenWidth);

      if (responsive.breakpoint == FSBreakpoint.sm) {
        expect(find.text('SM Only'), findsOneWidget);
      } else {
        expect(find.text('SM Only'), findsNothing);
      }
    });

    testWidgets('mdOnly should show only on md breakpoint',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapVisibility.mdOnly(
              child: const Text('MD Only'),
            ),
          ),
        ),
      );

      final screenWidth = _getScreenWidth(tester);
      final responsive = FSResponsive.of(screenWidth);

      if (responsive.breakpoint == FSBreakpoint.md) {
        expect(find.text('MD Only'), findsOneWidget);
      } else {
        expect(find.text('MD Only'), findsNothing);
      }
    });

    testWidgets('lgOnly should show only on lg breakpoint',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapVisibility.lgOnly(
              child: const Text('LG Only'),
            ),
          ),
        ),
      );

      final screenWidth = _getScreenWidth(tester);
      final responsive = FSResponsive.of(screenWidth);

      if (responsive.breakpoint == FSBreakpoint.lg) {
        expect(find.text('LG Only'), findsOneWidget);
      } else {
        expect(find.text('LG Only'), findsNothing);
      }
    });

    testWidgets('xlOnly should show only on xl breakpoint',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapVisibility.xlOnly(
              child: const Text('XL Only'),
            ),
          ),
        ),
      );

      final screenWidth = _getScreenWidth(tester);
      final responsive = FSResponsive.of(screenWidth);

      if (responsive.breakpoint == FSBreakpoint.xl) {
        expect(find.text('XL Only'), findsOneWidget);
      } else {
        expect(find.text('XL Only'), findsNothing);
      }
    });

    testWidgets('xxlOnly should show only on xxl breakpoint',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapVisibility.xxlOnly(
              child: const Text('XXL Only'),
            ),
          ),
        ),
      );

      final screenWidth = _getScreenWidth(tester);
      final responsive = FSResponsive.of(screenWidth);

      if (responsive.breakpoint == FSBreakpoint.xxl) {
        expect(find.text('XXL Only'), findsOneWidget);
      } else {
        expect(find.text('XXL Only'), findsNothing);
      }
    });

    testWidgets('mobileOnly should show only on xs and sm breakpoints',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapVisibility.mobileOnly(
              child: const Text('Mobile Only'),
            ),
          ),
        ),
      );

      final screenWidth = _getScreenWidth(tester);
      final responsive = FSResponsive.of(screenWidth);
      final isMobile = responsive.breakpoint == FSBreakpoint.xs ||
          responsive.breakpoint == FSBreakpoint.sm;

      if (isMobile) {
        expect(find.text('Mobile Only'), findsOneWidget);
      } else {
        expect(find.text('Mobile Only'), findsNothing);
      }
    });

    testWidgets('tabletOnly should show only on md breakpoint',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapVisibility.tabletOnly(
              child: const Text('Tablet Only'),
            ),
          ),
        ),
      );

      final screenWidth = _getScreenWidth(tester);
      final responsive = FSResponsive.of(screenWidth);

      if (responsive.breakpoint == FSBreakpoint.md) {
        expect(find.text('Tablet Only'), findsOneWidget);
      } else {
        expect(find.text('Tablet Only'), findsNothing);
      }
    });

    testWidgets('desktopOnly should show only on lg, xl, and xxl breakpoints',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapVisibility.desktopOnly(
              child: const Text('Desktop Only'),
            ),
          ),
        ),
      );

      final screenWidth = _getScreenWidth(tester);
      final responsive = FSResponsive.of(screenWidth);
      final isDesktop = responsive.breakpoint == FSBreakpoint.lg ||
          responsive.breakpoint == FSBreakpoint.xl ||
          responsive.breakpoint == FSBreakpoint.xxl;

      if (isDesktop) {
        expect(find.text('Desktop Only'), findsOneWidget);
      } else {
        expect(find.text('Desktop Only'), findsNothing);
      }
    });

    testWidgets('hideOnXs should hide on xs breakpoint',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapVisibility.hideOnXs(
              child: const Text('Not XS'),
            ),
          ),
        ),
      );

      final screenWidth = _getScreenWidth(tester);
      final responsive = FSResponsive.of(screenWidth);

      if (responsive.breakpoint == FSBreakpoint.xs) {
        expect(find.text('Not XS'), findsNothing);
      } else {
        expect(find.text('Not XS'), findsOneWidget);
      }
    });

    testWidgets('hideOnSm should hide on sm breakpoint',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapVisibility.hideOnSm(
              child: const Text('Not SM'),
            ),
          ),
        ),
      );

      final screenWidth = _getScreenWidth(tester);
      final responsive = FSResponsive.of(screenWidth);

      if (responsive.breakpoint == FSBreakpoint.sm) {
        expect(find.text('Not SM'), findsNothing);
      } else {
        expect(find.text('Not SM'), findsOneWidget);
      }
    });

    testWidgets('hideOnMd should hide on md breakpoint',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapVisibility.hideOnMd(
              child: const Text('Not MD'),
            ),
          ),
        ),
      );

      final screenWidth = _getScreenWidth(tester);
      final responsive = FSResponsive.of(screenWidth);

      if (responsive.breakpoint == FSBreakpoint.md) {
        expect(find.text('Not MD'), findsNothing);
      } else {
        expect(find.text('Not MD'), findsOneWidget);
      }
    });

    testWidgets('hideOnLg should hide on lg breakpoint',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapVisibility.hideOnLg(
              child: const Text('Not LG'),
            ),
          ),
        ),
      );

      final screenWidth = _getScreenWidth(tester);
      final responsive = FSResponsive.of(screenWidth);

      if (responsive.breakpoint == FSBreakpoint.lg) {
        expect(find.text('Not LG'), findsNothing);
      } else {
        expect(find.text('Not LG'), findsOneWidget);
      }
    });

    testWidgets('hideOnMobile should hide on xs and sm breakpoints',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapVisibility.hideOnMobile(
              child: const Text('Not Mobile'),
            ),
          ),
        ),
      );

      final screenWidth = _getScreenWidth(tester);
      final responsive = FSResponsive.of(screenWidth);
      final isMobile = responsive.breakpoint == FSBreakpoint.xs ||
          responsive.breakpoint == FSBreakpoint.sm;

      if (isMobile) {
        expect(find.text('Not Mobile'), findsNothing);
      } else {
        expect(find.text('Not Mobile'), findsOneWidget);
      }
    });

    testWidgets('hideOnDesktop should hide on lg, xl, and xxl breakpoints',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapVisibility.hideOnDesktop(
              child: const Text('Not Desktop'),
            ),
          ),
        ),
      );

      final screenWidth = _getScreenWidth(tester);
      final responsive = FSResponsive.of(screenWidth);
      final isDesktop = responsive.breakpoint == FSBreakpoint.lg ||
          responsive.breakpoint == FSBreakpoint.xl ||
          responsive.breakpoint == FSBreakpoint.xxl;

      if (isDesktop) {
        expect(find.text('Not Desktop'), findsNothing);
      } else {
        expect(find.text('Not Desktop'), findsOneWidget);
      }
    });
  });
}
