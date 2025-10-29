/// Flutstrap Responsive Utilities
///
/// Provides responsive design utilities that work with Flutstrap's breakpoint system
/// to create adaptive layouts that respond to different screen sizes.
///
/// ## Usage Examples
///
/// ```dart
/// // Responsive value selection
/// final padding = FSResponsive.of(MediaQuery.of(context).size.width).value<double>(
///   xs: 16.0,    // Mobile
///   sm: 20.0,    // Small tablet
///   md: 24.0,    // Tablet
///   lg: 32.0,    // Desktop
///   fallback: 24.0,
/// );
///
/// // Conditional rendering
/// FSResponsive.layoutBuilder(
///   context,
///   builder: (responsive) {
///     return responsive.show(
///       child: FloatingActionButton(onPressed: () {}),
///       showOnXs: false, // Hide FAB on mobile
///       showOnSm: false, // Hide FAB on small tablets
///     );
///   },
/// )
///
/// // Responsive widget building
/// responsive.builder(
///   builder: (breakpoint) {
///     switch (breakpoint) {
///       case FSBreakpoint.xs:
///         return MobileLayout();
///       case FSBreakpoint.sm:
///       case FSBreakpoint.md:
///         return TabletLayout();
///       default:
///         return DesktopLayout();
///     }
///   },
/// )
///
/// // Using responsive value container
/// static const responsivePadding = FSResponsiveValue<double>(
///   xs: 16.0,
///   sm: 20.0,
///   md: 24.0,
///   lg: 32.0,
///   xl: 40.0,
///   xxl: 48.0,
/// );
///
/// final padding = responsivePadding.value(responsive.breakpoint);
/// ```
///
/// {@category Core}
/// {@category Responsive}

import 'package:flutter/material.dart';
import 'breakpoints.dart';

/// Cache key for breakpoint caching
class _BreakpointCacheKey {
  final double screenWidth;
  final FSCustomBreakpoints breakpoints;

  const _BreakpointCacheKey(this.screenWidth, this.breakpoints);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _BreakpointCacheKey &&
          runtimeType == other.runtimeType &&
          screenWidth == other.screenWidth &&
          breakpoints == other.breakpoints;

  @override
  int get hashCode => Object.hash(screenWidth, breakpoints);
}

/// Responsive utility class that provides methods for responsive design
class FSResponsive {
  final double screenWidth;
  final FSCustomBreakpoints breakpoints;

  const FSResponsive({
    required this.screenWidth,
    this.breakpoints = const FSCustomBreakpoints(),
  });

  // ✅ BREAKPOINT CACHING FOR PERFORMANCE
  static final _breakpointCache = <_BreakpointCacheKey, FSBreakpoint>{};
  static const _maxCacheSize = 100;

  /// Factory constructor that creates responsive instance from screen width
  factory FSResponsive.of(double width, {FSCustomBreakpoints? breakpoints}) {
    return FSResponsive(
      screenWidth: width,
      breakpoints: breakpoints ?? const FSCustomBreakpoints(),
    );
  }

  /// Factory constructor from BuildContext using MediaQuery
  factory FSResponsive.fromContext(BuildContext context,
      {FSCustomBreakpoints? breakpoints}) {
    final mediaQuery = MediaQuery.of(context);
    return FSResponsive(
      screenWidth: mediaQuery.size.width,
      breakpoints: breakpoints ?? const FSCustomBreakpoints(),
    );
  }

  /// Get the current breakpoint based on screen width with caching
  FSBreakpoint get breakpoint {
    final cacheKey = _BreakpointCacheKey(screenWidth, breakpoints);

    return _breakpointCache.putIfAbsent(cacheKey, () {
      // ✅ MAINTAIN CACHE SIZE
      if (_breakpointCache.length > _maxCacheSize) {
        _breakpointCache.remove(_breakpointCache.keys.first);
      }
      return breakpoints.getBreakpoint(screenWidth);
    });
  }

  // ✅ EFFICIENT BREAKPOINT CHECKS USING ENUM INDEX
  /// Check if current screen size is exactly a specific breakpoint
  bool isBreakpoint(FSBreakpoint breakpoint) => this.breakpoint == breakpoint;

  /// Check if current screen size is larger than a specific breakpoint
  bool isLargerThan(FSBreakpoint breakpoint) =>
      this.breakpoint.index > breakpoint.index;

  /// Check if current screen size is smaller than a specific breakpoint
  bool isSmallerThan(FSBreakpoint breakpoint) =>
      this.breakpoint.index < breakpoint.index;

  /// Check if current screen size is equal to or larger than a specific breakpoint
  bool isEqualOrLargerThan(FSBreakpoint breakpoint) =>
      this.breakpoint.index >= breakpoint.index;

  /// Check if current screen size is equal to or smaller than a specific breakpoint
  bool isEqualOrSmallerThan(FSBreakpoint breakpoint) =>
      this.breakpoint.index <= breakpoint.index;

  // ✅ OPTIMIZED VALUE RESOLUTION WITH MOBILE-FIRST PRIORITY
  /// Responsive value selector with efficient fallback logic
  ///
  /// Uses mobile-first approach: falls back to smaller breakpoints first,
  /// then larger breakpoints if no value is found.
  T value<T>({
    T? xs,
    T? sm,
    T? md,
    T? lg,
    T? xl,
    T? xxl,
    required T fallback,
  }) {
    final values = [xs, sm, md, lg, xl, xxl];

    switch (breakpoint) {
      case FSBreakpoint.xs:
        return _findFirstNonNull(values, 0, fallback);
      case FSBreakpoint.sm:
        return _findFirstNonNull(values, 1, fallback);
      case FSBreakpoint.md:
        return _findFirstNonNull(values, 2, fallback);
      case FSBreakpoint.lg:
        return _findFirstNonNull(values, 3, fallback);
      case FSBreakpoint.xl:
        return _findFirstNonNull(values, 4, fallback);
      case FSBreakpoint.xxl:
        return _findFirstNonNull(values, 5, fallback);
    }
  }

  /// Efficiently find first non-null value in prioritized order (mobile-first)
  T _findFirstNonNull<T>(List<T?> values, int startIndex, T fallback) {
    // ✅ CHECK CURRENT AND SMALLER BREAKPOINTS FIRST (MOBILE-FIRST)
    for (var i = startIndex; i >= 0; i--) {
      if (values[i] != null) return values[i] as T;
    }
    // ✅ THEN CHECK LARGER BREAKPOINTS
    for (var i = startIndex + 1; i < values.length; i++) {
      if (values[i] != null) return values[i] as T;
    }
    return fallback;
  }

  // ✅ ENHANCED WIDGET METHODS WITH ERROR HANDLING

  /// Conditional rendering based on breakpoint
  ///
  /// Shows [child] only when the condition is met based on breakpoint.
  /// Returns [fallback] widget when condition is not met.
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
  ///
  /// Hides [child] when the condition is met based on breakpoint.
  /// Returns [fallback] widget when condition is met.
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

  /// Responsive widget builder for conditional rendering
  ///
  /// Builds different widgets based on the current breakpoint.
  /// Provides error handling for builder exceptions.
  Widget builder({
    required Widget Function(FSBreakpoint breakpoint) builder,
    Widget? fallback,
  }) {
    try {
      return builder(breakpoint);
    } catch (e) {
      assert(false, 'Error in responsive builder: $e');
      return fallback ?? const SizedBox.shrink();
    }
  }

  /// Create a responsive layout builder widget
  ///
  /// Wraps the builder in a LayoutBuilder for automatic responsive updates
  /// when screen size changes.
  static Widget layoutBuilder(
    BuildContext context, {
    required Widget Function(FSResponsive responsive) builder,
    FSCustomBreakpoints? breakpoints,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final responsive = FSResponsive.of(
          constraints.maxWidth,
          breakpoints: breakpoints,
        );
        return builder(responsive);
      },
    );
  }

  /// Create a responsive value builder widget
  ///
  /// Builds widgets based on responsive values without manual breakpoint handling.
  static Widget valueBuilder<T>({
    required BuildContext context,
    required T Function(FSResponsive responsive) valueSelector,
    required Widget Function(T value) builder,
    FSCustomBreakpoints? breakpoints,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final responsive = FSResponsive.of(
          constraints.maxWidth,
          breakpoints: breakpoints,
        );
        final value = valueSelector(responsive);
        return builder(value);
      },
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

  // ✅ EQUALITY AND HASHCODE FOR BETTER PERFORMANCE
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FSResponsive &&
          runtimeType == other.runtimeType &&
          screenWidth == other.screenWidth &&
          breakpoints == other.breakpoints;

  @override
  int get hashCode => Object.hash(screenWidth, breakpoints);

  @override
  String toString() =>
      'FSResponsive(screenWidth: $screenWidth, breakpoint: $breakpoint)';
}

/// Responsive value container that automatically updates with screen size
///
/// Provides a type-safe way to define responsive values for all breakpoints.
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

  /// Get value using FSResponsive instance
  T valueFromResponsive(FSResponsive responsive) {
    return value(responsive.breakpoint);
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

  /// Create a new responsive value by combining with another
  FSResponsiveValue<R> combine<R, U>(
    FSResponsiveValue<U> other,
    R Function(T, U) combiner,
  ) {
    return FSResponsiveValue<R>(
      xs: combiner(xs, other.xs),
      sm: combiner(sm, other.sm),
      md: combiner(md, other.md),
      lg: combiner(lg, other.lg),
      xl: combiner(xl, other.xl),
      xxl: combiner(xxl, other.xxl),
    );
  }

  // ✅ EQUALITY AND HASHCODE
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FSResponsiveValue &&
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
      'FSResponsiveValue(xs: $xs, sm: $sm, md: $md, lg: $lg, xl: $xl, xxl: $xxl)';
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

  /// Get the minimum width for this breakpoint
  double get minWidth {
    switch (this) {
      case FSBreakpoint.xs:
        return 0;
      case FSBreakpoint.sm:
        return FSBreakpoints.sm;
      case FSBreakpoint.md:
        return FSBreakpoints.md;
      case FSBreakpoint.lg:
        return FSBreakpoints.lg;
      case FSBreakpoint.xl:
        return FSBreakpoints.xl;
      case FSBreakpoint.xxl:
        return FSBreakpoints.xl; // ✅ FIXED: xxl uses xl value
    }
  }

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

  /// Get human-readable name for the breakpoint
  String get name {
    switch (this) {
      case FSBreakpoint.xs:
        return 'XS';
      case FSBreakpoint.sm:
        return 'SM';
      case FSBreakpoint.md:
        return 'MD';
      case FSBreakpoint.lg:
        return 'LG';
      case FSBreakpoint.xl:
        return 'XL';
      case FSBreakpoint.xxl:
        return 'XXL';
    }
  }
}

/// Extension methods for BuildContext for easier responsive access
extension FSResponsiveContextExtensions on BuildContext {
  /// Get responsive utilities for current screen size
  FSResponsive get responsive {
    final mediaQuery = MediaQuery.of(this);
    return FSResponsive.of(mediaQuery.size.width);
  }

  /// Get current breakpoint
  FSBreakpoint get breakpoint => responsive.breakpoint;

  /// Check if current screen is mobile size
  bool get isMobile => breakpoint.isMobile;

  /// Check if current screen is tablet size
  bool get isTablet => breakpoint.isTablet;

  /// Check if current screen is desktop size
  bool get isDesktop => breakpoint.isDesktop;
}
