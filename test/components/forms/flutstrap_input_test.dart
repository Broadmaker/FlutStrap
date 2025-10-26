import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:master_flutstrap/components/forms/flutstrap_input.dart';

void main() {
  group('FlutstrapInput', () {
    testWidgets('should render with basic properties',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapInput(
              hintText: 'Enter text',
            ),
          ),
        ),
      );

      expect(find.byType(TextFormField), findsOneWidget);
    });

    testWidgets('should show label text', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapInput(
              labelText: 'Username',
            ),
          ),
        ),
      );

      expect(find.text('Username'), findsOneWidget);
    });

    testWidgets('should show hint text', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapInput(
              hintText: 'Enter your username',
            ),
          ),
        ),
      );

      expect(find.text('Enter your username'), findsOneWidget);
    });

    testWidgets('should show error text when validator fails',
        (WidgetTester tester) async {
      final formKey = GlobalKey<FormState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.always,
              child: FlutstrapInput(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is required';
                  }
                  return null;
                },
              ),
            ),
          ),
        ),
      );

      formKey.currentState!.validate();
      await tester.pumpAndSettle();

      expect(find.text('This field is required'), findsOneWidget);
    });
    testWidgets('should show prefix icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapInput(
              prefixIcon: const Icon(Icons.person),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.person), findsOneWidget);
    });

    testWidgets('should show suffix icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapInput(
              suffixIcon: const Icon(Icons.visibility),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.visibility), findsOneWidget);
    });

    testWidgets('should be disabled when enabled is false',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapInput(
              hintText: 'Disabled input',
              enabled: false,
            ),
          ),
        ),
      );

      final input = tester.widget<TextFormField>(find.byType(TextFormField));
      expect(input.enabled, false);
    });

    testWidgets('should call onChanged when text changes',
        (WidgetTester tester) async {
      String? changedValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapInput(
              onChanged: (value) {
                changedValue = value;
              },
            ),
          ),
        ),
      );

      final input = find.byType(TextFormField);
      await tester.enterText(input, 'Hello World');

      expect(changedValue, 'Hello World');
    });
  });

  group('FlutstrapInput Methods', () {
    testWidgets('clear should clear the text', (WidgetTester tester) async {
      final inputKey = GlobalKey<FlutstrapInputState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapInput(
              key: inputKey,
              initialValue: 'Initial text',
            ),
          ),
        ),
      );

      // Verify initial text
      final field = tester.widget<TextFormField>(find.byType(TextFormField));
      expect(field.controller?.text, 'Initial text');

      // Clear the text
      inputKey.currentState?.clear();
      await tester.pump();

      expect(field.controller?.text, '');
    });

    testWidgets('setError should set error state', (WidgetTester tester) async {
      final inputKey = GlobalKey<FlutstrapInputState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapInput(
              key: inputKey,
            ),
          ),
        ),
      );

      // Set error
      inputKey.currentState?.setError('Custom error');
      await tester.pump();

      expect(find.text('Custom error'), findsOneWidget);
    });

    testWidgets('clearError should clear error state',
        (WidgetTester tester) async {
      final inputKey = GlobalKey<FlutstrapInputState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapInput(
              key: inputKey,
            ),
          ),
        ),
      );

      // Set error first
      inputKey.currentState?.setError('Custom error');
      await tester.pump();
      expect(find.text('Custom error'), findsOneWidget);

      // Clear error
      inputKey.currentState?.clearError();
      await tester.pump();
      expect(find.text('Custom error'), findsNothing);
    });
  });
}
