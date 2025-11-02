/// Flutstrap Column
///
/// A responsive column component for creating flexible grid columns
/// with breakpoint-based sizing.
///
/// {@category Layout}
/// {@category Components}

import 'package:flutter/material.dart';
import '../core/breakpoints.dart';
import '../core/responsive.dart';

/// Flutstrap Column Sizes
///
/// {@template flutstrap_col_size.important_notes}
/// Uses a 12-column grid system. Each size represents how many columns
/// the component should span out of 12.
/// {@endtemplate}
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
  }) : assert(xs >= 1 && xs <= 12, 'XS column size must be between 1 and 12');

  /// Create a column size that spans all breakpoints
  const FSColSize.all(int size)
      : xs = size,
        sm = size,
        md = size,
        lg = size,
        xl = size,
        xxl = size,
        assert(size >= 1 && size <= 12, 'Column size must be between 1 and 12');

  /// Get the size for a specific breakpoint with proper fallback
  int getSize(FSBreakpoint breakpoint) {
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

  /// Gets the flex value for this column size
  int getFlex(FSBreakpoint breakpoint) {
    return getSize(breakpoint);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FSColSize &&
          runtimeType == other.runtimeType &&
          xs == other.xs &&
          sm == other.sm &&
          md == other.md &&
          lg == other.lg &&
          xl == other.xl &&
          xxl == other.xxl;

  @override
  int get hashCode => Object.hash(xs, sm, md, lg, xl, xxl);

  @override
  String toString() =>
      'FSColSize(xs: $xs, sm: $sm, md: $md, lg: $lg, xl: $xl, xxl: $xxl)';
}

/// Flutstrap Column Component
///
/// {@template flutstrap_col.important_notes}
/// Important Notes:
/// - Must be used within a [FlutstrapRow] or [FlutstrapGrid] for proper layout
/// - The parent row/grid will wrap this column with [Expanded] and proper flex
/// - Uses a 12-column grid system (similar to Bootstrap)
/// {@endtemplate}
class FlutstrapCol extends StatelessWidget {
  final Widget child;
  final FSColSize size;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final AlignmentGeometry? alignment;
  final Color? color;
  final Decoration? decoration;

  const FlutstrapCol({
    super.key,
    required this.child,
    this.size = const FSColSize(),
    this.padding,
    this.margin,
    this.alignment,
    this.color,
    this.decoration,
  }) : assert(color == null || decoration == null,
            'Cannot provide both color and decoration');

  /// Gets the flex value for the current breakpoint
  int getFlex(double containerWidth) {
    final responsive = FSResponsive.of(containerWidth);
    return size.getFlex(responsive.breakpoint);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      alignment: alignment,
      color: color,
      decoration: decoration,
      child: child,
    );
  }

  // ✅ CONSISTENT COPYWITH PATTERN
  FlutstrapCol copyWith({
    Key? key,
    Widget? child,
    FSColSize? size,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    AlignmentGeometry? alignment,
    Color? color,
    Decoration? decoration,
  }) {
    return FlutstrapCol(
      key: key ?? this.key,
      child: child ?? this.child,
      size: size ?? this.size,
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      alignment: alignment ?? this.alignment,
      color: color ?? this.color,
      decoration: decoration ?? this.decoration,
    );
  }

  // ✅ CONVENIENCE METHODS USING COPYWITH
  FlutstrapCol withSize({
    int xs = 12,
    int? sm,
    int? md,
    int? lg,
    int? xl,
    int? xxl,
  }) {
    return copyWith(
      size: FSColSize(
        xs: xs,
        sm: sm,
        md: md,
        lg: lg,
        xl: xl,
        xxl: xxl,
      ),
    );
  }

  FlutstrapCol fullWidth() => copyWith(size: const FSColSize.all(12));
  FlutstrapCol halfWidth() => copyWith(size: const FSColSize.all(6));
  FlutstrapCol oneThirdWidth() => copyWith(size: const FSColSize.all(4));
  FlutstrapCol twoThirdsWidth() => copyWith(size: const FSColSize.all(8));
  FlutstrapCol oneFourthWidth() => copyWith(size: const FSColSize.all(3));
  FlutstrapCol threeFourthsWidth() => copyWith(size: const FSColSize.all(9));

  FlutstrapCol withPadding(EdgeInsetsGeometry customPadding) =>
      copyWith(padding: customPadding);
  FlutstrapCol withMargin(EdgeInsetsGeometry customMargin) =>
      copyWith(margin: customMargin);
  FlutstrapCol withAlignment(AlignmentGeometry customAlignment) =>
      copyWith(alignment: customAlignment);
  FlutstrapCol withColor(Color newColor) => copyWith(color: newColor);
  FlutstrapCol withDecoration(Decoration newDecoration) =>
      copyWith(decoration: newDecoration);

  // ✅ MOBILE-FIRST RESPONSIVE CONVENIENCE METHODS
  FlutstrapCol responsiveHalf() =>
      copyWith(size: const FSColSize(xs: 12, sm: 6, md: 6, lg: 6));
  FlutstrapCol responsiveThird() =>
      copyWith(size: const FSColSize(xs: 12, sm: 6, md: 4, lg: 4));
  FlutstrapCol responsiveFourth() =>
      copyWith(size: const FSColSize(xs: 12, sm: 6, md: 3, lg: 3));
  FlutstrapCol responsiveAuto() =>
      copyWith(size: const FSColSize(xs: 12, sm: 12, md: 12, lg: 12));
}
