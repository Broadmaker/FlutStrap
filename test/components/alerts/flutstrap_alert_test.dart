import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:master_flutstrap/components/alerts/flutstrap_alert.dart';

void main() {
  group('FlutstrapAlert', () {
    testWidgets('should render message', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapAlert(
              message: 'Test alert message',
            ),
          ),
        ),
      );

      expect(find.text('Test alert message'), findsOneWidget);
    });

    testWidgets('should render title and message', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapAlert(
              title: 'Alert Title',
              message: 'Alert message',
            ),
          ),
        ),
      );

      expect(find.text('Alert Title'), findsOneWidget);
      expect(find.text('Alert message'), findsOneWidget);
    });

    testWidgets('should show icon by default', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapAlert(
              message: 'Test alert',
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.info_outlined), findsOneWidget);
    });

    testWidgets('should hide icon when showIcon is false',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapAlert(
              message: 'Test alert',
              showIcon: false,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.info_outlined), findsNothing);
    });

    testWidgets('should show custom leading widget',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapAlert(
              message: 'Test alert',
              leading: const Icon(Icons.star),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets('should show dismiss button when dismissible is true',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapAlert(
              message: 'Dismissible alert',
              dismissible: true,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.close), findsOneWidget);
    });

    testWidgets('should not show dismiss button when dismissible is false',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapAlert(
              message: 'Non-dismissible alert',
              dismissible: false,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.close), findsNothing);
    });

    testWidgets('should dismiss when close button is tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapAlert(
              message: 'Dismiss me',
              dismissible: true,
            ),
          ),
        ),
      );

      expect(find.text('Dismiss me'), findsOneWidget);

      // Tap the close button
      await tester.tap(find.byIcon(Icons.close));
      await tester.pump();

      expect(find.text('Dismiss me'), findsNothing);
    });

    testWidgets('should call onDismiss callback when dismissed',
        (WidgetTester tester) async {
      bool dismissed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapAlert(
              message: 'Test alert',
              dismissible: true,
              onDismiss: () {
                dismissed = true;
              },
            ),
          ),
        ),
      );

      // Tap the close button
      await tester.tap(find.byIcon(Icons.close));
      await tester.pump();

      expect(dismissed, true);
    });
  });

  group('FSAlertFactories', () {
    testWidgets('success should create success alert',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FSAlertFactories.success(
              message: 'Operation successful',
            ),
          ),
        ),
      );

      expect(find.text('Success'), findsOneWidget);
      expect(find.text('Operation successful'), findsOneWidget);
      expect(find.byIcon(Icons.check_circle_outlined), findsOneWidget);
    });

    testWidgets('error should create danger alert',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FSAlertFactories.error(
              message: 'Operation failed',
            ),
          ),
        ),
      );

      expect(find.text('Error'), findsOneWidget);
      expect(find.text('Operation failed'), findsOneWidget);
      expect(find.byIcon(Icons.error_outlined), findsOneWidget);
    });

    testWidgets('warning should create warning alert',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FSAlertFactories.warning(
              message: 'Please be careful',
            ),
          ),
        ),
      );

      expect(find.text('Warning'), findsOneWidget);
      expect(find.text('Please be careful'), findsOneWidget);
      expect(find.byIcon(Icons.warning_amber_outlined), findsOneWidget);
    });

    testWidgets('info should create info alert', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FSAlertFactories.info(
              message: 'Here is some information',
            ),
          ),
        ),
      );

      expect(find.text('Information'), findsOneWidget);
      expect(find.text('Here is some information'), findsOneWidget);
      expect(find.byIcon(Icons.info_outlined), findsOneWidget);
    });
  });
}
