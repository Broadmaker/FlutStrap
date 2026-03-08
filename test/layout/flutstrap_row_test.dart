import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutstrap/flutstrap.dart';

void main() {
  group('FlutstrapRow - Basic Rendering Tests', () {
    testWidgets('should render with children', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const Scaffold(
            body: FlutstrapRow(
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
      expect(find.byType(Row), findsOneWidget);
    });

    testWidgets('should render with default gap', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const Scaffold(
            body: FlutstrapRow(
              children: [
                Text('Left'),
                Text('Right'),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Left'), findsOneWidget);
      expect(find.text('Right'), findsOneWidget);
    });

    testWidgets('should render with custom gap', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const Scaffold(
            body: FlutstrapRow(
              children: [
                Text('Left'),
                Text('Middle'),
                Text('Right'),
              ],
              gap: 20,
            ),
          ),
        ),
      );

      expect(find.text('Left'), findsOneWidget);
      expect(find.text('Middle'), findsOneWidget);
      expect(find.text('Right'), findsOneWidget);
    });

    testWidgets('should render with zero gap', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const Scaffold(
            body: FlutstrapRow(
              children: [
                Text('Left'),
                Text('Right'),
              ],
              gap: 0,
            ),
          ),
        ),
      );

      expect(find.text('Left'), findsOneWidget);
      expect(find.text('Right'), findsOneWidget);
    });

    testWidgets('should throw assertion when children is empty',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const Scaffold(
            body: FlutstrapRow(children: []),
          ),
        ),
      );

      expect(tester.takeException(), isAssertionError);
    });
  });

  group('FlutstrapRow - Alignment Tests', () {
    testWidgets('should align children to start', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapRow(
                children: [
                  Container(width: 50, height: 50, color: Colors.red),
                  Container(width: 50, height: 50, color: Colors.green),
                ],
                mainAxisAlignment: MainAxisAlignment.start,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(Container), findsNWidgets(2));
    });

    testWidgets('should align children to center', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapRow(
                children: [
                  Container(width: 50, height: 50, color: Colors.red),
                  Container(width: 50, height: 50, color: Colors.green),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(Container), findsNWidgets(2));
    });

    testWidgets('should align children to end', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapRow(
                children: [
                  Container(width: 50, height: 50, color: Colors.red),
                  Container(width: 50, height: 50, color: Colors.green),
                ],
                mainAxisAlignment: MainAxisAlignment.end,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(Container), findsNWidgets(2));
    });

    testWidgets('should space children evenly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapRow(
                children: [
                  Container(width: 50, height: 50, color: Colors.red),
                  Container(width: 50, height: 50, color: Colors.green),
                  Container(width: 50, height: 50, color: Colors.blue),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(Container), findsNWidgets(3));
    });

    testWidgets('should space children between', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapRow(
                children: [
                  Container(width: 50, height: 50, color: Colors.red),
                  Container(width: 50, height: 50, color: Colors.green),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(Container), findsNWidgets(2));
    });

    testWidgets('should space children around', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapRow(
                children: [
                  Container(width: 50, height: 50, color: Colors.red),
                  Container(width: 50, height: 50, color: Colors.green),
                  Container(width: 50, height: 50, color: Colors.blue),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceAround,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(Container), findsNWidgets(3));
    });
  });

  group('FlutstrapRow - Cross Alignment Tests', () {
    testWidgets('should align children to start cross axis',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                height: 100,
                child: FlutstrapRow(
                  children: [
                    Container(width: 50, height: 30, color: Colors.red),
                    Container(width: 50, height: 50, color: Colors.green),
                    Container(width: 50, height: 70, color: Colors.blue),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(Container), findsNWidgets(3));
    });

    testWidgets('should align children to center cross axis',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                height: 100,
                child: FlutstrapRow(
                  children: [
                    Container(width: 50, height: 30, color: Colors.red),
                    Container(width: 50, height: 50, color: Colors.green),
                    Container(width: 50, height: 70, color: Colors.blue),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(Container), findsNWidgets(3));
    });

    testWidgets('should align children to end cross axis',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                height: 100,
                child: FlutstrapRow(
                  children: [
                    Container(width: 50, height: 30, color: Colors.red),
                    Container(width: 50, height: 50, color: Colors.green),
                    Container(width: 50, height: 70, color: Colors.blue),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.end,
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(Container), findsNWidgets(3));
    });

    testWidgets('should stretch children cross axis',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                height: 100,
                child: FlutstrapRow(
                  children: [
                    Container(width: 50, color: Colors.red),
                    Container(width: 50, color: Colors.green),
                    Container(width: 50, color: Colors.blue),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(Container), findsNWidgets(3));
    });
  });

  group('FlutstrapRow - Height Constraint Tests', () {
    testWidgets('should apply min height constraint',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapRow(
              children: const [
                Text('Item 1'),
                Text('Item 2'),
              ],
              minHeight: 100,
            ),
          ),
        ),
      );

      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Item 2'), findsOneWidget);
    });

    testWidgets('should apply max height constraint',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapRow(
              children: const [
                Text('Item 1'),
                Text('Item 2'),
              ],
              maxHeight: 200,
            ),
          ),
        ),
      );

      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Item 2'), findsOneWidget);
    });

    testWidgets('should apply both min and max height constraints',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapRow(
              children: const [
                Text('Item 1'),
                Text('Item 2'),
              ],
              minHeight: 50,
              maxHeight: 150,
            ),
          ),
        ),
      );

      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Item 2'), findsOneWidget);
    });
  });

  group('FlutstrapRow - Flexible and Expanded Children Tests', () {
    testWidgets('should work with Expanded children',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 300,
              child: FlutstrapRow(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(color: Colors.red, height: 50),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(color: Colors.green, height: 50),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.byType(Container), findsNWidgets(2));
    });

    testWidgets('should work with Flexible children',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 300,
              child: FlutstrapRow(
                children: [
                  Flexible(
                    flex: 2,
                    child: Container(color: Colors.red, height: 50),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(color: Colors.green, height: 50),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.byType(Container), findsNWidgets(2));
    });

    testWidgets('should mix fixed and flexible children',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 400,
              child: FlutstrapRow(
                children: [
                  Container(width: 100, height: 50, color: Colors.red),
                  Expanded(
                    child: Container(color: Colors.green, height: 50),
                  ),
                  Container(width: 100, height: 50, color: Colors.blue),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.byType(Container), findsNWidgets(3));
    });
  });

  group('FlutstrapRow - Builder Methods', () {
    test('noGap() should set gap to 0', () {
      final row = FlutstrapRow(
        children: const [Text('Test')],
        gap: 16,
      );

      final noGapRow = row.noGap();
      expect(noGapRow.gap, 0);
    });

    test('withGap() should set custom gap', () {
      final row = FlutstrapRow(
        children: const [Text('Test')],
      );

      const customGap = 24.0;
      final gapRow = row.withGap(customGap);
      expect(gapRow.gap, customGap);
    });

    test('withMinHeight() should set min height', () {
      final row = FlutstrapRow(
        children: const [Text('Test')],
      );

      final minHeightRow = row.withMinHeight(100);
      expect(minHeightRow.minHeight, 100);
    });

    test('withMaxHeight() should set max height', () {
      final row = FlutstrapRow(
        children: const [Text('Test')],
      );

      final maxHeightRow = row.withMaxHeight(200);
      expect(maxHeightRow.maxHeight, 200);
    });

    test('withHeight() should set both min and max height', () {
      final row = FlutstrapRow(
        children: const [Text('Test')],
      );

      final heightRow = row.withHeight(150);
      expect(heightRow.minHeight, 150);
      expect(heightRow.maxHeight, 150);
    });

    test('center() should center children', () {
      final row = FlutstrapRow(
        children: const [Text('Test')],
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
      );

      final centerRow = row.center();
      expect(centerRow.mainAxisAlignment, MainAxisAlignment.center);
      expect(centerRow.crossAxisAlignment, CrossAxisAlignment.center);
    });

    test('spaceBetween() should set space between', () {
      final row = FlutstrapRow(
        children: const [Text('Test')],
      );

      final spaceBetweenRow = row.spaceBetween();
      expect(spaceBetweenRow.mainAxisAlignment, MainAxisAlignment.spaceBetween);
    });

    test('spaceAround() should set space around', () {
      final row = FlutstrapRow(
        children: const [Text('Test')],
      );

      final spaceAroundRow = row.spaceAround();
      expect(spaceAroundRow.mainAxisAlignment, MainAxisAlignment.spaceAround);
    });

    test('spaceEvenly() should set space evenly', () {
      final row = FlutstrapRow(
        children: const [Text('Test')],
      );

      final spaceEvenlyRow = row.spaceEvenly();
      expect(spaceEvenlyRow.mainAxisAlignment, MainAxisAlignment.spaceEvenly);
    });

    test('start() should align to start', () {
      final row = FlutstrapRow(
        children: const [Text('Test')],
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
      );

      final startRow = row.start();
      expect(startRow.mainAxisAlignment, MainAxisAlignment.start);
      expect(startRow.crossAxisAlignment, CrossAxisAlignment.start);
    });

    test('end() should align to end', () {
      final row = FlutstrapRow(
        children: const [Text('Test')],
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
      );

      final endRow = row.end();
      expect(endRow.mainAxisAlignment, MainAxisAlignment.end);
      expect(endRow.crossAxisAlignment, CrossAxisAlignment.end);
    });

    test('stretch() should stretch children', () {
      final row = FlutstrapRow(
        children: const [Text('Test')],
        crossAxisAlignment: CrossAxisAlignment.start,
      );

      final stretchRow = row.stretch();
      expect(stretchRow.crossAxisAlignment, CrossAxisAlignment.stretch);
    });

    test('gridRow() should create grid-optimized row', () {
      final row = FlutstrapRow(
        children: const [Text('Test')],
      );

      const gap = 16.0;
      final gridRow = row.gridRow(gap: gap);
      expect(gridRow.gap, gap);
      expect(gridRow.mainAxisAlignment, MainAxisAlignment.start);
      expect(gridRow.crossAxisAlignment, CrossAxisAlignment.start);
    });
  });

  group('FlutstrapRow - CopyWith Tests', () {
    test('copyWith should create new instance with updated values', () {
      final original = FlutstrapRow(
        children: const [Text('Original')],
        gap: 8,
        minHeight: 50,
        maxHeight: 100,
        mainAxisAlignment: MainAxisAlignment.start,
      );

      final copy = original.copyWith(
        gap: 16,
        minHeight: 75,
        mainAxisAlignment: MainAxisAlignment.center,
      );

      expect(copy.gap, 16);
      expect(copy.minHeight, 75);
      expect(copy.maxHeight, 100);
      expect(copy.mainAxisAlignment, MainAxisAlignment.center);

      expect(original.gap, 8);
      expect(original.minHeight, 50);
    });

    test('copyWith should keep original values when not specified', () {
      final original = FlutstrapRow(
        children: const [Text('Original')],
        gap: 8,
        minHeight: 50,
      );

      final copy = original.copyWith(
        gap: 16,
      );

      expect(copy.gap, 16);
      expect(copy.minHeight, 50);
    });
  });

  group('FlutstrapRow - Edge Cases', () {
    testWidgets('should handle single child correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const Scaffold(
            body: FlutstrapRow(
              children: [Text('Single Item')],
              gap: 20,
            ),
          ),
        ),
      );

      expect(find.text('Single Item'), findsOneWidget);
    });

    testWidgets('should handle very long content without overflow',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 200,
              child: FlutstrapRow(
                children: [
                  Text('A' * 100),
                  Text('B' * 100),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.textContaining('A' * 50), findsOneWidget);
      expect(find.textContaining('B' * 50), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('should handle null gap gracefully',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const Scaffold(
            body: FlutstrapRow(
              children: [Text('Item 1'), Text('Item 2')],
              gap: null,
            ),
          ),
        ),
      );

      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Item 2'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('should handle negative gap values',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const Scaffold(
            body: FlutstrapRow(
              children: [Text('Item 1'), Text('Item 2')],
              gap: -10,
            ),
          ),
        ),
      );

      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Item 2'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('should work with different text directions',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapRow(
              children: const [
                Text('Right 1'),
                Text('Right 2'),
              ],
              textDirection: TextDirection.rtl,
            ),
          ),
        ),
      );

      expect(find.text('Right 1'), findsOneWidget);
      expect(find.text('Right 2'), findsOneWidget);
    });
  });

  group('FlutstrapRow - Themed Tests', () {
    testWidgets('should work with FSTheme provider',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FSTheme(
            data: FSThemeData.light(),
            child: const Scaffold(
              body: FlutstrapRow(
                children: [
                  Text('Themed Row Item 1'),
                  Text('Themed Row Item 2'),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.text('Themed Row Item 1'), findsOneWidget);
      expect(find.text('Themed Row Item 2'), findsOneWidget);
    });

    testWidgets('should work with dark theme', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FSTheme(
            data: FSThemeData.dark(),
            child: const Scaffold(
              body: FlutstrapRow(
                children: [
                  Text('Dark Theme Row Item'),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.text('Dark Theme Row Item'), findsOneWidget);
    });
  });
}
