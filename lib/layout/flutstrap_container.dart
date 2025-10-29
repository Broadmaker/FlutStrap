/// Flutstrap Container
///
/// A responsive container component that provides consistent spacing,
/// max-width constraints, and responsive behavior based on breakpoints.
///
/// ## Usage Examples
///
/// ```dart
/// // Basic container with default padding
/// FlutstrapContainer(
///   child: Text('Hello World'),
///   fluid: false, // Respects max-width breakpoints
///   padding: EdgeInsets.all(16),
/// )
///
/// // Fluid container (full width)
/// FlutstrapContainer(
///   child: Text('Full Width Container'),
///   fluid: true,
///   color: Colors.blue,
/// ).fluidWidth()
///
/// // Using copyWith for modifications
/// FlutstrapContainer(
///   child: Text('Original'),
///   padding: EdgeInsets.all(16),
/// ).copyWith(
///   fluid: true,
///   margin: EdgeInsets.all(24),
///   color: Colors.red,
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

/// Flutstrap Container Component
///
/// A responsive container that adapts its max-width based on breakpoints
/// and provides consistent padding and margin.
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
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      // ✅ USE LAYOUTBUILDER FOR EFFICIENT RESPONSIVE CALCULATIONS
      builder: (context, constraints) {
        final responsive = FSResponsive.of(constraints.maxWidth);

        return Container(
          width: width,
          height: height,
          padding: padding ?? EdgeInsets.all(FSSpacing.md),
          margin: margin,
          color: color,
          decoration: decoration,
          alignment: alignment,
          clipBehavior: clipBehavior,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: _getMaxWidth(responsive, fluid),
            ),
            child: child,
          ),
        );
      },
    );
  }

  double _getMaxWidth(FSResponsive responsive, bool fluid) {
    if (fluid || width != null) return width ?? double.infinity;

    return responsive.value<double>(
      xs: double.infinity, // Full width on mobile
      sm: FSBreakpoints.sm,
      md: FSBreakpoints.md,
      lg: FSBreakpoints.lg,
      xl: FSBreakpoints.xl,
      xxl: FSBreakpoints.xl,
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
    double elevation = 2.0,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(8.0)),
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
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.all(8.0),
    );
  }

  FlutstrapContainer section() {
    return copyWith(
      padding: const EdgeInsets.all(24.0),
      margin: const EdgeInsets.symmetric(vertical: 16.0),
    );
  }
}
