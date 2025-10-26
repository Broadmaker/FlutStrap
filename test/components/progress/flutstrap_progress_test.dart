import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:master_flutstrap/components/progress/flutstrap_progress.dart';

// Custom finder that works with generic types
Finder findFlutstrapProgress() {
  return find.byWidgetPredicate(
    (widget) => widget is FlutstrapProgress,
  );
}

void main() {
  group('FlutstrapProgress Basic Tests', () {
    testWidgets('should render with basic properties',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapProgress(
                value: 50,
              ),
            ),
          ),
        ),
      );

      expect(findFlutstrapProgress(), findsOneWidget);
    });

    testWidgets('should render with label', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapProgress(
                value: 75,
                label: 'Loading...',
              ),
            ),
          ),
        ),
      );

      expect(find.text('Loading...'), findsOneWidget);
      expect(findFlutstrapProgress(), findsOneWidget);
    });

    testWidgets('should render with custom label', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapProgress(
                value: 25,
                customLabel: Row(
                  children: [
                    Icon(Icons.download),
                    SizedBox(width: 8),
                    Text('Downloading...'),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.download), findsOneWidget);
      expect(find.text('Downloading...'), findsOneWidget);
      expect(findFlutstrapProgress(), findsOneWidget);
    });

    testWidgets('should render indeterminate progress',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapProgress.indeterminate(),
            ),
          ),
        ),
      );

      expect(findFlutstrapProgress(), findsOneWidget);
    });

    testWidgets('should render with custom min and max values',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapProgress(
                value: 250,
                minValue: 0,
                maxValue: 500,
              ),
            ),
          ),
        ),
      );

      expect(findFlutstrapProgress(), findsOneWidget);
    });

    testWidgets('should render with striped pattern',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapProgress(
                value: 60,
                striped: true,
              ),
            ),
          ),
        ),
      );

      expect(findFlutstrapProgress(), findsOneWidget);
    });

    testWidgets('should render with animation', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapProgress(
                value: 80,
                animated: true,
              ),
            ),
          ),
        ),
      );

      expect(findFlutstrapProgress(), findsOneWidget);
    });
  });

  group('FSProgressVariant Tests', () {
    testWidgets('should render primary variant', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapProgress(
                value: 30,
                variant: FSProgressVariant.primary,
              ),
            ),
          ),
        ),
      );

      expect(findFlutstrapProgress(), findsOneWidget);
    });

    testWidgets('should render secondary variant', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapProgress(
                value: 40,
                variant: FSProgressVariant.secondary,
              ),
            ),
          ),
        ),
      );

      expect(findFlutstrapProgress(), findsOneWidget);
    });

    testWidgets('should render success variant', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapProgress(
                value: 90,
                variant: FSProgressVariant.success,
              ),
            ),
          ),
        ),
      );

      expect(findFlutstrapProgress(), findsOneWidget);
    });

    testWidgets('should render danger variant', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapProgress(
                value: 20,
                variant: FSProgressVariant.danger,
              ),
            ),
          ),
        ),
      );

      expect(findFlutstrapProgress(), findsOneWidget);
    });

    testWidgets('should render warning variant', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapProgress(
                value: 50,
                variant: FSProgressVariant.warning,
              ),
            ),
          ),
        ),
      );

      expect(findFlutstrapProgress(), findsOneWidget);
    });

    testWidgets('should render info variant', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapProgress(
                value: 70,
                variant: FSProgressVariant.info,
              ),
            ),
          ),
        ),
      );

      expect(findFlutstrapProgress(), findsOneWidget);
    });

    testWidgets('should render light variant', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapProgress(
                value: 60,
                variant: FSProgressVariant.light,
              ),
            ),
          ),
        ),
      );

      expect(findFlutstrapProgress(), findsOneWidget);
    });

    testWidgets('should render dark variant', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapProgress(
                value: 80,
                variant: FSProgressVariant.dark,
              ),
            ),
          ),
        ),
      );

      expect(findFlutstrapProgress(), findsOneWidget);
    });
  });

  group('FSProgressSize Tests', () {
    testWidgets('should render small size', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapProgress(
                value: 25,
                size: FSProgressSize.sm,
              ),
            ),
          ),
        ),
      );

      expect(findFlutstrapProgress(), findsOneWidget);
    });

    testWidgets('should render medium size', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapProgress(
                value: 50,
                size: FSProgressSize.md,
              ),
            ),
          ),
        ),
      );

      expect(findFlutstrapProgress(), findsOneWidget);
    });

    testWidgets('should render large size', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapProgress(
                value: 75,
                size: FSProgressSize.lg,
              ),
            ),
          ),
        ),
      );

      expect(findFlutstrapProgress(), findsOneWidget);
    });
  });

  group('FlutstrapProgressGroup Tests', () {
    testWidgets('should render multiple progress bars',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapProgressGroup(
                children: [
                  FlutstrapProgress(value: 25, label: 'Step 1'),
                  FlutstrapProgress(value: 50, label: 'Step 2'),
                  FlutstrapProgress(value: 75, label: 'Step 3'),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.text('Step 1'), findsOneWidget);
      expect(find.text('Step 2'), findsOneWidget);
      expect(find.text('Step 3'), findsOneWidget);
      expect(find.byType(FlutstrapProgress), findsNWidgets(3));
    });
  });

  group('FlutstrapProgress Edge Cases', () {
    testWidgets('should handle value at minimum', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapProgress(
                value: 0,
              ),
            ),
          ),
        ),
      );

      expect(findFlutstrapProgress(), findsOneWidget);
    });

    testWidgets('should handle value at maximum', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapProgress(
                value: 100,
              ),
            ),
          ),
        ),
      );

      expect(findFlutstrapProgress(), findsOneWidget);
    });

    testWidgets('should handle custom colors', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapProgress(
                value: 45,
                backgroundColor: Colors.grey[200],
                progressColor: Colors.purple,
              ),
            ),
          ),
        ),
      );

      expect(findFlutstrapProgress(), findsOneWidget);
    });

    testWidgets('should handle custom height', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapProgress(
                value: 60,
                height: 20,
              ),
            ),
          ),
        ),
      );

      expect(findFlutstrapProgress(), findsOneWidget);
    });

    testWidgets('should handle custom borderRadius',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapProgress(
                value: 35,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      );

      expect(findFlutstrapProgress(), findsOneWidget);
    });
  });

  group('FlutstrapProgress Property Tests', () {
    test('should have correct default variant', () {
      final progress = FlutstrapProgress(value: 50);
      expect(progress.variant, FSProgressVariant.primary);
    });

    test('should have correct default size', () {
      final progress = FlutstrapProgress(value: 50);
      expect(progress.size, FSProgressSize.md);
    });

    test('should have animation disabled by default', () {
      final progress = FlutstrapProgress(value: 50);
      expect(progress.animated, false);
    });

    test('should have stripes disabled by default', () {
      final progress = FlutstrapProgress(value: 50);
      expect(progress.striped, false);
    });

    test('should have correct default min and max values', () {
      final progress = FlutstrapProgress(value: 50);
      expect(progress.minValue, 0.0);
      expect(progress.maxValue, 100.0);
    });

    test('indeterminate progress should have correct defaults', () {
      final progress = FlutstrapProgress.indeterminate();
      expect(progress.animated, true);
      expect(progress.striped, true);
      expect(progress.value, 0);
    });
  });
}
