/// Flutstrap Visibility Utilities - PERFECTED VERSION
///
/// Responsive visibility components that show or hide content
/// based on breakpoints and screen sizes.
///
/// {@category Layout}
/// {@category Components}

import 'package:flutter/material.dart';
import '../core/breakpoints.dart';
import '../core/responsive.dart';

/// Flutstrap Visibility Component
///
/// {@template flutstrap_visibility.important_notes}
/// Shows or hides content based on breakpoint conditions.
/// Uses efficient breakpoint detection with minimal rebuilds.
/// {@endtemplate}
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
    super.key,
    required this.child,
    this.showOnXs = true,
    this.showOnSm = true,
    this.showOnMd = true,
    this.showOnLg = true,
    this.showOnXl = true,
    this.showOnXxl = true,
    this.fallback,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final responsive = FSResponsive.of(screenWidth);
    final breakpoint = responsive.breakpoint;

    final shouldShow = _shouldShowOnBreakpoint(breakpoint);
    return shouldShow ? child : (fallback ?? const SizedBox.shrink());
  }

  bool _shouldShowOnBreakpoint(FSBreakpoint breakpoint) {
    switch (breakpoint) {
      case FSBreakpoint.xs:
        return showOnXs;
      case FSBreakpoint.sm:
        return showOnSm;
      case FSBreakpoint.md:
        return showOnMd;
      case FSBreakpoint.lg:
        return showOnLg;
      case FSBreakpoint.xl:
        return showOnXl;
      case FSBreakpoint.xxl:
        return showOnXxl;
    }
  }

  // ✅ COMPREHENSIVE FACTORY METHODS WITH DOCUMENTATION

  /// {@template flutstrap_visibility.xs_only}
  /// Shows the child only on extra small screens (mobile phones in portrait)
  /// Hides on all other screen sizes
  /// {@endtemplate}
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

  /// {@template flutstrap_visibility.sm_only}
  /// Shows the child only on small screens (mobile phones in landscape)
  /// Hides on all other screen sizes
  /// {@endtemplate}
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

  /// {@template flutstrap_visibility.md_only}
  /// Shows the child only on medium screens (tablets)
  /// Hides on all other screen sizes
  /// {@endtemplate}
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

  /// {@template flutstrap_visibility.lg_only}
  /// Shows the child only on large screens (small desktops)
  /// Hides on all other screen sizes
  /// {@endtemplate}
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

  /// {@template flutstrap_visibility.xl_only}
  /// Shows the child only on extra large screens (medium desktops)
  /// Hides on all other screen sizes
  /// {@endtemplate}
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

  /// {@template flutstrap_visibility.xxl_only}
  /// Shows the child only on double extra large screens (large desktops)
  /// Hides on all other screen sizes
  /// {@endtemplate}
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

  /// {@template flutstrap_visibility.mobile_only}
  /// Shows the child only on mobile screens (xs and sm breakpoints)
  /// Hides on tablet and desktop screens
  /// {@endtemplate}
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

  /// {@template flutstrap_visibility.tablet_only}
  /// Shows the child only on tablet screens (md breakpoint)
  /// Hides on mobile and desktop screens
  /// {@endtemplate}
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

  /// {@template flutstrap_visibility.desktop_only}
  /// Shows the child only on desktop screens (lg, xl, and xxl breakpoints)
  /// Hides on mobile and tablet screens
  /// {@endtemplate}
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

  // HIDE METHODS

  /// {@template flutstrap_visibility.hide_on_xs}
  /// Hides the child on extra small screens (xs breakpoint)
  /// Shows on all other screen sizes
  /// {@endtemplate}
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

  /// {@template flutstrap_visibility.hide_on_sm}
  /// Hides the child on small screens (sm breakpoint)
  /// Shows on all other screen sizes
  /// {@endtemplate}
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

  /// {@template flutstrap_visibility.hide_on_mobile}
  /// Hides the child on mobile screens (xs and sm breakpoints)
  /// Shows on tablet and desktop screens
  /// {@endtemplate}
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

  /// {@template flutstrap_visibility.hide_on_desktop}
  /// Hides the child on desktop screens (lg, xl, and xxl breakpoints)
  /// Shows on mobile and tablet screens
  /// {@endtemplate}
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

  // ✅ COPYWITH PATTERN FOR CONSISTENCY
  FlutstrapVisibility copyWith({
    Key? key,
    Widget? child,
    bool? showOnXs,
    bool? showOnSm,
    bool? showOnMd,
    bool? showOnLg,
    bool? showOnXl,
    bool? showOnXxl,
    Widget? fallback,
  }) {
    return FlutstrapVisibility(
      key: key ?? this.key,
      child: child ?? this.child,
      showOnXs: showOnXs ?? this.showOnXs,
      showOnSm: showOnSm ?? this.showOnSm,
      showOnMd: showOnMd ?? this.showOnMd,
      showOnLg: showOnLg ?? this.showOnLg,
      showOnXl: showOnXl ?? this.showOnXl,
      showOnXxl: showOnXxl ?? this.showOnXxl,
      fallback: fallback ?? this.fallback,
    );
  }
}
