import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:master_flutstrap/components/cards/flutstrap_card.dart';

void main() {
  group('FlutstrapCard', () {
    testWidgets('should render with header and body',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapCard(
              headerText: 'Card Title',
              bodyText: 'Card content goes here',
            ),
          ),
        ),
      );

      expect(find.text('Card Title'), findsOneWidget);
      expect(find.text('Card content goes here'), findsOneWidget);
    });

    testWidgets('should render with custom header widget',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapCard(
              header: const Row(
                children: [
                  Icon(Icons.star),
                  Text('Custom Header'),
                ],
              ),
              bodyText: 'Card content',
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(find.text('Custom Header'), findsOneWidget);
      expect(find.text('Card content'), findsOneWidget);
    });

    testWidgets('should render footer when provided',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapCard(
              headerText: 'Title',
              bodyText: 'Content',
              footerText: 'Footer text',
            ),
          ),
        ),
      );

      expect(find.text('Title'), findsOneWidget);
      expect(find.text('Content'), findsOneWidget);
      expect(find.text('Footer text'), findsOneWidget);
    });

    testWidgets('should render dividers between sections',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapCard(
              headerText: 'Header',
              bodyText: 'Body',
              footerText: 'Footer',
            ),
          ),
        ),
      );

      // Should have 2 dividers (between header-body and body-footer)
      expect(find.byType(Divider), findsNWidgets(2));
    });

    testWidgets('simple factory should create card with title and content',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapCard.simple(
              title: 'Simple Card',
              content: 'Simple content',
            ),
          ),
        ),
      );

      expect(find.text('Simple Card'), findsOneWidget);
      expect(find.text('Simple content'), findsOneWidget);
    });

    testWidgets('action factory should create card with actions',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapCard.action(
              title: 'Action Card',
              content: 'Action content',
              actions: [
                TextButton(
                  onPressed: () {},
                  child: const Text('Action 1'),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Action Card'), findsOneWidget);
      expect(find.text('Action content'), findsOneWidget);
      expect(find.text('Action 1'), findsOneWidget);
    });
  });

  group('FlutstrapCard Builder Methods', () {
    test('withHeader should create card with header', () {
      final card = FlutstrapCard(
        bodyText: 'Body content',
      );

      final headerCard = card.withHeader('New Header');
      expect(headerCard.headerText, 'New Header');
      expect(headerCard.bodyText, 'Body content');
    });

    test('withBody should create card with body', () {
      final card = FlutstrapCard(
        headerText: 'Header',
      );

      final bodyCard = card.withBody('New Body');
      expect(bodyCard.headerText, 'Header');
      expect(bodyCard.bodyText, 'New Body');
    });

    test('withFooter should create card with footer', () {
      final card = FlutstrapCard(
        headerText: 'Header',
        bodyText: 'Body',
      );

      final footerCard = card.withFooter('New Footer');
      expect(footerCard.headerText, 'Header');
      expect(footerCard.bodyText, 'Body');
      expect(footerCard.footerText, 'New Footer');
    });

    test('outlinedCard should create outlined card', () {
      final card = FlutstrapCard(
        headerText: 'Header',
        bodyText: 'Body',
      );

      final outlinedCard = card.outlinedCard();
      expect(outlinedCard.outlined, true);
    });

    test('withPadding should create card with custom padding', () {
      final card = FlutstrapCard(
        headerText: 'Header',
      );

      final customPaddingCard = card.withPadding(const EdgeInsets.all(20));
      expect(customPaddingCard.padding, const EdgeInsets.all(20));
    });

    test('withBackground should create card with custom background', () {
      final card = FlutstrapCard(
        headerText: 'Header',
      );

      final backgroundCard = card.withBackground(Colors.blue);
      expect(backgroundCard.backgroundColor, Colors.blue);
    });
  });
}
