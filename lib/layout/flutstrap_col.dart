/// Flutstrap Column
///
/// A responsive column component for creating flexible grid columns
/// with breakpoint-based sizing.

import 'package:flutter/material.dart';
import '../core/breakpoints.dart';
import '../core/responsive.dart';
import '../core/theme.dart';
import '../core/spacing.dart';

/// Flutstrap Column Sizes
///
/// Defines the column sizes for different breakpoints
class FSColSize {
  final int xs;
  final int? sm;
  final int? md;
  final int? lg;
  final int? xl;
  final int? xxl;

  const FSColSize({
    this.xs = 12, // Default: full width on mobile
    this.sm,
    this.md,
    this.lg,
    this.xl,
    this.xxl,
  });

  /// Create a column size that spans all breakpoints
  const FSColSize.all(int size)
      : xs = size,
        sm = size,
        md = size,
        lg = size,
        xl = size,
        xxl = size;

  /// Get the size for a specific breakpoint
  int? getSize(FSBreakpoint breakpoint) {
    switch (breakpoint) {
      case FSBreakpoint.xs:
        return xs;
      case FSBreakpoint.sm:
        return sm ?? xs;
      case FSBreakpoint.md:
        return md ?? sm ?? xs;
      case FSBreakpoint.lg:
        return lg ?? md ?? sm ?? xs;
      case FSBreakpoint.xl:
        return xl ?? lg ?? md ?? sm ?? xs;
      case FSBreakpoint.xxl:
        return xxl ?? xl ?? lg ?? md ?? sm ?? xs;
    }
  }
}

/// Flutstrap Column Component
///
/// A flexible grid column that adapts its width based on breakpoints
/// and column size definitions.
class FlutstrapCol extends StatelessWidget {
  final Widget child;
  final FSColSize size;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final AlignmentGeometry? alignment;

  const FlutstrapCol({
    Key? key,
    required this.child,
    this.size = const FSColSize(),
    this.padding,
    this.margin,
    this.alignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FSTheme.of(context);
    final responsive = FSResponsive.of(MediaQuery.of(context).size.width);
    final currentSize = size.getSize(responsive.breakpoint) ?? 12;

    return Container(
      padding: padding ?? EdgeInsets.all(FSSpacing.md),
      margin: margin,
      alignment: alignment,
      child: FractionallySizedBox(
        widthFactor: currentSize / 12, // 12-column grid system
        child: child,
      ),
    );
  }

  /// Create a column with specific sizes for all breakpoints
  FlutstrapCol withSize({
    int xs = 12,
    int? sm,
    int? md,
    int? lg,
    int? xl,
    int? xxl,
  }) {
    return FlutstrapCol(
      child: child,
      size: FSColSize(
        xs: xs,
        sm: sm,
        md: md,
        lg: lg,
        xl: xl,
        xxl: xxl,
      ),
      padding: padding,
      margin: margin,
      alignment: alignment,
    );
  }

  /// Create a column that spans full width on all breakpoints
  FlutstrapCol fullWidth() {
    return FlutstrapCol(
      child: child,
      size: const FSColSize.all(12),
      padding: padding,
      margin: margin,
      alignment: alignment,
    );
  }

  /// Create a column that spans half width on all breakpoints
  FlutstrapCol halfWidth() {
    return FlutstrapCol(
      child: child,
      size: const FSColSize.all(6),
      padding: padding,
      margin: margin,
      alignment: alignment,
    );
  }

  /// Create a column that spans one third width on all breakpoints
  FlutstrapCol oneThirdWidth() {
    return FlutstrapCol(
      child: child,
      size: const FSColSize.all(4),
      padding: padding,
      margin: margin,
      alignment: alignment,
    );
  }

  /// Create a column that spans two thirds width on all breakpoints
  FlutstrapCol twoThirdsWidth() {
    return FlutstrapCol(
      child: child,
      size: const FSColSize.all(8),
      padding: padding,
      margin: margin,
      alignment: alignment,
    );
  }
}
