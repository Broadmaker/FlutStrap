import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutstrap/flutstrap.dart';

void main() {
  group('FlutstrapCheckbox - Rendering Tests', () {
    testWidgets('should render basic checkbox with label',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapCheckbox(
              value: false,
              onChanged: (value) {},
              label: 'Accept terms',
            ),
          ),
        ),
      );

      expect(find.text('Accept terms'), findsOneWidget);
      expect(find.byType(FlutstrapCheckbox), findsOneWidget);
    });

    testWidgets('should render with custom label widget',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapCheckbox(
              value: false,
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

    testWidgets('should render checked state with checkmark',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapCheckbox(
              value: true,
              onChanged: (value) {},
              label: 'Checked',
            ),
          ),
        ),
      );

      expect(find.text('Checked'), findsOneWidget);
      expect(find.byIcon(Icons.check), findsOneWidget);
    });

    testWidgets('should render indeterminate state',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapCheckbox(
              value: null,
              onChanged: (value) {},
              label: 'Indeterminate',
              tristate: true,
            ),
          ),
        ),
      );

      expect(find.text('Indeterminate'), findsOneWidget);
      expect(find.byIcon(Icons.check), findsNothing);
    });

    testWidgets('should render disabled checkbox', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapCheckbox(
              value: true,
              onChanged: null,
              label: 'Disabled',
              disabled: true,
            ),
          ),
        ),
      );

      expect(find.text('Disabled'), findsOneWidget);
    });

    testWidgets('should render inline checkbox', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Row(
              children: [
                FlutstrapCheckbox(
                  value: false,
                  onChanged: (value) {},
                  label: 'Option 1',
                  inline: true,
                ),
                FlutstrapCheckbox(
                  value: true,
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

  group('FlutstrapCheckbox - Variant Tests', () {
    testWidgets('primary variant should render', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapCheckbox(
              value: true,
              onChanged: (value) {},
              variant: FSCheckboxVariant.primary,
              label: 'Primary',
            ),
          ),
        ),
      );

      expect(find.text('Primary'), findsOneWidget);
      expect(find.byIcon(Icons.check), findsOneWidget);
    });

    testWidgets('success variant should render', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapCheckbox(
              value: true,
              onChanged: (value) {},
              variant: FSCheckboxVariant.success,
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
            body: FlutstrapCheckbox(
              value: true,
              onChanged: (value) {},
              variant: FSCheckboxVariant.danger,
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
            body: FlutstrapCheckbox(
              value: true,
              onChanged: (value) {},
              variant: FSCheckboxVariant.warning,
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
            body: FlutstrapCheckbox(
              value: true,
              onChanged: (value) {},
              variant: FSCheckboxVariant.info,
              label: 'Info',
            ),
          ),
        ),
      );

      expect(find.text('Info'), findsOneWidget);
    });
  });

  group('FlutstrapCheckbox - Size Tests', () {
    testWidgets('small size should render', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapCheckbox(
              value: true,
              onChanged: (value) {},
              size: FSCheckboxSize.sm,
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
            body: FlutstrapCheckbox(
              value: true,
              onChanged: (value) {},
              size: FSCheckboxSize.md,
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
            body: FlutstrapCheckbox(
              value: true,
              onChanged: (value) {},
              size: FSCheckboxSize.lg,
              label: 'Large',
            ),
          ),
        ),
      );

      expect(find.text('Large'), findsOneWidget);
    });
  });

  group('FlutstrapCheckbox - Interaction Tests', () {
    testWidgets('should call onChanged when tapped',
        (WidgetTester tester) async {
      bool? newValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapCheckbox(
              value: false,
              onChanged: (value) => newValue = value,
              label: 'Tap me',
            ),
          ),
        ),
      );

      await tester.tap(find.text('Tap me'));
      await tester.pump();

      expect(newValue, true);
    });

    testWidgets('should toggle from true to false',
        (WidgetTester tester) async {
      bool? newValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapCheckbox(
              value: true,
              onChanged: (value) => newValue = value,
              label: 'Toggle',
            ),
          ),
        ),
      );

      await tester.tap(find.text('Toggle'));
      await tester.pump();

      expect(newValue, false);
    });

    testWidgets('should cycle through tri-states', (WidgetTester tester) async {
      final values = <bool?>[];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapCheckbox(
              value: false,
              onChanged: (value) => values.add(value),
              label: 'Tri-state',
              tristate: true,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Tri-state'));
      await tester.pump();
      expect(values.last, true);

      await tester.tap(find.text('Tri-state'));
      await tester.pump();
      expect(values.last, false);

      await tester.tap(find.text('Tri-state'));
      await tester.pump();
      expect(values.last, null);
    });

    testWidgets('should not call onChanged when disabled',
        (WidgetTester tester) async {
      var called = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapCheckbox(
              value: false,
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
            body: FlutstrapCheckbox(
              value: false,
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

  group('FlutstrapCheckbox - Validation Tests', () {
    testWidgets('should show validation message when invalid',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapCheckbox(
              value: false,
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
            body: FlutstrapCheckbox(
              value: true,
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
            body: FlutstrapCheckbox(
              value: false,
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

  group('FlutstrapCheckbox - Builder Methods', () {
    test('primary() should set variant to primary', () {
      final checkbox = FlutstrapCheckbox(
        value: false,
        onChanged: (value) {},
        variant: FSCheckboxVariant.success,
      );

      final primaryCheckbox = checkbox.primary();
      expect(primaryCheckbox.variant, FSCheckboxVariant.primary);
    });

    test('success() should set variant to success', () {
      final checkbox = FlutstrapCheckbox(
        value: false,
        onChanged: (value) {},
        variant: FSCheckboxVariant.primary,
      );

      final successCheckbox = checkbox.success();
      expect(successCheckbox.variant, FSCheckboxVariant.success);
    });

    test('danger() should set variant to danger', () {
      final checkbox = FlutstrapCheckbox(
        value: false,
        onChanged: (value) {},
        variant: FSCheckboxVariant.primary,
      );

      final dangerCheckbox = checkbox.danger();
      expect(dangerCheckbox.variant, FSCheckboxVariant.danger);
    });

    test('warning() should set variant to warning', () {
      final checkbox = FlutstrapCheckbox(
        value: false,
        onChanged: (value) {},
        variant: FSCheckboxVariant.primary,
      );

      final warningCheckbox = checkbox.warning();
      expect(warningCheckbox.variant, FSCheckboxVariant.warning);
    });

    test('info() should set variant to info', () {
      final checkbox = FlutstrapCheckbox(
        value: false,
        onChanged: (value) {},
        variant: FSCheckboxVariant.primary,
      );

      final infoCheckbox = checkbox.info();
      expect(infoCheckbox.variant, FSCheckboxVariant.info);
    });

    test('small() should set size to sm', () {
      final checkbox = FlutstrapCheckbox(
        value: false,
        onChanged: (value) {},
        size: FSCheckboxSize.md,
      );

      final smallCheckbox = checkbox.small();
      expect(smallCheckbox.size, FSCheckboxSize.sm);
    });

    test('medium() should set size to md', () {
      final checkbox = FlutstrapCheckbox(
        value: false,
        onChanged: (value) {},
        size: FSCheckboxSize.sm,
      );

      final mediumCheckbox = checkbox.medium();
      expect(mediumCheckbox.size, FSCheckboxSize.md);
    });

    test('large() should set size to lg', () {
      final checkbox = FlutstrapCheckbox(
        value: false,
        onChanged: (value) {},
        size: FSCheckboxSize.md,
      );

      final largeCheckbox = checkbox.large();
      expect(largeCheckbox.size, FSCheckboxSize.lg);
    });

    test('asDisabled() should set disabled to true', () {
      final checkbox = FlutstrapCheckbox(
        value: false,
        onChanged: (value) {},
        disabled: false,
      );

      final disabledCheckbox = checkbox.asDisabled();
      expect(disabledCheckbox.disabled, true);
    });

    test('asEnabled() should set disabled to false', () {
      final checkbox = FlutstrapCheckbox(
        value: false,
        onChanged: (value) {},
        disabled: true,
      );

      final enabledCheckbox = checkbox.asEnabled();
      expect(enabledCheckbox.disabled, false);
    });

    test('withLabel() should set label', () {
      final checkbox = FlutstrapCheckbox(
        value: false,
        onChanged: (value) {},
        label: 'Old label',
      );

      final labeledCheckbox = checkbox.withLabel('New label');
      expect(labeledCheckbox.label, 'New label');
    });

    test('withValidation() should set validation properties', () {
      final checkbox = FlutstrapCheckbox(
        value: false,
        onChanged: (value) {},
      );

      final validatedCheckbox = checkbox.withValidation('Error message');
      expect(validatedCheckbox.validationMessage, 'Error message');
      expect(validatedCheckbox.showValidation, true);
      expect(validatedCheckbox.isValid, false);
    });

    test('asTristate() should set tristate to true', () {
      final checkbox = FlutstrapCheckbox(
        value: false,
        onChanged: (value) {},
        tristate: false,
      );

      final triStateCheckbox = checkbox.asTristate();
      expect(triStateCheckbox.tristate, true);
    });
  });

  group('FlutstrapCheckbox - CopyWith Tests', () {
    test('copyWith should create new instance with updated values', () {
      final original = FlutstrapCheckbox(
        value: false,
        onChanged: (value) {},
        label: 'Original',
        variant: FSCheckboxVariant.primary,
        size: FSCheckboxSize.md,
        disabled: false,
      );

      final copy = original.copyWith(
        value: true,
        label: 'Copied',
        variant: FSCheckboxVariant.success,
        disabled: true,
      );

      expect(copy.value, true);
      expect(copy.label, 'Copied');
      expect(copy.variant, FSCheckboxVariant.success);
      expect(copy.disabled, true);

      expect(original.value, false);
      expect(original.label, 'Original');
    });

    test('copyWith should keep original values when not specified', () {
      final original = FlutstrapCheckbox(
        value: false,
        onChanged: (value) {},
        label: 'Original',
        variant: FSCheckboxVariant.primary,
      );

      final copy = original.copyWith(value: true);

      expect(copy.value, true);
      expect(copy.label, 'Original');
      expect(copy.variant, FSCheckboxVariant.primary);
    });
  });

  group('FlutstrapCheckbox - Edge Cases', () {
    testWidgets('should handle null value without crashing',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapCheckbox(
              value: null,
              onChanged: (value) {},
              label: 'Null value',
            ),
          ),
        ),
      );

      expect(find.text('Null value'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('should handle null label without crashing',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapCheckbox(
              value: false,
              onChanged: (value) {},
              label: null,
            ),
          ),
        ),
      );

      expect(find.byType(FlutstrapCheckbox), findsOneWidget);
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
              child: FlutstrapCheckbox(
                value: false,
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

    testWidgets('should handle rapid taps gracefully',
        (WidgetTester tester) async {
      var callCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapCheckbox(
              value: false,
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

  group('FlutstrapCheckbox - Themed Tests', () {
    testWidgets('should work with FSTheme provider',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FSTheme(
            data: FSThemeData.light(),
            child: Scaffold(
              body: Builder(
                builder: (context) => FlutstrapCheckbox(
                  value: true,
                  onChanged: (value) {},
                  label: 'Themed checkbox',
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Themed checkbox'), findsOneWidget);
      expect(find.byIcon(Icons.check), findsOneWidget);
    });

    testWidgets('should work with dark theme', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FSTheme(
            data: FSThemeData.dark(),
            child: Scaffold(
              body: Builder(
                builder: (context) => FlutstrapCheckbox(
                  value: true,
                  onChanged: (value) {},
                  label: 'Dark theme checkbox',
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Dark theme checkbox'), findsOneWidget);
      expect(find.byIcon(Icons.check), findsOneWidget);
    });
  });
}
