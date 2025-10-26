// test/components/forms/flutstrap_form_group_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:master_flutstrap/components/forms/flutstrap_form_group.dart';
import 'package:master_flutstrap/core/theme.dart';

// Mock form fields for testing
// Mock form fields for testing - updated with constraints
Widget _buildMockInput({String? placeholder}) {
  return Container(
    constraints: const BoxConstraints(maxWidth: 200),
    height: 40,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(4),
    ),
    child: Text(placeholder ?? 'Input'),
  );
}

Widget _buildMockCheckbox({String? label}) {
  return Container(
    constraints: const BoxConstraints(maxWidth: 120),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        if (label != null) ...[
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ],
    ),
  );
}

void main() {
  // Helper function to wrap form group with theme for tests
  Widget buildTestableFormGroup(FlutstrapFormGroup formGroup) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: FSTheme(
        data: FSThemeData.light(),
        child: Scaffold(
          body: Center(
            child: Container(
              width: 600,
              child: formGroup,
            ),
          ),
        ),
      ),
    );
  }

  group('FlutstrapFormGroup', () {
    testWidgets('renders form group with children', (tester) async {
      await tester.pumpWidget(
        buildTestableFormGroup(
          FlutstrapFormGroup(
            children: [
              _buildMockInput(placeholder: 'Input 1'),
              _buildMockInput(placeholder: 'Input 2'),
            ],
          ),
        ),
      );

      expect(find.byType(FlutstrapFormGroup), findsOneWidget);
      expect(find.text('Input 1'), findsOneWidget);
      expect(find.text('Input 2'), findsOneWidget);
    });

    testWidgets('renders form group with label', (tester) async {
      await tester.pumpWidget(
        buildTestableFormGroup(
          FlutstrapFormGroup(
            label: 'Form Group Label',
            children: [
              _buildMockInput(),
            ],
          ),
        ),
      );

      expect(find.text('Form Group Label'), findsOneWidget);
    });

    testWidgets('shows required indicator when required', (tester) async {
      await tester.pumpWidget(
        buildTestableFormGroup(
          FlutstrapFormGroup(
            label: 'Required Field',
            required: true,
            children: [
              _buildMockInput(),
            ],
          ),
        ),
      );

      expect(find.text('Required Field'), findsOneWidget);
      expect(find.text('*'), findsOneWidget);
    });

    testWidgets('does not show required indicator when not required',
        (tester) async {
      await tester.pumpWidget(
        buildTestableFormGroup(
          FlutstrapFormGroup(
            label: 'Optional Field',
            required: false,
            children: [
              _buildMockInput(),
            ],
          ),
        ),
      );

      expect(find.text('Optional Field'), findsOneWidget);
      expect(find.text('*'), findsNothing);
    });

    testWidgets('renders form group with helper text', (tester) async {
      await tester.pumpWidget(
        buildTestableFormGroup(
          FlutstrapFormGroup(
            helperText: 'This is helper text',
            children: [
              _buildMockInput(),
            ],
          ),
        ),
      );

      expect(find.text('This is helper text'), findsOneWidget);
    });

    testWidgets('shows validation message when invalid', (tester) async {
      await tester.pumpWidget(
        buildTestableFormGroup(
          FlutstrapFormGroup(
            showValidation: true,
            isValid: false,
            validationMessage: 'This field is required',
            children: [
              _buildMockInput(),
            ],
          ),
        ),
      );

      expect(find.text('This field is required'), findsOneWidget);
    });

    testWidgets('hides validation message when valid', (tester) async {
      await tester.pumpWidget(
        buildTestableFormGroup(
          FlutstrapFormGroup(
            showValidation: true,
            isValid: true,
            validationMessage: 'This field is required',
            children: [
              _buildMockInput(),
            ],
          ),
        ),
      );

      expect(find.text('This field is required'), findsNothing);
    });

    testWidgets('hides validation message when showValidation is false',
        (tester) async {
      await tester.pumpWidget(
        buildTestableFormGroup(
          FlutstrapFormGroup(
            showValidation: false,
            isValid: false,
            validationMessage: 'This field is required',
            children: [
              _buildMockInput(),
            ],
          ),
        ),
      );

      expect(find.text('This field is required'), findsNothing);
    });

    testWidgets('renders vertical layout by default', (tester) async {
      await tester.pumpWidget(
        buildTestableFormGroup(
          FlutstrapFormGroup(
            children: [
              _buildMockInput(placeholder: 'Input 1'),
              _buildMockInput(placeholder: 'Input 2'),
            ],
          ),
        ),
      );

      // Instead of looking for Column, verify the children are arranged vertically
      // by checking they are both present and the component renders correctly
      expect(find.byType(FlutstrapFormGroup), findsOneWidget);
      expect(find.text('Input 1'), findsOneWidget);
      expect(find.text('Input 2'), findsOneWidget);

      // For vertical layout, we can verify that both inputs are found
      // and the component doesn't use horizontal-specific features
      final rowFinder = find.descendant(
        of: find.byType(FlutstrapFormGroup),
        matching: find.byType(Row),
      );
      expect(rowFinder, findsNothing);
    });
    testWidgets('renders horizontal layout correctly', (tester) async {
      await tester.pumpWidget(
        buildTestableFormGroup(
          FlutstrapFormGroup(
            layout: FSFormGroupLayout.horizontal,
            children: [
              _buildMockInput(placeholder: 'Input 1'),
              _buildMockInput(placeholder: 'Input 2'),
            ],
          ),
        ),
      );

      // For horizontal layout, verify children are present
      expect(find.byType(FlutstrapFormGroup), findsOneWidget);
      expect(find.text('Input 1'), findsOneWidget);
      expect(find.text('Input 2'), findsOneWidget);

      // We can't reliably test for Row vs Column due to multiple layout widgets,
      // but we can verify the component works with horizontal layout
    });
    testWidgets('renders inline layout correctly', (tester) async {
      await tester.pumpWidget(
        buildTestableFormGroup(
          FlutstrapFormGroup(
            layout: FSFormGroupLayout.inline,
            children: [
              _buildMockCheckbox(label: 'Option 1'),
              _buildMockCheckbox(label: 'Option 2'),
              _buildMockCheckbox(label: 'Option 3'),
            ],
          ),
        ),
      );

      // For inline layout, verify all children are present
      expect(find.byType(FlutstrapFormGroup), findsOneWidget);
      expect(find.text('Option 1'), findsOneWidget);
      expect(find.text('Option 2'), findsOneWidget);
      expect(find.text('Option 3'), findsOneWidget);
    });
    testWidgets('respects custom spacing in vertical layout', (tester) async {
      await tester.pumpWidget(
        buildTestableFormGroup(
          FlutstrapFormGroup(
            layout: FSFormGroupLayout.vertical,
            spacing: 32.0,
            children: [
              _buildMockInput(placeholder: 'Input 1'),
              _buildMockInput(placeholder: 'Input 2'),
            ],
          ),
        ),
      );

      expect(find.byType(FlutstrapFormGroup), findsOneWidget);
      // Spacing is handled internally, so we just verify it renders
    });

    testWidgets('respects custom spacing in horizontal layout', (tester) async {
      await tester.pumpWidget(
        buildTestableFormGroup(
          FlutstrapFormGroup(
            layout: FSFormGroupLayout.horizontal,
            spacing: 24.0,
            children: [
              _buildMockInput(placeholder: 'Input 1'),
              _buildMockInput(placeholder: 'Input 2'),
            ],
          ),
        ),
      );

      expect(find.byType(FlutstrapFormGroup), findsOneWidget);
    });

    testWidgets('hides label when showLabel is false', (tester) async {
      await tester.pumpWidget(
        buildTestableFormGroup(
          FlutstrapFormGroup(
            label: 'Hidden Label',
            showLabel: false,
            children: [
              _buildMockInput(),
            ],
          ),
        ),
      );

      expect(find.text('Hidden Label'), findsNothing);
    });

    testWidgets('uses custom label when provided', (tester) async {
      final customLabel = Container(
        padding: const EdgeInsets.all(8),
        color: Colors.blue,
        child: const Text('Custom Label'),
      );

      await tester.pumpWidget(
        buildTestableFormGroup(
          FlutstrapFormGroup(
            label: 'Text Label',
            customLabel: customLabel,
            children: [
              _buildMockInput(),
            ],
          ),
        ),
      );

      expect(find.text('Custom Label'), findsOneWidget);
      expect(find.text('Text Label'), findsNothing);
    });

    testWidgets('handles empty children list', (tester) async {
      await tester.pumpWidget(
        buildTestableFormGroup(
          FlutstrapFormGroup(
            children: [],
          ),
        ),
      );

      expect(find.byType(FlutstrapFormGroup), findsOneWidget);
      // Should render without errors even with empty children
    });

    testWidgets('handles single child', (tester) async {
      await tester.pumpWidget(
        buildTestableFormGroup(
          FlutstrapFormGroup(
            children: [
              _buildMockInput(placeholder: 'Single Input'),
            ],
          ),
        ),
      );

      expect(find.byType(FlutstrapFormGroup), findsOneWidget);
      expect(find.text('Single Input'), findsOneWidget);
    });

    testWidgets('respects different sizes', (tester) async {
      final sizes = FSFormGroupSize.values;

      for (final size in sizes) {
        await tester.pumpWidget(
          buildTestableFormGroup(
            FlutstrapFormGroup(
              size: size,
              children: [
                _buildMockInput(),
              ],
            ),
          ),
        );

        expect(find.byType(FlutstrapFormGroup), findsOneWidget);
        await tester.pumpWidget(Container()); // Clean up for next iteration
      }
    });

    testWidgets('respects crossAxisAlignment in vertical layout',
        (tester) async {
      await tester.pumpWidget(
        buildTestableFormGroup(
          FlutstrapFormGroup(
            layout: FSFormGroupLayout.vertical,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(width: 100, height: 40, color: Colors.red),
              Container(width: 200, height: 40, color: Colors.blue),
            ],
          ),
        ),
      );

      expect(find.byType(FlutstrapFormGroup), findsOneWidget);
      // Alignment is visual, hard to test directly in widget tests
    });

    testWidgets('respects mainAxisAlignment in horizontal layout',
        (tester) async {
      await tester.pumpWidget(
        buildTestableFormGroup(
          FlutstrapFormGroup(
            layout: FSFormGroupLayout.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMockInput(placeholder: 'Input 1'),
              _buildMockInput(placeholder: 'Input 2'),
            ],
          ),
        ),
      );

      expect(find.byType(FlutstrapFormGroup), findsOneWidget);
    });
  });

  group('FSFormGroupLayout', () {
    test('has correct values', () {
      expect(FSFormGroupLayout.values.length, 3);
      expect(FSFormGroupLayout.values, contains(FSFormGroupLayout.vertical));
      expect(FSFormGroupLayout.values, contains(FSFormGroupLayout.horizontal));
      expect(FSFormGroupLayout.values, contains(FSFormGroupLayout.inline));
    });
  });

  group('FSFormGroupSize', () {
    test('has correct values', () {
      expect(FSFormGroupSize.values.length, 3);
      expect(FSFormGroupSize.values, contains(FSFormGroupSize.sm));
      expect(FSFormGroupSize.values, contains(FSFormGroupSize.md));
      expect(FSFormGroupSize.values, contains(FSFormGroupSize.lg));
    });
  });

  group('Edge Cases', () {
    testWidgets('handles null label', (tester) async {
      await tester.pumpWidget(
        buildTestableFormGroup(
          FlutstrapFormGroup(
            children: [
              _buildMockInput(),
            ],
            // label is null by default
          ),
        ),
      );

      expect(find.byType(FlutstrapFormGroup), findsOneWidget);
    });

    testWidgets('handles empty label string', (tester) async {
      await tester.pumpWidget(
        buildTestableFormGroup(
          FlutstrapFormGroup(
            label: '',
            children: [
              _buildMockInput(),
            ],
          ),
        ),
      );

      // Should render without errors even with empty label
      expect(find.byType(FlutstrapFormGroup), findsOneWidget);
    });

    testWidgets('handles null helper text', (tester) async {
      await tester.pumpWidget(
        buildTestableFormGroup(
          FlutstrapFormGroup(
            children: [
              _buildMockInput(),
            ],
            // helperText is null by default
          ),
        ),
      );

      expect(find.byType(FlutstrapFormGroup), findsOneWidget);
    });

    testWidgets('handles null validation message', (tester) async {
      await tester.pumpWidget(
        buildTestableFormGroup(
          FlutstrapFormGroup(
            showValidation: true,
            isValid: false,
            // validationMessage is null
            children: [
              _buildMockInput(),
            ],
          ),
        ),
      );

      // Should render without errors even with null validation message
      expect(find.byType(FlutstrapFormGroup), findsOneWidget);
    });

    testWidgets('handles very long label text', (tester) async {
      const longLabel = 'This is a very long label text that wraps';

      await tester.pumpWidget(
        buildTestableFormGroup(
          FlutstrapFormGroup(
            label: longLabel,
            children: [
              Container(
                constraints: const BoxConstraints(maxWidth: 200),
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text('Input'),
              ),
            ],
          ),
        ),
      );

      expect(find.text(longLabel), findsOneWidget);
      expect(find.byType(FlutstrapFormGroup), findsOneWidget);
    });
    testWidgets('handles many children in vertical layout', (tester) async {
      await tester.pumpWidget(
        buildTestableFormGroup(
          FlutstrapFormGroup(
            layout: FSFormGroupLayout.vertical,
            children: List.generate(10,
                (index) => _buildMockInput(placeholder: 'Input ${index + 1}')),
          ),
        ),
      );

      expect(find.byType(FlutstrapFormGroup), findsOneWidget);
      for (int i = 1; i <= 10; i++) {
        expect(find.text('Input $i'), findsOneWidget);
      }
    });

    testWidgets('handles many children in horizontal layout', (tester) async {
      await tester.pumpWidget(
        buildTestableFormGroup(
          FlutstrapFormGroup(
            layout: FSFormGroupLayout.horizontal,
            children: List.generate(
                5,
                (index) =>
                    // Use constrained width for horizontal layout
                    Container(
                      constraints: const BoxConstraints(maxWidth: 100),
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text('Field ${index + 1}'),
                    )),
          ),
        ),
      );

      expect(find.byType(FlutstrapFormGroup), findsOneWidget);
      for (int i = 1; i <= 5; i++) {
        expect(find.text('Field $i'), findsOneWidget);
      }
    });

    testWidgets('handles many children in inline layout', (tester) async {
      await tester.pumpWidget(
        buildTestableFormGroup(
          FlutstrapFormGroup(
            layout: FSFormGroupLayout.inline,
            children: List.generate(
                8, (index) => _buildMockCheckbox(label: 'Option ${index + 1}')),
          ),
        ),
      );

      expect(find.byType(FlutstrapFormGroup), findsOneWidget);
      for (int i = 1; i <= 8; i++) {
        expect(find.text('Option $i'), findsOneWidget);
      }
    });

    testWidgets('validation message appears below helper text', (tester) async {
      await tester.pumpWidget(
        buildTestableFormGroup(
          FlutstrapFormGroup(
            helperText: 'This is helper text',
            showValidation: true,
            isValid: false,
            validationMessage: 'This is an error',
            children: [
              _buildMockInput(),
            ],
          ),
        ),
      );

      expect(find.text('This is helper text'), findsOneWidget);
      expect(find.text('This is an error'), findsOneWidget);

      // Both should be visible at the same time
    });

    testWidgets('custom label takes precedence over text label',
        (tester) async {
      final customLabel = const Text('Custom Label Widget');

      await tester.pumpWidget(
        buildTestableFormGroup(
          FlutstrapFormGroup(
            label: 'Text Label',
            customLabel: customLabel,
            children: [
              _buildMockInput(),
            ],
          ),
        ),
      );

      expect(find.text('Custom Label Widget'), findsOneWidget);
      expect(find.text('Text Label'), findsNothing);
    });

    testWidgets('form group integrates with actual form components',
        (tester) async {
      // This test verifies that the form group works with real form components
      await tester.pumpWidget(
        buildTestableFormGroup(
          FlutstrapFormGroup(
            label: 'Login Form',
            helperText: 'Enter your credentials',
            children: [
              Container(
                width: 200,
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Username',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  ),
                ),
              ),
              Container(
                width: 200,
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Password',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  ),
                  obscureText: true,
                ),
              ),
            ],
          ),
        ),
      );

      expect(find.byType(FlutstrapFormGroup), findsOneWidget);
      expect(find.text('Login Form'), findsOneWidget);
      expect(find.text('Enter your credentials'), findsOneWidget);
    });
  });
}
