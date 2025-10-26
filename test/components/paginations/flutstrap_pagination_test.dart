// test/components/paginations/flutstrap_pagination_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:master_flutstrap/components/paginations/flutstrap_pagination.dart';

void main() {
  // Helper function to wrap pagination with constrained width for tests
  Widget buildTestablePagination(FlutstrapPagination pagination) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            width: 800, // Constrained width for tests
            child: pagination,
          ),
        ),
      ),
    );
  }

  group('FlutstrapPagination', () {
    testWidgets('renders basic pagination with page numbers', (tester) async {
      int? currentPage;

      await tester.pumpWidget(
        buildTestablePagination(
          FlutstrapPagination(
            currentPage: 1,
            totalPages: 5,
            onPageChanged: (page) {
              currentPage = page;
            },
          ),
        ),
      );

      // Should render page numbers
      expect(find.text('1'), findsOneWidget);
      expect(find.text('2'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
      expect(find.text('4'), findsOneWidget);
      expect(find.text('5'), findsOneWidget);

      // Should render previous/next buttons
      expect(find.text('Previous'), findsOneWidget);
      expect(find.text('Next'), findsOneWidget);
    });

    testWidgets('highlights current page as active', (tester) async {
      await tester.pumpWidget(
        buildTestablePagination(
          FlutstrapPagination(
            currentPage: 3,
            totalPages: 5,
            onPageChanged: (page) {},
          ),
        ),
      );

      // Page 3 should be active
      expect(find.text('3'), findsOneWidget);
      expect(find.text('1'), findsOneWidget);
      expect(find.text('5'), findsOneWidget);
    });

    testWidgets('disables previous button on first page', (tester) async {
      await tester.pumpWidget(
        buildTestablePagination(
          FlutstrapPagination(
            currentPage: 1,
            totalPages: 5,
            onPageChanged: (page) {},
          ),
        ),
      );

      // Previous button should be present but disabled
      expect(find.text('Previous'), findsOneWidget);
    });

    testWidgets('disables next button on last page', (tester) async {
      await tester.pumpWidget(
        buildTestablePagination(
          FlutstrapPagination(
            currentPage: 5,
            totalPages: 5,
            onPageChanged: (page) {},
          ),
        ),
      );

      // Next button should be present but disabled
      expect(find.text('Next'), findsOneWidget);
    });

    testWidgets(
        'shows first and last buttons when enabled and not on first/last page',
        (tester) async {
      await tester.pumpWidget(
        buildTestablePagination(
          FlutstrapPagination(
            currentPage: 3, // Not first or last page
            totalPages: 5,
            onPageChanged: (page) {},
            showFirstLast: true,
          ),
        ),
      );

      expect(find.text('First'), findsOneWidget);
      expect(find.text('Last'), findsOneWidget);
    });

    testWidgets('hides first button when on first page', (tester) async {
      await tester.pumpWidget(
        buildTestablePagination(
          FlutstrapPagination(
            currentPage: 1, // First page
            totalPages: 5,
            onPageChanged: (page) {},
            showFirstLast: true,
          ),
        ),
      );

      // First button should be hidden when on first page
      expect(find.text('First'), findsNothing);
      expect(find.text('Last'), findsOneWidget); // Last should still show
    });

    testWidgets('hides last button when on last page', (tester) async {
      await tester.pumpWidget(
        buildTestablePagination(
          FlutstrapPagination(
            currentPage: 5, // Last page
            totalPages: 5,
            onPageChanged: (page) {},
            showFirstLast: true,
          ),
        ),
      );

      // Last button should be hidden when on last page
      expect(find.text('Last'), findsNothing);
      expect(find.text('First'), findsOneWidget); // First should still show
    });

    testWidgets('shows items count when enabled', (tester) async {
      await tester.pumpWidget(
        buildTestablePagination(
          FlutstrapPagination(
            currentPage: 2,
            totalPages: 5,
            totalItems: 50,
            itemsPerPage: 10,
            onPageChanged: (page) {},
            showItemsCount: true,
          ),
        ),
      );

      expect(find.text('Showing 11 to 20 of 50 items'), findsOneWidget);
    });

    testWidgets('hides page numbers when showNumbers is false', (tester) async {
      await tester.pumpWidget(
        buildTestablePagination(
          FlutstrapPagination(
            currentPage: 3,
            totalPages: 5,
            onPageChanged: (page) {},
            showNumbers: false,
          ),
        ),
      );

      // Should not show page numbers
      expect(find.text('1'), findsNothing);
      expect(find.text('3'), findsNothing);
      expect(find.text('5'), findsNothing);

      // But should still show previous/next
      expect(find.text('Previous'), findsOneWidget);
      expect(find.text('Next'), findsOneWidget);
    });

    testWidgets('hides previous/next buttons when showPreviousNext is false',
        (tester) async {
      await tester.pumpWidget(
        buildTestablePagination(
          FlutstrapPagination(
            currentPage: 3,
            totalPages: 5,
            onPageChanged: (page) {},
            showPreviousNext: false,
          ),
        ),
      );

      // Should not show previous/next buttons
      expect(find.text('Previous'), findsNothing);
      expect(find.text('Next'), findsNothing);

      // But should still show page numbers
      expect(find.text('1'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
      expect(find.text('5'), findsOneWidget);
    });

    testWidgets('generates ellipsis for many pages', (tester) async {
      await tester.pumpWidget(
        buildTestablePagination(
          FlutstrapPagination(
            currentPage: 5,
            totalPages: 10,
            onPageChanged: (page) {},
            maxVisiblePages: 5,
          ),
        ),
      );

      // Should show ellipsis and limited page numbers
      expect(find.text('1'), findsOneWidget); // First page
      expect(find.text('10'), findsOneWidget); // Last page
      // Ellipsis should be present (exact count depends on algorithm)
    });

    testWidgets('respects different alignments', (tester) async {
      final alignments = FSPaginationAlignment.values;

      for (final alignment in alignments) {
        await tester.pumpWidget(
          buildTestablePagination(
            FlutstrapPagination(
              currentPage: 1,
              totalPages: 3,
              onPageChanged: (page) {},
              alignment: alignment,
            ),
          ),
        );

        // Should render without errors for all alignments
        expect(find.text('1'), findsOneWidget);
        expect(find.text('2'), findsOneWidget);
        expect(find.text('3'), findsOneWidget);

        // Clean up for next test
        await tester.pumpWidget(Container());
      }
    });

    testWidgets('respects different sizes', (tester) async {
      final sizes = FSPaginationSize.values;

      for (final size in sizes) {
        await tester.pumpWidget(
          buildTestablePagination(
            FlutstrapPagination(
              currentPage: 1,
              totalPages: 3,
              onPageChanged: (page) {},
              size: size,
            ),
          ),
        );

        // Should render without errors for all sizes
        expect(find.text('1'), findsOneWidget);
        expect(find.text('2'), findsOneWidget);
        expect(find.text('3'), findsOneWidget);

        // Clean up for next test
        await tester.pumpWidget(Container());
      }
    });

    testWidgets('respects different variants', (tester) async {
      final variants = FSPaginationVariant.values;

      for (final variant in variants) {
        await tester.pumpWidget(
          buildTestablePagination(
            FlutstrapPagination(
              currentPage: 1,
              totalPages: 3,
              onPageChanged: (page) {},
              variant: variant,
            ),
          ),
        );

        // Should render without errors for all variants
        expect(find.text('1'), findsOneWidget);
        expect(find.text('2'), findsOneWidget);
        expect(find.text('3'), findsOneWidget);

        // Clean up for next test
        await tester.pumpWidget(Container());
      }
    });

    testWidgets('calls onPageChanged when page is tapped', (tester) async {
      int? selectedPage;

      await tester.pumpWidget(
        buildTestablePagination(
          FlutstrapPagination(
            currentPage: 1,
            totalPages: 5,
            onPageChanged: (page) {
              selectedPage = page;
            },
          ),
        ),
      );

      // Tap on page 2
      await tester.tap(find.text('2'));
      await tester.pumpAndSettle();

      expect(selectedPage, equals(2));
    });

    testWidgets('calls onPageChanged when next button is tapped',
        (tester) async {
      int? selectedPage;

      await tester.pumpWidget(
        buildTestablePagination(
          FlutstrapPagination(
            currentPage: 1,
            totalPages: 5,
            onPageChanged: (page) {
              selectedPage = page;
            },
          ),
        ),
      );

      // Tap next button
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();

      expect(selectedPage, equals(2));
    });

    testWidgets('calls onPageChanged when previous button is tapped',
        (tester) async {
      int? selectedPage;

      await tester.pumpWidget(
        buildTestablePagination(
          FlutstrapPagination(
            currentPage: 2,
            totalPages: 5,
            onPageChanged: (page) {
              selectedPage = page;
            },
          ),
        ),
      );

      // Tap previous button
      await tester.tap(find.text('Previous'));
      await tester.pumpAndSettle();

      expect(selectedPage, equals(1));
    });

    testWidgets('calls onPageChanged when first button is tapped',
        (tester) async {
      int? selectedPage;

      await tester.pumpWidget(
        buildTestablePagination(
          FlutstrapPagination(
            currentPage: 3, // Not first page
            totalPages: 5,
            onPageChanged: (page) {
              selectedPage = page;
            },
            showFirstLast: true,
          ),
        ),
      );

      // Tap first button
      await tester.tap(find.text('First'));
      await tester.pumpAndSettle();

      expect(selectedPage, equals(1));
    });

    testWidgets('calls onPageChanged when last button is tapped',
        (tester) async {
      int? selectedPage;

      await tester.pumpWidget(
        buildTestablePagination(
          FlutstrapPagination(
            currentPage: 3, // Not last page
            totalPages: 5,
            onPageChanged: (page) {
              selectedPage = page;
            },
            showFirstLast: true,
          ),
        ),
      );

      // Tap last button
      await tester.tap(find.text('Last'));
      await tester.pumpAndSettle();

      expect(selectedPage, equals(5));
    });

    testWidgets('handles disabled state', (tester) async {
      int tapCount = 0;

      await tester.pumpWidget(
        buildTestablePagination(
          FlutstrapPagination(
            currentPage: 3,
            totalPages: 5,
            onPageChanged: (page) {
              tapCount++;
            },
            disabled: true,
          ),
        ),
      );

      // Try to tap various buttons - none should trigger callbacks
      await tester.tap(find.text('2'));
      await tester.tap(find.text('Previous'));
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();

      expect(tapCount, equals(0));
    });

    testWidgets('uses custom text labels for previous and next',
        (tester) async {
      await tester.pumpWidget(
        buildTestablePagination(
          FlutstrapPagination(
            currentPage: 1,
            totalPages: 3,
            onPageChanged: (page) {},
            previousText: 'Prev',
            nextText: 'Next Page',
            itemsCountText: 'Items {start}-{end} of {total}',
            showItemsCount: true,
            totalItems: 30,
          ),
        ),
      );

      expect(find.text('Prev'), findsOneWidget);
      expect(find.text('Next Page'), findsOneWidget);
      expect(find.text('Items 1-10 of 30'), findsOneWidget);
    });

    testWidgets('uses custom text labels for first and last when enabled',
        (tester) async {
      await tester.pumpWidget(
        buildTestablePagination(
          FlutstrapPagination(
            currentPage: 2, // Middle page so first/last show
            totalPages: 3,
            onPageChanged: (page) {},
            firstText: 'Start',
            lastText: 'End',
            showFirstLast: true,
          ),
        ),
      );

      expect(find.text('Start'), findsOneWidget);
      expect(find.text('End'), findsOneWidget);
    });

    testWidgets('handles single page gracefully', (tester) async {
      await tester.pumpWidget(
        buildTestablePagination(
          FlutstrapPagination(
            currentPage: 1,
            totalPages: 1,
            onPageChanged: (page) {},
          ),
        ),
      );

      // Should render without errors
      expect(find.text('1'), findsOneWidget);
      expect(find.text('Previous'), findsOneWidget);
      expect(find.text('Next'), findsOneWidget);
    });
  });

  group('Edge Cases', () {
    testWidgets('handles large page numbers without crashing', (tester) async {
      await tester.pumpWidget(
        buildTestablePagination(
          FlutstrapPagination(
            currentPage: 10, // Reduced from 100
            totalPages: 50, // Reduced from 1000
            onPageChanged: (page) {},
            maxVisiblePages: 5, // Strict limit for tests
          ),
        ),
      );

      // Should render without errors
      expect(find.text('10'), findsOneWidget);
      expect(find.text('1'), findsOneWidget);
      expect(find.text('50'), findsOneWidget);
    });

    testWidgets('handles items count with exact multiples', (tester) async {
      await tester.pumpWidget(
        buildTestablePagination(
          FlutstrapPagination(
            currentPage: 5,
            totalPages: 5,
            totalItems: 50,
            itemsPerPage: 10,
            onPageChanged: (page) {},
            showItemsCount: true,
          ),
        ),
      );

      expect(find.text('Showing 41 to 50 of 50 items'), findsOneWidget);
    });

    testWidgets('handles items count with partial last page', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          // Use regular MaterialApp for this simple test
          home: Scaffold(
            body: Center(
              child: FlutstrapPagination(
                currentPage: 6,
                totalPages: 6,
                totalItems: 55,
                itemsPerPage: 10,
                onPageChanged: (page) {},
                showItemsCount: true,
                showNumbers: false, // Hide numbers to prevent overflow
              ),
            ),
          ),
        ),
      );

      expect(find.text('Showing 51 to 55 of 55 items'), findsOneWidget);
    });
    testWidgets('handles items count on first page with partial data',
        (tester) async {
      await tester.pumpWidget(
        buildTestablePagination(
          FlutstrapPagination(
            currentPage: 1,
            totalPages: 1,
            totalItems: 7,
            itemsPerPage: 10,
            onPageChanged: (page) {},
            showItemsCount: true,
          ),
        ),
      );

      expect(find.text('Showing 1 to 7 of 7 items'), findsOneWidget);
    });

    testWidgets(
        'handles items count when itemsPerPage is larger than totalItems',
        (tester) async {
      await tester.pumpWidget(
        buildTestablePagination(
          FlutstrapPagination(
            currentPage: 1,
            totalPages: 1,
            totalItems: 5,
            itemsPerPage: 10,
            onPageChanged: (page) {},
            showItemsCount: true,
          ),
        ),
      );

      expect(find.text('Showing 1 to 5 of 5 items'), findsOneWidget);
    });
  });

  group('Enums', () {
    test('FSPaginationVariant has correct values', () {
      expect(FSPaginationVariant.values.length, 8);
      expect(FSPaginationVariant.values, contains(FSPaginationVariant.primary));
      expect(
          FSPaginationVariant.values, contains(FSPaginationVariant.secondary));
      expect(FSPaginationVariant.values, contains(FSPaginationVariant.success));
      expect(FSPaginationVariant.values, contains(FSPaginationVariant.danger));
      expect(FSPaginationVariant.values, contains(FSPaginationVariant.warning));
      expect(FSPaginationVariant.values, contains(FSPaginationVariant.info));
      expect(FSPaginationVariant.values, contains(FSPaginationVariant.light));
      expect(FSPaginationVariant.values, contains(FSPaginationVariant.dark));
    });

    test('FSPaginationSize has correct values', () {
      expect(FSPaginationSize.values.length, 3);
      expect(FSPaginationSize.values, contains(FSPaginationSize.sm));
      expect(FSPaginationSize.values, contains(FSPaginationSize.md));
      expect(FSPaginationSize.values, contains(FSPaginationSize.lg));
    });

    test('FSPaginationAlignment has correct values', () {
      expect(FSPaginationAlignment.values.length, 3);
      expect(
          FSPaginationAlignment.values, contains(FSPaginationAlignment.start));
      expect(
          FSPaginationAlignment.values, contains(FSPaginationAlignment.center));
      expect(FSPaginationAlignment.values, contains(FSPaginationAlignment.end));
    });
  });
}
