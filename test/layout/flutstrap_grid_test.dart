import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutstrap/flutstrap.dart';

void main() {
  group('FlutstrapGrid - Basic Rendering Tests', () {
    testWidgets('should render with children', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FlutstrapGrid(
              children: [
                Text('Item 1'),
                Text('Item 2'),
                Text('Item 3'),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Item 2'), findsOneWidget);
      expect(find.text('Item 3'), findsOneWidget);
    });

    testWidgets('should render with row gaps', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FlutstrapGrid(
              children: [
                Text('Row 1'),
                Text('Row 2'),
                Text('Row 3'),
              ],
              rowGap: 20,
            ),
          ),
        ),
      );

      expect(find.text('Row 1'), findsOneWidget);
      expect(find.text('Row 2'), findsOneWidget);
      expect(find.text('Row 3'), findsOneWidget);
    });

    testWidgets('should render with custom padding',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapGrid(
              children: const [Text('Padded Grid')],
              padding: const EdgeInsets.all(20),
            ),
          ),
        ),
      );

      expect(find.text('Padded Grid'), findsOneWidget);
    });

    testWidgets('should render with custom margin',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapGrid(
              children: const [Text('Margin Grid')],
              margin: const EdgeInsets.all(20),
            ),
          ),
        ),
      );

      expect(find.text('Margin Grid'), findsOneWidget);
    });

    testWidgets('should render with color', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapGrid(
              children: const [Text('Colored Grid')],
              color: Colors.blue,
            ),
          ),
        ),
      );

      expect(find.text('Colored Grid'), findsOneWidget);
    });

    testWidgets('should render fluid grid', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FlutstrapGrid(
              children: [Text('Fluid Grid')],
              fluid: true,
            ),
          ),
        ),
      );

      expect(find.text('Fluid Grid'), findsOneWidget);
    });

    testWidgets('should throw assertion when children is empty',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapGrid(children: []),
          ),
        ),
      );

      expect(tester.takeException(), isAssertionError);
    });
  });

  group('FlutstrapGrid - Single Row Factory Tests', () {
    testWidgets('singleRow factory should create grid with one row',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapGrid.singleRow(
              columns: [
                Container(
                  color: Colors.red,
                  height: 50,
                  child: const Text('Col 1'),
                ),
                Container(
                  color: Colors.green,
                  height: 50,
                  child: const Text('Col 2'),
                ),
              ],
              gap: 10,
            ),
          ),
        ),
      );

      expect(find.text('Col 1'), findsOneWidget);
      expect(find.text('Col 2'), findsOneWidget);
      expect(find.byType(FlutstrapRow), findsOneWidget);
    });

    testWidgets('singleRow should handle custom alignment',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapGrid.singleRow(
              columns: [
                Container(
                  height: 50,
                  child: const Text('Col 1'),
                ),
                Container(
                  height: 100,
                  child: const Text('Col 2'),
                ),
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          ),
        ),
      );

      expect(find.text('Col 1'), findsOneWidget);
      expect(find.text('Col 2'), findsOneWidget);
    });

    testWidgets('singleRow should throw assertion when columns empty',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapGrid.singleRow(columns: []),
          ),
        ),
      );

      expect(tester.takeException(), isAssertionError);
    });
  });

  group('FlutstrapGrid - Multiple Rows Factory Tests', () {
    testWidgets('multipleRows factory should create grid with multiple rows',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapGrid.multipleRows(
              rows: [
                [
                  const Text('Row 1 - Col 1'),
                  const Text('Row 1 - Col 2'),
                ],
                [
                  const Text('Row 2 - Col 1'),
                  const Text('Row 2 - Col 2'),
                  const Text('Row 2 - Col 3'),
                ],
                [
                  const Text('Row 3 - Col 1'),
                ],
              ],
              rowGap: 20,
              columnGap: 10,
            ),
          ),
        ),
      );

      expect(find.text('Row 1 - Col 1'), findsOneWidget);
      expect(find.text('Row 1 - Col 2'), findsOneWidget);
      expect(find.text('Row 2 - Col 1'), findsOneWidget);
      expect(find.text('Row 2 - Col 2'), findsOneWidget);
      expect(find.text('Row 2 - Col 3'), findsOneWidget);
      expect(find.text('Row 3 - Col 1'), findsOneWidget);
      expect(find.byType(FlutstrapRow), findsNWidgets(3));
    });

    testWidgets('multipleRows should throw assertion when rows empty',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapGrid.multipleRows(rows: []),
          ),
        ),
      );

      expect(tester.takeException(), isAssertionError);
    });

    testWidgets('multipleRows should throw assertion when a row is empty',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapGrid.multipleRows(
              rows: [
                [const Text('Valid')],
                [],
              ],
            ),
          ),
        ),
      );

      expect(tester.takeException(), isAssertionError);
    });
  });

  group('FlutstrapGrid - Responsive Factory Tests', () {
    testWidgets('responsive factory should create responsive grid',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 1000,
              child: FlutstrapGrid.responsive(
                children: List.generate(
                  6,
                  (index) => Container(
                    height: 50,
                    color: Colors.blue.withOpacity(0.5),
                    child: Center(child: Text('Item $index')),
                  ),
                ),
                xsColumns: 1,
                smColumns: 2,
                mdColumns: 3,
                lgColumns: 4,
                xlColumns: 6,
                gap: 10,
              ),
            ),
          ),
        ),
      );

      for (int i = 0; i < 6; i++) {
        expect(find.text('Item $i'), findsOneWidget);
      }
    });

    testWidgets('responsive factory should respect xs columns on small screen',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 400,
              child: FlutstrapGrid.responsive(
                children: List.generate(
                  4,
                  (index) => Container(
                    height: 50,
                    child: Center(child: Text('Item $index')),
                  ),
                ),
                xsColumns: 2,
                smColumns: 4,
              ),
            ),
          ),
        ),
      );

      for (int i = 0; i < 4; i++) {
        expect(find.text('Item $i'), findsOneWidget);
      }
    });

    testWidgets(
        'responsive factory should throw assertion with invalid columns',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapGrid.responsive(
              children: [const Text('Item')],
              xsColumns: 13,
            ),
          ),
        ),
      );

      expect(tester.takeException(), isAssertionError);
    });

    testWidgets('responsive factory should throw assertion with empty children',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapGrid.responsive(
              children: [],
              xsColumns: 1,
            ),
          ),
        ),
      );

      expect(tester.takeException(), isAssertionError);
    });
  });

  group('FlutstrapGrid - Cards Factory Tests', () {
    testWidgets('cards factory should create card grid',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 800,
              child: FlutstrapGrid.cards(
                cards: List.generate(
                  5,
                  (index) => Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text('Card $index'),
                    ),
                  ),
                ),
                columns: 3,
                gap: 16,
              ),
            ),
          ),
        ),
      );

      for (int i = 0; i < 5; i++) {
        expect(find.text('Card $i'), findsOneWidget);
      }
    });

    testWidgets('cards factory should handle equal height option',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 800,
              child: FlutstrapGrid.cards(
                cards: List.generate(
                  3,
                  (index) => Container(
                    height: index == 0 ? 100 : 50,
                    color: Colors.blue,
                    child: Text('Card $index'),
                  ),
                ),
                columns: 2,
                equalHeight: true,
              ),
            ),
          ),
        ),
      );

      for (int i = 0; i < 3; i++) {
        expect(find.text('Card $i'), findsOneWidget);
      }
    });

    testWidgets('cards factory should throw assertion when cards empty',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapGrid.cards(
              cards: [],
              columns: 3,
            ),
          ),
        ),
      );

      expect(tester.takeException(), isAssertionError);
    });

    testWidgets('cards factory should throw assertion with invalid columns',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapGrid.cards(
              cards: [const Text('Card')],
              columns: 0,
            ),
          ),
        ),
      );

      expect(tester.takeException(), isAssertionError);
    });
  });

  group('FlutstrapGrid - AutoFit Factory Tests', () {
    testWidgets('autoFit factory should create auto-fitting grid',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 800,
              child: FlutstrapGrid.autoFit(
                children: List.generate(
                  8,
                  (index) => Container(
                    height: 50,
                    color: Colors.blue.withOpacity(0.5),
                    child: Center(child: Text('Item $index')),
                  ),
                ),
                minColumnWidth: 150,
                gap: 16,
              ),
            ),
          ),
        ),
      );

      for (int i = 0; i < 8; i++) {
        expect(find.text('Item $i'), findsOneWidget);
      }
    });

    testWidgets('autoFit factory should handle very small container',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 100,
              child: FlutstrapGrid.autoFit(
                children: List.generate(
                  3,
                  (index) => Container(
                    height: 50,
                    child: Center(child: Text('Item $index')),
                  ),
                ),
                minColumnWidth: 150,
                gap: 16,
              ),
            ),
          ),
        ),
      );

      for (int i = 0; i < 3; i++) {
        expect(find.text('Item $i'), findsOneWidget);
      }
    });

    testWidgets('autoFit factory should throw assertion when children empty',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapGrid.autoFit(
              children: [],
              minColumnWidth: 100,
            ),
          ),
        ),
      );

      expect(tester.takeException(), isAssertionError);
    });

    testWidgets(
        'autoFit factory should throw assertion with invalid minColumnWidth',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapGrid.autoFit(
              children: [const Text('Item')],
              minColumnWidth: 0,
            ),
          ),
        ),
      );

      expect(tester.takeException(), isAssertionError);
    });
  });

  group('FlutstrapGrid - Builder Methods', () {
    test('fluidGrid() should set fluid to true', () {
      final grid = FlutstrapGrid(
        children: const [Text('Test')],
        fluid: false,
      );

      final fluidGrid = grid.fluidGrid();
      expect(fluidGrid.fluid, true);
    });

    test('withPadding() should set custom padding', () {
      final grid = FlutstrapGrid(
        children: const [Text('Test')],
      );

      final paddedGrid = grid.withPadding(const EdgeInsets.all(20));
      expect(paddedGrid.padding, const EdgeInsets.all(20));
    });

    test('withMargin() should set custom margin', () {
      final grid = FlutstrapGrid(
        children: const [Text('Test')],
      );

      final marginGrid = grid.withMargin(const EdgeInsets.all(15));
      expect(marginGrid.margin, const EdgeInsets.all(15));
    });

    test('withRowGap() should set row gap', () {
      final grid = FlutstrapGrid(
        children: const [Text('Test')],
      );

      final gapGrid = grid.withRowGap(25);
      expect(gapGrid.rowGap, 25);
    });

    test('withColor() should set color', () {
      final grid = FlutstrapGrid(
        children: const [Text('Test')],
      );

      final coloredGrid = grid.withColor(Colors.red);
      expect(coloredGrid.color, Colors.red);
    });

    test('withDecoration() should set decoration', () {
      final grid = FlutstrapGrid(
        children: const [Text('Test')],
      );

      final decoration = BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(8),
      );
      final decoratedGrid = grid.withDecoration(decoration);
      expect(decoratedGrid.decoration, decoration);
    });
  });

  group('FlutstrapGrid - CopyWith Tests', () {
    test('copyWith should create new instance with updated values', () {
      final original = FlutstrapGrid(
        children: const [Text('Original')],
        fluid: false,
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(4),
        color: Colors.blue,
        rowGap: 10,
      );

      final copy = original.copyWith(
        fluid: true,
        padding: const EdgeInsets.all(16),
        rowGap: 20,
      );

      expect(copy.fluid, true);
      expect(copy.padding, const EdgeInsets.all(16));
      expect(copy.rowGap, 20);

      expect(original.fluid, false);
      expect(original.padding, const EdgeInsets.all(8));
      expect(original.rowGap, 10);
    });

    test('copyWith should keep original values when not specified', () {
      final original = FlutstrapGrid(
        children: const [Text('Original')],
        fluid: true,
        padding: const EdgeInsets.all(8),
      );

      final copy = original.copyWith(
        fluid: false,
      );

      expect(copy.fluid, false);
      expect(copy.padding, const EdgeInsets.all(8));
    });
  });

  group('FlutstrapGrid - Edge Cases', () {
    testWidgets('should handle very long content without overflow',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 300,
              child: FlutstrapGrid(
                children: [
                  Text('A' * 1000),
                  Text('B' * 1000),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.textContaining('A' * 100), findsOneWidget);
      expect(find.textContaining('B' * 100), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('should handle zero or negative row gaps',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapGrid(
              children: const [
                Text('Row 1'),
                Text('Row 2'),
              ],
              rowGap: 0,
            ),
          ),
        ),
      );

      expect(find.text('Row 1'), findsOneWidget);
      expect(find.text('Row 2'), findsOneWidget);
    });
  });

  group('FSGridUtils Tests', () {
    test('calculateRowCount should return correct number of rows', () {
      expect(FSGridUtils.calculateRowCount(10, 3), 4);
      expect(FSGridUtils.calculateRowCount(6, 2), 3);
      expect(FSGridUtils.calculateRowCount(0, 3), 0);
      expect(FSGridUtils.calculateRowCount(5, 0), 0);
    });

    test('distributeItems should distribute items correctly', () {
      final items = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

      final distributed = FSGridUtils.distributeItems(items, 3);
      expect(distributed.length, 4);
      expect(distributed[0], [1, 2, 3]);
      expect(distributed[1], [4, 5, 6]);
      expect(distributed[2], [7, 8, 9]);
      expect(distributed[3], [10]);

      final empty = FSGridUtils.distributeItems([], 3);
      expect(empty, []);
    });

    test('calculateOptimalColumns should return correct number of columns', () {
      expect(FSGridUtils.calculateOptimalColumns(800, 200, 16), 3);
      expect(FSGridUtils.calculateOptimalColumns(100, 200, 16), 1);
      expect(FSGridUtils.calculateOptimalColumns(0, 200, 16), 1);
    });

    test('calculateColumnWidth should return correct column width', () {
      expect(FSGridUtils.calculateColumnWidth(800, 3, 16), 256);
      expect(FSGridUtils.calculateColumnWidth(800, 1, 16), 800);
      expect(FSGridUtils.calculateColumnWidth(800, 0, 16), 0);
    });
  });

  group('FlutstrapGrid - Themed Tests', () {
    testWidgets('should work with FSTheme provider',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FSTheme(
            data: FSThemeData.light(),
            child: const Scaffold(
              body: FlutstrapGrid(
                children: [
                  Text('Themed Grid Item 1'),
                  Text('Themed Grid Item 2'),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.text('Themed Grid Item 1'), findsOneWidget);
      expect(find.text('Themed Grid Item 2'), findsOneWidget);
    });

    testWidgets('should work with dark theme', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FSTheme(
            data: FSThemeData.dark(),
            child: const Scaffold(
              body: FlutstrapGrid(
                children: [
                  Text('Dark Theme Grid Item'),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.text('Dark Theme Grid Item'), findsOneWidget);
    });
  });
}
