import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutstrap/flutstrap.dart';

void main() {
  group('FlutstrapCard - Rendering Tests', () {
    testWidgets('should render with header and body text',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
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
      expect(find.byType(Card), findsOneWidget);
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
        const MaterialApp(
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

    testWidgets(
        'should render dividers between sections when showDividers is true',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FlutstrapCard(
              headerText: 'Header',
              bodyText: 'Body',
              footerText: 'Footer',
              showDividers: true,
            ),
          ),
        ),
      );

      expect(find.byType(Divider), findsNWidgets(2));
    });

    testWidgets('should NOT render dividers when showDividers is false',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FlutstrapCard(
              headerText: 'Header',
              bodyText: 'Body',
              footerText: 'Footer',
              showDividers: false,
            ),
          ),
        ),
      );

      expect(find.byType(Divider), findsNothing);
    });
  });

  group('FlutstrapCard - Variant Tests', () {
    testWidgets('elevated variant should have elevation',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapCard(
              headerText: 'Title',
              bodyText: 'Content',
              variant: FSCardVariant.elevated,
            ),
          ),
        ),
      );

      final card = tester.widget<Card>(find.byType(Card));
      expect(card.elevation, greaterThan(0));
    });

    testWidgets('outlined variant should have border',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapCard(
              headerText: 'Title',
              bodyText: 'Content',
              variant: FSCardVariant.outlined,
            ),
          ),
        ),
      );

      final card = tester.widget<Card>(find.byType(Card));
      final shape = card.shape as RoundedRectangleBorder;
      expect(shape.side.width, greaterThan(0));
    });

    testWidgets('filled variant should render with custom background',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapCard(
              headerText: 'Title',
              bodyText: 'Content',
              variant: FSCardVariant.filled,
            ),
          ),
        ),
      );

      expect(find.text('Title'), findsOneWidget);
      expect(find.text('Content'), findsOneWidget);
    });
  });

  group('FlutstrapCard - Interactive Tests', () {
    testWidgets('should respond to tap when onTap is provided',
        (WidgetTester tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapCard(
              headerText: 'Title',
              bodyText: 'Content',
              onTap: () => tapped = true,
              interactive: true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(FlutstrapCard));
      await tester.pump();
      expect(tapped, true);
    });

    testWidgets('should respond to long press when onLongPress is provided',
        (WidgetTester tester) async {
      var longPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapCard(
              headerText: 'Title',
              bodyText: 'Content',
              onLongPress: () => longPressed = true,
              interactive: true,
            ),
          ),
        ),
      );

      await tester.longPress(find.byType(FlutstrapCard));
      await tester.pump();
      expect(longPressed, true);
    });

    testWidgets('should not respond to tap when interactive is false',
        (WidgetTester tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapCard(
              headerText: 'Title',
              bodyText: 'Content',
              onTap: () => tapped = true,
              interactive: false,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(FlutstrapCard));
      await tester.pump();
      expect(tapped, false);
    });
  });

  group('FlutstrapCard - Factory Methods', () {
    testWidgets('simple factory should create card with title and content',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapCard.simple(
              title: 'Simple Card',
              content: 'Simple content',
              footer: 'Footer text',
            ),
          ),
        ),
      );

      expect(find.text('Simple Card'), findsOneWidget);
      expect(find.text('Simple content'), findsOneWidget);
      expect(find.text('Footer text'), findsOneWidget);
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

    testWidgets('image factory should create card with image',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapCard.image(
              image: Container(
                height: 100,
                color: Colors.blue,
                child: const Center(child: Text('Image Content')),
              ),
              title: 'Image Card',
              content: 'Image description',
            ),
          ),
        ),
      );

      expect(find.text('Image Content'), findsOneWidget);
      expect(find.text('Image Card'), findsOneWidget);
      expect(find.text('Image description'), findsOneWidget);
    });

    testWidgets('interactive factory should create tappable card',
        (WidgetTester tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapCard.interactive(
              title: 'Interactive Card',
              content: 'Tap me!',
              onTap: () => tapped = true,
              trailing: const Icon(Icons.chevron_right),
            ),
          ),
        ),
      );

      expect(find.text('Interactive Card'), findsOneWidget);
      expect(find.text('Tap me!'), findsOneWidget);
      expect(find.byIcon(Icons.chevron_right), findsOneWidget);

      await tester.tap(find.byType(FlutstrapCard));
      await tester.pump();
      expect(tapped, true);
    });
  });

  group('FlutstrapCard - Builder Methods', () {
    test('withHeader should create card with new header', () {
      final card = FlutstrapCard(
        bodyText: 'Body content',
      );

      final headerCard = card.withHeader('New Header');
      expect(headerCard.headerText, 'New Header');
      expect(headerCard.bodyText, 'Body content');
    });

    test('withBody should create card with new body', () {
      final card = FlutstrapCard(
        headerText: 'Header',
      );

      final bodyCard = card.withBody('New Body');
      expect(bodyCard.headerText, 'Header');
      expect(bodyCard.bodyText, 'New Body');
    });

    test('withFooter should create card with new footer', () {
      final card = FlutstrapCard(
        headerText: 'Header',
        bodyText: 'Body',
      );

      final footerCard = card.withFooter('New Footer');
      expect(footerCard.headerText, 'Header');
      expect(footerCard.bodyText, 'Body');
      expect(footerCard.footerText, 'New Footer');
    });

    test('asOutlined should create outlined variant card', () {
      final card = FlutstrapCard(
        headerText: 'Header',
        bodyText: 'Body',
        variant: FSCardVariant.elevated,
      );

      final outlinedCard = card.asOutlined();
      expect(outlinedCard.variant, FSCardVariant.outlined);
    });

    test('asFilled should create filled variant card', () {
      final card = FlutstrapCard(
        headerText: 'Header',
        bodyText: 'Body',
        variant: FSCardVariant.elevated,
      );

      final filledCard = card.asFilled();
      expect(filledCard.variant, FSCardVariant.filled);
    });

    test('asElevated should create elevated variant card', () {
      final card = FlutstrapCard(
        headerText: 'Header',
        bodyText: 'Body',
        variant: FSCardVariant.outlined,
      );

      final elevatedCard = card.asElevated();
      expect(elevatedCard.variant, FSCardVariant.elevated);
    });

    test('withoutDividers should disable dividers', () {
      final card = FlutstrapCard(
        headerText: 'Header',
        bodyText: 'Body',
        footerText: 'Footer',
        showDividers: true,
      );

      final noDividersCard = card.withoutDividers();
      expect(noDividersCard.showDividers, false);
    });

    test('asInteractive should enable interactive mode', () {
      final card = FlutstrapCard(
        headerText: 'Header',
        bodyText: 'Body',
        interactive: false,
      );

      final interactiveCard = card.asInteractive();
      expect(interactiveCard.interactive, true);
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

  group('FlutstrapCard - Constructor Assertions', () {
    testWidgets(
        'should throw assertion when both header and headerText are provided',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapCard(
              header: const Text('Custom'),
              headerText: 'Text',
              bodyText: 'Body',
            ),
          ),
        ),
      );

      expect(tester.takeException(), isAssertionError);
    });

    testWidgets(
        'should throw assertion when both body and bodyText are provided',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapCard(
              headerText: 'Header',
              body: const Text('Custom Body'),
              bodyText: 'Body Text',
            ),
          ),
        ),
      );

      expect(tester.takeException(), isAssertionError);
    });

    testWidgets(
        'should throw assertion when both footer and footerText are provided',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapCard(
              headerText: 'Header',
              bodyText: 'Body',
              footer: const Text('Custom Footer'),
              footerText: 'Footer Text',
            ),
          ),
        ),
      );

      expect(tester.takeException(), isAssertionError);
    });
  });

  group('FlutstrapCard - Edge Cases', () {
    testWidgets('should handle empty card gracefully',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FlutstrapCard(),
          ),
        ),
      );

      expect(find.byType(SizedBox), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('should handle very long text without errors',
        (WidgetTester tester) async {
      final longText = 'A' * 1000;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 200,
              child: FlutstrapCard(
                headerText: 'Header',
                bodyText: longText,
              ),
            ),
          ),
        ),
      );

      expect(find.text('Header'), findsOneWidget);
      expect(find.textContaining('A' * 100), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('should handle null values safely',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FlutstrapCard(
              headerText: null,
              bodyText: 'Body',
              footerText: null,
            ),
          ),
        ),
      );

      expect(find.text('Body'), findsOneWidget);
      expect(find.byType(Divider), findsNothing);
    });
  });

  group('FlutstrapCard - Themed Factory', () {
    testWidgets('themed factory should use theme from context',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FSTheme(
            data: FSThemeData.light(),
            child: Builder(
              builder: (context) => Scaffold(
                body: FlutstrapCard.themed(
                  context: context,
                  headerText: 'Themed Card',
                  bodyText: 'Content',
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Themed Card'), findsOneWidget);
      expect(find.text('Content'), findsOneWidget);
    });
  });
}
