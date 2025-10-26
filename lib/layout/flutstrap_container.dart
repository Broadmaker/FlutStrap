/// Flutstrap Container
///
/// A responsive container component that provides consistent spacing,
/// max-width constraints, and responsive behavior based on breakpoints.

import 'package:flutter/material.dart';
import '../core/breakpoints.dart';
import '../core/responsive.dart';
import '../core/theme.dart';
import '../core/spacing.dart'; // Import spacing for direct access

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
    Key? key,
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = FSTheme.of(context);
    final responsive = FSResponsive.of(MediaQuery.of(context).size.width);

    return Container(
      width: width,
      height: height,
      padding: padding ?? EdgeInsets.all(FSSpacing.md), // Use static constant
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
  }

  double _getMaxWidth(FSResponsive responsive, bool fluid) {
    if (fluid) return double.infinity;

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

  /// Create a container with fluid width (full width)
  FlutstrapContainer fluidWidth() {
    return FlutstrapContainer(
      child: child,
      fluid: true,
      padding: padding,
      margin: margin,
      color: color,
      decoration: decoration,
      width: width,
      height: height,
      alignment: alignment,
      clipBehavior: clipBehavior,
    );
  }

  /// Create a container with custom max width
  FlutstrapContainer withMaxWidth(double maxWidth) {
    return FlutstrapContainer(
      child: child,
      fluid: false,
      padding: padding,
      margin: margin,
      color: color,
      decoration: decoration,
      width: maxWidth,
      height: height,
      alignment: alignment,
      clipBehavior: clipBehavior,
    );
  }
}
