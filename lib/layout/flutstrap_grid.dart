/// Flutstrap Grid
///
/// A comprehensive grid system container that combines container, rows, and columns
/// for easy responsive layout creation inspired by Bootstrap's grid system.

import 'package:flutter/material.dart';
import 'flutstrap_container.dart';
import 'flutstrap_row.dart';
import 'flutstrap_col.dart';
import '../core/breakpoints.dart';
import '../core/spacing.dart';

/// Flutstrap Grid Component
///
/// A main grid container that provides easy creation of responsive grids
/// with consistent spacing and layout patterns.
class FlutstrapGrid extends StatelessWidget {
  final List<FlutstrapRow> children;
  final bool fluid;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final Decoration? decoration;
  final AlignmentGeometry? alignment;

  const FlutstrapGrid({
    Key? key,
    required this.children,
    this.fluid = false,
    this.padding,
    this.margin,
    this.color,
    this.decoration,
    this.alignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutstrapContainer(
      fluid: fluid,
      padding: padding,
      margin: margin,
      color: color,
      decoration: decoration,
      alignment: alignment,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  /// Create a fluid grid (full width)
  FlutstrapGrid fluidGrid() {
    return FlutstrapGrid(
      children: children,
      fluid: true,
      padding: padding,
      margin: margin,
      color: color,
      decoration: decoration,
      alignment: alignment,
    );
  }

  /// Create a grid with custom padding
  FlutstrapGrid withPadding(EdgeInsetsGeometry customPadding) {
    return FlutstrapGrid(
      children: children,
      fluid: fluid,
      padding: customPadding,
      margin: margin,
      color: color,
      decoration: decoration,
      alignment: alignment,
    );
  }

  /// Create a grid with custom margin
  FlutstrapGrid withMargin(EdgeInsetsGeometry customMargin) {
    return FlutstrapGrid(
      children: children,
      fluid: fluid,
      padding: padding,
      margin: customMargin,
      color: color,
      decoration: decoration,
      alignment: alignment,
    );
  }

  /// Quick grid creation with a single row
  factory FlutstrapGrid.singleRow({
    required List<Widget> columns,
    double? gap,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
  }) {
    return FlutstrapGrid(
      children: [
        FlutstrapRow(
          children: columns,
          gap: gap,
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
        ),
      ],
    );
  }

  /// Quick grid creation with multiple rows
  factory FlutstrapGrid.multipleRows({
    required List<List<Widget>> rows,
    double? rowGap,
    double? columnGap,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
  }) {
    return FlutstrapGrid(
      children: rows.map((columns) {
        return FlutstrapRow(
          children: columns,
          gap: columnGap,
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
        );
      }).toList(),
    );
  }

  /// Create a responsive grid that changes layout based on breakpoints
  factory FlutstrapGrid.responsive({
    required List<Widget> children,
    int xsColumns = 1,
    int? smColumns,
    int? mdColumns,
    int? lgColumns,
    int? xlColumns,
    int? xxlColumns,
    double? gap,
    bool fluid = false,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
  }) {
    // This would create a grid that automatically rearranges columns
    // based on breakpoints. For simplicity, we'll use a single row
    // that contains responsive columns.
    return FlutstrapGrid(
      children: [
        FlutstrapRow(
          children: children,
          gap: gap,
        ),
      ],
      fluid: fluid,
      padding: padding,
      margin: margin,
    );
  }

  /// Create a card grid layout (common pattern)
  factory FlutstrapGrid.cards({
    required List<Widget> cards,
    int columns = 3,
    double gap = FSSpacing.md,
    bool fluid = false,
    EdgeInsetsGeometry? padding,
  }) {
    // Group cards into rows based on column count
    final rows = <FlutstrapRow>[];
    for (var i = 0; i < cards.length; i += columns) {
      final end = i + columns < cards.length ? i + columns : cards.length;
      final rowCards = cards.sublist(i, end);

      // Add empty columns to maintain alignment if needed
      while (rowCards.length < columns) {
        rowCards.add(const SizedBox.shrink());
      }

      rows.add(FlutstrapRow(
        children: rowCards,
        gap: gap,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
      ));
    }

    return FlutstrapGrid(
      children: rows,
      fluid: fluid,
      padding: padding,
    );
  }
}

/// Grid layout utilities
class FSGrid {
  /// Create a responsive column size configuration
  static FSColSize responsiveSize({
    int xs = 12,
    int? sm,
    int? md,
    int? lg,
    int? xl,
    int? xxl,
  }) {
    return FSColSize(
      xs: xs,
      sm: sm,
      md: md,
      lg: lg,
      xl: xl,
      xxl: xxl,
    );
  }

  /// Common column size presets
  static FSColSize get fullWidth => const FSColSize.all(12);
  static FSColSize get halfWidth => const FSColSize.all(6);
  static FSColSize get oneThirdWidth => const FSColSize.all(4);
  static FSColSize get twoThirdsWidth => const FSColSize.all(8);
  static FSColSize get oneFourthWidth => const FSColSize.all(3);
  static FSColSize get threeFourthsWidth => const FSColSize.all(9);

  /// Mobile-first responsive sizes (full width on mobile, then responsive)
  static FSColSize get responsiveHalf => FSColSize(xs: 12, sm: 6, md: 6, lg: 6);
  static FSColSize get responsiveThird =>
      FSColSize(xs: 12, sm: 6, md: 4, lg: 4);
  static FSColSize get responsiveFourth =>
      FSColSize(xs: 12, sm: 6, md: 3, lg: 3);

  /// Calculate the number of rows needed for a grid
  static int calculateRowCount(int itemCount, int columnsPerRow) {
    if (itemCount == 0) return 0;
    return (itemCount / columnsPerRow).ceil();
  }

  /// Distribute items into rows for grid layout
  static List<List<T>> distributeItems<T>(List<T> items, int columnsPerRow) {
    final rows = <List<T>>[];
    for (var i = 0; i < items.length; i += columnsPerRow) {
      final end =
          i + columnsPerRow < items.length ? i + columnsPerRow : items.length;
      rows.add(items.sublist(i, end));
    }
    return rows;
  }
}
