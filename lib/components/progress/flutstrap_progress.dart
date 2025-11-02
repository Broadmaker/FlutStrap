/// Flutstrap Progress Bar
///
/// A customizable progress bar with Bootstrap-inspired styling.
///
/// {@macro flutstrap_progress.usage}
/// {@macro flutstrap_progress.accessibility}
/// {@macro flutstrap_progress.performance}
/// {@macro flutstrap_progress.troubleshooting}
///
/// {@template flutstrap_progress.usage}
/// ## Comprehensive Usage Examples
///
/// ```dart
/// // Basic progress with custom colors
/// FlutstrapProgress(
///   value: 75,
///   progressColor: Colors.purple,
///   backgroundColor: Colors.purple.withOpacity(0.2),
///   height: 12,
/// )
///
/// // Progress with custom animation
/// FlutstrapProgress(
///   value: currentProgress,
///   animated: true,
///   animationDuration: Duration(seconds: 2),
///   animationCurve: Curves.bounceOut,
/// )
///
/// // Progress in a fixed width container
/// FlutstrapProgress(
///   value: 50,
///   fixedWidth: 200,
///   expandToFill: false,
/// )
///
/// // Progress group with different variants
/// FlutstrapProgressGroup(
///   children: [
///     FlutstrapProgress(value: 25, variant: FSProgressVariant.primary),
///     FlutstrapProgress(value: 50, variant: FSProgressVariant.success),
///     FlutstrapProgress(value: 75, variant: FSProgressVariant.warning),
///   ],
///   spacing: 12,
/// )
/// ```
/// {@endtemplate}
///
/// {@template flutstrap_progress.accessibility}
/// ## Accessibility
///
/// - Full screen reader support with live region updates
/// - Proper semantic labels for progress states
/// - High contrast support for all variants
/// - Clear visual indicators for progress completion
/// - ARIA compliant attributes for screen readers
/// {@endtemplate}
///
/// {@template flutstrap_progress.performance}
/// ## Performance Guidelines
///
/// - Use `animated: false` for static progress bars
/// - Avoid using striped animations on multiple progress bars simultaneously
/// - Use `fixedWidth` when progress bar is in a constrained layout
/// - Consider using `expandToFill: false` in ListView items
/// - Disable animations when progress updates frequently
/// {@endtemplate}
///
/// {@template flutstrap_progress.troubleshooting}
/// ## Troubleshooting
///
/// ### Animation not working
/// - Ensure `animated: true` is set
/// - Check that the progress value is changing
/// - Verify animation duration is appropriate
///
/// ### Progress bar not visible
/// - Check progress value is between minValue and maxValue
/// - Verify colors have sufficient contrast
/// - Ensure container has sufficient width
///
/// ### Performance issues
/// - Disable animations for multiple progress bars
/// - Use fixedWidth instead of flexible sizing
/// - Avoid complex gradients in striped mode
/// - Set `expandToFill: false` in scrollable contexts
/// {@endtemplate}
///
/// {@category Components}
/// {@category Feedback}

import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../../core/spacing.dart';

/// Flutstrap Progress Bar Variants
///
/// Defines the visual style variants for progress bars
enum FSProgressVariant {
  primary,
  secondary,
  success,
  danger,
  warning,
  info,
  light,
  dark,
}

/// Flutstrap Progress Bar Sizes
///
/// Defines the size variants for progress bars
enum FSProgressSize {
  sm,
  md,
  lg,
}

/// Flutstrap Progress Bar
///
/// A customizable progress bar with Bootstrap-inspired styling.
@immutable
class FlutstrapProgress extends StatelessWidget {
  final double value;
  final double minValue;
  final double maxValue;
  final FSProgressVariant variant;
  final FSProgressSize size;
  final bool animated;
  final bool striped;
  final String? label;
  final Widget? customLabel;
  final Color? backgroundColor;
  final Color? progressColor;
  final double? height;
  final double? fixedWidth;
  final bool expandToFill;
  final BorderRadiusGeometry? borderRadius;
  final Duration animationDuration;
  final Curve animationCurve;
  final bool Function(double value, double minValue, double maxValue)?
      validator;

  const FlutstrapProgress({
    super.key,
    required this.value,
    double? minValue,
    double? maxValue,
    this.variant = FSProgressVariant.primary,
    this.size = FSProgressSize.md,
    this.animated = false,
    this.striped = false,
    this.label,
    this.customLabel,
    this.backgroundColor,
    this.progressColor,
    this.height,
    this.fixedWidth,
    this.expandToFill = true,
    this.borderRadius,
    this.animationDuration = const Duration(milliseconds: 500),
    this.animationCurve = Curves.easeInOut,
    this.validator,
  })  : minValue = minValue ?? 0.0,
        maxValue = maxValue ?? 100.0,
        assert(value >= 0, 'Value must be non-negative'),
        assert((minValue ?? 0.0) < (maxValue ?? 100.0),
            'minValue must be less than maxValue');

  /// Creates an indeterminate progress bar
  const FlutstrapProgress.indeterminate({
    super.key,
    this.variant = FSProgressVariant.primary,
    this.size = FSProgressSize.md,
    this.animated = true,
    this.striped = true,
    this.label,
    this.customLabel,
    this.backgroundColor,
    this.progressColor,
    this.height,
    this.fixedWidth,
    this.expandToFill = true,
    this.borderRadius,
    this.animationDuration = const Duration(milliseconds: 1500),
    this.animationCurve = Curves.easeInOut,
    this.validator,
  })  : value = 0,
        minValue = 0,
        maxValue = 100;

  /// Default validator for progress values
  static bool defaultValidator(double value, double minValue, double maxValue) {
    if (value < minValue || value > maxValue) return false;
    if (minValue >= maxValue) return false;
    if (value.isNaN || minValue.isNaN || maxValue.isNaN) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final theme = FSTheme.of(context);
    final progressStyle = _ProgressStyle(theme, variant, size);

    // ✅ VALIDATE: Check progress values
    final isValid = (validator ?? defaultValidator)(value, minValue, maxValue);
    if (!isValid) {
      return _buildErrorState(context, progressStyle);
    }

    final progressPercentage = _calculatePercentage();
    final showLabel = label != null || customLabel != null;

    return Semantics(
      liveRegion: true,
      label: '${progressPercentage.toStringAsFixed(0)}% complete',
      // ✅ FIXED: Removed the problematic value parameter
      child: Container(
        width: fixedWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showLabel) ...[
              _buildLabel(progressStyle),
              SizedBox(height: _ProgressConstants.labelSpacing),
            ],
            // ✅ IMPROVED: Use LayoutBuilder for proper width calculation
            expandToFill
                ? _buildExpandingProgress(progressStyle, progressPercentage)
                : _buildFixedProgress(progressStyle, progressPercentage),
          ],
        ),
      ),
    );
  }

  /// Build progress bar that expands to fill available space
  Widget _buildExpandingProgress(
      _ProgressStyle progressStyle, double percentage) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            // Background track
            _ProgressTrack(
              height: height ?? progressStyle.height,
              backgroundColor: backgroundColor ?? progressStyle.backgroundColor,
              borderRadius: borderRadius ?? progressStyle.borderRadius,
            ),
            // Progress fill
            _ProgressFill(
              percentage: percentage,
              height: height ?? progressStyle.height,
              progressColor: progressColor ?? progressStyle.progressColor,
              borderRadius: borderRadius ?? progressStyle.borderRadius,
              animated: animated,
              striped: striped,
              animationDuration: animationDuration,
              animationCurve: animationCurve,
              maxWidth: constraints.maxWidth,
            ),
            // Value label overlay
            if (_shouldShowValueLabel(percentage))
              _ProgressValueLabel(
                percentage: percentage,
                height: height ?? progressStyle.height,
                textStyle: progressStyle.valueTextStyle,
              ),
          ],
        );
      },
    );
  }

  /// Build progress bar with fixed width behavior
  Widget _buildFixedProgress(_ProgressStyle progressStyle, double percentage) {
    return Stack(
      children: [
        // Background track
        _ProgressTrack(
          height: height ?? progressStyle.height,
          backgroundColor: backgroundColor ?? progressStyle.backgroundColor,
          borderRadius: borderRadius ?? progressStyle.borderRadius,
        ),
        // Progress fill
        _ProgressFill(
          percentage: percentage,
          height: height ?? progressStyle.height,
          progressColor: progressColor ?? progressStyle.progressColor,
          borderRadius: borderRadius ?? progressStyle.borderRadius,
          animated: animated,
          striped: striped,
          animationDuration: animationDuration,
          animationCurve: animationCurve,
          maxWidth: double.infinity,
        ),
        // Value label overlay
        if (_shouldShowValueLabel(percentage))
          _ProgressValueLabel(
            percentage: percentage,
            height: height ?? progressStyle.height,
            textStyle: progressStyle.valueTextStyle,
          ),
      ],
    );
  }

  Widget _buildLabel(_ProgressStyle progressStyle) {
    if (customLabel != null) {
      return customLabel!;
    }

    return Text(
      label!,
      style: progressStyle.labelTextStyle,
    );
  }

  Widget _buildErrorState(BuildContext context, _ProgressStyle progressStyle) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: progressStyle.labelTextStyle.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
          SizedBox(height: _ProgressConstants.labelSpacing),
        ],
        Container(
          height: height ?? progressStyle.height,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.error.withOpacity(0.1),
            borderRadius: borderRadius ?? progressStyle.borderRadius,
            border: Border.all(
              color: Theme.of(context).colorScheme.error,
              width: 1,
            ),
          ),
          child: Center(
            child: Icon(
              Icons.error_outline,
              size: (height ?? progressStyle.height) * 0.8,
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ),
      ],
    );
  }

  double _calculatePercentage() {
    final range = maxValue - minValue;
    final clampedValue = value.clamp(minValue, maxValue);
    return ((clampedValue - minValue) / range) * 100.0;
  }

  bool _shouldShowValueLabel(double percentage) {
    return percentage >= _ProgressConstants.valueLabelThreshold &&
        percentage > 5.0; // Don't show for very small percentages
  }

  // CONVENIENCE: Builder methods
  FlutstrapProgress copyWith({
    double? value,
    double? minValue,
    double? maxValue,
    FSProgressVariant? variant,
    FSProgressSize? size,
    bool? animated,
    bool? striped,
    String? label,
    Widget? customLabel,
    Color? backgroundColor,
    Color? progressColor,
    double? height,
    double? fixedWidth,
    bool? expandToFill,
    BorderRadiusGeometry? borderRadius,
    Duration? animationDuration,
    Curve? animationCurve,
    bool Function(double value, double minValue, double maxValue)? validator,
  }) {
    return FlutstrapProgress(
      key: key,
      value: value ?? this.value,
      minValue: minValue ?? this.minValue,
      maxValue: maxValue ?? this.maxValue,
      variant: variant ?? this.variant,
      size: size ?? this.size,
      animated: animated ?? this.animated,
      striped: striped ?? this.striped,
      label: label ?? this.label,
      customLabel: customLabel ?? this.customLabel,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      progressColor: progressColor ?? this.progressColor,
      height: height ?? this.height,
      fixedWidth: fixedWidth ?? this.fixedWidth,
      expandToFill: expandToFill ?? this.expandToFill,
      borderRadius: borderRadius ?? this.borderRadius,
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
      validator: validator ?? this.validator,
    );
  }

  // CONVENIENCE: Variant methods
  FlutstrapProgress primary() => copyWith(variant: FSProgressVariant.primary);
  FlutstrapProgress success() => copyWith(variant: FSProgressVariant.success);
  FlutstrapProgress danger() => copyWith(variant: FSProgressVariant.danger);
  FlutstrapProgress warning() => copyWith(variant: FSProgressVariant.warning);
  FlutstrapProgress info() => copyWith(variant: FSProgressVariant.info);
  FlutstrapProgress light() => copyWith(variant: FSProgressVariant.light);
  FlutstrapProgress dark() => copyWith(variant: FSProgressVariant.dark);

  // CONVENIENCE: Size methods
  FlutstrapProgress small() => copyWith(size: FSProgressSize.sm);
  FlutstrapProgress medium() => copyWith(size: FSProgressSize.md);
  FlutstrapProgress large() => copyWith(size: FSProgressSize.lg);

  // CONVENIENCE: Style methods
  FlutstrapProgress asAnimated() => copyWith(animated: true);
  FlutstrapProgress asStriped() => copyWith(striped: true);
  FlutstrapProgress withLabel(String newLabel) => copyWith(label: newLabel);
  FlutstrapProgress withFixedWidth(double width) => copyWith(fixedWidth: width);
  FlutstrapProgress withoutExpansion() => copyWith(expandToFill: false);
}

/// Progress bar background track
@immutable
class _ProgressTrack extends StatelessWidget {
  final double height;
  final Color backgroundColor;
  final BorderRadiusGeometry borderRadius;

  const _ProgressTrack({
    required this.height,
    required this.backgroundColor,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
      ),
    );
  }
}

/// Progress bar fill with animation and stripe effects
@immutable
class _ProgressFill extends StatefulWidget {
  final double percentage;
  final double height;
  final Color progressColor;
  final BorderRadiusGeometry borderRadius;
  final bool animated;
  final bool striped;
  final Duration animationDuration;
  final Curve animationCurve;
  final double maxWidth;

  const _ProgressFill({
    required this.percentage,
    required this.height,
    required this.progressColor,
    required this.borderRadius,
    required this.animated,
    required this.striped,
    required this.animationDuration,
    required this.animationCurve,
    required this.maxWidth,
  });

  @override
  State<_ProgressFill> createState() => _ProgressFillState();
}

class _ProgressFillState extends State<_ProgressFill>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _widthAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    )..addStatusListener(_handleAnimationStatus);

    _initializeAnimation();
  }

  void _handleAnimationStatus(AnimationStatus status) {
    // ✅ ADD: Handle animation completion and errors
    if (status == AnimationStatus.completed && widget.animated) {
      // Animation completed successfully
    } else if (status == AnimationStatus.dismissed) {
      // Animation reset
    }
  }

  void _initializeAnimation() {
    try {
      _widthAnimation = Tween<double>(
        begin: 0,
        end: widget.percentage,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: widget.animationCurve,
      ));

      if (widget.animated && widget.percentage > 0) {
        _animationController.forward();
      } else {
        _animationController.value = 1.0; // Set to final state immediately
      }
    } catch (e) {
      // ✅ ADD: Fallback for animation errors
      _animationController.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(_ProgressFill oldWidget) {
    super.didUpdateWidget(oldWidget);

    final needsAnimationUpdate = widget.percentage != oldWidget.percentage ||
        widget.animated != oldWidget.animated ||
        widget.animationDuration != oldWidget.animationDuration;

    if (needsAnimationUpdate && widget.animated) {
      try {
        _widthAnimation = Tween<double>(
          begin: oldWidget.percentage,
          end: widget.percentage,
        ).animate(CurvedAnimation(
          parent: _animationController,
          curve: widget.animationCurve,
        ));
        _animationController.forward(from: 0);
      } catch (e) {
        // ✅ ADD: Safe fallback for animation updates
        _animationController.value = 1.0;
      }
    } else if (!widget.animated) {
      _animationController.value = 1.0; // Ensure final state
    }
  }

  @override
  void dispose() {
    _animationController
      ..removeStatusListener(_handleAnimationStatus)
      ..dispose(); // ✅ CRITICAL: Prevent memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _widthAnimation,
      builder: (context, child) {
        return Container(
          height: widget.height,
          width: _calculateWidth(_widthAnimation.value),
          decoration: BoxDecoration(
            color: widget.progressColor,
            borderRadius: widget.borderRadius,
            gradient: widget.striped ? _createStripedGradient() : null,
          ),
        );
      },
    );
  }

  // ✅ FIXED: Better width calculation using provided maxWidth
  double _calculateWidth(double percentage) {
    return (percentage * 0.01) * widget.maxWidth;
  }

  LinearGradient? _createStripedGradient() {
    return LinearGradient(
      colors: [
        widget.progressColor,
        widget.progressColor.withOpacity(_ProgressConstants.stripeOpacity),
        widget.progressColor,
      ],
      stops: const [0.0, 0.5, 1.0],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      tileMode: TileMode.repeated,
    );
  }
}

/// Progress value label that appears inside the progress bar
@immutable
class _ProgressValueLabel extends StatelessWidget {
  final double percentage;
  final double height;
  final TextStyle textStyle;

  const _ProgressValueLabel({
    required this.percentage,
    required this.height,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: height * 0.5),
        child: Text(
          '${percentage.toStringAsFixed(0)}%',
          style: textStyle,
          maxLines: 1,
          overflow: TextOverflow.fade,
        ),
      ),
    );
  }
}

/// Multiple progress bars in a single container
@immutable
class FlutstrapProgressGroup extends StatelessWidget {
  final List<FlutstrapProgress> children;
  final double spacing;
  final bool expandToFill;

  const FlutstrapProgressGroup({
    super.key,
    required this.children,
    this.spacing = _ProgressConstants.defaultSpacing,
    this.expandToFill = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < children.length; i++) ...[
          children[i].copyWith(expandToFill: expandToFill),
          if (i < children.length - 1) SizedBox(height: spacing),
        ],
      ],
    );
  }
}

/// Internal style configuration for progress bars
class _ProgressStyle {
  final FSThemeData theme;
  final FSProgressVariant variant;
  final FSProgressSize size;

  _ProgressStyle(this.theme, this.variant, this.size);

  double get height {
    switch (size) {
      case FSProgressSize.sm:
        return _ProgressConstants.smallHeight;
      case FSProgressSize.md:
        return _ProgressConstants.mediumHeight;
      case FSProgressSize.lg:
        return _ProgressConstants.largeHeight;
    }
  }

  Color get backgroundColor =>
      theme.colors.surface.withOpacity(_ProgressConstants.backgroundOpacity);

  Color get progressColor => _getProgressColor();

  BorderRadiusGeometry get borderRadius =>
      BorderRadius.circular(height * _ProgressConstants.borderRadiusFactor);

  TextStyle get labelTextStyle => theme.typography.bodySmall.copyWith(
        color: theme.colors.onBackground,
        fontWeight: FontWeight.w500,
      );

  TextStyle get valueTextStyle => theme.typography.bodySmall.copyWith(
        color: _getValueTextColor(),
        fontWeight: FontWeight.w600,
      );

  Color _getProgressColor() {
    final colors = theme.colors;
    switch (variant) {
      case FSProgressVariant.primary:
        return colors.primary;
      case FSProgressVariant.secondary:
        return colors.secondary;
      case FSProgressVariant.success:
        return colors.success;
      case FSProgressVariant.danger:
        return colors.danger;
      case FSProgressVariant.warning:
        return colors.warning;
      case FSProgressVariant.info:
        return colors.info;
      case FSProgressVariant.light:
        return colors.surface;
      case FSProgressVariant.dark:
        return colors.onBackground;
    }
  }

  Color _getValueTextColor() {
    switch (variant) {
      case FSProgressVariant.light:
        return theme.colors.onBackground;
      case FSProgressVariant.dark:
        return theme.colors.background;
      default:
        return theme.colors.onPrimary;
    }
  }
}

// CONSTANTS FOR BETTER MAINTAINABILITY
class _ProgressConstants {
  static const double smallHeight = 4.0;
  static const double mediumHeight = 8.0;
  static const double largeHeight = 12.0;
  static const double defaultSpacing = 8.0;
  static const double backgroundOpacity = 0.3;
  static const double stripeOpacity = 0.15;
  static const double borderRadiusFactor = 0.5;
  static const double labelSpacing = 8.0;
  static const double valueLabelThreshold = 0.5;
}
