/// Flutstrap Breakpoint System
///
/// Defines the responsive breakpoints inspired by Bootstrap but optimized
/// for Flutter and mobile-first design approach.

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

/// Flutstrap breakpoint values matching Bootstrap's default breakpoints
/// but converted to logical pixels for Flutter
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

  /// Get the numeric value for a given breakpoint
  static double value(FSBreakpoint breakpoint) {
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
        return xl; // xxl uses same as xl by default
    }
  }

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

/// Custom breakpoint configuration for advanced theming
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
    this.xxl = FSBreakpoints.xl,
  });

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
