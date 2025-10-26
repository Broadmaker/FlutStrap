import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:master_flutstrap/layout/flutstrap_row.dart';

void main() {
  group('FlutstrapRow', () {
    testWidgets('should render children in a row', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapRow(
              children: const [
                Text('Child 1'),
                Text('Child 2'),
                Text('Child 3'),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Child 1'), findsOneWidget);
      expect(find.text('Child 2'), findsOneWidget);
      expect(find.text('Child 3'), findsOneWidget);
    });

    testWidgets('should use Wrap when gap is specified',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapRow(
              children: const [
                Text('Child 1'),
                Text('Child 2'),
              ],
              gap: 16.0,
            ),
          ),
        ),
      );

      expect(find.byType(Wrap), findsOneWidget);
      expect(find.text('Child 1'), findsOneWidget);
      expect(find.text('Child 2'), findsOneWidget);
    });

    testWidgets('should use Row when gap is zero', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapRow(
              children: const [
                Text('Child 1'),
                Text('Child 2'),
              ],
              gap: 0,
            ),
          ),
        ),
      );

      expect(find.byType(Row), findsOneWidget);
      expect(find.text('Child 1'), findsOneWidget);
      expect(find.text('Child 2'), findsOneWidget);
    });

    testWidgets('should apply mainAxisAlignment', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapRow(
              children: const [
                Text('Child 1'),
                Text('Child 2'),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
              gap: 16.0,
            ),
          ),
        ),
      );

      final wrap = tester.widget<Wrap>(find.byType(Wrap));
      expect(wrap.alignment, WrapAlignment.center);
    });

    test('noGap should create row with zero gap', () {
      const row = FlutstrapRow(
        children: [Text('Test')],
        gap: 16.0,
      );

      final noGapRow = row.noGap();
      expect(noGapRow.gap, 0);
    });

    test('withGap should create row with custom gap', () {
      const row = FlutstrapRow(
        children: [Text('Test')],
      );

      final customGapRow = row.withGap(24.0);
      expect(customGapRow.gap, 24.0);
    });
  });
}
