import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:master_flutstrap/components/navbars/flutstrap_navbar.dart';

// Custom finder that works with generic types
Finder findFlutstrapNavbar() {
  return find.byWidgetPredicate(
    (widget) => widget is FlutstrapNavbar,
  );
}

void main() {
  // Set up a desktop screen size for all tests
  void setDesktopScreen(WidgetTester tester) {
    tester.binding.window.physicalSizeTestValue = const Size(1200, 800);
    tester.binding.window.devicePixelRatioTestValue = 1.0;
  }

  void clearScreenSize(WidgetTester tester) {
    tester.binding.window.clearPhysicalSizeTestValue();
  }

  group('FlutstrapNavbar Basic Tests', () {
    final sampleItems = [
      FSNavbarItem(label: 'Home', onTap: () {}),
      FSNavbarItem(label: 'About', onTap: () {}),
      FSNavbarItem(label: 'Contact', onTap: () {}),
    ];

    testWidgets('should render with basic properties',
        (WidgetTester tester) async {
      setDesktopScreen(tester);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapNavbar(
              brandText: 'My App',
              items: sampleItems,
            ),
          ),
        ),
      );

      expect(find.text('My App'), findsOneWidget);

      // On desktop, items should be visible
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('About'), findsOneWidget);
      expect(find.text('Contact'), findsOneWidget);
      expect(findFlutstrapNavbar(), findsOneWidget);

      clearScreenSize(tester);
    });

    testWidgets('should render with custom brand widget',
        (WidgetTester tester) async {
      setDesktopScreen(tester);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapNavbar(
              brand: Row(
                children: [
                  Icon(Icons.star),
                  SizedBox(width: 8),
                  Text('Custom Brand'),
                ],
              ),
              items: sampleItems,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(find.text('Custom Brand'), findsOneWidget);
      expect(findFlutstrapNavbar(), findsOneWidget);

      clearScreenSize(tester);
    });

    testWidgets('should render with brand image', (WidgetTester tester) async {
      setDesktopScreen(tester);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapNavbar(
              brandText: 'My App',
              brandImage: Icon(Icons.account_circle),
              items: sampleItems,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.account_circle), findsOneWidget);
      expect(find.text('My App'), findsOneWidget);
      expect(findFlutstrapNavbar(), findsOneWidget);

      clearScreenSize(tester);
    });

    testWidgets('should render with search bar when showSearch is true',
        (WidgetTester tester) async {
      setDesktopScreen(tester);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapNavbar(
              brandText: 'My App',
              items: sampleItems,
              showSearch: true,
              searchPlaceholder: 'Search...',
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.text('Search...'), findsOneWidget);
      expect(findFlutstrapNavbar(), findsOneWidget);

      clearScreenSize(tester);
    });

    testWidgets('should render with custom items', (WidgetTester tester) async {
      setDesktopScreen(tester);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapNavbar(
              brandText: 'My App',
              items: sampleItems,
              customItems: [
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.notifications),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.settings), findsOneWidget);
      expect(find.byIcon(Icons.notifications), findsOneWidget);
      expect(findFlutstrapNavbar(), findsOneWidget);

      clearScreenSize(tester);
    });

    testWidgets('should render with active item', (WidgetTester tester) async {
      setDesktopScreen(tester);

      final itemsWithActive = [
        FSNavbarItem(label: 'Home', onTap: () {}, isActive: true),
        FSNavbarItem(label: 'About', onTap: () {}),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapNavbar(
              brandText: 'My App',
              items: itemsWithActive,
            ),
          ),
        ),
      );

      expect(find.text('Home'), findsOneWidget);
      expect(find.text('About'), findsOneWidget);
      expect(findFlutstrapNavbar(), findsOneWidget);

      clearScreenSize(tester);
    });

    testWidgets('should render with disabled item',
        (WidgetTester tester) async {
      setDesktopScreen(tester);

      final itemsWithDisabled = [
        FSNavbarItem(label: 'Home', onTap: () {}),
        FSNavbarItem(label: 'About', onTap: () {}, enabled: false),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapNavbar(
              brandText: 'My App',
              items: itemsWithDisabled,
            ),
          ),
        ),
      );

      expect(find.text('Home'), findsOneWidget);
      expect(find.text('About'), findsOneWidget);
      expect(findFlutstrapNavbar(), findsOneWidget);

      clearScreenSize(tester);
    });

    testWidgets('should render with items containing icons',
        (WidgetTester tester) async {
      setDesktopScreen(tester);

      final itemsWithIcons = [
        FSNavbarItem(
          label: 'Home',
          onTap: () {},
          icon: Icon(Icons.home),
        ),
        FSNavbarItem(
          label: 'Settings',
          onTap: () {},
          icon: Icon(Icons.settings),
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapNavbar(
              brandText: 'My App',
              items: itemsWithIcons,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.home), findsOneWidget);
      expect(find.byIcon(Icons.settings), findsOneWidget);
      expect(findFlutstrapNavbar(), findsOneWidget);

      clearScreenSize(tester);
    });
  });

  group('FSNavbarItem Tests', () {
    test('should create simple item with required properties', () {
      final item = FSNavbarItem.simple(
        label: 'Test Item',
        onTap: () {},
      );

      expect(item.label, 'Test Item');
      expect(item.onTap, isNotNull);
      expect(item.icon, isNull);
      expect(item.children, isNull);
      expect(item.isActive, false);
      expect(item.enabled, true);
    });

    test('should create dropdown item with children', () {
      final children = [
        FSNavbarItem(label: 'Child 1', onTap: () {}),
        FSNavbarItem(label: 'Child 2', onTap: () {}),
      ];

      final item = FSNavbarItem.dropdown(
        label: 'Dropdown',
        children: children,
      );

      expect(item.label, 'Dropdown');
      expect(item.onTap, isNull);
      expect(item.children, children);
      expect(item.isActive, false);
      expect(item.enabled, true);
    });

    test('should create item with all properties', () {
      final item = FSNavbarItem(
        label: 'Test Item',
        onTap: () {},
        icon: Icon(Icons.star),
        isActive: true,
        enabled: false,
      );

      expect(item.label, 'Test Item');
      expect(item.onTap, isNotNull);
      expect(item.icon, isNotNull);
      expect(item.isActive, true);
      expect(item.enabled, false);
    });
  });

  group('FlutstrapNavbar Variants', () {
    final sampleItems = [
      FSNavbarItem(label: 'Home', onTap: () {}),
    ];

    testWidgets('should render light variant', (WidgetTester tester) async {
      setDesktopScreen(tester);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapNavbar(
              brandText: 'My App',
              items: sampleItems,
              variant: FSNavbarVariant.light,
            ),
          ),
        ),
      );

      expect(findFlutstrapNavbar(), findsOneWidget);
      clearScreenSize(tester);
    });

    testWidgets('should render dark variant', (WidgetTester tester) async {
      setDesktopScreen(tester);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapNavbar(
              brandText: 'My App',
              items: sampleItems,
              variant: FSNavbarVariant.dark,
            ),
          ),
        ),
      );

      expect(findFlutstrapNavbar(), findsOneWidget);
      clearScreenSize(tester);
    });

    testWidgets('should render primary variant', (WidgetTester tester) async {
      setDesktopScreen(tester);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapNavbar(
              brandText: 'My App',
              items: sampleItems,
              variant: FSNavbarVariant.primary,
            ),
          ),
        ),
      );

      expect(findFlutstrapNavbar(), findsOneWidget);
      clearScreenSize(tester);
    });

    testWidgets('should render secondary variant', (WidgetTester tester) async {
      setDesktopScreen(tester);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapNavbar(
              brandText: 'My App',
              items: sampleItems,
              variant: FSNavbarVariant.secondary,
            ),
          ),
        ),
      );

      expect(findFlutstrapNavbar(), findsOneWidget);
      clearScreenSize(tester);
    });

    testWidgets('should render success variant', (WidgetTester tester) async {
      setDesktopScreen(tester);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapNavbar(
              brandText: 'My App',
              items: sampleItems,
              variant: FSNavbarVariant.success,
            ),
          ),
        ),
      );

      expect(findFlutstrapNavbar(), findsOneWidget);
      clearScreenSize(tester);
    });

    testWidgets('should render danger variant', (WidgetTester tester) async {
      setDesktopScreen(tester);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapNavbar(
              brandText: 'My App',
              items: sampleItems,
              variant: FSNavbarVariant.danger,
            ),
          ),
        ),
      );

      expect(findFlutstrapNavbar(), findsOneWidget);
      clearScreenSize(tester);
    });

    testWidgets('should render warning variant', (WidgetTester tester) async {
      setDesktopScreen(tester);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapNavbar(
              brandText: 'My App',
              items: sampleItems,
              variant: FSNavbarVariant.warning,
            ),
          ),
        ),
      );

      expect(findFlutstrapNavbar(), findsOneWidget);
      clearScreenSize(tester);
    });

    testWidgets('should render info variant', (WidgetTester tester) async {
      setDesktopScreen(tester);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapNavbar(
              brandText: 'My App',
              items: sampleItems,
              variant: FSNavbarVariant.info,
            ),
          ),
        ),
      );

      expect(findFlutstrapNavbar(), findsOneWidget);
      clearScreenSize(tester);
    });
  });

  group('FlutstrapNavbar Edge Cases', () {
    testWidgets('should handle empty items list', (WidgetTester tester) async {
      setDesktopScreen(tester);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapNavbar(
              brandText: 'My App',
              items: [],
            ),
          ),
        ),
      );

      expect(find.text('My App'), findsOneWidget);
      expect(findFlutstrapNavbar(), findsOneWidget);
      clearScreenSize(tester);
    });

    testWidgets('should handle items with same labels',
        (WidgetTester tester) async {
      setDesktopScreen(tester);

      final itemsWithSameLabels = [
        FSNavbarItem(label: 'Duplicate', onTap: () {}),
        FSNavbarItem(label: 'Duplicate', onTap: () {}),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapNavbar(
              brandText: 'My App',
              items: itemsWithSameLabels,
            ),
          ),
        ),
      );

      expect(find.text('Duplicate'), findsNWidgets(2));
      expect(findFlutstrapNavbar(), findsOneWidget);
      clearScreenSize(tester);
    });

    testWidgets('should handle very long brand text',
        (WidgetTester tester) async {
      setDesktopScreen(tester);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapNavbar(
              brandText: 'Very Long Brand Name That Might Wrap',
              items: [FSNavbarItem(label: 'Home', onTap: () {})],
            ),
          ),
        ),
      );

      expect(find.text('Very Long Brand Name That Might Wrap'), findsOneWidget);
      expect(findFlutstrapNavbar(), findsOneWidget);
      clearScreenSize(tester);
    });
  });

  group('FlutstrapNavbar Property Tests', () {
    test('should have correct default variant', () {
      final navbar = FlutstrapNavbar(
        items: [FSNavbarItem(label: 'Home', onTap: () {})],
      );

      expect(navbar.variant, FSNavbarVariant.light);
    });

    test('should have correct default position', () {
      final navbar = FlutstrapNavbar(
        items: [FSNavbarItem(label: 'Home', onTap: () {})],
      );

      expect(navbar.position, FSNavbarPosition.static);
    });

    test('should have search disabled by default', () {
      final navbar = FlutstrapNavbar(
        items: [FSNavbarItem(label: 'Home', onTap: () {})],
      );

      expect(navbar.showSearch, false);
    });

    test('should have expand disabled by default', () {
      final navbar = FlutstrapNavbar(
        items: [FSNavbarItem(label: 'Home', onTap: () {})],
      );

      expect(navbar.expand, false);
    });

    test('should have fluid disabled by default', () {
      final navbar = FlutstrapNavbar(
        items: [FSNavbarItem(label: 'Home', onTap: () {})],
      );

      expect(navbar.fluid, false);
    });

    test('should have correct default elevation', () {
      final navbar = FlutstrapNavbar(
        items: [FSNavbarItem(label: 'Home', onTap: () {})],
      );

      expect(navbar.elevation, 0);
    });
  });

  group('FlutstrapNavbar Mobile Behavior', () {
    testWidgets('should show mobile menu button on small screens',
        (WidgetTester tester) async {
      // Set a small screen size
      tester.binding.window.physicalSizeTestValue = const Size(400, 800);
      tester.binding.window.devicePixelRatioTestValue = 1.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapNavbar(
              brandText: 'My App',
              items: [
                FSNavbarItem(label: 'Home', onTap: () {}),
                FSNavbarItem(label: 'About', onTap: () {}),
              ],
            ),
          ),
        ),
      );

      // Should show mobile menu button (hamburger icon)
      expect(find.byIcon(Icons.menu), findsOneWidget);

      // On mobile, nav items should not be visible in desktop view
      expect(find.text('Home'), findsNothing);
      expect(find.text('About'), findsNothing);

      expect(findFlutstrapNavbar(), findsOneWidget);

      // Reset window size
      tester.binding.window.clearPhysicalSizeTestValue();
    });

    testWidgets('should toggle mobile menu when menu button is tapped',
        (WidgetTester tester) async {
      // Set a small screen size
      tester.binding.window.physicalSizeTestValue = const Size(400, 800);
      tester.binding.window.devicePixelRatioTestValue = 1.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutstrapNavbar(
              brandText: 'My App',
              items: [
                FSNavbarItem(label: 'Home', onTap: () {}),
                FSNavbarItem(label: 'About', onTap: () {}),
              ],
            ),
          ),
        ),
      );

      // Tap the mobile menu button
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pump();

      // Should show close icon after tap
      expect(find.byIcon(Icons.close), findsOneWidget);

      // Mobile menu should now show the items
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('About'), findsOneWidget);

      expect(findFlutstrapNavbar(), findsOneWidget);

      // Reset window size
      tester.binding.window.clearPhysicalSizeTestValue();
    });
  });

  // Simple interaction test
  testWidgets('should respond to item tap without error',
      (WidgetTester tester) async {
    setDesktopScreen(tester);

    bool wasTapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FlutstrapNavbar(
            brandText: 'My App',
            items: [
              FSNavbarItem(
                label: 'Test Item',
                onTap: () {
                  wasTapped = true;
                },
              ),
            ],
          ),
        ),
      ),
    );

    // Tap on the navbar item
    await tester.tap(find.text('Test Item'));
    await tester.pump();

    expect(wasTapped, true);
    expect(findFlutstrapNavbar(), findsOneWidget);

    clearScreenSize(tester);
  });
}
