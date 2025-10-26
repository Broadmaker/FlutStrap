import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:master_flutstrap/components/forms/flutstrap_checkbox.dart';

void main() {
  // Helper function to wrap checkbox with constrained width for tests
  Widget buildTestableCheckbox(FlutstrapCheckbox checkbox) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            width: 400,
            child: checkbox,
          ),
        ),
      ),
    );
  }

  group('FlutstrapCheckbox', () {
    testWidgets('renders checkbox with default properties', (tester) async {
      await tester.pumpWidget(
        buildTestableCheckbox(
          FlutstrapCheckbox(
            value: false,
            onChanged: (value) {},
          ),
        ),
      );

      expect(find.byType(FlutstrapCheckbox), findsOneWidget);
    });

    testWidgets('renders checkbox with label', (tester) async {
      await tester.pumpWidget(
        buildTestableCheckbox(
          FlutstrapCheckbox(
            value: false,
            onChanged: (value) {},
            label: 'Checkbox Label',
          ),
        ),
      );

      expect(find.text('Checkbox Label'), findsOneWidget);
    });

    testWidgets('calls onChanged when entire checkbox area is tapped',
        (tester) async {
      bool? callbackValue;
      bool wasCalled = false;

      await tester.pumpWidget(
        buildTestableCheckbox(
          FlutstrapCheckbox(
            value: false,
            onChanged: (value) {
              callbackValue = value;
              wasCalled = true;
            },
            label: 'Test Checkbox',
          ),
        ),
      );

      // Tap anywhere on the checkbox (including the label)
      await tester.tap(find.byType(FlutstrapCheckbox));
      await tester.pumpAndSettle();

      expect(wasCalled, true);
      expect(callbackValue, true);
    });

    testWidgets('toggles from true to false when tapped', (tester) async {
      bool? callbackValue;
      bool wasCalled = false;

      await tester.pumpWidget(
        buildTestableCheckbox(
          FlutstrapCheckbox(
            value: true,
            onChanged: (value) {
              callbackValue = value;
              wasCalled = true;
            },
            label: 'Test Checkbox',
          ),
        ),
      );

      await tester.tap(find.byType(FlutstrapCheckbox));
      await tester.pumpAndSettle();

      expect(wasCalled, true);
      expect(callbackValue, false);
    });

    testWidgets('does not call onChanged when disabled', (tester) async {
      bool wasCalled = false;

      await tester.pumpWidget(
        buildTestableCheckbox(
          FlutstrapCheckbox(
            value: false,
            onChanged: (value) {
              wasCalled = true;
            },
            label: 'Disabled Checkbox',
            disabled: true,
          ),
        ),
      );

      await tester.tap(find.byType(FlutstrapCheckbox));
      await tester.pumpAndSettle();

      expect(wasCalled, false);
    });

    testWidgets('renders in inline layout', (tester) async {
      await tester.pumpWidget(
        buildTestableCheckbox(
          FlutstrapCheckbox(
            value: false,
            onChanged: (value) {},
            label: 'Inline Checkbox',
            inline: true,
          ),
        ),
      );

      expect(find.text('Inline Checkbox'), findsOneWidget);
    });

    testWidgets('renders in block layout by default', (tester) async {
      await tester.pumpWidget(
        buildTestableCheckbox(
          FlutstrapCheckbox(
            value: false,
            onChanged: (value) {},
            label: 'Block Checkbox',
          ),
        ),
      );

      expect(find.text('Block Checkbox'), findsOneWidget);
    });

    testWidgets('respects different variants', (tester) async {
      final variants = FSCheckboxVariant.values;

      for (final variant in variants) {
        await tester.pumpWidget(
          buildTestableCheckbox(
            FlutstrapCheckbox(
              value: true,
              onChanged: (value) {},
              variant: variant,
            ),
          ),
        );

        expect(find.byType(FlutstrapCheckbox), findsOneWidget);
        await tester.pumpWidget(Container());
      }
    });

    testWidgets('respects different sizes', (tester) async {
      final sizes = FSCheckboxSize.values;

      for (final size in sizes) {
        await tester.pumpWidget(
          buildTestableCheckbox(
            FlutstrapCheckbox(
              value: false,
              onChanged: (value) {},
              size: size,
            ),
          ),
        );

        expect(find.byType(FlutstrapCheckbox), findsOneWidget);
        await tester.pumpWidget(Container());
      }
    });

    testWidgets('shows validation message when invalid', (tester) async {
      await tester.pumpWidget(
        buildTestableCheckbox(
          FlutstrapCheckbox(
            value: false,
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
        buildTestableCheckbox(
          FlutstrapCheckbox(
            value: false,
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
        buildTestableCheckbox(
          FlutstrapCheckbox(
            value: false,
            onChanged: null,
          ),
        ),
      );

      expect(find.byType(FlutstrapCheckbox), findsOneWidget);

      await tester.tap(find.byType(FlutstrapCheckbox));
      await tester.pumpAndSettle();

      // If we get here without exception, the test passes
    });

    testWidgets('shows checkmark when value is true', (tester) async {
      await tester.pumpWidget(
        buildTestableCheckbox(
          FlutstrapCheckbox(
            value: true,
            onChanged: (value) {},
          ),
        ),
      );

      expect(find.byIcon(Icons.check), findsOneWidget);
    });

    testWidgets('hides checkmark when value is false', (tester) async {
      await tester.pumpWidget(
        buildTestableCheckbox(
          FlutstrapCheckbox(
            value: false,
            onChanged: (value) {},
          ),
        ),
      );

      expect(find.byIcon(Icons.check), findsNothing);
    });

    testWidgets('renders with custom label widget', (tester) async {
      final customLabel = Container(
        padding: const EdgeInsets.all(8),
        child: const Text('Custom Label'),
      );

      await tester.pumpWidget(
        buildTestableCheckbox(
          FlutstrapCheckbox(
            value: false,
            onChanged: (value) {},
            customLabel: customLabel,
          ),
        ),
      );

      expect(find.text('Custom Label'), findsOneWidget);
    });
  });

  group('FSCheckboxVariant', () {
    test('has correct values', () {
      expect(FSCheckboxVariant.values.length, 8);
      expect(FSCheckboxVariant.values, contains(FSCheckboxVariant.primary));
      expect(FSCheckboxVariant.values, contains(FSCheckboxVariant.secondary));
      expect(FSCheckboxVariant.values, contains(FSCheckboxVariant.success));
      expect(FSCheckboxVariant.values, contains(FSCheckboxVariant.danger));
      expect(FSCheckboxVariant.values, contains(FSCheckboxVariant.warning));
      expect(FSCheckboxVariant.values, contains(FSCheckboxVariant.info));
      expect(FSCheckboxVariant.values, contains(FSCheckboxVariant.light));
      expect(FSCheckboxVariant.values, contains(FSCheckboxVariant.dark));
    });
  });

  group('FSCheckboxSize', () {
    test('has correct values', () {
      expect(FSCheckboxSize.values.length, 3);
      expect(FSCheckboxSize.values, contains(FSCheckboxSize.sm));
      expect(FSCheckboxSize.values, contains(FSCheckboxSize.md));
      expect(FSCheckboxSize.values, contains(FSCheckboxSize.lg));
    });
  });
}
