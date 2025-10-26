import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:master_flutstrap/components/dropdowns/flutstrap_dropdown.dart';

// Custom finder that works with generic types
Finder findFlutstrapDropdown() {
  return find.byWidgetPredicate(
    (widget) => widget is FlutstrapDropdown,
  );
}

// Custom finder for the specific Focus widget inside our dropdown
Finder findDropdownFocus() {
  return find.descendant(
    of: findFlutstrapDropdown(),
    matching: find.byType(Focus),
  );
}

// Custom finder for the specific GestureDetector inside our dropdown
Finder findDropdownGestureDetector() {
  return find.descendant(
    of: findFlutstrapDropdown(),
    matching: find.byType(GestureDetector),
  );
}

// Custom finder for the specific CompositedTransformTarget inside our dropdown
Finder findDropdownCompositedTransformTarget() {
  return find.descendant(
    of: findFlutstrapDropdown(),
    matching: find.byType(CompositedTransformTarget),
  );
}

void main() {
  group('FlutstrapDropdown Basic Tests', () {
    final sampleItems = [
      FSDropdownItem(value: '1', label: 'Option 1'),
      FSDropdownItem(value: '2', label: 'Option 2'),
      FSDropdownItem(value: '3', label: 'Option 3'),
    ];

    testWidgets('should render with basic properties',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapDropdown<String>(
                items: sampleItems,
                placeholder: 'Select an option',
              ),
            ),
          ),
        ),
      );

      expect(find.text('Select an option'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_drop_down), findsOneWidget);
      expect(findFlutstrapDropdown(), findsOneWidget);
    });

    testWidgets('should show selected value when provided',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapDropdown<String>(
                items: sampleItems,
                value: '1',
              ),
            ),
          ),
        ),
      );

      expect(find.text('Option 1'), findsOneWidget);
      expect(findFlutstrapDropdown(), findsOneWidget);
    });

    testWidgets('should show label, helper, and error text',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapDropdown<String>(
                items: sampleItems,
                labelText: 'Category',
                helperText: 'Please select',
                errorText: 'Required field',
              ),
            ),
          ),
        ),
      );

      expect(find.text('Category'), findsOneWidget);
      expect(find.text('Please select'), findsOneWidget);
      expect(find.text('Required field'), findsOneWidget);
      expect(findFlutstrapDropdown(), findsOneWidget);
    });

    testWidgets('should show prefix icon when provided',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapDropdown<String>(
                items: sampleItems,
                prefixIcon: Icon(Icons.category),
              ),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.category), findsOneWidget);
      expect(findFlutstrapDropdown(), findsOneWidget);
    });

    testWidgets('should be disabled when enabled is false',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapDropdown<String>(
                items: sampleItems,
                placeholder: 'Choose...',
                enabled: false,
                onChanged: (value) {},
              ),
            ),
          ),
        ),
      );

      expect(find.text('Choose...'), findsOneWidget);
      expect(findFlutstrapDropdown(), findsOneWidget);
    });
  });

  group('FSDropdownItem Tests', () {
    test('should create item with required properties', () {
      const item = FSDropdownItem<String>(
        value: 'test',
        label: 'Test Item',
      );

      expect(item.value, 'test');
      expect(item.label, 'Test Item');
      expect(item.enabled, true);
      expect(item.leading, isNull);
      expect(item.trailing, isNull);
    });

    test('should create item with all properties', () {
      const item = FSDropdownItem<String>(
        value: 'test',
        label: 'Test Item',
        leading: Icon(Icons.star),
        trailing: Icon(Icons.check),
        enabled: false,
      );

      expect(item.value, 'test');
      expect(item.label, 'Test Item');
      expect(item.enabled, false);
      expect(item.leading, isNotNull);
      expect(item.trailing, isNotNull);
    });

    test('should handle different value types', () {
      const stringItem =
          FSDropdownItem<String>(value: 'string', label: 'String');
      const intItem = FSDropdownItem<int>(value: 42, label: 'Number');
      const boolItem = FSDropdownItem<bool>(value: true, label: 'Boolean');

      expect(stringItem.value, 'string');
      expect(intItem.value, 42);
      expect(boolItem.value, true);
    });
  });

  group('FlutstrapDropdown Variants and Sizes', () {
    final sampleItems = [
      FSDropdownItem(value: '1', label: 'Option 1'),
    ];

    testWidgets('should render primary variant', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapDropdown<String>(
                items: sampleItems,
                variant: FSDropdownVariant.primary,
              ),
            ),
          ),
        ),
      );

      expect(findFlutstrapDropdown(), findsOneWidget);
    });

    testWidgets('should render secondary variant', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapDropdown<String>(
                items: sampleItems,
                variant: FSDropdownVariant.secondary,
              ),
            ),
          ),
        ),
      );

      expect(findFlutstrapDropdown(), findsOneWidget);
    });

    testWidgets('should render success variant', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapDropdown<String>(
                items: sampleItems,
                variant: FSDropdownVariant.success,
              ),
            ),
          ),
        ),
      );

      expect(findFlutstrapDropdown(), findsOneWidget);
    });

    testWidgets('should render danger variant', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapDropdown<String>(
                items: sampleItems,
                variant: FSDropdownVariant.danger,
              ),
            ),
          ),
        ),
      );

      expect(findFlutstrapDropdown(), findsOneWidget);
    });

    testWidgets('should render warning variant', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapDropdown<String>(
                items: sampleItems,
                variant: FSDropdownVariant.warning,
              ),
            ),
          ),
        ),
      );

      expect(findFlutstrapDropdown(), findsOneWidget);
    });

    testWidgets('should render info variant', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapDropdown<String>(
                items: sampleItems,
                variant: FSDropdownVariant.info,
              ),
            ),
          ),
        ),
      );

      expect(findFlutstrapDropdown(), findsOneWidget);
    });

    testWidgets('should render light variant', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapDropdown<String>(
                items: sampleItems,
                variant: FSDropdownVariant.light,
              ),
            ),
          ),
        ),
      );

      expect(findFlutstrapDropdown(), findsOneWidget);
    });

    testWidgets('should render dark variant', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapDropdown<String>(
                items: sampleItems,
                variant: FSDropdownVariant.dark,
              ),
            ),
          ),
        ),
      );

      expect(findFlutstrapDropdown(), findsOneWidget);
    });

    testWidgets('should render small size', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapDropdown<String>(
                items: sampleItems,
                size: FSDropdownSize.sm,
              ),
            ),
          ),
        ),
      );

      expect(findFlutstrapDropdown(), findsOneWidget);
    });

    testWidgets('should render medium size', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapDropdown<String>(
                items: sampleItems,
                size: FSDropdownSize.md,
              ),
            ),
          ),
        ),
      );

      expect(findFlutstrapDropdown(), findsOneWidget);
    });

    testWidgets('should render large size', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapDropdown<String>(
                items: sampleItems,
                size: FSDropdownSize.lg,
              ),
            ),
          ),
        ),
      );

      expect(findFlutstrapDropdown(), findsOneWidget);
    });
  });

  group('FlutstrapDropdown Edge Cases', () {
    testWidgets('should handle null value safely', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapDropdown<String>(
                items: [
                  FSDropdownItem(value: '1', label: 'Option 1'),
                ],
                value: null,
                placeholder: 'Please select',
              ),
            ),
          ),
        ),
      );

      expect(find.text('Please select'), findsOneWidget);
      expect(findFlutstrapDropdown(), findsOneWidget);
    });

    testWidgets('should handle empty items list', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapDropdown<String>(
                items: [],
                placeholder: 'No options',
              ),
            ),
          ),
        ),
      );

      expect(find.text('No options'), findsOneWidget);
      expect(findFlutstrapDropdown(), findsOneWidget);
    });

    testWidgets('should handle items with same labels',
        (WidgetTester tester) async {
      final itemsWithSameLabels = [
        FSDropdownItem(value: '1', label: 'Same Label'),
        FSDropdownItem(value: '2', label: 'Same Label'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapDropdown<String>(
                items: itemsWithSameLabels,
                placeholder: 'Choose...',
              ),
            ),
          ),
        ),
      );

      expect(findFlutstrapDropdown(), findsOneWidget);
    });

    testWidgets('should handle disabled items', (WidgetTester tester) async {
      final itemsWithDisabled = [
        FSDropdownItem(value: '1', label: 'Enabled Option'),
        FSDropdownItem(value: '2', label: 'Disabled Option', enabled: false),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapDropdown<String>(
                items: itemsWithDisabled,
                placeholder: 'Choose...',
              ),
            ),
          ),
        ),
      );

      expect(findFlutstrapDropdown(), findsOneWidget);
    });
  });

  group('FlutstrapDropdown Property Tests', () {
    test('should have search disabled by default', () {
      final dropdown = FlutstrapDropdown<String>(
        items: [FSDropdownItem(value: '1', label: 'Option 1')],
      );

      expect(dropdown.showSearch, false);
    });

    test('should have correct default size', () {
      final dropdown = FlutstrapDropdown<String>(
        items: [FSDropdownItem(value: '1', label: 'Option 1')],
      );

      expect(dropdown.size, FSDropdownSize.md);
    });

    test('should have correct default variant', () {
      final dropdown = FlutstrapDropdown<String>(
        items: [FSDropdownItem(value: '1', label: 'Option 1')],
      );

      expect(dropdown.variant, FSDropdownVariant.primary);
    });

    test('should have correct default enabled state', () {
      final dropdown = FlutstrapDropdown<String>(
        items: [FSDropdownItem(value: '1', label: 'Option 1')],
      );

      expect(dropdown.enabled, true);
    });
  });

  // Simple interaction test
  testWidgets('should respond to tap without error',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: FlutstrapDropdown<String>(
              items: [
                FSDropdownItem(value: '1', label: 'Option 1'),
              ],
              placeholder: 'Tap me',
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Tap me'));
    await tester.pump();

    expect(find.text('Tap me'), findsOneWidget);
    expect(findFlutstrapDropdown(), findsOneWidget);
  });

  // Test that verifies the widget tree structure - FIXED VERSION
  testWidgets('should have correct widget structure',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: FlutstrapDropdown<String>(
              items: [
                FSDropdownItem(value: '1', label: 'Option 1'),
              ],
              placeholder: 'Test',
            ),
          ),
        ),
      ),
    );

    // Use our custom finders that are specific to the dropdown
    expect(findDropdownCompositedTransformTarget(), findsOneWidget);
    expect(findDropdownGestureDetector(), findsOneWidget);
    expect(findDropdownFocus(), findsOneWidget);

    // For Container and Row, we can use descendant finders too
    expect(
      find.descendant(
        of: findFlutstrapDropdown(),
        matching: find.byType(Container),
      ),
      findsAtLeast(1),
    );
    expect(
      find.descendant(
        of: findFlutstrapDropdown(),
        matching: find.byType(Row),
      ),
      findsOneWidget,
    );

    expect(findFlutstrapDropdown(), findsOneWidget);
  });

  // Alternative simpler structure test
  testWidgets('should contain expected internal widgets',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: FlutstrapDropdown<String>(
              items: [
                FSDropdownItem(value: '1', label: 'Option 1'),
              ],
              placeholder: 'Test',
            ),
          ),
        ),
      ),
    );

    // Just verify that our main dropdown widget exists and contains the expected structure
    expect(findFlutstrapDropdown(), findsOneWidget);

    // Verify that the dropdown contains the expected internal structure
    final dropdownFinder = findFlutstrapDropdown();
    final dropdownElement = tester.element(dropdownFinder);

    // Check that it has the expected child widgets by looking for specific patterns
    expect(find.descendant(of: dropdownFinder, matching: find.byType(Row)),
        findsOneWidget);
    expect(
        find.descendant(
            of: dropdownFinder, matching: find.byIcon(Icons.arrow_drop_down)),
        findsOneWidget);
  });
}
