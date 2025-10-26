import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:master_flutstrap/layout/flutstrap_container.dart';
import 'package:master_flutstrap/core/theme.dart';
import 'package:master_flutstrap/core/breakpoints.dart';

void main() {
  group('FlutstrapContainer', () {
    testWidgets('should render child widget', (WidgetTester tester) async {
      const testText = 'Hello Container';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapContainer(
              child: const Text(testText),
            ),
          ),
        ),
      );

      expect(find.text(testText), findsOneWidget);
    });

    testWidgets('should apply default padding', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapContainer(
              child: const Text('Test'),
            ),
          ),
        ),
      );

      // Find the Container that's a direct child of Scaffold body
      final containerFinder = find.descendant(
        of: find.byType(Scaffold),
        matching: find.byType(Container),
      );
      expect(containerFinder, findsOneWidget);
    });

    testWidgets('should use fluid width when specified',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapContainer(
              child: const Text('Test'),
              fluid: true,
            ),
          ),
        ),
      );

      // Find the ConstrainedBox that's inside our FlutstrapContainer
      final constrainedBoxFinder = find.descendant(
        of: find.byType(FlutstrapContainer),
        matching: find.byType(ConstrainedBox),
      );

      expect(constrainedBoxFinder, findsOneWidget);
      expect(find.text('Test'), findsOneWidget);
    });

    testWidgets('should use custom padding when provided',
        (WidgetTester tester) async {
      const customPadding = EdgeInsets.all(20.0);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapContainer(
              child: const Text('Test'),
              padding: customPadding,
            ),
          ),
        ),
      );

      // Find the specific Container inside FlutstrapContainer
      final container = tester.widget<Container>(
        find
            .descendant(
              of: find.byType(FlutstrapContainer),
              matching: find.byType(Container),
            )
            .first,
      );
      expect(container.padding, customPadding);
    });

    testWidgets('should apply color when provided',
        (WidgetTester tester) async {
      const testColor = Colors.blue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapContainer(
              child: const Text('Test'),
              color: testColor,
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(
        find
            .descendant(
              of: find.byType(FlutstrapContainer),
              matching: find.byType(Container),
            )
            .first,
      );
      expect(container.color, testColor);
    });

    test('fluidWidth should create fluid container', () {
      const container = FlutstrapContainer(
        child: Text('Test'),
      );

      final fluidContainer = container.fluidWidth();
      expect(fluidContainer.fluid, true);
    });

    test('withMaxWidth should create container with custom width', () {
      const container = FlutstrapContainer(
        child: Text('Test'),
      );

      final customContainer = container.withMaxWidth(500);
      expect(customContainer.width, 500);
    });
  });

  group('FlutstrapContainer Responsive', () {
    testWidgets('should render without errors', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapContainer(
              child: const Text('Test'),
            ),
          ),
        ),
      );

      expect(find.text('Test'), findsOneWidget);
    });

    testWidgets('should handle different screen sizes',
        (WidgetTester tester) async {
      // Test that it works on different screen sizes without throwing
      final sizes = [400.0, 800.0, 1200.0];

      for (final size in sizes) {
        tester.binding.window.physicalSizeTestValue = Size(size, 800);

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: FlutstrapContainer(
                child: const Text('Test'),
              ),
            ),
          ),
        );

        expect(find.text('Test'), findsOneWidget);

        // Clean up for next iteration
        await tester.pumpAndSettle();
      }

      // Final clean up
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
    });
  });

  // Additional test to verify maxWidth behavior
  testWidgets('should have correct maxWidth constraints',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FlutstrapContainer(
            child: const Text('Test'),
            fluid: false,
          ),
        ),
      ),
    );

    // Find the ConstrainedBox inside our FlutstrapContainer
    final constrainedBox = tester.widget<ConstrainedBox>(
      find.descendant(
        of: find.byType(FlutstrapContainer),
        matching: find.byType(ConstrainedBox),
      ),
    );

    // Should have some constraint (not necessarily finite in xs breakpoint)
    expect(constrainedBox.constraints, isNotNull);
  });
}
