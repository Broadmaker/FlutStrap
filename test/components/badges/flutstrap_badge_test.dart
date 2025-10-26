import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:master_flutstrap/components/badges/flutstrap_badge.dart';

// Custom finder that works with generic types
Finder findFlutstrapBadge() {
  return find.byWidgetPredicate(
    (widget) => widget is FlutstrapBadge,
  );
}

void main() {
  group('FlutstrapBadge Basic Tests', () {
    testWidgets('should render with basic properties',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapBadge(
                text: 'New',
              ),
            ),
          ),
        ),
      );

      expect(find.text('New'), findsOneWidget);
      expect(findFlutstrapBadge(), findsOneWidget);
    });

    testWidgets('should render with count only', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapBadge.count(
                count: 5,
              ),
            ),
          ),
        ),
      );

      expect(find.text('5'), findsOneWidget);
      expect(findFlutstrapBadge(), findsOneWidget);
    });

    testWidgets('should render dot badge', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapBadge.dot(),
            ),
          ),
        ),
      );

      expect(findFlutstrapBadge(), findsOneWidget);
    });

    testWidgets('should render with pill shape', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapBadge(
                text: 'Pill',
                pill: true,
              ),
            ),
          ),
        ),
      );

      expect(find.text('Pill'), findsOneWidget);
      expect(findFlutstrapBadge(), findsOneWidget);
    });

    testWidgets('should render with child widget', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapBadge(
                text: '2',
                child: IconButton(
                  icon: Icon(Icons.notifications),
                  onPressed: () {},
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.notifications), findsOneWidget);
      expect(find.text('2'), findsOneWidget);
      expect(findFlutstrapBadge(), findsOneWidget);
    });

    testWidgets('should handle tap events', (WidgetTester tester) async {
      bool wasTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapBadge(
                text: 'Clickable',
                onTap: () {
                  wasTapped = true;
                },
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Clickable'));
      await tester.pump();

      expect(wasTapped, true);
      expect(findFlutstrapBadge(), findsOneWidget);
    });
  });

  group('FSBadgeVariant Tests', () {
    testWidgets('should render primary variant', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapBadge(
                text: 'Primary',
                variant: FSBadgeVariant.primary,
              ),
            ),
          ),
        ),
      );

      expect(find.text('Primary'), findsOneWidget);
      expect(findFlutstrapBadge(), findsOneWidget);
    });

    testWidgets('should render secondary variant', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapBadge(
                text: 'Secondary',
                variant: FSBadgeVariant.secondary,
              ),
            ),
          ),
        ),
      );

      expect(find.text('Secondary'), findsOneWidget);
      expect(findFlutstrapBadge(), findsOneWidget);
    });

    testWidgets('should render success variant', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapBadge(
                text: 'Success',
                variant: FSBadgeVariant.success,
              ),
            ),
          ),
        ),
      );

      expect(find.text('Success'), findsOneWidget);
      expect(findFlutstrapBadge(), findsOneWidget);
    });

    testWidgets('should render danger variant', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapBadge(
                text: 'Danger',
                variant: FSBadgeVariant.danger,
              ),
            ),
          ),
        ),
      );

      expect(find.text('Danger'), findsOneWidget);
      expect(findFlutstrapBadge(), findsOneWidget);
    });

    testWidgets('should render warning variant', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapBadge(
                text: 'Warning',
                variant: FSBadgeVariant.warning,
              ),
            ),
          ),
        ),
      );

      expect(find.text('Warning'), findsOneWidget);
      expect(findFlutstrapBadge(), findsOneWidget);
    });

    testWidgets('should render info variant', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapBadge(
                text: 'Info',
                variant: FSBadgeVariant.info,
              ),
            ),
          ),
        ),
      );

      expect(find.text('Info'), findsOneWidget);
      expect(findFlutstrapBadge(), findsOneWidget);
    });

    testWidgets('should render light variant', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapBadge(
                text: 'Light',
                variant: FSBadgeVariant.light,
              ),
            ),
          ),
        ),
      );

      expect(find.text('Light'), findsOneWidget);
      expect(findFlutstrapBadge(), findsOneWidget);
    });

    testWidgets('should render dark variant', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapBadge(
                text: 'Dark',
                variant: FSBadgeVariant.dark,
              ),
            ),
          ),
        ),
      );

      expect(find.text('Dark'), findsOneWidget);
      expect(findFlutstrapBadge(), findsOneWidget);
    });
  });

  group('FSBadgeSize Tests', () {
    testWidgets('should render small size', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapBadge(
                text: 'Small',
                size: FSBadgeSize.sm,
              ),
            ),
          ),
        ),
      );

      expect(find.text('Small'), findsOneWidget);
      expect(findFlutstrapBadge(), findsOneWidget);
    });

    testWidgets('should render medium size', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapBadge(
                text: 'Medium',
                size: FSBadgeSize.md,
              ),
            ),
          ),
        ),
      );

      expect(find.text('Medium'), findsOneWidget);
      expect(findFlutstrapBadge(), findsOneWidget);
    });

    testWidgets('should render large size', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapBadge(
                text: 'Large',
                size: FSBadgeSize.lg,
              ),
            ),
          ),
        ),
      );

      expect(find.text('Large'), findsOneWidget);
      expect(findFlutstrapBadge(), findsOneWidget);
    });
  });

  group('FlutstrapBadge Edge Cases', () {
    testWidgets('should handle large count with max limit',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapBadge.count(
                count: 150,
                maxCount: 99,
              ),
            ),
          ),
        ),
      );

      expect(find.text('99+'), findsOneWidget);
      expect(findFlutstrapBadge(), findsOneWidget);
    });

    testWidgets('should handle zero count', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapBadge.count(
                count: 0,
              ),
            ),
          ),
        ),
      );

      expect(find.text('0'), findsOneWidget);
      expect(findFlutstrapBadge(), findsOneWidget);
    });

    testWidgets('should handle custom colors', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapBadge(
                text: 'Custom',
                backgroundColor: Colors.purple,
                textColor: Colors.white,
              ),
            ),
          ),
        ),
      );

      expect(find.text('Custom'), findsOneWidget);
      expect(findFlutstrapBadge(), findsOneWidget);
    });

    testWidgets('should handle very long text', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapBadge(
                text: 'Very Long Badge Text That Might Be Truncated',
              ),
            ),
          ),
        ),
      );

      expect(find.text('Very Long Badge Text That Might Be Truncated'),
          findsOneWidget);
      expect(findFlutstrapBadge(), findsOneWidget);
    });
  });

  group('FlutstrapBadgePositioned Tests', () {
    testWidgets('should render badge positioned on child',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapBadgePositioned(
                child: IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {},
                ),
                badge: FlutstrapBadge.count(count: 3),
              ),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.shopping_cart), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
      expect(findFlutstrapBadge(), findsOneWidget);
    });
  });

  group('FlutstrapBadge Property Tests', () {
    test('should have correct default variant', () {
      final badge = FlutstrapBadge(text: 'Test');
      expect(badge.variant, FSBadgeVariant.primary);
    });

    test('should have correct default size', () {
      final badge = FlutstrapBadge(text: 'Test');
      expect(badge.size, FSBadgeSize.md);
    });

    test('should have pill disabled by default', () {
      final badge = FlutstrapBadge(text: 'Test');
      expect(badge.pill, false);
    });

    test('should have dot disabled by default', () {
      final badge = FlutstrapBadge(text: 'Test');
      expect(badge.dot, false);
    });

    test('count badge should have pill enabled by default', () {
      final badge = FlutstrapBadge.count(count: 1);
      expect(badge.pill, true);
    });

    test('dot badge should have correct defaults', () {
      final badge = FlutstrapBadge.dot();
      expect(badge.dot, true);
      expect(badge.pill, true);
      expect(badge.variant, FSBadgeVariant.danger);
      expect(badge.size, FSBadgeSize.sm);
    });
  });
}
