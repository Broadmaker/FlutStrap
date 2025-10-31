/// {@template flutstrap_breakpoint_system}
/// ## Flutstrap Breakpoint System
///
/// Defines the responsive breakpoints inspired by Bootstrap but optimized
/// for Flutter and mobile-first design approach.
///
/// ### Default Breakpoints (logical pixels):
///
/// - **XS**: 576px (portrait phones)
/// - **SM**: 768px (landscape phones)
/// - **MD**: 992px (tablets)
/// - **LG**: 1200px (desktops)
/// - **XL**: 1400px (large desktops)
/// - **XXL**: 1600px (larger desktops)
///
/// ### Usage Examples:
///
/// ```dart
/// // Get current breakpoint
/// final breakpoint = FSCustomBreakpoints().getBreakpoint(MediaQuery.of(context).size.width);
///
/// // Responsive layout
/// if (breakpoint == FSBreakpoint.xs) {
///   return MobileLayout();
/// } else {
///   return DesktopLayout();
/// }
///
/// // Using breakpoint extensions
/// if (FSBreakpoint.lg.isLargerThan(currentBreakpoint)) {
///   return CompactLayout();
/// }
/// ```
/// {@endtemplate}
///
/// {@template flutstrap_breakpoints.performance}
/// ## Performance Features
///
/// - **Compile-time Constants**: All default breakpoints are const for better performance
/// - **Efficient Lookups**: Cached value mappings for fast breakpoint resolution
/// - **Memory Optimized**: Lightweight breakpoint detection without heavy computations
/// - **Tree-shakeable**: Unused breakpoint configurations can be removed by Dart compiler
///
/// ### Best Practices:
///
/// - Use `const FSCustomBreakpoints()` when using default values
/// - Cache breakpoint calculations in stateful widgets
/// - Use breakpoint extensions for cleaner code
/// - Consider using `LayoutBuilder` for responsive layouts
/// {@endtemplate}
///
/// {@category Responsive}
/// {@category Layout}
/// {@category Foundation}

/// Breakpoint identifiers for different screen sizes
enum FSBreakpoint {
  /// Extra small devices (portrait phones, less than 576px)
  xs,

  /// Small devices (landscape phones, 576px and up)
  sm,

  /// Medium devices (tablets, 768px and up)
  md,

  /// Large devices (desktops, 992px and up)
  lg,

  /// Extra large devices (large desktops, 1200px and up)
  xl,

  /// Double extra large devices (larger desktops, 1400px and up)
  xxl,
}

/// {@template fs_breakpoints}
/// Flutstrap breakpoint values matching Bootstrap's default breakpoints
/// but converted to logical pixels for Flutter.
///
/// These values represent the minimum width at which each breakpoint applies
/// in a mobile-first responsive design approach.
/// {@endtemplate}
class FSBreakpoints {
  /// Maximum container width for extra small screens
  static const double xs = 576;

  /// Maximum container width for small screens
  static const double sm = 768;

  /// Maximum container width for medium screens
  static const double md = 992;

  /// Maximum container width for large screens
  static const double lg = 1200;

  /// Maximum container width for extra large screens
  static const double xl = 1400;

  /// Maximum container width for double extra large screens
  static const double xxl = 1600;

  // ✅ Cached value mapping for faster lookups
  static const Map<FSBreakpoint, double> _values = {
    FSBreakpoint.xs: xs,
    FSBreakpoint.sm: sm,
    FSBreakpoint.md: md,
    FSBreakpoint.lg: lg,
    FSBreakpoint.xl: xl,
    FSBreakpoint.xxl: xxl,
  };

  /// Get the numeric value for a given breakpoint
  static double value(FSBreakpoint breakpoint) => _values[breakpoint]!;

  /// Get the breakpoint name as a string
  static String name(FSBreakpoint breakpoint) {
    return breakpoint.toString().split('.').last;
  }

  /// Convert breakpoint to human-readable format
  static String displayName(FSBreakpoint breakpoint) {
    switch (breakpoint) {
      case FSBreakpoint.xs:
        return 'Extra Small';
      case FSBreakpoint.sm:
        return 'Small';
      case FSBreakpoint.md:
        return 'Medium';
      case FSBreakpoint.lg:
        return 'Large';
      case FSBreakpoint.xl:
        return 'Extra Large';
      case FSBreakpoint.xxl:
        return 'Double Extra Large';
    }
  }
}

/// Extension methods for [FSBreakpoint] enum
extension FSBreakpointExtensions on FSBreakpoint {
  /// Get the numeric value of this breakpoint
  double get value => FSBreakpoints.value(this);

  /// Get the string name of this breakpoint
  String get name => FSBreakpoints.name(this);

  /// Get the display name of this breakpoint
  String get displayName => FSBreakpoints.displayName(this);

  /// Check if this breakpoint is larger than another breakpoint
  bool isLargerThan(FSBreakpoint other) => value > other.value;

  /// Check if this breakpoint is smaller than another breakpoint
  bool isSmallerThan(FSBreakpoint other) => value < other.value;

  /// Check if this breakpoint is equal to or larger than another breakpoint
  bool isEqualOrLargerThan(FSBreakpoint other) => value >= other.value;

  /// Check if this breakpoint is equal to or smaller than another breakpoint
  bool isEqualOrSmallerThan(FSBreakpoint other) => value <= other.value;
}

/// {@template fs_custom_breakpoints}
/// Custom breakpoint configuration for advanced theming and responsive design.
///
/// Allows customization of breakpoint values for specific design requirements
/// while maintaining the same mobile-first responsive approach.
///
/// ### Example:
///
/// ```dart
/// const customBreakpoints = FSCustomBreakpoints(
///   sm: 600,  // Custom small breakpoint
///   lg: 1100, // Custom large breakpoint
/// );
/// ```
/// {@endtemplate}
class FSCustomBreakpoints {
  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double xxl;

  const FSCustomBreakpoints({
    this.xs = FSBreakpoints.xs,
    this.sm = FSBreakpoints.sm,
    this.md = FSBreakpoints.md,
    this.lg = FSBreakpoints.lg,
    this.xl = FSBreakpoints.xl,
    this.xxl = FSBreakpoints.xxl,
  })  : assert(xs >= 0 && sm >= 0 && md >= 0 && lg >= 0 && xl >= 0 && xxl >= 0,
            'Breakpoint values must be non-negative'),
        assert(xs < sm && sm < md && md < lg && lg < xl && xl < xxl,
            'Breakpoints must be in ascending order');

  /// Get the numeric value for a given breakpoint from custom configuration
  double value(FSBreakpoint breakpoint) {
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

  /// Get the current breakpoint based on screen width
  FSBreakpoint getBreakpoint(double screenWidth) {
    if (screenWidth < xs) return FSBreakpoint.xs;
    if (screenWidth < sm) return FSBreakpoint.sm;
    if (screenWidth < md) return FSBreakpoint.md;
    if (screenWidth < lg) return FSBreakpoint.lg;
    if (screenWidth < xl) return FSBreakpoint.xl;
    return FSBreakpoint.xxl;
  }

  /// Create a copy with updated values
  FSCustomBreakpoints copyWith({
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? xxl,
  }) {
    return FSCustomBreakpoints(
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      xxl: xxl ?? this.xxl,
    );
  }
}

/// Extension methods for [FSCustomBreakpoints]
extension FSCustomBreakpointsExtensions on FSCustomBreakpoints {
  /// Check if screen width matches a specific breakpoint
  bool isBreakpoint(double screenWidth, FSBreakpoint breakpoint) {
    return getBreakpoint(screenWidth) == breakpoint;
  }

  /// Check if screen width is at least a specific breakpoint
  bool isAtLeast(double screenWidth, FSBreakpoint breakpoint) {
    return screenWidth >= value(breakpoint);
  }

  /// Check if screen width is less than a specific breakpoint
  bool isLessThan(double screenWidth, FSBreakpoint breakpoint) {
    return screenWidth < value(breakpoint);
  }

  /// Check if screen width is between two breakpoints (inclusive)
  bool isBetween(double screenWidth, FSBreakpoint min, FSBreakpoint max) {
    return screenWidth >= value(min) && screenWidth < value(max);
  }

  /// Get the next larger breakpoint
  FSBreakpoint? nextBreakpoint(FSBreakpoint current) {
    final values = [
      FSBreakpoint.xs,
      FSBreakpoint.sm,
      FSBreakpoint.md,
      FSBreakpoint.lg,
      FSBreakpoint.xl,
      FSBreakpoint.xxl
    ];
    final index = values.indexOf(current);
    return index < values.length - 1 ? values[index + 1] : null;
  }

  /// Get the previous smaller breakpoint
  FSBreakpoint? previousBreakpoint(FSBreakpoint current) {
    final values = [
      FSBreakpoint.xs,
      FSBreakpoint.sm,
      FSBreakpoint.md,
      FSBreakpoint.lg,
      FSBreakpoint.xl,
      FSBreakpoint.xxl
    ];
    final index = values.indexOf(current);
    return index > 0 ? values[index - 1] : null;
  }
}
