import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:master_flutstrap/layout/flutstrap_grid.dart';
import 'package:master_flutstrap/layout/flutstrap_row.dart';
import 'package:master_flutstrap/layout/flutstrap_col.dart';

void main() {
  group('FlutstrapGrid', () {
    testWidgets('should render child rows', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapGrid(
              children: [
                FlutstrapRow(
                  children: const [Text('Row 1, Col 1'), Text('Row 1, Col 2')],
                ),
                FlutstrapRow(
                  children: const [Text('Row 2, Col 1'), Text('Row 2, Col 2')],
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Row 1, Col 1'), findsOneWidget);
      expect(find.text('Row 1, Col 2'), findsOneWidget);
      expect(find.text('Row 2, Col 1'), findsOneWidget);
      expect(find.text('Row 2, Col 2'), findsOneWidget);
    });

    testWidgets('singleRow factory should create grid with one row',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapGrid.singleRow(
              columns: const [Text('Col 1'), Text('Col 2'), Text('Col 3')],
            ),
          ),
        ),
      );

      expect(find.text('Col 1'), findsOneWidget);
      expect(find.text('Col 2'), findsOneWidget);
      expect(find.text('Col 3'), findsOneWidget);
    });

    testWidgets('multipleRows factory should create grid with multiple rows',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapGrid.multipleRows(
              rows: [
                [const Text('R1C1'), const Text('R1C2')],
                [const Text('R2C1'), const Text('R2C2')],
              ],
            ),
          ),
        ),
      );

      expect(find.text('R1C1'), findsOneWidget);
      expect(find.text('R1C2'), findsOneWidget);
      expect(find.text('R2C1'), findsOneWidget);
      expect(find.text('R2C2'), findsOneWidget);
    });

    testWidgets('cards factory should create card grid layout',
        (WidgetTester tester) async {
      final cards = List.generate(6, (index) => Text('Card ${index + 1}'));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapGrid.cards(
              cards: cards,
              columns: 3,
            ),
          ),
        ),
      );

      expect(find.text('Card 1'), findsOneWidget);
      expect(find.text('Card 6'), findsOneWidget);
    });

    test('fluidGrid should create fluid container', () {
      const grid = FlutstrapGrid(
        children: [
          FlutstrapRow(children: [Text('Test')])
        ],
        fluid: false,
      );

      final fluidGrid = grid.fluidGrid();
      expect(fluidGrid.fluid, true);
    });

    test('withPadding should create grid with custom padding', () {
      const grid = FlutstrapGrid(
        children: [
          FlutstrapRow(children: [Text('Test')])
        ],
      );

      final customPaddingGrid = grid.withPadding(const EdgeInsets.all(20));
      expect(customPaddingGrid.padding, const EdgeInsets.all(20));
    });

    test('withMargin should create grid with custom margin', () {
      const grid = FlutstrapGrid(
        children: [
          FlutstrapRow(children: [Text('Test')])
        ],
      );

      final customMarginGrid = grid.withMargin(const EdgeInsets.all(10));
      expect(customMarginGrid.margin, const EdgeInsets.all(10));
    });
  });

  group('FSGrid', () {
    test('responsiveSize should create column size configuration', () {
      final size = FSGrid.responsiveSize(xs: 12, sm: 6, md: 4);

      expect(size.xs, 12);
      expect(size.sm, 6);
      expect(size.md, 4);
    });

    test('common size presets should return correct values', () {
      expect(FSGrid.fullWidth.xs, 12);
      expect(FSGrid.halfWidth.xs, 6);
      expect(FSGrid.oneThirdWidth.xs, 4);
      expect(FSGrid.twoThirdsWidth.xs, 8);
    });

    test('calculateRowCount should calculate correct number of rows', () {
      expect(FSGrid.calculateRowCount(0, 3), 0);
      expect(FSGrid.calculateRowCount(3, 3), 1);
      expect(FSGrid.calculateRowCount(4, 3), 2);
      expect(FSGrid.calculateRowCount(6, 3), 2);
      expect(FSGrid.calculateRowCount(7, 3), 3);
    });

    test('distributeItems should distribute items into rows', () {
      final items = [1, 2, 3, 4, 5, 6];
      final distributed = FSGrid.distributeItems(items, 3);

      expect(distributed.length, 2);
      expect(distributed[0], [1, 2, 3]);
      expect(distributed[1], [4, 5, 6]);
    });

    test('distributeItems should handle uneven distribution', () {
      final items = [1, 2, 3, 4, 5];
      final distributed = FSGrid.distributeItems(items, 3);

      expect(distributed.length, 2);
      expect(distributed[0], [1, 2, 3]);
      expect(distributed[1], [4, 5]);
    });
  });
}
