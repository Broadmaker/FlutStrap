import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutstrap/flutstrap.dart';

void main() {
  group('FlutstrapTextArea - Rendering Tests', () {
    testWidgets('should render basic textarea with label',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FlutstrapTextArea(
              label: 'Description',
              placeholder: 'Enter description...',
            ),
          ),
        ),
      );

      expect(find.text('Description'), findsOneWidget);
      expect(find.text('Enter description...'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('should render with helper text', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FlutstrapTextArea(
              label: 'Bio',
              helperText: 'Tell us about yourself',
            ),
          ),
        ),
      );

      expect(find.text('Bio'), findsOneWidget);
      expect(find.text('Tell us about yourself'), findsOneWidget);
    });

    testWidgets('should render required indicator',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FlutstrapTextArea(
              label: 'Required Field',
              required: true,
            ),
          ),
        ),
      );

      expect(find.text('Required Field'), findsOneWidget);
      expect(find.text('*'), findsOneWidget);
    });

    testWidgets('should render with initial value',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FlutstrapTextArea(
              label: 'Notes',
              initialValue: 'Initial text content',
            ),
          ),
        ),
      );

      expect(find.text('Notes'), findsOneWidget);
      expect(find.text('Initial text content'), findsOneWidget);
    });

    testWidgets('should render disabled textarea', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FlutstrapTextArea(
              label: 'Disabled',
              disabled: true,
              initialValue: 'Cannot edit',
            ),
          ),
        ),
      );

      expect(find.text('Disabled'), findsOneWidget);
      expect(find.text('Cannot edit'), findsOneWidget);
    });

    testWidgets('should render readonly textarea', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FlutstrapTextArea(
              label: 'Read Only',
              readonly: true,
              initialValue: 'Read only content',
            ),
          ),
        ),
      );

      expect(find.text('Read Only'), findsOneWidget);
      expect(find.text('Read only content'), findsOneWidget);
    });
  });

  group('FlutstrapTextArea - Size Tests', () {
    testWidgets('small size should render', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FlutstrapTextArea(
              label: 'Small',
              size: FSTextAreaSize.sm,
            ),
          ),
        ),
      );

      expect(find.text('Small'), findsOneWidget);
    });

    testWidgets('medium size should render', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FlutstrapTextArea(
              label: 'Medium',
              size: FSTextAreaSize.md,
            ),
          ),
        ),
      );

      expect(find.text('Medium'), findsOneWidget);
    });

    testWidgets('large size should render', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FlutstrapTextArea(
              label: 'Large',
              size: FSTextAreaSize.lg,
            ),
          ),
        ),
      );

      expect(find.text('Large'), findsOneWidget);
    });
  });

  group('FlutstrapTextArea - Variant Tests', () {
    testWidgets('primary variant should render', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FlutstrapTextArea(
              label: 'Primary',
              variant: FSTextAreaVariant.primary,
            ),
          ),
        ),
      );

      expect(find.text('Primary'), findsOneWidget);
    });

    testWidgets('success variant should render', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FlutstrapTextArea(
              label: 'Success',
              variant: FSTextAreaVariant.success,
            ),
          ),
        ),
      );

      expect(find.text('Success'), findsOneWidget);
    });

    testWidgets('danger variant should render', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FlutstrapTextArea(
              label: 'Danger',
              variant: FSTextAreaVariant.danger,
            ),
          ),
        ),
      );

      expect(find.text('Danger'), findsOneWidget);
    });

    testWidgets('warning variant should render', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FlutstrapTextArea(
              label: 'Warning',
              variant: FSTextAreaVariant.warning,
            ),
          ),
        ),
      );

      expect(find.text('Warning'), findsOneWidget);
    });

    testWidgets('info variant should render', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FlutstrapTextArea(
              label: 'Info',
              variant: FSTextAreaVariant.info,
            ),
          ),
        ),
      );

      expect(find.text('Info'), findsOneWidget);
    });
  });

  group('FlutstrapTextArea - Rows and Auto-resize Tests', () {
    testWidgets('should render with specified number of rows',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FlutstrapTextArea(
              label: 'Fixed rows',
              rows: 5,
            ),
          ),
        ),
      );

      expect(find.text('Fixed rows'), findsOneWidget);
    });

    testWidgets('should auto-resize with content', (WidgetTester tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapTextArea(
              label: 'Auto resize',
              autoResize: true,
              controller: controller,
            ),
          ),
        ),
      );

      controller.text = 'Line 1\nLine 2\nLine 3\nLine 4\nLine 5';
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));

      expect(find.text('Auto resize'), findsOneWidget);
    });
  });

  group('FlutstrapTextArea - Character Counter Tests', () {
    testWidgets('should show character counter when enabled',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FlutstrapTextArea(
              label: 'Limited input',
              maxLength: 100,
              showCharacterCounter: true,
            ),
          ),
        ),
      );

      expect(find.text('0/100'), findsOneWidget);
    });

    testWidgets('should update counter as user types',
        (WidgetTester tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapTextArea(
              label: 'Counter test',
              maxLength: 50,
              showCharacterCounter: true,
              controller: controller,
            ),
          ),
        ),
      );

      expect(find.text('0/50'), findsOneWidget);

      controller.text = 'Hello world';
      await tester.pump();
      expect(find.text('11/50'), findsOneWidget);
    });

    testWidgets('should show warning color when near limit',
        (WidgetTester tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapTextArea(
              label: 'Near limit',
              maxLength: 10,
              showCharacterCounter: true,
              controller: controller,
            ),
          ),
        ),
      );

      controller.text = '1234567890';
      await tester.pump();
      expect(find.text('10/10'), findsOneWidget);
    });
  });

  group('FlutstrapTextArea - Validation Tests', () {
    testWidgets('should show validation message when invalid',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FlutstrapTextArea(
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
        const MaterialApp(
          home: Scaffold(
            body: FlutstrapTextArea(
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
        const MaterialApp(
          home: Scaffold(
            body: FlutstrapTextArea(
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

  group('FlutstrapTextArea - Interaction Tests', () {
    testWidgets('should call onChanged when text changes',
        (WidgetTester tester) async {
      String? changedValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapTextArea(
              label: 'Change test',
              onChanged: (value) => changedValue = value,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'New text');
      await tester.pump();

      expect(changedValue, 'New text');
    });

    testWidgets('should call onSubmitted when submitted',
        (WidgetTester tester) async {
      String? submittedValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapTextArea(
              label: 'Submit test',
              onSubmitted: (value) => submittedValue = value,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'Submit me');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      expect(submittedValue, 'Submit me');
    });

    testWidgets('should not allow typing when disabled',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FlutstrapTextArea(
              label: 'Disabled',
              disabled: true,
            ),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.enabled, false);
    });

    testWidgets('should not allow typing when readonly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FlutstrapTextArea(
              label: 'Read Only',
              readonly: true,
            ),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.readOnly, true);
    });
  });

  group('FlutstrapTextArea - Builder Methods', () {
    test('primary() should set variant to primary', () {
      const textarea = FlutstrapTextArea(
        label: 'Test',
        variant: FSTextAreaVariant.success,
      );

      final primary = textarea.primary();
      expect(primary.variant, FSTextAreaVariant.primary);
    });

    test('success() should set variant to success', () {
      const textarea = FlutstrapTextArea(
        label: 'Test',
        variant: FSTextAreaVariant.primary,
      );

      final success = textarea.success();
      expect(success.variant, FSTextAreaVariant.success);
    });

    test('danger() should set variant to danger', () {
      const textarea = FlutstrapTextArea(
        label: 'Test',
        variant: FSTextAreaVariant.primary,
      );

      final danger = textarea.danger();
      expect(danger.variant, FSTextAreaVariant.danger);
    });

    test('warning() should set variant to warning', () {
      const textarea = FlutstrapTextArea(
        label: 'Test',
        variant: FSTextAreaVariant.primary,
      );

      final warning = textarea.warning();
      expect(warning.variant, FSTextAreaVariant.warning);
    });

    test('info() should set variant to info', () {
      const textarea = FlutstrapTextArea(
        label: 'Test',
        variant: FSTextAreaVariant.primary,
      );

      final info = textarea.info();
      expect(info.variant, FSTextAreaVariant.info);
    });

    test('small() should set size to sm', () {
      const textarea = FlutstrapTextArea(
        label: 'Test',
        size: FSTextAreaSize.md,
      );

      final small = textarea.small();
      expect(small.size, FSTextAreaSize.sm);
    });

    test('medium() should set size to md', () {
      const textarea = FlutstrapTextArea(
        label: 'Test',
        size: FSTextAreaSize.sm,
      );

      final medium = textarea.medium();
      expect(medium.size, FSTextAreaSize.md);
    });

    test('large() should set size to lg', () {
      const textarea = FlutstrapTextArea(
        label: 'Test',
        size: FSTextAreaSize.md,
      );

      final large = textarea.large();
      expect(large.size, FSTextAreaSize.lg);
    });

    test('asDisabled() should set disabled to true', () {
      const textarea = FlutstrapTextArea(
        label: 'Test',
        disabled: false,
      );

      final disabled = textarea.asDisabled();
      expect(disabled.disabled, true);
    });

    test('asEnabled() should set disabled to false', () {
      const textarea = FlutstrapTextArea(
        label: 'Test',
        disabled: true,
      );

      final enabled = textarea.asEnabled();
      expect(enabled.disabled, false);
    });

    test('withLabel() should set label', () {
      const textarea = FlutstrapTextArea(
        label: 'Old label',
      );

      final relabeled = textarea.withLabel('New label');
      expect(relabeled.label, 'New label');
    });

    test('withHint() should set placeholder', () {
      const textarea = FlutstrapTextArea(
        label: 'Test',
      );

      final withHint = textarea.withHint('New hint');
      expect(withHint.placeholder, 'New hint');
    });

    test('withHelper() should set helper text', () {
      const textarea = FlutstrapTextArea(
        label: 'Test',
      );

      final withHelper = textarea.withHelper('Helper text');
      expect(withHelper.helperText, 'Helper text');
    });

    test('withValidation() should set validation properties', () {
      const textarea = FlutstrapTextArea(
        label: 'Test',
      );

      final validated = textarea.withValidation('Error message');
      expect(validated.validationMessage, 'Error message');
      expect(validated.showValidation, true);
      expect(validated.isValid, false);
    });
  });

  group('FlutstrapTextArea - CopyWith Tests', () {
    test('copyWith should create new instance with updated values', () {
      const original = FlutstrapTextArea(
        label: 'Original',
        placeholder: 'Placeholder',
        helperText: 'Helper',
        disabled: false,
        readonly: false,
        size: FSTextAreaSize.md,
        variant: FSTextAreaVariant.primary,
      );

      final copy = original.copyWith(
        label: 'Copied',
        disabled: true,
        readonly: true,
        variant: FSTextAreaVariant.success,
      );

      expect(copy.label, 'Copied');
      expect(copy.disabled, true);
      expect(copy.readonly, true);
      expect(copy.variant, FSTextAreaVariant.success);

      expect(original.label, 'Original');
      expect(original.disabled, false);
    });

    test('copyWith should keep original values when not specified', () {
      const original = FlutstrapTextArea(
        label: 'Original',
        placeholder: 'Placeholder',
        size: FSTextAreaSize.lg,
      );

      final copy = original.copyWith(
        label: 'New',
      );

      expect(copy.label, 'New');
      expect(copy.placeholder, 'Placeholder');
      expect(copy.size, FSTextAreaSize.lg);
    });
  });

  group('FlutstrapTextArea - Controller Tests', () {
    testWidgets('should work with external controller',
        (WidgetTester tester) async {
      final controller = TextEditingController(text: 'Initial');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapTextArea(
              label: 'Controlled',
              controller: controller,
            ),
          ),
        ),
      );

      expect(find.text('Controlled'), findsOneWidget);
      expect(find.text('Initial'), findsOneWidget);

      controller.text = 'Updated';
      await tester.pump();
      expect(find.text('Updated'), findsOneWidget);
    });

    testWidgets('should update when controller changes',
        (WidgetTester tester) async {
      final controller1 = TextEditingController(text: 'First');
      final controller2 = TextEditingController(text: 'Second');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapTextArea(
              label: 'Switch',
              controller: controller1,
            ),
          ),
        ),
      );

      expect(find.text('First'), findsOneWidget);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapTextArea(
              label: 'Switch',
              controller: controller2,
            ),
          ),
        ),
      );

      expect(find.text('Second'), findsOneWidget);
    });
  });

  group('FlutstrapTextArea - Programmatic Control Tests', () {
    testWidgets('should have working methods via global key',
        (WidgetTester tester) async {
      final key = GlobalKey();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapTextArea(
              key: key,
              label: 'Control test',
              initialValue: 'Initial',
            ),
          ),
        ),
      );

      // We can't access private methods directly in tests,
      // but we can test the public API through interaction
      expect(find.text('Initial'), findsOneWidget);

      // Clear by typing over it
      await tester.enterText(find.byType(TextField), 'New text');
      await tester.pump();
      expect(find.text('New text'), findsOneWidget);
    });

    testWidgets('should handle focus programmatically via FocusNode',
        (WidgetTester tester) async {
      final focusNode = FocusNode();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapTextArea(
              label: 'Focus test',
              focusNode: focusNode,
            ),
          ),
        ),
      );

      expect(focusNode.hasFocus, false);

      focusNode.requestFocus();
      await tester.pump();
      expect(focusNode.hasFocus, true);

      focusNode.unfocus();
      await tester.pump();
      expect(focusNode.hasFocus, false);
    });
  });

  group('FlutstrapTextArea - Edge Cases', () {
    testWidgets('should handle null label without crashing',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FlutstrapTextArea(
              label: null,
              placeholder: 'No label',
            ),
          ),
        ),
      );

      expect(find.text('No label'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('should handle very long text without crashing',
        (WidgetTester tester) async {
      final longText = 'A' * 10000;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapTextArea(
              label: 'Long text',
              initialValue: longText,
              autoResize: true,
            ),
          ),
        ),
      );

      expect(find.text('Long text'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('should handle rapid typing', (WidgetTester tester) async {
      var changeCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapTextArea(
              label: 'Rapid typing',
              onChanged: (value) => changeCount++,
              autoResize: true,
            ),
          ),
        ),
      );

      for (int i = 0; i < 10; i++) {
        await tester.enterText(find.byType(TextField), 'a' * (i + 1));
      }
      await tester.pump();

      expect(changeCount, greaterThan(0));
      expect(tester.takeException(), isNull);
    });

    testWidgets('should handle widget removal', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapTextArea(
              label: 'Dispose test',
              autoResize: true,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'Some text');

      await tester.pumpWidget(Container());

      expect(tester.takeException(), isNull);
    });
  });

  group('FlutstrapTextArea - Themed Tests', () {
    testWidgets('should work with FSTheme provider',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FSTheme(
            data: FSThemeData.light(),
            child: const Scaffold(
              body: FlutstrapTextArea(
                label: 'Themed textarea',
              ),
            ),
          ),
        ),
      );

      expect(find.text('Themed textarea'), findsOneWidget);
    });

    testWidgets('should work with dark theme', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FSTheme(
            data: FSThemeData.dark(),
            child: const Scaffold(
              body: FlutstrapTextArea(
                label: 'Dark theme textarea',
              ),
            ),
          ),
        ),
      );

      expect(find.text('Dark theme textarea'), findsOneWidget);
    });
  });
}
