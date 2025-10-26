// test/components/forms/flutstrap_radio_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:master_flutstrap/components/forms/flutstrap_radio.dart';

void main() {
  // Helper function to wrap radio with constrained width for tests
  Widget buildTestableRadio(FlutstrapRadio radio) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            width: 400,
            child: radio,
          ),
        ),
      ),
    );
  }

  group('FlutstrapRadio', () {
    testWidgets('renders radio with default properties', (tester) async {
      await tester.pumpWidget(
        buildTestableRadio(
          FlutstrapRadio<String>(
            value: 'option1',
            groupValue: null,
            onChanged: (value) {},
          ),
        ),
      );

      expect(find.byType(FlutstrapRadio<String>), findsOneWidget);
    });

    testWidgets('renders radio with label', (tester) async {
      await tester.pumpWidget(
        buildTestableRadio(
          FlutstrapRadio<String>(
            value: 'option1',
            groupValue: null,
            onChanged: (value) {},
            label: 'Radio Label',
          ),
        ),
      );

      expect(find.text('Radio Label'), findsOneWidget);
    });

    testWidgets('shows dot when selected', (tester) async {
      await tester.pumpWidget(
        buildTestableRadio(
          FlutstrapRadio<String>(
            value: 'option1',
            groupValue: 'option1', // Same value means selected
            onChanged: (value) {},
          ),
        ),
      );

      // Look for the inner dot container by finding a small Container with BoxDecoration
      final dotContainer = find.byWidgetPredicate(
        (widget) {
          if (widget is Container) {
            final container = widget;
            // Look for small containers (the dot) - based on the error, dot has w=8.0, h=8.0
            if (container.constraints != null &&
                container.constraints!.maxWidth == 8.0 &&
                container.constraints!.maxHeight == 8.0) {
              return container.decoration != null &&
                  container.decoration is BoxDecoration;
            }
          }
          return false;
        },
      );

      expect(dotContainer, findsOneWidget);
    });

    testWidgets('hides dot when not selected', (tester) async {
      await tester.pumpWidget(
        buildTestableRadio(
          FlutstrapRadio<String>(
            value: 'option1',
            groupValue: 'option2', // Different value means not selected
            onChanged: (value) {},
          ),
        ),
      );

      // Look for small containers that could be the dot
      final potentialDotContainers = find.byWidgetPredicate(
        (widget) {
          if (widget is Container) {
            final container = widget;
            // Look for small containers (the dot) - based on the error, dot has w=8.0, h=8.0
            if (container.constraints != null &&
                container.constraints!.maxWidth == 8.0 &&
                container.constraints!.maxHeight == 8.0) {
              return container.decoration != null &&
                  container.decoration is BoxDecoration;
            }
          }
          return false;
        },
      );

      // Should not find any dot containers when not selected
      expect(potentialDotContainers, findsNothing);
    });

    testWidgets('calls onChanged when tapped and not selected', (tester) async {
      String? callbackValue;
      bool wasCalled = false;

      await tester.pumpWidget(
        buildTestableRadio(
          FlutstrapRadio<String>(
            value: 'option1',
            groupValue: 'option2', // Not selected initially
            onChanged: (value) {
              callbackValue = value;
              wasCalled = true;
            },
            label: 'Test Radio',
          ),
        ),
      );

      // Tap the radio to select it
      await tester.tap(find.byType(FlutstrapRadio<String>));
      await tester.pumpAndSettle();

      expect(wasCalled, true);
      expect(callbackValue, 'option1');
    });

    testWidgets('does not call onChanged when already selected',
        (tester) async {
      bool wasCalled = false;

      await tester.pumpWidget(
        buildTestableRadio(
          FlutstrapRadio<String>(
            value: 'option1',
            groupValue: 'option1', // Already selected
            onChanged: (value) {
              wasCalled = true;
            },
            label: 'Test Radio',
          ),
        ),
      );

      // Tap the already selected radio
      await tester.tap(find.byType(FlutstrapRadio<String>));
      await tester.pumpAndSettle();

      expect(wasCalled, false); // Should not call when already selected
    });

    testWidgets('does not call onChanged when disabled', (tester) async {
      bool wasCalled = false;

      await tester.pumpWidget(
        buildTestableRadio(
          FlutstrapRadio<String>(
            value: 'option1',
            groupValue: 'option2',
            onChanged: (value) {
              wasCalled = true;
            },
            label: 'Disabled Radio',
            disabled: true,
          ),
        ),
      );

      await tester.tap(find.byType(FlutstrapRadio<String>));
      await tester.pumpAndSettle();

      expect(wasCalled, false);
    });

    testWidgets('renders in inline layout', (tester) async {
      await tester.pumpWidget(
        buildTestableRadio(
          FlutstrapRadio<String>(
            value: 'option1',
            groupValue: null,
            onChanged: (value) {},
            label: 'Inline Radio',
            inline: true,
          ),
        ),
      );

      expect(find.text('Inline Radio'), findsOneWidget);
    });

    testWidgets('renders in block layout by default', (tester) async {
      await tester.pumpWidget(
        buildTestableRadio(
          FlutstrapRadio<String>(
            value: 'option1',
            groupValue: null,
            onChanged: (value) {},
            label: 'Block Radio',
          ),
        ),
      );

      expect(find.text('Block Radio'), findsOneWidget);
    });

    testWidgets('respects different variants', (tester) async {
      final variants = FSRadioVariant.values;

      for (final variant in variants) {
        await tester.pumpWidget(
          buildTestableRadio(
            FlutstrapRadio<String>(
              value: 'option1',
              groupValue: 'option1', // Selected to test active state
              onChanged: (value) {},
              variant: variant,
            ),
          ),
        );

        expect(find.byType(FlutstrapRadio<String>), findsOneWidget);
        await tester.pumpWidget(Container());
      }
    });

    testWidgets('respects different sizes', (tester) async {
      final sizes = FSRadioSize.values;

      for (final size in sizes) {
        await tester.pumpWidget(
          buildTestableRadio(
            FlutstrapRadio<String>(
              value: 'option1',
              groupValue: null,
              onChanged: (value) {},
              size: size,
            ),
          ),
        );

        expect(find.byType(FlutstrapRadio<String>), findsOneWidget);
        await tester.pumpWidget(Container());
      }
    });

    testWidgets('shows validation message when invalid', (tester) async {
      await tester.pumpWidget(
        buildTestableRadio(
          FlutstrapRadio<String>(
            value: 'option1',
            groupValue: null,
            onChanged: (value) {},
            showValidation: true,
            isValid: false,
            validationMessage: 'This field is required',
          ),
        ),
      );

      expect(find.text('This field is required'), findsOneWidget);
    });

    testWidgets('hides validation message when valid', (tester) async {
      await tester.pumpWidget(
        buildTestableRadio(
          FlutstrapRadio<String>(
            value: 'option1',
            groupValue: null,
            onChanged: (value) {},
            showValidation: true,
            isValid: true,
            validationMessage: 'This field is required',
          ),
        ),
      );

      expect(find.text('This field is required'), findsNothing);
    });

    testWidgets('handles null onChanged callback without crashing',
        (tester) async {
      await tester.pumpWidget(
        buildTestableRadio(
          FlutstrapRadio<String>(
            value: 'option1',
            groupValue: null,
            onChanged: null,
          ),
        ),
      );

      expect(find.byType(FlutstrapRadio<String>), findsOneWidget);

      await tester.tap(find.byType(FlutstrapRadio<String>));
      await tester.pumpAndSettle();

      // If we get here without exception, the test passes
    });

    testWidgets('renders with custom label widget', (tester) async {
      final customLabel = Container(
        padding: const EdgeInsets.all(8),
        child: const Text('Custom Label'),
      );

      await tester.pumpWidget(
        buildTestableRadio(
          FlutstrapRadio<String>(
            value: 'option1',
            groupValue: null,
            onChanged: (value) {},
            customLabel: customLabel,
          ),
        ),
      );

      expect(find.text('Custom Label'), findsOneWidget);
    });

    testWidgets('works with different value types', (tester) async {
      // Test with int values
      await tester.pumpWidget(
        buildTestableRadio(
          FlutstrapRadio<int>(
            value: 1,
            groupValue: null,
            onChanged: (value) {},
            label: 'Integer Radio',
          ),
        ),
      );

      expect(find.text('Integer Radio'), findsOneWidget);
      expect(find.byType(FlutstrapRadio<int>), findsOneWidget);
    });

    testWidgets('works with boolean values', (tester) async {
      await tester.pumpWidget(
        buildTestableRadio(
          FlutstrapRadio<bool>(
            value: true,
            groupValue: null,
            onChanged: (value) {},
            label: 'Boolean Radio',
          ),
        ),
      );

      expect(find.text('Boolean Radio'), findsOneWidget);
      expect(find.byType(FlutstrapRadio<bool>), findsOneWidget);
    });
  });

  group('Radio Group Behavior', () {
    testWidgets('only one radio can be selected in a group', (tester) async {
      String? selectedValue = 'option1';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                FlutstrapRadio<String>(
                  value: 'option1',
                  groupValue: selectedValue,
                  onChanged: (value) => selectedValue = value,
                  label: 'Option 1',
                ),
                FlutstrapRadio<String>(
                  value: 'option2',
                  groupValue: selectedValue,
                  onChanged: (value) => selectedValue = value,
                  label: 'Option 2',
                ),
              ],
            ),
          ),
        ),
      );

      // Initially option1 should be selected
      expect(selectedValue, 'option1');

      // Tap option2
      final option2 = find.text('Option 2');
      await tester.tap(option2);
      await tester.pumpAndSettle();

      // Now option2 should be selected
      expect(selectedValue, 'option2');
    });

    testWidgets('radio group maintains single selection', (tester) async {
      String? selectedValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return Column(
                  children: [
                    FlutstrapRadio<String>(
                      value: 'A',
                      groupValue: selectedValue,
                      onChanged: (value) =>
                          setState(() => selectedValue = value),
                      label: 'Option A',
                    ),
                    FlutstrapRadio<String>(
                      value: 'B',
                      groupValue: selectedValue,
                      onChanged: (value) =>
                          setState(() => selectedValue = value),
                      label: 'Option B',
                    ),
                    FlutstrapRadio<String>(
                      value: 'C',
                      groupValue: selectedValue,
                      onChanged: (value) =>
                          setState(() => selectedValue = value),
                      label: 'Option C',
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      );

      // Select option A
      await tester.tap(find.text('Option A'));
      await tester.pumpAndSettle();

      // Select option B
      await tester.tap(find.text('Option B'));
      await tester.pumpAndSettle();

      // Only option B should be selected
      expect(selectedValue, 'B');
    });
  });

  group('FSRadioVariant', () {
    test('has correct values', () {
      expect(FSRadioVariant.values.length, 8);
      expect(FSRadioVariant.values, contains(FSRadioVariant.primary));
      expect(FSRadioVariant.values, contains(FSRadioVariant.secondary));
      expect(FSRadioVariant.values, contains(FSRadioVariant.success));
      expect(FSRadioVariant.values, contains(FSRadioVariant.danger));
      expect(FSRadioVariant.values, contains(FSRadioVariant.warning));
      expect(FSRadioVariant.values, contains(FSRadioVariant.info));
      expect(FSRadioVariant.values, contains(FSRadioVariant.light));
      expect(FSRadioVariant.values, contains(FSRadioVariant.dark));
    });
  });

  group('FSRadioSize', () {
    test('has correct values', () {
      expect(FSRadioSize.values.length, 3);
      expect(FSRadioSize.values, contains(FSRadioSize.sm));
      expect(FSRadioSize.values, contains(FSRadioSize.md));
      expect(FSRadioSize.values, contains(FSRadioSize.lg));
    });
  });

  group('Edge Cases', () {
    testWidgets('handles null groupValue', (tester) async {
      await tester.pumpWidget(
        buildTestableRadio(
          FlutstrapRadio<String>(
            value: 'option1',
            groupValue: null,
            onChanged: (value) {},
            label: 'Test Radio',
          ),
        ),
      );

      expect(find.text('Test Radio'), findsOneWidget);
      // Should render without errors when groupValue is null
    });

    testWidgets('handles same value and groupValue', (tester) async {
      await tester.pumpWidget(
        buildTestableRadio(
          FlutstrapRadio<String>(
            value: 'option1',
            groupValue: 'option1',
            onChanged: (value) {},
            label: 'Selected Radio',
          ),
        ),
      );

      expect(find.text('Selected Radio'), findsOneWidget);
      // Should render as selected when value equals groupValue
    });

    testWidgets('prefers customLabel over label when both provided',
        (tester) async {
      final customLabel = Container(
        child: const Text('Custom Label'),
      );

      await tester.pumpWidget(
        buildTestableRadio(
          FlutstrapRadio<String>(
            value: 'option1',
            groupValue: null,
            onChanged: (value) {},
            label: 'Text Label',
            customLabel: customLabel,
          ),
        ),
      );

      expect(find.text('Custom Label'), findsOneWidget);
      expect(find.text('Text Label'), findsNothing);
    });

    testWidgets('renders without label correctly', (tester) async {
      await tester.pumpWidget(
        buildTestableRadio(
          FlutstrapRadio<String>(
            value: 'option1',
            groupValue: null,
            onChanged: (value) {},
            // No label provided
          ),
        ),
      );

      expect(find.byType(FlutstrapRadio<String>), findsOneWidget);
      expect(find.byType(Text), findsNothing);
    });

    // Alternative approach: Test by tapping and checking callback
    testWidgets('selected state changes when tapped', (tester) async {
      String? selectedValue;
      bool wasCalled = false;

      await tester.pumpWidget(
        buildTestableRadio(
          FlutstrapRadio<String>(
            value: 'option1',
            groupValue: selectedValue,
            onChanged: (value) {
              selectedValue = value;
              wasCalled = true;
            },
            label: 'Test Radio',
          ),
        ),
      );

      // Initially not selected
      expect(selectedValue, isNull);

      // Tap to select
      await tester.tap(find.byType(FlutstrapRadio<String>));
      await tester.pumpAndSettle();

      expect(wasCalled, true);
      expect(selectedValue, 'option1');
    });

    testWidgets('unselected radio does not show dot', (tester) async {
      await tester.pumpWidget(
        buildTestableRadio(
          FlutstrapRadio<String>(
            value: 'option1',
            groupValue: 'option2', // Not selected
            onChanged: (value) {},
            label: 'Unselected',
          ),
        ),
      );

      // Should render without errors when not selected
      expect(find.text('Unselected'), findsOneWidget);
    });
  });
}
