/// Flutstrap Row
///
/// A responsive row component that creates horizontal layout containers
/// for organizing columns with consistent spacing and alignment.
///
/// ## Usage Examples
///
/// ```dart
/// // Basic row with default gap
/// FlutstrapRow(
///   children: [Text('Item 1'), Text('Item 2'), Text('Item 3')],
///   gap: 16,
/// )
///
/// // Centered row with custom alignment
/// FlutstrapRow(
///   children: [Icon(Icons.star), Text('Rating: 4.5')],
///   mainAxisAlignment: MainAxisAlignment.center,
///   crossAxisAlignment: CrossAxisAlignment.center,
///   gap: 8,
/// ).center()
///
/// // Using copyWith for modifications
/// FlutstrapRow(
///   children: [/* items */],
/// ).copyWith(gap: 20, mainAxisAlignment: MainAxisAlignment.spaceBetween)
/// ```
///
/// {@category Layout}
/// {@category Components}

import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../core/spacing.dart';

/// Flutstrap Row Component
///
/// A horizontal layout container that arranges its children in a row
/// with consistent spacing and alignment options.
class FlutstrapRow extends StatelessWidget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline? textBaseline;
  final double? gap;

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
  }) : super(); // ✅ REMOVE ASSERT FROM INITIALIZER LIST

  @override
  Widget build(BuildContext context) {
    // ✅ MOVE ASSERT TO BUILD METHOD
    assert(children.isNotEmpty, 'Row must have at least one child');

    final rowGap = gap ?? FSSpacing.md;

    // Use regular Row for better performance when no gap is needed
    if (rowGap == 0) {
      return Row(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        mainAxisSize: mainAxisSize,
        textDirection: textDirection,
        verticalDirection: verticalDirection,
        textBaseline: textBaseline,
        children: children,
      );
    }

    // Use Wrap with spacing for gap support
    return Wrap(
      direction: Axis.horizontal,
      spacing: rowGap,
      runSpacing: rowGap,
      alignment: _wrapAlignment(mainAxisAlignment),
      crossAxisAlignment: _wrapCrossAlignment(crossAxisAlignment),
      children: children,
    );
  }

  WrapAlignment _wrapAlignment(MainAxisAlignment alignment) {
    switch (alignment) {
      case MainAxisAlignment.start:
        return WrapAlignment.start;
      case MainAxisAlignment.end:
        return WrapAlignment.end;
      case MainAxisAlignment.center:
        return WrapAlignment.center;
      case MainAxisAlignment.spaceBetween:
        return WrapAlignment.spaceBetween;
      case MainAxisAlignment.spaceAround:
        return WrapAlignment.spaceAround;
      case MainAxisAlignment.spaceEvenly:
        return WrapAlignment.spaceEvenly;
    }
  }

  WrapCrossAlignment _wrapCrossAlignment(CrossAxisAlignment alignment) {
    switch (alignment) {
      case CrossAxisAlignment.start:
        return WrapCrossAlignment.start;
      case CrossAxisAlignment.end:
        return WrapCrossAlignment.end;
      case CrossAxisAlignment.center:
        return WrapCrossAlignment.center;
      case CrossAxisAlignment.stretch:
        return WrapCrossAlignment.center; // Wrap doesn't support stretch
      case CrossAxisAlignment.baseline:
        return WrapCrossAlignment.center; // Wrap doesn't support baseline
    }
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
    );
  }

  // ✅ CONVENIENCE METHODS USING COPYWITH
  FlutstrapRow noGap() => copyWith(gap: 0);
  FlutstrapRow withGap(double customGap) => copyWith(gap: customGap);

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
}
