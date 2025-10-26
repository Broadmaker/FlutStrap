/// Flutstrap Row
///
/// A responsive row component that creates horizontal layout containers
/// for organizing columns with consistent spacing and alignment.

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
    Key? key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline,
    this.gap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = FSTheme.of(context);
    final rowGap = gap ?? FSSpacing.md;

    // If no gap, use regular Row
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

    // Use Wrap with spacing for gap support (simpler than dealing with margin hacks)
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

  /// Create a row with no gap between children
  FlutstrapRow noGap() {
    return FlutstrapRow(
      children: children,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      gap: 0,
    );
  }

  /// Create a row with custom gap
  FlutstrapRow withGap(double customGap) {
    return FlutstrapRow(
      children: children,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      gap: customGap,
    );
  }
}
