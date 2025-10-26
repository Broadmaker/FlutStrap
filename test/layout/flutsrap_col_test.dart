import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:master_flutstrap/layout/flutstrap_col.dart';
import 'package:master_flutstrap/core/breakpoints.dart';

void main() {
  group('FlutstrapCol', () {
    testWidgets('should render child widget', (WidgetTester tester) async {
      const testText = 'Hello Column';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapCol(
              child: const Text(testText),
            ),
          ),
        ),
      );

      expect(find.text(testText), findsOneWidget);
    });

    testWidgets('should use FractionallySizedBox for responsive width',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapCol(
              child: const Text('Test'),
              size: const FSColSize(xs: 6), // Half width
            ),
          ),
        ),
      );

      expect(find.byType(FractionallySizedBox), findsOneWidget);
    });

    testWidgets('should apply default padding', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapCol(
              child: const Text('Test'),
            ),
          ),
        ),
      );

      final containerFinder = find.byType(Container);
      expect(containerFinder, findsOneWidget);
    });

    test('fullWidth should create 12-column width', () {
      const col = FlutstrapCol(
        child: Text('Test'),
      );

      final fullWidthCol = col.fullWidth();
      expect(fullWidthCol.size.xxl, 12);
    });

    test('halfWidth should create 6-column width', () {
      const col = FlutstrapCol(
        child: Text('Test'),
      );

      final halfWidthCol = col.halfWidth();
      expect(halfWidthCol.size.xxl, 6);
    });

    test('oneThirdWidth should create 4-column width', () {
      const col = FlutstrapCol(
        child: Text('Test'),
      );

      final oneThirdCol = col.oneThirdWidth();
      expect(oneThirdCol.size.xxl, 4);
    });

    test('twoThirdsWidth should create 8-column width', () {
      const col = FlutstrapCol(
        child: Text('Test'),
      );

      final twoThirdsCol = col.twoThirdsWidth();
      expect(twoThirdsCol.size.xxl, 8);
    });
  });

  group('FSColSize', () {
    test('should provide fallback sizes', () {
      const size = FSColSize(
        xs: 12,
        md: 6,
        xl: 4,
      );

      expect(size.getSize(FSBreakpoint.xs), 12); // xs specified
      expect(size.getSize(FSBreakpoint.sm), 12); // falls back to xs
      expect(size.getSize(FSBreakpoint.md), 6); // md specified
      expect(size.getSize(FSBreakpoint.lg), 6); // falls back to md
      expect(size.getSize(FSBreakpoint.xl), 4); // xl specified
      expect(size.getSize(FSBreakpoint.xxl), 4); // falls back to xl
    });

    test('all constructor should set same size for all breakpoints', () {
      const size = FSColSize.all(8);

      expect(size.xs, 8);
      expect(size.sm, 8);
      expect(size.md, 8);
      expect(size.lg, 8);
      expect(size.xl, 8);
      expect(size.xxl, 8);
    });
  });
}
