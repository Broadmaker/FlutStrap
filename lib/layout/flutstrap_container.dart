/// Flutstrap Container - ENHANCED VERSION
///
/// A responsive container component that provides consistent spacing,
/// max-width constraints, and responsive behavior based on breakpoints.

import 'package:flutter/material.dart';
import '../core/breakpoints.dart';
import '../core/responsive.dart';
import '../core/spacing.dart';

class FlutstrapContainer extends StatelessWidget {
  final Widget child;
  final bool fluid;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final Decoration? decoration;
  final double? width;
  final double? height;
  final AlignmentGeometry? alignment;
  final Clip clipBehavior;

  // Constants for consistent styling
  static const double defaultCardElevation = 2.0;
  static const double defaultBorderRadius = 8.0;
  static const double sectionPadding = 24.0;
  static const double cardPadding = 16.0;

  const FlutstrapContainer({
    super.key,
    required this.child,
    this.fluid = false,
    this.padding,
    this.margin,
    this.color,
    this.decoration,
    this.width,
    this.height,
    this.alignment,
    this.clipBehavior = Clip.none,
  }) : assert(color == null || decoration == null,
            'Cannot provide both color and decoration');

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final responsive = FSResponsive.of(constraints.maxWidth);

        // Early return for fluid containers to avoid unnecessary calculations
        if (fluid && width == null) {
          return _buildContainer(double.infinity, constraints);
        }

        final maxWidth = _getMaxWidth(responsive, fluid);
        return _buildContainer(maxWidth, constraints);
      },
    );
  }

  Widget _buildContainer(double maxWidth, BoxConstraints constraints) {
    // FIX: Ensure the container has proper constraints
    final containerConstraints = BoxConstraints(
      maxWidth: maxWidth,
      minWidth: 0.0, // FIX: Add minimum width constraint
      minHeight: 0.0, // FIX: Add minimum height constraint
      maxHeight: constraints.maxHeight.isInfinite
          ? double.infinity
          : constraints.maxHeight,
    );

    return Container(
      width: width,
      height: height,
      padding: padding ?? const EdgeInsets.all(FSSpacing.md),
      margin: margin,
      color: color,
      decoration: decoration,
      alignment: alignment,
      clipBehavior: clipBehavior,
      constraints:
          containerConstraints, // FIX: Apply constraints directly to Container
      child: child,
    );
  }

  double _getMaxWidth(FSResponsive responsive, bool fluid) {
    if (fluid) return double.infinity;
    if (width != null) return width!;

    return responsive.value<double>(
      xs: double.infinity,
      sm: FSBreakpoints.sm,
      md: FSBreakpoints.md,
      lg: FSBreakpoints.lg,
      xl: FSBreakpoints.xl,
      xxl: FSBreakpoints.xxl ?? FSBreakpoints.xl,
      fallback: FSBreakpoints.xl,
    );
  }

  // ✅ CONSISTENT COPYWITH PATTERN
  FlutstrapContainer copyWith({
    Key? key,
    Widget? child,
    bool? fluid,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Color? color,
    Decoration? decoration,
    double? width,
    double? height,
    AlignmentGeometry? alignment,
    Clip? clipBehavior,
  }) {
    return FlutstrapContainer(
      key: key ?? this.key,
      child: child ?? this.child,
      fluid: fluid ?? this.fluid,
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      color: color ?? this.color,
      decoration: decoration ?? this.decoration,
      width: width ?? this.width,
      height: height ?? this.height,
      alignment: alignment ?? this.alignment,
      clipBehavior: clipBehavior ?? this.clipBehavior,
    );
  }

  // ✅ CONVENIENCE METHODS USING COPYWITH
  FlutstrapContainer fluidWidth() => copyWith(fluid: true);
  FlutstrapContainer withMaxWidth(double maxWidth) =>
      copyWith(width: maxWidth, fluid: false);
  FlutstrapContainer withPadding(EdgeInsetsGeometry customPadding) =>
      copyWith(padding: customPadding);
  FlutstrapContainer withMargin(EdgeInsetsGeometry customMargin) =>
      copyWith(margin: customMargin);
  FlutstrapContainer withColor(Color newColor) => copyWith(color: newColor);
  FlutstrapContainer withDecoration(Decoration newDecoration) =>
      copyWith(decoration: newDecoration);
  FlutstrapContainer withAlignment(AlignmentGeometry newAlignment) =>
      copyWith(alignment: newAlignment);
  FlutstrapContainer withSize({double? newWidth, double? newHeight}) =>
      copyWith(width: newWidth, height: newHeight);

  // ✅ COMMON CONTAINER VARIANTS
  FlutstrapContainer card({
    Color backgroundColor = Colors.white,
    double elevation = defaultCardElevation,
    BorderRadius borderRadius =
        const BorderRadius.all(Radius.circular(defaultBorderRadius)),
  }) {
    return copyWith(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: elevation * 2,
            offset: Offset(0, elevation),
          ),
        ],
      ),
      padding: const EdgeInsets.all(cardPadding),
      margin: const EdgeInsets.all(8.0),
    );
  }

  FlutstrapContainer section() {
    return copyWith(
      padding: const EdgeInsets.all(sectionPadding),
      margin: const EdgeInsets.symmetric(vertical: 16.0),
    );
  }

  FlutstrapContainer bordered({
    Color borderColor = const Color(0xFFE2E8F0),
    double borderWidth = 1.0,
    BorderRadius borderRadius =
        const BorderRadius.all(Radius.circular(defaultBorderRadius)),
  }) {
    return copyWith(
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: borderWidth),
        borderRadius: borderRadius,
      ),
    );
  }
}
