import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:master_flutstrap/components/modals/flutstrap_modal.dart';

void main() {
  group('FlutstrapModal', () {
    testWidgets('should render with title and content',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapModal(
                title: Text('Test Title'),
                content: Text('Test Content'),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Test Title'), findsOneWidget);
      expect(find.text('Test Content'), findsOneWidget);
    });

    testWidgets('should show close button when enabled',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapModal(
                title: Text('Test'),
                content: Text('Content'),
                showCloseButton: true,
              ),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.close), findsOneWidget);
    });

    testWidgets('should not show close button when disabled',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapModal(
                title: Text('Test'),
                content: Text('Content'),
                showCloseButton: false,
              ),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.close), findsNothing);
    });

    testWidgets('should render without title', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapModal(
                content: Text('Content Only'),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Content Only'), findsOneWidget);
    });

    testWidgets('should render actions', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapModal(
                title: Text('Test'),
                content: Text('Content'),
                actions: [
                  TextButton(
                    onPressed: () {},
                    child: Text('Cancel'),
                  ),
                  FilledButton(
                    onPressed: () {},
                    child: Text('Save'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.text('Cancel'), findsOneWidget);
      expect(find.text('Save'), findsOneWidget);
    });

    testWidgets('should apply different sizes', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: FlutstrapModal(
                title: Text('Small Modal'),
                content: Text('Content'),
                size: FSModalSize.sm,
              ),
            ),
          ),
        ),
      );

      expect(find.text('Small Modal'), findsOneWidget);
    });
  });

  group('FlutstrapModalService', () {
    testWidgets('showModal should display modal with title and content',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => TextButton(
                onPressed: () => FlutstrapModalService.showModal(
                  context: context,
                  title: 'Service Modal',
                  content: 'Service Content',
                ),
                child: Text('Open Modal'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open Modal'));
      await tester.pumpAndSettle();

      expect(find.text('Service Modal'), findsOneWidget);
      expect(find.text('Service Content'), findsOneWidget);
    });

    testWidgets('showConfirmModal should return true when confirmed',
        (WidgetTester tester) async {
      bool? result;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => TextButton(
                onPressed: () async {
                  result = await FlutstrapModalService.showConfirmModal(
                    context: context,
                    title: 'Confirm Test',
                    content: 'Are you sure?',
                    confirmText: 'Yes, Confirm', // Use unique text
                    cancelText: 'No, Cancel', // Use unique text
                  );
                },
                child: Text('Open Confirm'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open Confirm'));
      await tester.pumpAndSettle();

      // Use the unique confirm button text
      await tester.tap(find.text('Yes, Confirm'));
      await tester.pumpAndSettle();

      expect(result, true);
    });

    testWidgets('showConfirmModal should return false when cancelled',
        (WidgetTester tester) async {
      bool? result;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => TextButton(
                onPressed: () async {
                  result = await FlutstrapModalService.showConfirmModal(
                    context: context,
                    title: 'Confirm Test',
                    content: 'Are you sure?',
                    confirmText: 'Yes, Confirm', // Use unique text
                    cancelText: 'No, Cancel', // Use unique text
                  );
                },
                child: Text('Open Confirm'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open Confirm'));
      await tester.pumpAndSettle();

      // Use the unique cancel button text
      await tester.tap(find.text('No, Cancel'));
      await tester.pumpAndSettle();

      expect(result, false);
    });

    testWidgets('showAlert should display warning modal',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => TextButton(
                onPressed: () => FlutstrapModalService.showAlert(
                  context: context,
                  title: 'Warning Alert',
                  content: 'This is a warning!',
                ),
                child: Text('Open Alert'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open Alert'));
      await tester.pumpAndSettle();

      expect(find.text('Warning Alert'), findsOneWidget);
      expect(find.text('This is a warning!'), findsOneWidget);
      expect(find.text('OK'), findsOneWidget);
    });

    testWidgets('showSuccess should display success modal',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => TextButton(
                onPressed: () => FlutstrapModalService.showSuccess(
                  context: context,
                  title: 'Success Title',
                  content: 'Operation completed!',
                ),
                child: Text('Open Success'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open Success'));
      await tester.pumpAndSettle();

      expect(find.text('Success Title'), findsOneWidget);
      expect(find.text('Operation completed!'), findsOneWidget);
    });

    testWidgets('showError should display error modal',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => TextButton(
                onPressed: () => FlutstrapModalService.showError(
                  context: context,
                  title: 'Error Title',
                  content: 'Something went wrong!',
                ),
                child: Text('Open Error'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open Error'));
      await tester.pumpAndSettle();

      expect(find.text('Error Title'), findsOneWidget);
      expect(find.text('Something went wrong!'), findsOneWidget);
    });

    testWidgets('showCustomModal should display custom content',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => TextButton(
                onPressed: () => FlutstrapModalService.showCustomModal(
                  context: context,
                  title: Text('Custom Modal'),
                  content: Column(
                    children: [
                      Text('Custom content line 1'),
                      Text('Custom content line 2'),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Custom Close'),
                    ),
                  ],
                ),
                child: Text('Open Custom'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open Custom'));
      await tester.pumpAndSettle();

      expect(find.text('Custom Modal'), findsOneWidget);
      expect(find.text('Custom content line 1'), findsOneWidget);
      expect(find.text('Custom content line 2'), findsOneWidget);
      expect(find.text('Custom Close'), findsOneWidget);
    });
  });

  group('FlutstrapModalTrigger', () {
    testWidgets('should open modal when tapped', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapModalTrigger(
              modalTitle: Text('Trigger Modal Title'),
              modalContent: Text('Trigger Modal Content'),
              child: Container(
                padding: EdgeInsets.all(16),
                child: Text('Tap Me'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Tap Me'));
      await tester.pumpAndSettle();

      expect(find.text('Trigger Modal Title'), findsOneWidget);
      expect(find.text('Trigger Modal Content'), findsOneWidget);
    });
  });
}
