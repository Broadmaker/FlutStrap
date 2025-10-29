/// Flutstrap Spacing System
///
/// Provides a consistent spacing scale inspired by Bootstrap's spacing utilities
/// but optimized for Flutter's layout system.

import 'breakpoints.dart';

/// Spacing scale values following Bootstrap's 8px base unit
class FSSpacing {
  /// No spacing - 0.0
  static const double none = 0.0;

  /// Extra small spacing - 4.0
  static const double xs = 4.0;

  /// Small spacing - 8.0
  static const double sm = 8.0;

  /// Medium spacing - 16.0
  static const double md = 16.0;

  /// Large spacing - 24.0
  static const double lg = 24.0;

  /// Extra large spacing - 32.0
  static const double xl = 32.0;

  /// Double extra large spacing - 48.0
  static const double xxl = 48.0;

  /// Triple extra large spacing - 64.0
  static const double xxxl = 64.0;

  // ✅ ADD CONST CONSTRUCTOR
  const FSSpacing();

  /// Get spacing value by scale index
  static double byIndex(int index) {
    switch (index) {
      case 0:
        return none;
      case 1:
        return xs;
      case 2:
        return sm;
      case 3:
        return md;
      case 4:
        return lg;
      case 5:
        return xl;
      case 6:
        return xxl;
      case 7:
        return xxxl;
      default:
        // For indices beyond defined scale, use proportional scaling
        return sm * index;
    }
  }

  /// Get all predefined spacing values
  static List<double> get values => [none, xs, sm, md, lg, xl, xxl, xxxl];

  /// Get spacing values as a map for easy access
  static Map<String, double> get map => {
        'none': none,
        'xs': xs,
        'sm': sm,
        'md': md,
        'lg': lg,
        'xl': xl,
        'xxl': xxl,
        'xxxl': xxxl,
      };
}

/// Spacing scale identifiers
enum FSSpacingScale {
  none,
  xs,
  sm,
  md,
  lg,
  xl,
  xxl,
  xxxl,
}

/// Extension methods for [FSSpacingScale] enum
extension FSSpacingScaleExtensions on FSSpacingScale {
  /// Get the numeric value of this spacing scale
  double get value {
    switch (this) {
      case FSSpacingScale.none:
        return FSSpacing.none;
      case FSSpacingScale.xs:
        return FSSpacing.xs;
      case FSSpacingScale.sm:
        return FSSpacing.sm;
      case FSSpacingScale.md:
        return FSSpacing.md;
      case FSSpacingScale.lg:
        return FSSpacing.lg;
      case FSSpacingScale.xl:
        return FSSpacing.xl;
      case FSSpacingScale.xxl:
        return FSSpacing.xxl;
      case FSSpacingScale.xxxl:
        return FSSpacing.xxxl;
    }
  }

  /// Get the string name of this spacing scale
  String get name => toString().split('.').last;
}

/// Custom spacing configuration for advanced theming
class FSCustomSpacing {
  final double none;
  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double xxl;
  final double xxxl;

  const FSCustomSpacing({
    this.none = FSSpacing.none,
    this.xs = FSSpacing.xs,
    this.sm = FSSpacing.sm,
    this.md = FSSpacing.md,
    this.lg = FSSpacing.lg,
    this.xl = FSSpacing.xl,
    this.xxl = FSSpacing.xxl,
    this.xxxl = FSSpacing.xxxl,
  });

  /// Get spacing value by scale enum
  double value(FSSpacingScale scale) {
    switch (scale) {
      case FSSpacingScale.none:
        return none;
      case FSSpacingScale.xs:
        return xs;
      case FSSpacingScale.sm:
        return sm;
      case FSSpacingScale.md:
        return md;
      case FSSpacingScale.lg:
        return lg;
      case FSSpacingScale.xl:
        return xl;
      case FSSpacingScale.xxl:
        return xxl;
      case FSSpacingScale.xxxl:
        return xxxl;
    }
  }

  /// Get spacing value by scale index
  double byIndex(int index) {
    switch (index) {
      case 0:
        return none;
      case 1:
        return xs;
      case 2:
        return sm;
      case 3:
        return md;
      case 4:
        return lg;
      case 5:
        return xl;
      case 6:
        return xxl;
      case 7:
        return xxxl;
      default:
        return sm * index;
    }
  }

  /// Get all spacing values
  List<double> get values => [none, xs, sm, md, lg, xl, xxl, xxxl];

  /// Create a copy with updated values
  FSCustomSpacing copyWith({
    double? none,
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? xxl,
    double? xxxl,
  }) {
    return FSCustomSpacing(
      none: none ?? this.none,
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      xxl: xxl ?? this.xxl,
      xxxl: xxxl ?? this.xxxl,
    );
  }

  /// Create spacing with multiplier applied to all values
  FSCustomSpacing withMultiplier(double multiplier) {
    return FSCustomSpacing(
      none: none * multiplier,
      xs: xs * multiplier,
      sm: sm * multiplier,
      md: md * multiplier,
      lg: lg * multiplier,
      xl: xl * multiplier,
      xxl: xxl * multiplier,
      xxxl: xxxl * multiplier,
    );
  }
}

/// Responsive spacing that adapts to breakpoints
class FSResponsiveSpacing {
  final FSCustomSpacing xs;
  final FSCustomSpacing sm;
  final FSCustomSpacing md;
  final FSCustomSpacing lg;
  final FSCustomSpacing xl;
  final FSCustomSpacing xxl;

  const FSResponsiveSpacing({
    FSCustomSpacing? xs,
    FSCustomSpacing? sm,
    FSCustomSpacing? md,
    FSCustomSpacing? lg,
    FSCustomSpacing? xl,
    FSCustomSpacing? xxl,
  })  : xs = xs ?? const FSCustomSpacing(),
        sm = sm ?? const FSCustomSpacing(),
        md = md ?? const FSCustomSpacing(),
        lg = lg ?? const FSCustomSpacing(),
        xl = xl ?? const FSCustomSpacing(),
        xxl = xxl ?? const FSCustomSpacing();

  /// Get spacing for a specific breakpoint
  FSCustomSpacing forBreakpoint(FSBreakpoint breakpoint) {
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

  /// Create a copy with updated values
  FSResponsiveSpacing copyWith({
    FSCustomSpacing? xs,
    FSCustomSpacing? sm,
    FSCustomSpacing? md,
    FSCustomSpacing? lg,
    FSCustomSpacing? xl,
    FSCustomSpacing? xxl,
  }) {
    return FSResponsiveSpacing(
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      xxl: xxl ?? this.xxl,
    );
  }
}
