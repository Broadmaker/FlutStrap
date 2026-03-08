import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutstrap/flutstrap.dart';

void main() {
  group('FlutstrapRadio - Rendering Tests', () {
    testWidgets('should render basic radio with label',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapRadio<String>(
              value: 'option1',
              groupValue: 'option1',
              onChanged: (value) {},
              label: 'Option 1',
            ),
          ),
        ),
      );

      expect(find.text('Option 1'), findsOneWidget);
      expect(find.byType(FlutstrapRadio<String>), findsOneWidget);
    });

    testWidgets('should render selected state', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapRadio<String>(
              value: 'option1',
              groupValue: 'option1',
              onChanged: (value) {},
              label: 'Selected',
            ),
          ),
        ),
      );

      expect(find.text('Selected'), findsOneWidget);
      // Selected state is indicated by the dot
    });

    testWidgets('should render unselected state', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapRadio<String>(
              value: 'option1',
              groupValue: 'option2',
              onChanged: (value) {},
              label: 'Unselected',
            ),
          ),
        ),
      );

      expect(find.text('Unselected'), findsOneWidget);
    });

    testWidgets('should render with custom label widget',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapRadio<String>(
              value: 'option1',
              groupValue: 'option1',
              onChanged: (value) {},
              customLabel: Row(
                children: const [
                  Icon(Icons.star, size: 16),
                  Text('Custom Label'),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(find.text('Custom Label'), findsOneWidget);
    });

    testWidgets('should render disabled radio', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapRadio<String>(
              value: 'option1',
              groupValue: 'option1',
              onChanged: null,
              label: 'Disabled',
              disabled: true,
            ),
          ),
        ),
      );

      expect(find.text('Disabled'), findsOneWidget);
    });

    testWidgets('should render inline radio', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Row(
              children: [
                FlutstrapRadio<String>(
                  value: 'option1',
                  groupValue: 'option1',
                  onChanged: (value) {},
                  label: 'Option 1',
                  inline: true,
                ),
                FlutstrapRadio<String>(
                  value: 'option2',
                  groupValue: 'option1',
                  onChanged: (value) {},
                  label: 'Option 2',
                  inline: true,
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Option 1'), findsOneWidget);
      expect(find.text('Option 2'), findsOneWidget);
    });
  });

  group('FlutstrapRadio - Variant Tests', () {
    testWidgets('primary variant should render', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapRadio<String>(
              value: 'option1',
              groupValue: 'option1',
              onChanged: (value) {},
              variant: FSRadioVariant.primary,
              label: 'Primary',
            ),
          ),
        ),
      );

      expect(find.text('Primary'), findsOneWidget);
    });

    testWidgets('success variant should render', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapRadio<String>(
              value: 'option1',
              groupValue: 'option1',
              onChanged: (value) {},
              variant: FSRadioVariant.success,
              label: 'Success',
            ),
          ),
        ),
      );

      expect(find.text('Success'), findsOneWidget);
    });

    testWidgets('danger variant should render', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapRadio<String>(
              value: 'option1',
              groupValue: 'option1',
              onChanged: (value) {},
              variant: FSRadioVariant.danger,
              label: 'Danger',
            ),
          ),
        ),
      );

      expect(find.text('Danger'), findsOneWidget);
    });

    testWidgets('warning variant should render', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapRadio<String>(
              value: 'option1',
              groupValue: 'option1',
              onChanged: (value) {},
              variant: FSRadioVariant.warning,
              label: 'Warning',
            ),
          ),
        ),
      );

      expect(find.text('Warning'), findsOneWidget);
    });

    testWidgets('info variant should render', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapRadio<String>(
              value: 'option1',
              groupValue: 'option1',
              onChanged: (value) {},
              variant: FSRadioVariant.info,
              label: 'Info',
            ),
          ),
        ),
      );

      expect(find.text('Info'), findsOneWidget);
    });
  });

  group('FlutstrapRadio - Size Tests', () {
    testWidgets('small size should render', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapRadio<String>(
              value: 'option1',
              groupValue: 'option1',
              onChanged: (value) {},
              size: FSRadioSize.sm,
              label: 'Small',
            ),
          ),
        ),
      );

      expect(find.text('Small'), findsOneWidget);
    });

    testWidgets('medium size should render', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapRadio<String>(
              value: 'option1',
              groupValue: 'option1',
              onChanged: (value) {},
              size: FSRadioSize.md,
              label: 'Medium',
            ),
          ),
        ),
      );

      expect(find.text('Medium'), findsOneWidget);
    });

    testWidgets('large size should render', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapRadio<String>(
              value: 'option1',
              groupValue: 'option1',
              onChanged: (value) {},
              size: FSRadioSize.lg,
              label: 'Large',
            ),
          ),
        ),
      );

      expect(find.text('Large'), findsOneWidget);
    });
  });

  group('FlutstrapRadio - Interaction Tests', () {
    testWidgets('should call onChanged when unselected radio is tapped',
        (WidgetTester tester) async {
      String? selectedValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapRadio<String>(
              value: 'option1',
              groupValue: 'option2',
              onChanged: (value) => selectedValue = value,
              label: 'Tap me',
            ),
          ),
        ),
      );

      await tester.tap(find.text('Tap me'));
      await tester.pump();

      expect(selectedValue, 'option1');
    });

    testWidgets('should NOT call onChanged when selected radio is tapped',
        (WidgetTester tester) async {
      var callCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapRadio<String>(
              value: 'option1',
              groupValue: 'option1',
              onChanged: (value) => callCount++,
              label: 'Selected',
            ),
          ),
        ),
      );

      await tester.tap(find.text('Selected'));
      await tester.pump();

      expect(callCount, 0);
    });

    testWidgets('should update group value across multiple radios',
        (WidgetTester tester) async {
      String? groupValue = 'option1';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return Column(
                  children: [
                    FlutstrapRadio<String>(
                      value: 'option1',
                      groupValue: groupValue,
                      onChanged: (value) => setState(() => groupValue = value),
                      label: 'Option 1',
                    ),
                    FlutstrapRadio<String>(
                      value: 'option2',
                      groupValue: groupValue,
                      onChanged: (value) => setState(() => groupValue = value),
                      label: 'Option 2',
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      );

      // Initially option1 is selected
      expect(groupValue, 'option1');

      // Tap option2
      await tester.tap(find.text('Option 2'));
      await tester.pump();

      // Now option2 should be selected
      expect(groupValue, 'option2');
    });

    testWidgets('should not call onChanged when disabled',
        (WidgetTester tester) async {
      var called = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapRadio<String>(
              value: 'option1',
              groupValue: 'option2',
              onChanged: (value) => called = true,
              label: 'Disabled',
              disabled: true,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Disabled'));
      await tester.pump();

      expect(called, false);
    });

    testWidgets('should not call onChanged when onChanged is null',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapRadio<String>(
              value: 'option1',
              groupValue: 'option2',
              onChanged: null,
              label: 'No action',
            ),
          ),
        ),
      );

      await tester.tap(find.text('No action'));
      await tester.pump();

      expect(tester.takeException(), isNull);
    });
  });

  group('FlutstrapRadio - Validation Tests', () {
    testWidgets('should show validation message when invalid',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapRadio<String>(
              value: 'option1',
              groupValue: 'option1',
              onChanged: (value) {},
              label: 'Required field',
              showValidation: true,
              isValid: false,
              validationMessage: 'This field is required',
            ),
          ),
        ),
      );

      expect(find.text('Required field'), findsOneWidget);
      expect(find.text('This field is required'), findsOneWidget);
    });

    testWidgets('should not show validation message when valid',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapRadio<String>(
              value: 'option1',
              groupValue: 'option1',
              onChanged: (value) {},
              label: 'Valid field',
              showValidation: true,
              isValid: true,
              validationMessage: 'Error message',
            ),
          ),
        ),
      );

      expect(find.text('Error message'), findsNothing);
    });

    testWidgets(
        'should show validation message only when showValidation is true',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapRadio<String>(
              value: 'option1',
              groupValue: 'option1',
              onChanged: (value) {},
              label: 'Field',
              showValidation: false,
              isValid: false,
              validationMessage: 'Hidden error',
            ),
          ),
        ),
      );

      expect(find.text('Hidden error'), findsNothing);
    });
  });

  group('FlutstrapRadio - Builder Methods', () {
    test('primary() should set variant to primary', () {
      final radio = FlutstrapRadio<String>(
        value: 'test',
        groupValue: 'test',
        onChanged: (value) {},
        variant: FSRadioVariant.success,
      );

      final primaryRadio = radio.primary();
      expect(primaryRadio.variant, FSRadioVariant.primary);
    });

    test('success() should set variant to success', () {
      final radio = FlutstrapRadio<String>(
        value: 'test',
        groupValue: 'test',
        onChanged: (value) {},
        variant: FSRadioVariant.primary,
      );

      final successRadio = radio.success();
      expect(successRadio.variant, FSRadioVariant.success);
    });

    test('danger() should set variant to danger', () {
      final radio = FlutstrapRadio<String>(
        value: 'test',
        groupValue: 'test',
        onChanged: (value) {},
        variant: FSRadioVariant.primary,
      );

      final dangerRadio = radio.danger();
      expect(dangerRadio.variant, FSRadioVariant.danger);
    });

    test('warning() should set variant to warning', () {
      final radio = FlutstrapRadio<String>(
        value: 'test',
        groupValue: 'test',
        onChanged: (value) {},
        variant: FSRadioVariant.primary,
      );

      final warningRadio = radio.warning();
      expect(warningRadio.variant, FSRadioVariant.warning);
    });

    test('info() should set variant to info', () {
      final radio = FlutstrapRadio<String>(
        value: 'test',
        groupValue: 'test',
        onChanged: (value) {},
        variant: FSRadioVariant.primary,
      );

      final infoRadio = radio.info();
      expect(infoRadio.variant, FSRadioVariant.info);
    });

    test('small() should set size to sm', () {
      final radio = FlutstrapRadio<String>(
        value: 'test',
        groupValue: 'test',
        onChanged: (value) {},
        size: FSRadioSize.md,
      );

      final smallRadio = radio.small();
      expect(smallRadio.size, FSRadioSize.sm);
    });

    test('medium() should set size to md', () {
      final radio = FlutstrapRadio<String>(
        value: 'test',
        groupValue: 'test',
        onChanged: (value) {},
        size: FSRadioSize.sm,
      );

      final mediumRadio = radio.medium();
      expect(mediumRadio.size, FSRadioSize.md);
    });

    test('large() should set size to lg', () {
      final radio = FlutstrapRadio<String>(
        value: 'test',
        groupValue: 'test',
        onChanged: (value) {},
        size: FSRadioSize.md,
      );

      final largeRadio = radio.large();
      expect(largeRadio.size, FSRadioSize.lg);
    });

    test('asDisabled() should set disabled to true', () {
      final radio = FlutstrapRadio<String>(
        value: 'test',
        groupValue: 'test',
        onChanged: (value) {},
        disabled: false,
      );

      final disabledRadio = radio.asDisabled();
      expect(disabledRadio.disabled, true);
    });

    test('asEnabled() should set disabled to false', () {
      final radio = FlutstrapRadio<String>(
        value: 'test',
        groupValue: 'test',
        onChanged: (value) {},
        disabled: true,
      );

      final enabledRadio = radio.asEnabled();
      expect(enabledRadio.disabled, false);
    });

    test('withLabel() should set label', () {
      final radio = FlutstrapRadio<String>(
        value: 'test',
        groupValue: 'test',
        onChanged: (value) {},
        label: 'Old label',
      );

      final labeledRadio = radio.withLabel('New label');
      expect(labeledRadio.label, 'New label');
    });

    test('withValidation() should set validation properties', () {
      final radio = FlutstrapRadio<String>(
        value: 'test',
        groupValue: 'test',
        onChanged: (value) {},
      );

      final validatedRadio = radio.withValidation('Error message');
      expect(validatedRadio.validationMessage, 'Error message');
      expect(validatedRadio.showValidation, true);
      expect(validatedRadio.isValid, false);
    });
  });

  group('FlutstrapRadio - CopyWith Tests', () {
    test('copyWith should create new instance with updated values', () {
      final original = FlutstrapRadio<String>(
        value: 'test1',
        groupValue: 'test1',
        onChanged: (value) {},
        label: 'Original',
        variant: FSRadioVariant.primary,
        size: FSRadioSize.md,
        disabled: false,
      );

      final copy = original.copyWith(
        value: 'test2',
        groupValue: 'test2',
        label: 'Copied',
        variant: FSRadioVariant.success,
        disabled: true,
      );

      expect(copy.value, 'test2');
      expect(copy.groupValue, 'test2');
      expect(copy.label, 'Copied');
      expect(copy.variant, FSRadioVariant.success);
      expect(copy.disabled, true);

      expect(original.value, 'test1');
      expect(original.label, 'Original');
    });

    test('copyWith should keep original values when not specified', () {
      final original = FlutstrapRadio<String>(
        value: 'test',
        groupValue: 'test',
        onChanged: (value) {},
        label: 'Original',
        variant: FSRadioVariant.primary,
      );

      final copy = original.copyWith(value: 'new');

      expect(copy.value, 'new');
      expect(copy.groupValue, 'test'); // Kept from original
      expect(copy.label, 'Original'); // Kept from original
      expect(copy.variant, FSRadioVariant.primary); // Kept from original
    });
  });

  group('FlutstrapRadio - Edge Cases', () {
    testWidgets('should handle null groupValue without crashing',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapRadio<String>(
              value: 'option1',
              groupValue: null,
              onChanged: (value) {},
              label: 'Null group',
            ),
          ),
        ),
      );

      expect(find.text('Null group'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('should handle null label without crashing',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapRadio<String>(
              value: 'option1',
              groupValue: 'option1',
              onChanged: (value) {},
              label: null,
            ),
          ),
        ),
      );

      expect(find.byType(FlutstrapRadio<String>), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('should handle very long label without overflow',
        (WidgetTester tester) async {
      final longLabel = 'A' * 200;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 200,
              child: FlutstrapRadio<String>(
                value: 'option1',
                groupValue: 'option1',
                onChanged: (value) {},
                label: longLabel,
              ),
            ),
          ),
        ),
      );

      expect(find.textContaining('A' * 50), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('should handle multiple rapid taps gracefully',
        (WidgetTester tester) async {
      var callCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapRadio<String>(
              value: 'option1',
              groupValue: 'option2',
              onChanged: (value) => callCount++,
              label: 'Rapid tap',
            ),
          ),
        ),
      );

      await tester.tap(find.text('Rapid tap'));
      await tester.tap(find.text('Rapid tap'));
      await tester.tap(find.text('Rapid tap'));
      await tester.pump();

      expect(callCount, greaterThan(0));
    });
  });

  group('FlutstrapRadio - Themed Tests', () {
    testWidgets('should work with FSTheme provider',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FSTheme(
            data: FSThemeData.light(),
            child: Scaffold(
              body: Builder(
                builder: (context) => FlutstrapRadio<String>(
                  value: 'option1',
                  groupValue: 'option1',
                  onChanged: (value) {},
                  label: 'Themed radio',
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Themed radio'), findsOneWidget);
    });

    testWidgets('should work with dark theme', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FSTheme(
            data: FSThemeData.dark(),
            child: Scaffold(
              body: Builder(
                builder: (context) => FlutstrapRadio<String>(
                  value: 'option1',
                  groupValue: 'option1',
                  onChanged: (value) {},
                  label: 'Dark theme radio',
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Dark theme radio'), findsOneWidget);
    });
  });

  group('FlutstrapRadio - Radio Group Tests', () {
    testWidgets('should only have one selected radio in a group',
        (WidgetTester tester) async {
      String? groupValue = 'option1';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return Column(
                  children: [
                    FlutstrapRadio<String>(
                      value: 'option1',
                      groupValue: groupValue,
                      onChanged: (value) => setState(() => groupValue = value),
                      label: 'Option 1',
                    ),
                    FlutstrapRadio<String>(
                      value: 'option2',
                      groupValue: groupValue,
                      onChanged: (value) => setState(() => groupValue = value),
                      label: 'Option 2',
                    ),
                    FlutstrapRadio<String>(
                      value: 'option3',
                      groupValue: groupValue,
                      onChanged: (value) => setState(() => groupValue = value),
                      label: 'Option 3',
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      );

      // Tap option 2
      await tester.tap(find.text('Option 2'));
      await tester.pump();
      expect(groupValue, 'option2');

      // Tap option 3
      await tester.tap(find.text('Option 3'));
      await tester.pump();
      expect(groupValue, 'option3');

      // Tap option 2 again (should not change)
      await tester.tap(find.text('Option 2'));
      await tester.pump();
      expect(groupValue, 'option3'); // Still option3
    });
  });
}
