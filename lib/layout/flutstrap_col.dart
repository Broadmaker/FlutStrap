/// Flutstrap Column
///
/// A responsive column component for creating flexible grid columns
/// with breakpoint-based sizing.
///
/// ## Usage Examples
///
/// ```dart
/// // Responsive column that adapts to screen size
/// FlutstrapCol(
///   size: FSColSize(xs: 12, sm: 6, md: 4, lg: 3),
///   child: Card(child: Text('Responsive Card')),
/// )
///
/// // Full width column on all screens
/// FlutstrapCol(
///   size: FSColSize.all(12),
///   child: Container(color: Colors.blue, height: 100),
/// ).fullWidth()
///
/// // Using copyWith for modifications
/// FlutstrapCol(
///   child: Text('Original'),
///   padding: EdgeInsets.all(16),
/// ).copyWith(
///   size: FSColSize(xs: 6, md: 4),
///   margin: EdgeInsets.only(bottom: 16),
/// )
/// ```
///
/// {@category Layout}
/// {@category Components}

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

  // ✅ EQUALITY AND HASHCODE FOR BETTER PERFORMANCE
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
/// A flexible grid column that adapts its width based on breakpoints
/// and column size definitions.
class FlutstrapCol extends StatelessWidget {
  final Widget child;
  final FSColSize size;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final AlignmentGeometry? alignment;

  const FlutstrapCol({
    super.key,
    required this.child,
    this.size = const FSColSize(),
    this.padding,
    this.margin,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      // ✅ USE LAYOUTBUILDER FOR EFFICIENT RESPONSIVE CALCULATIONS
      builder: (context, constraints) {
        final responsive = FSResponsive.of(constraints.maxWidth);
        final currentSize = size.getSize(responsive.breakpoint) ?? 12;

        return Container(
          padding: padding,
          margin: margin,
          alignment: alignment,
          child: FractionallySizedBox(
            widthFactor: currentSize / 12, // 12-column grid system
            child: child,
          ),
        );
      },
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
  }) {
    return FlutstrapCol(
      key: key ?? this.key,
      child: child ?? this.child,
      size: size ?? this.size,
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      alignment: alignment ?? this.alignment,
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
    ));
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

  // ✅ MOBILE-FIRST RESPONSIVE CONVENIENCE METHODS
  FlutstrapCol responsiveHalf() =>
      copyWith(size: FSColSize(xs: 12, sm: 6, md: 6, lg: 6));
  FlutstrapCol responsiveThird() =>
      copyWith(size: FSColSize(xs: 12, sm: 6, md: 4, lg: 4));
  FlutstrapCol responsiveFourth() =>
      copyWith(size: FSColSize(xs: 12, sm: 6, md: 3, lg: 3));
}
