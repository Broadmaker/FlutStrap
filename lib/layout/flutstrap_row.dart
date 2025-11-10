/// Flutstrap Row
///
/// A responsive row component that creates horizontal layout containers
/// for organizing columns with consistent spacing and alignment.
///
/// {@category Layout}
/// {@category Components}

import 'package:flutter/material.dart';
import '../core/spacing.dart';

/// Flutstrap Row Component
///
/// {@template flutstrap_row.important_notes}
/// Important Notes:
/// - Uses Flutter's [Row] widget with [SizedBox] for proper gap implementation
/// - Maintains all [Row] functionality including flex behavior
/// - More performant than using [Wrap] for simple horizontal layouts
/// {@endtemplate}
class FlutstrapRow extends StatelessWidget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline? textBaseline;
  final double? gap;
  final double? minHeight; // FIX: Add minimum height constraint
  final double? maxHeight; // FIX: Add maximum height constraint

  const FlutstrapRow({
    super.key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline,
    this.gap,
    this.minHeight, // FIX: Optional minimum height
    this.maxHeight, // FIX: Optional maximum height
  });

  @override
  Widget build(BuildContext context) {
    assert(children.isNotEmpty, 'FlutstrapRow must have at least one child');

    final rowGap = gap ?? FSSpacing.md;

    // FIX: Wrap in ConstrainedBox to prevent unbounded height issues
    Widget rowWidget;

    // Use regular Row when no gap is needed for better performance
    if (rowGap == 0) {
      rowWidget = Row(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        mainAxisSize: mainAxisSize,
        textDirection: textDirection,
        verticalDirection: verticalDirection,
        textBaseline: textBaseline,
        children: _ensureChildrenHaveConstraints(
            children), // FIX: Ensure children have constraints
      );
    } else {
      rowWidget = Row(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        mainAxisSize: mainAxisSize,
        textDirection: textDirection,
        verticalDirection: verticalDirection,
        textBaseline: textBaseline,
        children: _buildChildrenWithGap(children, rowGap),
      );
    }

    // FIX: Apply height constraints to prevent "no size" errors
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: minHeight ?? 0.0, // FIX: Ensure minimum height
        maxHeight: maxHeight ?? double.infinity,
      ),
      child: rowWidget,
    );
  }

  /// FIX: Ensure children have proper constraints when used in flexible layouts
  List<Widget> _ensureChildrenHaveConstraints(List<Widget> children) {
    return children.map((child) {
      // If child is already flexible or expanded, leave it as is
      if (child is Flexible || child is Expanded) {
        return child;
      }

      // For non-flexible children in a row, ensure they have proper constraints
      // This prevents "unbounded" errors in vertical layouts
      return ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: 0.0,
          minWidth: 0.0,
        ),
        child: child,
      );
    }).toList();
  }

  /// Builds children with proper gap implementation using SizedBox
  List<Widget> _buildChildrenWithGap(List<Widget> children, double gap) {
    if (children.length <= 1) return _ensureChildrenHaveConstraints(children);

    final result = <Widget>[];
    for (int i = 0; i < children.length; i++) {
      // FIX: Apply constraints to each child
      final constrainedChild =
          _ensureChildrenHaveConstraints([children[i]]).first;
      result.add(constrainedChild);

      // Add gap between children, but not after the last one
      if (i < children.length - 1) {
        result.add(SizedBox(width: gap));
      }
    }
    return result;
  }

  // ✅ CONSISTENT COPYWITH PATTERN
  FlutstrapRow copyWith({
    Key? key,
    List<Widget>? children,
    MainAxisAlignment? mainAxisAlignment,
    CrossAxisAlignment? crossAxisAlignment,
    MainAxisSize? mainAxisSize,
    TextDirection? textDirection,
    VerticalDirection? verticalDirection,
    TextBaseline? textBaseline,
    double? gap,
    double? minHeight, // FIX: Include new parameters
    double? maxHeight, // FIX: Include new parameters
  }) {
    return FlutstrapRow(
      key: key ?? this.key,
      children: children ?? this.children,
      mainAxisAlignment: mainAxisAlignment ?? this.mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment ?? this.crossAxisAlignment,
      mainAxisSize: mainAxisSize ?? this.mainAxisSize,
      textDirection: textDirection ?? this.textDirection,
      verticalDirection: verticalDirection ?? this.verticalDirection,
      textBaseline: textBaseline ?? this.textBaseline,
      gap: gap ?? this.gap,
      minHeight: minHeight ?? this.minHeight, // FIX: Copy new parameters
      maxHeight: maxHeight ?? this.maxHeight, // FIX: Copy new parameters
    );
  }

  // ✅ CONVENIENCE METHODS USING COPYWITH
  FlutstrapRow noGap() => copyWith(gap: 0);
  FlutstrapRow withGap(double customGap) => copyWith(gap: customGap);

  // FIX: Add height constraint methods
  FlutstrapRow withMinHeight(double height) => copyWith(minHeight: height);
  FlutstrapRow withMaxHeight(double height) => copyWith(maxHeight: height);
  FlutstrapRow withHeight(double height) =>
      copyWith(minHeight: height, maxHeight: height);

  FlutstrapRow center() => copyWith(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
      );

  FlutstrapRow spaceBetween() => copyWith(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      );

  FlutstrapRow spaceAround() => copyWith(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
      );

  FlutstrapRow spaceEvenly() => copyWith(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      );

  FlutstrapRow start() => copyWith(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
      );

  FlutstrapRow end() => copyWith(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
      );

  FlutstrapRow stretch() => copyWith(
        crossAxisAlignment: CrossAxisAlignment.stretch,
      );

  /// Creates a row specifically designed for grid columns
  FlutstrapRow gridRow({
    double gap = 0,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
  }) {
    return copyWith(
      gap: gap,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }
}
