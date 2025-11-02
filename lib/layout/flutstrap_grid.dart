/// Flutstrap Grid System - CORRECTED VERSION
///
/// A comprehensive grid system container that combines container, rows, and columns
/// for easy responsive layout creation inspired by Bootstrap's grid system.
///
/// {@category Layout}
/// {@category Components}

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'flutstrap_container.dart';
import 'flutstrap_row.dart';
import 'flutstrap_col.dart';
import '../core/spacing.dart';

/// Flutstrap Grid Component
///
/// {@template flutstrap_grid.important_notes}
/// Important Notes:
/// - Properly coordinates between [FlutstrapRow] and [FlutstrapCol] for grid layouts
/// - Uses flex-based grid system for proper column distribution
/// - Maintains responsive behavior across all breakpoints
/// {@endtemplate}
class FlutstrapGrid extends StatelessWidget {
  final List<Widget> children;
  final bool fluid;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final Decoration? decoration;
  final AlignmentGeometry? alignment;
  final double? rowGap;

  // Constants for consistent grid behavior
  static const double defaultRowGap = 16.0;
  static const double defaultColumnGap = 16.0;

  const FlutstrapGrid({
    super.key,
    required this.children,
    this.fluid = false,
    this.padding,
    this.margin,
    this.color,
    this.decoration,
    this.alignment,
    this.rowGap,
  }); // ✅ REMOVED ASSERT FROM INITIALIZER LIST

  @override
  Widget build(BuildContext context) {
    // ✅ MOVED ASSERT TO BUILD METHOD
    assert(children.isNotEmpty, 'Grid must have at least one child');

    return FlutstrapContainer(
      fluid: fluid,
      padding: padding,
      margin: margin,
      color: color,
      decoration: decoration,
      alignment: alignment,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildGridChildren(),
      ),
    );
  }

  List<Widget> _buildGridChildren() {
    final effectiveRowGap = rowGap ?? defaultRowGap;

    if (effectiveRowGap <= 0) return children;

    final result = <Widget>[];
    for (var i = 0; i < children.length; i++) {
      result.add(children[i]);
      if (i < children.length - 1) {
        result.add(SizedBox(height: effectiveRowGap));
      }
    }
    return result;
  }

  /// Converts regular rows to grid rows with proper column wrapping
  List<Widget> _convertToGridRows(List<Widget> rows, double containerWidth) {
    return rows.map((row) {
      if (row is FlutstrapRow) {
        return _wrapRowChildrenWithColumns(row, containerWidth);
      }
      return row;
    }).toList();
  }

  /// Wraps FlutstrapCol children with Expanded widgets for proper grid behavior
  Widget _wrapRowChildrenWithColumns(FlutstrapRow row, double containerWidth) {
    final wrappedChildren = row.children.map((child) {
      if (child is FlutstrapCol) {
        final flex = child.getFlex(containerWidth);
        return Expanded(
          flex: flex,
          child: child,
        );
      }
      return child;
    }).toList();

    return FlutstrapRow(
      children: wrappedChildren,
      mainAxisAlignment: row.mainAxisAlignment,
      crossAxisAlignment: row.crossAxisAlignment,
      mainAxisSize: row.mainAxisSize,
      textDirection: row.textDirection,
      verticalDirection: row.verticalDirection,
      textBaseline: row.textBaseline,
      gap: row.gap,
    );
  }

  // ✅ CONSISTENT COPYWITH PATTERN
  FlutstrapGrid copyWith({
    Key? key,
    List<Widget>? children,
    bool? fluid,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Color? color,
    Decoration? decoration,
    AlignmentGeometry? alignment,
    double? rowGap,
  }) {
    return FlutstrapGrid(
      key: key ?? this.key,
      children: children ?? this.children,
      fluid: fluid ?? this.fluid,
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      color: color ?? this.color,
      decoration: decoration ?? this.decoration,
      alignment: alignment ?? this.alignment,
      rowGap: rowGap ?? this.rowGap,
    );
  }

  // ✅ CONVENIENCE METHODS USING COPYWITH
  FlutstrapGrid fluidGrid() => copyWith(fluid: true);
  FlutstrapGrid withPadding(EdgeInsetsGeometry customPadding) =>
      copyWith(padding: customPadding);
  FlutstrapGrid withMargin(EdgeInsetsGeometry customMargin) =>
      copyWith(margin: customMargin);
  FlutstrapGrid withRowGap(double gap) => copyWith(rowGap: gap);
  FlutstrapGrid withColor(Color newColor) => copyWith(color: newColor);
  FlutstrapGrid withDecoration(Decoration newDecoration) =>
      copyWith(decoration: newDecoration);

  // ✅ IMPROVED FACTORY METHODS WITH VALIDATION

  /// Quick grid creation with a single row
  factory FlutstrapGrid.singleRow({
    required List<Widget> columns,
    double? gap,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
    bool fluid = false,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
  }) {
    assert(columns.isNotEmpty, 'Columns list cannot be empty');

    return FlutstrapGrid(
      children: [
        FlutstrapRow(
          children: columns,
          gap: gap ?? defaultColumnGap,
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
        ),
      ],
      fluid: fluid,
      padding: padding,
      margin: margin,
    );
  }

  /// Quick grid creation with multiple rows
  factory FlutstrapGrid.multipleRows({
    required List<List<Widget>> rows,
    double? rowGap,
    double? columnGap,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
    bool fluid = false,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
  }) {
    assert(rows.isNotEmpty, 'Rows list cannot be empty');
    assert(rows.every((row) => row.isNotEmpty),
        'Each row must have at least one column');

    return FlutstrapGrid(
      children: rows.map((columns) {
        return FlutstrapRow(
          children: columns,
          gap: columnGap ?? defaultColumnGap,
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
        );
      }).toList(),
      fluid: fluid,
      padding: padding,
      margin: margin,
      rowGap: rowGap ?? defaultRowGap,
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
    assert(children.isNotEmpty, 'Children list cannot be empty');
    assert(xsColumns >= 1 && xsColumns <= 12,
        'XS columns must be between 1 and 12');

    // Convert children to FlutstrapCol with responsive sizing
    final responsiveChildren = children.map((child) {
      return FlutstrapCol(
        size: FSColSize(
          xs: 12 ~/ xsColumns,
          sm: smColumns != null ? 12 ~/ smColumns : null,
          md: mdColumns != null ? 12 ~/ mdColumns : null,
          lg: lgColumns != null ? 12 ~/ lgColumns : null,
          xl: xlColumns != null ? 12 ~/ xlColumns : null,
          xxl: xxlColumns != null ? 12 ~/ xxlColumns : null,
        ),
        child: child,
      );
    }).toList();

    return FlutstrapGrid(
      children: [
        FlutstrapRow(
          children: responsiveChildren,
          gap: gap ?? defaultColumnGap,
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
    EdgeInsetsGeometry? margin,
    bool equalHeight = true,
  }) {
    assert(cards.isNotEmpty, 'Cards list cannot be empty');
    assert(columns >= 1, 'Columns must be at least 1');

    // Distribute cards into rows
    final rows = FSGridUtils.distributeItems(cards, columns).map((rowCards) {
      final rowChildren = rowCards.map((card) {
        final wrappedCard = equalHeight
            ? Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: card,
                ),
              )
            : card;

        return FlutstrapCol(
          size: FSColSize.all(12 ~/ columns),
          child: wrappedCard,
        );
      }).toList();

      return FlutstrapRow(
        children: rowChildren,
        gap: gap,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment:
            equalHeight ? CrossAxisAlignment.stretch : CrossAxisAlignment.start,
      );
    }).toList();

    return FlutstrapGrid(
      children: rows,
      fluid: fluid,
      padding: padding,
      margin: margin,
      rowGap: gap,
    );
  }

  /// Create an auto-fit grid that adjusts columns based on available width
  factory FlutstrapGrid.autoFit({
    required List<Widget> children,
    required double minColumnWidth,
    double gap = FSSpacing.md,
    bool fluid = false,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
  }) {
    assert(children.isNotEmpty, 'Children list cannot be empty');
    assert(minColumnWidth > 0, 'Min column width must be positive');

    return FlutstrapGrid(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final containerWidth = constraints.maxWidth;
            final columns = FSGridUtils.calculateOptimalColumns(
              containerWidth,
              minColumnWidth,
              gap,
            );

            final rows = FSGridUtils.distributeItems(children, columns);

            return Column(
              children: rows.map((rowItems) {
                return FlutstrapRow(
                  children: rowItems.map((item) {
                    return Expanded(
                      child: item,
                    );
                  }).toList(),
                  gap: gap,
                );
              }).toList(),
            );
          },
        ),
      ],
      fluid: fluid,
      padding: padding,
      margin: margin,
    );
  }
}

/// Grid layout utilities with enhanced performance and type safety
class FSGridUtils {
  // Private constructor for utility class
  const FSGridUtils._();

  /// Calculate the number of rows needed for a grid efficiently
  static int calculateRowCount(int itemCount, int columnsPerRow) {
    if (itemCount <= 0 || columnsPerRow <= 0) return 0;
    return (itemCount + columnsPerRow - 1) ~/ columnsPerRow;
  }

  /// Distribute items into rows for grid layout with type safety
  static List<List<T>> distributeItems<T>(List<T> items, int columnsPerRow) {
    if (items.isEmpty || columnsPerRow <= 0) return [];

    final rowCount = calculateRowCount(items.length, columnsPerRow);
    return List.generate(rowCount, (rowIndex) {
      final start = rowIndex * columnsPerRow;
      final end = math.min(start + columnsPerRow, items.length);
      return items.sublist(start, end);
    });
  }

  /// Calculate optimal columns based on container width and min column width
  static int calculateOptimalColumns(
      double containerWidth, double minColumnWidth, double gap) {
    if (containerWidth <= 0 || minColumnWidth <= 0) return 1;

    final availableWidth = containerWidth + gap;
    final columns = (availableWidth / (minColumnWidth + gap)).floor();
    return math.max(1, math.min(columns, 12)); // Limit to 12 columns max
  }

  /// Calculate column width based on grid parameters
  static double calculateColumnWidth(
      double containerWidth, int columns, double gap) {
    if (containerWidth <= 0 || columns <= 0) return 0;

    final totalGap = (columns - 1) * gap;
    return (containerWidth - totalGap) / columns;
  }
}
