// test/components/tooltips/flutstrap_tooltip_smoke_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:master_flutstrap/components/tooltips/flutstrap_tooltip.dart';

void main() {
  testWidgets('FlutstrapTooltip smoke test', (tester) async {
    // This test just verifies the tooltip can be created and rendered without crashing
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FlutstrapTooltip(
            message: 'Test tooltip',
            child: Text('Hover me'),
          ),
        ),
      ),
    );

    // Verify the child renders
    expect(find.text('Hover me'), findsOneWidget);

    // Verify no exceptions are thrown during interactions
    await tester.tap(find.text('Hover me'));
    await tester.pumpAndSettle();

    // Still should find the child
    expect(find.text('Hover me'), findsOneWidget);
  });

  test('FSTooltipVariant values', () {
    expect(FSTooltipVariant.values.length, 8);
  });

  test('FSTooltipPlacement values', () {
    expect(FSTooltipPlacement.values.length, 12);
  });
}
