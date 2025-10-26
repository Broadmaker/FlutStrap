import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:master_flutstrap/components/spinners/flutstrap_spinner.dart';

// Custom finder that works with generic types
Finder findFlutstrapSpinner() {
  return find.byWidgetPredicate(
    (widget) => widget is FlutstrapSpinner,
  );
}

void main() {
  group('FlutstrapSpinner Basic Tests', () {
    testWidgets('should render with basic properties',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapSpinner(),
            ),
          ),
        ),
      );

      expect(findFlutstrapSpinner(), findsOneWidget);
    });

    testWidgets('should render with label', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapSpinner(
                label: 'Loading...',
              ),
            ),
          ),
        ),
      );

      expect(find.text('Loading...'), findsOneWidget);
      expect(findFlutstrapSpinner(), findsOneWidget);
    });

    testWidgets('should render with custom label', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapSpinner(
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
      expect(findFlutstrapSpinner(), findsOneWidget);
    });

    testWidgets('should render centered', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapSpinner(
              centered: true,
            ),
          ),
        ),
      );

      expect(findFlutstrapSpinner(), findsOneWidget);
    });
  });

  group('FSSpinnerType Tests', () {
    testWidgets('should render border spinner', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapSpinner(
                type: FSSpinnerType.border,
              ),
            ),
          ),
        ),
      );

      expect(findFlutstrapSpinner(), findsOneWidget);
    });

    testWidgets('should render growing spinner', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapSpinner(
                type: FSSpinnerType.growing,
              ),
            ),
          ),
        ),
      );

      expect(findFlutstrapSpinner(), findsOneWidget);
    });

    testWidgets('should render dots spinner', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapSpinner(
                type: FSSpinnerType.dots,
              ),
            ),
          ),
        ),
      );

      expect(findFlutstrapSpinner(), findsOneWidget);
    });
  });

  group('FSSpinnerVariant Tests', () {
    testWidgets('should render primary variant', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapSpinner(
                variant: FSSpinnerVariant.primary,
              ),
            ),
          ),
        ),
      );

      expect(findFlutstrapSpinner(), findsOneWidget);
    });

    testWidgets('should render secondary variant', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapSpinner(
                variant: FSSpinnerVariant.secondary,
              ),
            ),
          ),
        ),
      );

      expect(findFlutstrapSpinner(), findsOneWidget);
    });

    testWidgets('should render success variant', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapSpinner(
                variant: FSSpinnerVariant.success,
              ),
            ),
          ),
        ),
      );

      expect(findFlutstrapSpinner(), findsOneWidget);
    });

    testWidgets('should render danger variant', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapSpinner(
                variant: FSSpinnerVariant.danger,
              ),
            ),
          ),
        ),
      );

      expect(findFlutstrapSpinner(), findsOneWidget);
    });

    testWidgets('should render warning variant', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapSpinner(
                variant: FSSpinnerVariant.warning,
              ),
            ),
          ),
        ),
      );

      expect(findFlutstrapSpinner(), findsOneWidget);
    });

    testWidgets('should render info variant', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapSpinner(
                variant: FSSpinnerVariant.info,
              ),
            ),
          ),
        ),
      );

      expect(findFlutstrapSpinner(), findsOneWidget);
    });

    testWidgets('should render light variant', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapSpinner(
                variant: FSSpinnerVariant.light,
              ),
            ),
          ),
        ),
      );

      expect(findFlutstrapSpinner(), findsOneWidget);
    });

    testWidgets('should render dark variant', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapSpinner(
                variant: FSSpinnerVariant.dark,
              ),
            ),
          ),
        ),
      );

      expect(findFlutstrapSpinner(), findsOneWidget);
    });
  });

  group('FSSpinnerSize Tests', () {
    testWidgets('should render small size', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapSpinner(
                size: FSSpinnerSize.sm,
              ),
            ),
          ),
        ),
      );

      expect(findFlutstrapSpinner(), findsOneWidget);
    });

    testWidgets('should render medium size', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapSpinner(
                size: FSSpinnerSize.md,
              ),
            ),
          ),
        ),
      );

      expect(findFlutstrapSpinner(), findsOneWidget);
    });

    testWidgets('should render large size', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapSpinner(
                size: FSSpinnerSize.lg,
              ),
            ),
          ),
        ),
      );

      expect(findFlutstrapSpinner(), findsOneWidget);
    });
  });

  group('FlutstrapSpinnerButton Tests', () {
    testWidgets('should render button with spinner when loading',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapSpinnerButton(
                isLoading: true,
                onPressed: () {},
                child: Text('Submit'),
              ),
            ),
          ),
        ),
      );

      expect(findFlutstrapSpinner(), findsOneWidget);
      expect(find.text('Submit'),
          findsNothing); // Child should be hidden when loading
    });

    testWidgets('should render button with child when not loading',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapSpinnerButton(
                isLoading: false,
                onPressed: () {},
                child: Text('Submit'),
              ),
            ),
          ),
        ),
      );

      expect(findFlutstrapSpinner(), findsNothing); // Spinner should be hidden
      expect(find.text('Submit'), findsOneWidget); // Child should be visible
    });
  });

  group('FlutstrapSpinner Edge Cases', () {
    testWidgets('should handle custom color', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapSpinner(
                color: Colors.purple,
              ),
            ),
          ),
        ),
      );

      expect(findFlutstrapSpinner(), findsOneWidget);
    });

    testWidgets('should handle custom stroke width',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapSpinner(
                strokeWidth: 5.0,
              ),
            ),
          ),
        ),
      );

      expect(findFlutstrapSpinner(), findsOneWidget);
    });

    testWidgets('should handle custom animation duration',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapSpinner(
                animationDuration: Duration(milliseconds: 500),
              ),
            ),
          ),
        ),
      );

      expect(findFlutstrapSpinner(), findsOneWidget);
    });
  });

  group('FlutstrapSpinner Property Tests', () {
    test('should have correct default variant', () {
      final spinner = FlutstrapSpinner();
      expect(spinner.variant, FSSpinnerVariant.primary);
    });

    test('should have correct default size', () {
      final spinner = FlutstrapSpinner();
      expect(spinner.size, FSSpinnerSize.md);
    });

    test('should have correct default type', () {
      final spinner = FlutstrapSpinner();
      expect(spinner.type, FSSpinnerType.border);
    });

    test('should have centered disabled by default', () {
      final spinner = FlutstrapSpinner();
      expect(spinner.centered, false);
    });

    test('should have correct default animation duration', () {
      final spinner = FlutstrapSpinner();
      expect(spinner.animationDuration, Duration(milliseconds: 1000));
    });
  });
}
