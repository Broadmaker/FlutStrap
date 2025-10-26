/// Flutstrap Visibility Utilities
///
/// Responsive visibility components that show or hide content
/// based on breakpoints and screen sizes.

import 'package:flutter/material.dart';
import '../core/breakpoints.dart';
import '../core/responsive.dart';
import '../core/theme.dart';

/// Flutstrap Visibility Component
///
/// Shows or hides content based on breakpoint conditions.
class FlutstrapVisibility extends StatelessWidget {
  final Widget child;
  final bool showOnXs;
  final bool showOnSm;
  final bool showOnMd;
  final bool showOnLg;
  final bool showOnXl;
  final bool showOnXxl;
  final Widget? fallback;

  const FlutstrapVisibility({
    Key? key,
    required this.child,
    this.showOnXs = true,
    this.showOnSm = true,
    this.showOnMd = true,
    this.showOnLg = true,
    this.showOnXl = true,
    this.showOnXxl = true,
    this.fallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = FSResponsive.of(MediaQuery.of(context).size.width);
    final breakpoint = responsive.breakpoint;

    // Direct switch statement - no complex fallback logic
    bool shouldShow;
    switch (breakpoint) {
      case FSBreakpoint.xs:
        shouldShow = showOnXs;
        break;
      case FSBreakpoint.sm:
        shouldShow = showOnSm;
        break;
      case FSBreakpoint.md:
        shouldShow = showOnMd;
        break;
      case FSBreakpoint.lg:
        shouldShow = showOnLg;
        break;
      case FSBreakpoint.xl:
        shouldShow = showOnXl;
        break;
      case FSBreakpoint.xxl:
        shouldShow = showOnXxl;
        break;
    }

    return shouldShow ? child : (fallback ?? const SizedBox.shrink());
  }

  /// Show only on extra small screens (xs)
  factory FlutstrapVisibility.xsOnly({
    required Widget child,
    Widget? fallback,
  }) {
    return FlutstrapVisibility(
      child: child,
      showOnXs: true,
      showOnSm: false,
      showOnMd: false,
      showOnLg: false,
      showOnXl: false,
      showOnXxl: false,
      fallback: fallback,
    );
  }

  /// Show only on small screens (sm)
  factory FlutstrapVisibility.smOnly({
    required Widget child,
    Widget? fallback,
  }) {
    return FlutstrapVisibility(
      child: child,
      showOnXs: false,
      showOnSm: true,
      showOnMd: false,
      showOnLg: false,
      showOnXl: false,
      showOnXxl: false,
      fallback: fallback,
    );
  }

  /// Show only on medium screens (md)
  factory FlutstrapVisibility.mdOnly({
    required Widget child,
    Widget? fallback,
  }) {
    return FlutstrapVisibility(
      child: child,
      showOnXs: false,
      showOnSm: false,
      showOnMd: true,
      showOnLg: false,
      showOnXl: false,
      showOnXxl: false,
      fallback: fallback,
    );
  }

  /// Show only on large screens (lg)
  factory FlutstrapVisibility.lgOnly({
    required Widget child,
    Widget? fallback,
  }) {
    return FlutstrapVisibility(
      child: child,
      showOnXs: false,
      showOnSm: false,
      showOnMd: false,
      showOnLg: true,
      showOnXl: false,
      showOnXxl: false,
      fallback: fallback,
    );
  }

  /// Show only on extra large screens (xl)
  factory FlutstrapVisibility.xlOnly({
    required Widget child,
    Widget? fallback,
  }) {
    return FlutstrapVisibility(
      child: child,
      showOnXs: false,
      showOnSm: false,
      showOnMd: false,
      showOnLg: false,
      showOnXl: true,
      showOnXxl: false,
      fallback: fallback,
    );
  }

  /// Show only on double extra large screens (xxl)
  factory FlutstrapVisibility.xxlOnly({
    required Widget child,
    Widget? fallback,
  }) {
    return FlutstrapVisibility(
      child: child,
      showOnXs: false,
      showOnSm: false,
      showOnMd: false,
      showOnLg: false,
      showOnXl: false,
      showOnXxl: true,
      fallback: fallback,
    );
  }

  /// Show only on mobile screens (xs and sm)
  factory FlutstrapVisibility.mobileOnly({
    required Widget child,
    Widget? fallback,
  }) {
    return FlutstrapVisibility(
      child: child,
      showOnXs: true,
      showOnSm: true,
      showOnMd: false,
      showOnLg: false,
      showOnXl: false,
      showOnXxl: false,
      fallback: fallback,
    );
  }

  /// Show only on tablet screens (md)
  factory FlutstrapVisibility.tabletOnly({
    required Widget child,
    Widget? fallback,
  }) {
    return FlutstrapVisibility(
      child: child,
      showOnXs: false,
      showOnSm: false,
      showOnMd: true,
      showOnLg: false,
      showOnXl: false,
      showOnXxl: false,
      fallback: fallback,
    );
  }

  /// Show only on desktop screens (lg, xl, xxl)
  factory FlutstrapVisibility.desktopOnly({
    required Widget child,
    Widget? fallback,
  }) {
    return FlutstrapVisibility(
      child: child,
      showOnXs: false,
      showOnSm: false,
      showOnMd: false,
      showOnLg: true,
      showOnXl: true,
      showOnXxl: true,
      fallback: fallback,
    );
  }

  /// Hide on extra small screens (xs)
  factory FlutstrapVisibility.hideOnXs({
    required Widget child,
    Widget? fallback,
  }) {
    return FlutstrapVisibility(
      child: child,
      showOnXs: false,
      showOnSm: true,
      showOnMd: true,
      showOnLg: true,
      showOnXl: true,
      showOnXxl: true,
      fallback: fallback,
    );
  }

  /// Hide on small screens (sm)
  factory FlutstrapVisibility.hideOnSm({
    required Widget child,
    Widget? fallback,
  }) {
    return FlutstrapVisibility(
      child: child,
      showOnXs: true,
      showOnSm: false,
      showOnMd: true,
      showOnLg: true,
      showOnXl: true,
      showOnXxl: true,
      fallback: fallback,
    );
  }

  /// Hide on medium screens (md)
  factory FlutstrapVisibility.hideOnMd({
    required Widget child,
    Widget? fallback,
  }) {
    return FlutstrapVisibility(
      child: child,
      showOnXs: true,
      showOnSm: true,
      showOnMd: false,
      showOnLg: true,
      showOnXl: true,
      showOnXxl: true,
      fallback: fallback,
    );
  }

  /// Hide on large screens (lg)
  factory FlutstrapVisibility.hideOnLg({
    required Widget child,
    Widget? fallback,
  }) {
    return FlutstrapVisibility(
      child: child,
      showOnXs: true,
      showOnSm: true,
      showOnMd: true,
      showOnLg: false,
      showOnXl: true,
      showOnXxl: true,
      fallback: fallback,
    );
  }

  /// Hide on mobile screens (xs and sm)
  factory FlutstrapVisibility.hideOnMobile({
    required Widget child,
    Widget? fallback,
  }) {
    return FlutstrapVisibility(
      child: child,
      showOnXs: false,
      showOnSm: false,
      showOnMd: true,
      showOnLg: true,
      showOnXl: true,
      showOnXxl: true,
      fallback: fallback,
    );
  }

  /// Hide on desktop screens (lg, xl, xxl)
  factory FlutstrapVisibility.hideOnDesktop({
    required Widget child,
    Widget? fallback,
  }) {
    return FlutstrapVisibility(
      child: child,
      showOnXs: true,
      showOnSm: true,
      showOnMd: true,
      showOnLg: false,
      showOnXl: false,
      showOnXxl: false,
      fallback: fallback,
    );
  }
}
