/// Flutstrap Responsive Utilities
///
/// Provides responsive design utilities that work with Flutstrap's breakpoint system
/// to create adaptive layouts that respond to different screen sizes.

import 'package:flutter/material.dart';
import 'breakpoints.dart';

/// Responsive utility class that provides methods for responsive design
class FSResponsive {
  final double screenWidth;
  final FSCustomBreakpoints breakpoints;

  const FSResponsive({
    required this.screenWidth,
    this.breakpoints = const FSCustomBreakpoints(),
  });

  /// Factory constructor that uses MediaQuery data from BuildContext
  factory FSResponsive.of(double width, {FSCustomBreakpoints? breakpoints}) {
    return FSResponsive(
      screenWidth: width,
      breakpoints: breakpoints ?? const FSCustomBreakpoints(),
    );
  }

  /// Get the current breakpoint based on screen width
  FSBreakpoint get breakpoint => breakpoints.getBreakpoint(screenWidth);

  /// Check if current screen size is exactly a specific breakpoint
  bool isBreakpoint(FSBreakpoint breakpoint) => this.breakpoint == breakpoint;

  /// Check if current screen size is larger than a specific breakpoint
  bool isLargerThan(FSBreakpoint breakpoint) =>
      this.breakpoint.isLargerThan(breakpoint);

  /// Check if current screen size is smaller than a specific breakpoint
  bool isSmallerThan(FSBreakpoint breakpoint) =>
      this.breakpoint.isSmallerThan(breakpoint);

  /// Check if current screen size is equal to or larger than a specific breakpoint
  bool isEqualOrLargerThan(FSBreakpoint breakpoint) =>
      this.breakpoint.isEqualOrLargerThan(breakpoint);

  /// Check if current screen size is equal to or smaller than a specific breakpoint
  bool isEqualOrSmallerThan(FSBreakpoint breakpoint) =>
      this.breakpoint.isEqualOrSmallerThan(breakpoint);

  /// Responsive value selector
  ///
  /// Returns a value based on the current breakpoint with fallback support
  T value<T>({
    T? xs,
    T? sm,
    T? md,
    T? lg,
    T? xl,
    T? xxl,
    required T fallback,
  }) {
    switch (breakpoint) {
      case FSBreakpoint.xs:
        return xs ?? sm ?? md ?? lg ?? xl ?? xxl ?? fallback;
      case FSBreakpoint.sm:
        return sm ?? xs ?? md ?? lg ?? xl ?? xxl ?? fallback;
      case FSBreakpoint.md:
        return md ?? sm ?? lg ?? xs ?? xl ?? xxl ?? fallback;
      case FSBreakpoint.lg:
        return lg ?? md ?? xl ?? sm ?? xxl ?? xs ?? fallback;
      case FSBreakpoint.xl:
        return xl ?? lg ?? xxl ?? md ?? sm ?? xs ?? fallback;
      case FSBreakpoint.xxl:
        return xxl ?? xl ?? lg ?? md ?? sm ?? xs ?? fallback;
    }
  }

  /// Conditional rendering based on breakpoint
  ///
  /// Shows [child] only when the condition is met based on breakpoint
  Widget show({
    required Widget child,
    bool showOnXs = true,
    bool showOnSm = true,
    bool showOnMd = true,
    bool showOnLg = true,
    bool showOnXl = true,
    bool showOnXxl = true,
    Widget? fallback,
  }) {
    final shouldShow = value<bool>(
      xs: showOnXs,
      sm: showOnSm,
      md: showOnMd,
      lg: showOnLg,
      xl: showOnXl,
      xxl: showOnXxl,
      fallback: true,
    );

    return shouldShow ? child : (fallback ?? const SizedBox.shrink());
  }

  /// Hide widget based on breakpoint (inverse of show)
  Widget hide({
    required Widget child,
    bool hideOnXs = false,
    bool hideOnSm = false,
    bool hideOnMd = false,
    bool hideOnLg = false,
    bool hideOnXl = false,
    bool hideOnXxl = false,
    Widget? fallback,
  }) {
    return show(
      child: child,
      showOnXs: !hideOnXs,
      showOnSm: !hideOnSm,
      showOnMd: !hideOnMd,
      showOnLg: !hideOnLg,
      showOnXl: !hideOnXl,
      showOnXxl: !hideOnXxl,
      fallback: fallback,
    );
  }

  /// Create a copy with updated screen width
  FSResponsive copyWith({
    double? screenWidth,
    FSCustomBreakpoints? breakpoints,
  }) {
    return FSResponsive(
      screenWidth: screenWidth ?? this.screenWidth,
      breakpoints: breakpoints ?? this.breakpoints,
    );
  }
}

/// Responsive value container that automatically updates with screen size
class FSResponsiveValue<T> {
  final T xs;
  final T sm;
  final T md;
  final T lg;
  final T xl;
  final T xxl;

  const FSResponsiveValue({
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.xxl,
  });

  /// Create a responsive value where all breakpoints have the same value
  const FSResponsiveValue.all(T value)
      : xs = value,
        sm = value,
        md = value,
        lg = value,
        xl = value,
        xxl = value;

  /// Get value for current breakpoint
  T value(FSBreakpoint breakpoint) {
    switch (breakpoint) {
      case FSBreakpoint.xs:
        return xs;
      case FSBreakpoint.sm:
        return sm;
      case FSBreakpoint.md:
        return md;
      case FSBreakpoint.lg:
        return lg;
      case FSBreakpoint.xl:
        return xl;
      case FSBreakpoint.xxl:
        return xxl;
    }
  }

  /// Map responsive values to different type
  FSResponsiveValue<R> map<R>(R Function(T value) mapper) {
    return FSResponsiveValue<R>(
      xs: mapper(xs),
      sm: mapper(sm),
      md: mapper(md),
      lg: mapper(lg),
      xl: mapper(xl),
      xxl: mapper(xxl),
    );
  }
}

/// Extension methods for easier responsive design
extension FSResponsiveExtensions on FSBreakpoint {
  /// Check if this breakpoint is considered mobile size
  bool get isMobile => this == FSBreakpoint.xs || this == FSBreakpoint.sm;

  /// Check if this breakpoint is considered tablet size
  bool get isTablet => this == FSBreakpoint.md;

  /// Check if this breakpoint is considered desktop size
  bool get isDesktop =>
      this == FSBreakpoint.lg ||
      this == FSBreakpoint.xl ||
      this == FSBreakpoint.xxl;

  /// Get the next larger breakpoint
  FSBreakpoint get next {
    switch (this) {
      case FSBreakpoint.xs:
        return FSBreakpoint.sm;
      case FSBreakpoint.sm:
        return FSBreakpoint.md;
      case FSBreakpoint.md:
        return FSBreakpoint.lg;
      case FSBreakpoint.lg:
        return FSBreakpoint.xl;
      case FSBreakpoint.xl:
      case FSBreakpoint.xxl:
        return FSBreakpoint.xxl;
    }
  }

  /// Get the previous smaller breakpoint
  FSBreakpoint get previous {
    switch (this) {
      case FSBreakpoint.xs:
        return FSBreakpoint.xs;
      case FSBreakpoint.sm:
        return FSBreakpoint.xs;
      case FSBreakpoint.md:
        return FSBreakpoint.sm;
      case FSBreakpoint.lg:
        return FSBreakpoint.md;
      case FSBreakpoint.xl:
        return FSBreakpoint.lg;
      case FSBreakpoint.xxl:
        return FSBreakpoint.xl;
    }
  }
}
