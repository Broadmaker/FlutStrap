// test/components/forms/flutstrap_textarea_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:master_flutstrap/components/forms/flutstrap_textarea.dart';
import 'package:master_flutstrap/core/theme.dart';

void main() {
  // Helper function to wrap textarea with theme and constrained width for tests
  Widget buildTestableTextArea(FlutstrapTextArea textArea) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: FSTheme(
        data: FSThemeData.light(),
        child: Scaffold(
          body: Center(
            child: Container(
              width: 400,
              child: textArea,
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to debug what text widgets are found
  void _debugFindAllText(WidgetTester tester) {
    final textWidgets = find.byType(Text).evaluate();
    for (final element in textWidgets) {
      final text = element.widget as Text;
      print('Found text: "${text.data}"');
    }
  }

  group('FlutstrapTextArea', () {
    testWidgets('renders textarea with default properties', (tester) async {
      await tester.pumpWidget(
        buildTestableTextArea(
          FlutstrapTextArea(
            onChanged: (value) {},
          ),
        ),
      );

      expect(find.byType(FlutstrapTextArea), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('renders textarea with label', (tester) async {
      await tester.pumpWidget(
        buildTestableTextArea(
          FlutstrapTextArea(
            label: 'Description',
            onChanged: (value) {},
          ),
        ),
      );

      expect(find.text('Description'), findsOneWidget);
    });

    testWidgets('renders textarea with placeholder', (tester) async {
      await tester.pumpWidget(
        buildTestableTextArea(
          FlutstrapTextArea(
            placeholder: 'Enter your description here...',
            onChanged: (value) {},
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.decoration!.hintText, 'Enter your description here...');
    });

    testWidgets('renders textarea with initial value', (tester) async {
      await tester.pumpWidget(
        buildTestableTextArea(
          FlutstrapTextArea(
            initialValue: 'Initial text',
            onChanged: (value) {},
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.controller!.text, 'Initial text');
    });

    testWidgets('calls onChanged when text changes', (tester) async {
      String? changedValue;
      await tester.pumpWidget(
        buildTestableTextArea(
          FlutstrapTextArea(
            onChanged: (value) {
              changedValue = value;
            },
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'New text');
      expect(changedValue, 'New text');
    });

    testWidgets('calls onSubmitted when submitted', (tester) async {
      String? submittedValue;
      await tester.pumpWidget(
        buildTestableTextArea(
          FlutstrapTextArea(
            onSubmitted: (value) {
              submittedValue = value;
            },
            onChanged: (value) {},
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      textField.onSubmitted!('Submitted text');
      expect(submittedValue, 'Submitted text');
    });

    testWidgets('shows required indicator when required', (tester) async {
      await tester.pumpWidget(
        buildTestableTextArea(
          FlutstrapTextArea(
            label: 'Description',
            required: true,
            onChanged: (value) {},
          ),
        ),
      );

      expect(find.text('Description'), findsOneWidget);
      expect(find.text('*'), findsOneWidget);
    });

    testWidgets('does not show required indicator when not required',
        (tester) async {
      await tester.pumpWidget(
        buildTestableTextArea(
          FlutstrapTextArea(
            label: 'Description',
            required: false,
            onChanged: (value) {},
          ),
        ),
      );

      expect(find.text('Description'), findsOneWidget);
      expect(find.text('*'), findsNothing);
    });

    testWidgets('shows helper text when provided', (tester) async {
      await tester.pumpWidget(
        buildTestableTextArea(
          FlutstrapTextArea(
            helperText: 'This is a helper text',
            onChanged: (value) {},
          ),
        ),
      );

      expect(find.text('This is a helper text'), findsOneWidget);
    });

    testWidgets('shows character counter when enabled', (tester) async {
      await tester.pumpWidget(
        buildTestableTextArea(
          FlutstrapTextArea(
            maxLength: 100,
            showCharacterCounter: true,
            onChanged: (value) {},
          ),
        ),
      );

      // Look for any text that contains the pattern "X/100"
      final counterFinder = find.descendant(
        of: find.byType(FlutstrapTextArea),
        matching: find.textContaining('/100'),
      );

      expect(counterFinder, findsOneWidget);

      // Should show 0/100 initially
      final counterText = tester.widget<Text>(counterFinder);
      expect(counterText.data, '0/100');
    });

    testWidgets('updates character counter when text changes - FINAL FIX',
        (tester) async {
      // Use a StatefulWidget to properly manage the controller
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: FSTheme(
            data: FSThemeData.light(),
            child: Scaffold(
              body: Center(
                child: Container(
                  width: 400,
                  child: FlutstrapTextArea(
                    maxLength: 100,
                    showCharacterCounter: true,
                    onChanged: (value) {},
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      // Focus on the text field first
      await tester.tap(find.byType(TextField));
      await tester.pump();

      // Enter text properly
      await tester.enterText(find.byType(TextField), 'Hello');
      await tester
          .pumpAndSettle(); // Use pumpAndSettle to ensure all animations complete

      // Look for the updated counter - be more flexible in finding it
      final counterFinder = find.descendant(
        of: find.byType(FlutstrapTextArea),
        matching: find.byWidgetPredicate(
          (widget) =>
              widget is Text && (widget.data?.contains('/100') ?? false),
        ),
      );

      expect(counterFinder, findsOneWidget);

      // Verify the counter text
      final counterText = tester.widget<Text>(counterFinder);
      expect(counterText.data, '5/100');
    });
    testWidgets('shows validation message when invalid', (tester) async {
      await tester.pumpWidget(
        buildTestableTextArea(
          FlutstrapTextArea(
            showValidation: true,
            isValid: false,
            validationMessage: 'This field is required',
            onChanged: (value) {},
          ),
        ),
      );

      expect(find.text('This field is required'), findsOneWidget);
    });

    testWidgets('hides validation message when valid', (tester) async {
      await tester.pumpWidget(
        buildTestableTextArea(
          FlutstrapTextArea(
            showValidation: true,
            isValid: true,
            validationMessage: 'This field is required',
            onChanged: (value) {},
          ),
        ),
      );

      expect(find.text('This field is required'), findsNothing);
    });

    testWidgets('hides validation message when showValidation is false',
        (tester) async {
      await tester.pumpWidget(
        buildTestableTextArea(
          FlutstrapTextArea(
            showValidation: false,
            isValid: false,
            validationMessage: 'This field is required',
            onChanged: (value) {},
          ),
        ),
      );

      expect(find.text('This field is required'), findsNothing);
    });

    testWidgets('respects disabled state', (tester) async {
      await tester.pumpWidget(
        buildTestableTextArea(
          FlutstrapTextArea(
            disabled: true,
            onChanged: (value) {},
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.enabled, isFalse);
    });

    testWidgets('respects readonly state', (tester) async {
      await tester.pumpWidget(
        buildTestableTextArea(
          FlutstrapTextArea(
            readonly: true,
            onChanged: (value) {},
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.readOnly, isTrue);
    });

    testWidgets('respects different sizes', (tester) async {
      final sizes = FSTextAreaSize.values;

      for (final size in sizes) {
        await tester.pumpWidget(
          buildTestableTextArea(
            FlutstrapTextArea(
              size: size,
              onChanged: (value) {},
            ),
          ),
        );

        expect(find.byType(FlutstrapTextArea), findsOneWidget);
        await tester.pumpWidget(Container()); // Clean up for next iteration
      }
    });

    testWidgets('respects different variants', (tester) async {
      final variants = FSTextAreaVariant.values;

      for (final variant in variants) {
        await tester.pumpWidget(
          buildTestableTextArea(
            FlutstrapTextArea(
              variant: variant,
              onChanged: (value) {},
            ),
          ),
        );

        expect(find.byType(FlutstrapTextArea), findsOneWidget);
        await tester.pumpWidget(Container()); // Clean up for next iteration
      }
    });

    testWidgets('respects custom rows', (tester) async {
      await tester.pumpWidget(
        buildTestableTextArea(
          FlutstrapTextArea(
            rows: 5,
            onChanged: (value) {},
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.minLines, 5);
      expect(textField.maxLines, 5);
    });

    testWidgets('respects autoResize when enabled', (tester) async {
      await tester.pumpWidget(
        buildTestableTextArea(
          FlutstrapTextArea(
            autoResize: true,
            onChanged: (value) {},
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.minLines, isNull);
      expect(textField.maxLines, isNull);
    });

    testWidgets('respects maxLength constraint', (tester) async {
      await tester.pumpWidget(
        buildTestableTextArea(
          FlutstrapTextArea(
            maxLength: 10,
            onChanged: (value) {},
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.maxLength, 10);
    });

    testWidgets('hides label when showLabel is false', (tester) async {
      await tester.pumpWidget(
        buildTestableTextArea(
          FlutstrapTextArea(
            label: 'Description',
            showLabel: false,
            onChanged: (value) {},
          ),
        ),
      );

      expect(find.text('Description'), findsNothing);
    });

    testWidgets('uses custom padding when provided', (tester) async {
      final customPadding = const EdgeInsets.all(20.0);

      await tester.pumpWidget(
        buildTestableTextArea(
          FlutstrapTextArea(
            padding: customPadding,
            onChanged: (value) {},
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.decoration!.contentPadding, customPadding);
    });

    testWidgets('handles focus node correctly', (tester) async {
      final focusNode = FocusNode();

      await tester.pumpWidget(
        buildTestableTextArea(
          FlutstrapTextArea(
            focusNode: focusNode,
            onChanged: (value) {},
          ),
        ),
      );

      expect(focusNode.hasFocus, isFalse);
      await tester.tap(find.byType(TextField));
      await tester.pump();
      expect(focusNode.hasFocus, isTrue);
    });

    testWidgets('handles text input action', (tester) async {
      await tester.pumpWidget(
        buildTestableTextArea(
          FlutstrapTextArea(
            textInputAction: TextInputAction.done,
            onChanged: (value) {},
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.textInputAction, TextInputAction.done);
    });

    testWidgets('handles onEditingComplete callback', (tester) async {
      bool wasCalled = false;

      await tester.pumpWidget(
        buildTestableTextArea(
          FlutstrapTextArea(
            onEditingComplete: () {
              wasCalled = true;
            },
            onChanged: (value) {},
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      textField.onEditingComplete!();
      expect(wasCalled, isTrue);
    });
  });

  group('FSTextAreaSize', () {
    test('has correct values', () {
      expect(FSTextAreaSize.values.length, 3);
      expect(FSTextAreaSize.values, contains(FSTextAreaSize.sm));
      expect(FSTextAreaSize.values, contains(FSTextAreaSize.md));
      expect(FSTextAreaSize.values, contains(FSTextAreaSize.lg));
    });
  });

  group('FSTextAreaVariant', () {
    test('has correct values', () {
      expect(FSTextAreaVariant.values.length, 8);
      expect(FSTextAreaVariant.values, contains(FSTextAreaVariant.primary));
      expect(FSTextAreaVariant.values, contains(FSTextAreaVariant.secondary));
      expect(FSTextAreaVariant.values, contains(FSTextAreaVariant.success));
      expect(FSTextAreaVariant.values, contains(FSTextAreaVariant.danger));
      expect(FSTextAreaVariant.values, contains(FSTextAreaVariant.warning));
      expect(FSTextAreaVariant.values, contains(FSTextAreaVariant.info));
      expect(FSTextAreaVariant.values, contains(FSTextAreaVariant.light));
      expect(FSTextAreaVariant.values, contains(FSTextAreaVariant.dark));
    });
  });

  group('Edge Cases', () {
    testWidgets('handles null onChanged callback without crashing',
        (tester) async {
      await tester.pumpWidget(
        buildTestableTextArea(
          const FlutstrapTextArea(
            onChanged: null,
          ),
        ),
      );

      expect(find.byType(FlutstrapTextArea), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'Test text');
      await tester.pumpAndSettle();

      // If we get here without exception, the test passes
    });

    testWidgets('handles null initialValue', (tester) async {
      await tester.pumpWidget(
        buildTestableTextArea(
          FlutstrapTextArea(
            onChanged: (value) {},
            // initialValue is null by default
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.controller!.text, isEmpty);
    });

    testWidgets('handles empty label', (tester) async {
      await tester.pumpWidget(
        buildTestableTextArea(
          FlutstrapTextArea(
            label: '',
            onChanged: (value) {},
          ),
        ),
      );

      // Should render without errors even with empty label
      expect(find.byType(FlutstrapTextArea), findsOneWidget);
    });

    testWidgets('character counter updates with controller text changes',
        (tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        buildTestableTextArea(
          FlutstrapTextArea(
            maxLength: 10,
            showCharacterCounter: true,
            onChanged: (value) {},
            controller: controller,
          ),
        ),
      );

      // Test multiple text changes
      controller.text = 'Hi';
      await tester.pump();

      final counterFinder1 = find.descendant(
        of: find.byType(FlutstrapTextArea),
        matching: find.textContaining('/10'),
      );
      expect(tester.widget<Text>(counterFinder1).data, '2/10');

      controller.text = 'Hello World';
      await tester.pump();
      expect(tester.widget<Text>(counterFinder1).data, '11/10');

      controller.text = '';
      await tester.pump();
      expect(tester.widget<Text>(counterFinder1).data, '0/10');

      controller.dispose();
    });

    testWidgets('autoResize updates when text changes', (tester) async {
      await tester.pumpWidget(
        buildTestableTextArea(
          FlutstrapTextArea(
            autoResize: true,
            onChanged: (value) {},
          ),
        ),
      );

      // Initial state
      final initialTextField = tester.widget<TextField>(find.byType(TextField));
      expect(initialTextField.minLines, isNull);
      expect(initialTextField.maxLines, isNull);

      // Add text and verify rebuild
      await tester.enterText(find.byType(TextField), 'Line 1\nLine 2\nLine 3');
      await tester.pump();

      // Should still have auto-resize properties
      final updatedTextField = tester.widget<TextField>(find.byType(TextField));
      expect(updatedTextField.minLines, isNull);
      expect(updatedTextField.maxLines, isNull);
    });

    testWidgets('focus changes border color', (tester) async {
      await tester.pumpWidget(
        buildTestableTextArea(
          FlutstrapTextArea(
            onChanged: (value) {},
          ),
        ),
      );

      // Find the container that wraps the TextField - use a more specific finder
      final containerFinder = find.descendant(
        of: find.byType(FlutstrapTextArea),
        matching: find.byWidgetPredicate(
          (widget) =>
              widget is Container &&
              widget.decoration is BoxDecoration &&
              (widget.decoration as BoxDecoration).border != null,
        ),
      );

      expect(containerFinder, findsOneWidget);

      // Initially not focused
      final containerBeforeFocus = tester.widget<Container>(containerFinder);
      final initialBorder =
          (containerBeforeFocus.decoration as BoxDecoration).border;

      // Tap to focus
      await tester.tap(find.byType(TextField));
      await tester.pump();

      // After focus - border color should change
      final containerAfterFocus = tester.widget<Container>(containerFinder);
      final focusedBorder =
          (containerAfterFocus.decoration as BoxDecoration).border;

      // The border should be different when focused
      expect(initialBorder != focusedBorder, isTrue);
    });
    testWidgets('disabled state has correct styling', (tester) async {
      await tester.pumpWidget(
        buildTestableTextArea(
          FlutstrapTextArea(
            disabled: true,
            onChanged: (value) {},
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.decoration!.filled, isTrue);
      expect(textField.enabled, isFalse);
    });

    testWidgets('readonly state allows focus but not editing', (tester) async {
      final controller = TextEditingController(text: 'Readonly text');
      bool wasChanged = false;

      await tester.pumpWidget(
        buildTestableTextArea(
          FlutstrapTextArea(
            readonly: true,
            controller: controller,
            onChanged: (value) {
              wasChanged = true;
            },
          ),
        ),
      );

      // Verify the component renders
      expect(find.byType(FlutstrapTextArea), findsOneWidget);

      // Store initial text
      final initialText = controller.text;

      // Try to focus the field
      await tester.tap(find.byType(TextField));
      await tester.pump();

      // Try to enter new text - this should not work in readonly mode
      await tester.enterText(find.byType(TextField), 'New text attempt');
      await tester.pump();

      // The key assertions: text should not change and onChanged should not be called
      expect(controller.text, initialText);
      expect(wasChanged, isFalse);

      controller.dispose();
    });
    testWidgets('debug character counter visibility', (tester) async {
      await tester.pumpWidget(
        buildTestableTextArea(
          FlutstrapTextArea(
            maxLength: 100,
            showCharacterCounter: true,
            onChanged: (value) {},
          ),
        ),
      );

      // Debug: print all text widgets to see what's available
      _debugFindAllText(tester);
    });
  });
}
