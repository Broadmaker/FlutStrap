/// Flutstrap Progress Bar
///
/// A customizable progress bar with Bootstrap-inspired styling.
///
/// {@macro flutstrap_progress.usage}
/// {@macro flutstrap_progress.accessibility}
///
/// {@template flutstrap_progress.usage}
/// ## Usage Examples
///
/// ```dart
/// // Basic progress bar
/// FlutstrapProgress(
///   value: 75,
///   variant: FSProgressVariant.primary,
///   label: 'Upload Progress',
/// )
///
/// // Animated striped progress bar
/// FlutstrapProgress(
///   value: currentProgress,
///   variant: FSProgressVariant.success,
///   animated: true,
///   striped: true,
///   size: FSProgressSize.lg,
/// )
///
/// // Indeterminate progress
/// FlutstrapProgress.indeterminate(
///   variant: FSProgressVariant.info,
///   label: 'Processing...',
/// )
///
/// // Multiple progress bars
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
  final BorderRadiusGeometry? borderRadius;
  final Duration animationDuration;
  final Curve animationCurve;

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
    this.borderRadius,
    this.animationDuration = const Duration(milliseconds: 500),
    this.animationCurve = Curves.easeInOut,
  })  : minValue = minValue ?? 0.0,
        maxValue = maxValue ?? 100.0,
        assert(value >= 0, 'Value must be non-negative'),
        assert((minValue ?? 0.0) < (maxValue ?? 100.0),
            'minValue must be less than maxValue'),
        super();

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
    this.borderRadius,
    this.animationDuration = const Duration(milliseconds: 1000),
    this.animationCurve = Curves.linear,
  })  : value = 0,
        minValue = 0,
        maxValue = 100,
        super();

  @override
  Widget build(BuildContext context) {
    final theme = FSTheme.of(context);
    final progressStyle = _ProgressStyle(theme, variant, size);

    final progressPercentage = _calculatePercentage();
    final showLabel = label != null || customLabel != null;

    return Semantics(
      liveRegion: true,
      value: '${progressPercentage.toStringAsFixed(0)}% complete',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showLabel) ...[
            _buildLabel(progressStyle),
            SizedBox(height: _ProgressConstants.labelSpacing),
          ],
          Stack(
            children: [
              // Background track
              _ProgressTrack(
                height: height ?? progressStyle.height,
                backgroundColor:
                    backgroundColor ?? progressStyle.backgroundColor,
                borderRadius: borderRadius ?? progressStyle.borderRadius,
              ),
              // Progress fill
              _ProgressFill(
                percentage: progressPercentage,
                height: height ?? progressStyle.height,
                progressColor: progressColor ?? progressStyle.progressColor,
                borderRadius: borderRadius ?? progressStyle.borderRadius,
                animated: animated,
                striped: striped,
                animationDuration: animationDuration,
                animationCurve: animationCurve,
              ),
              // Value label overlay (only show when appropriate)
              if (_shouldShowValueLabel(progressPercentage))
                _ProgressValueLabel(
                  percentage: progressPercentage,
                  height: height ?? progressStyle.height,
                  textStyle: progressStyle.valueTextStyle,
                ),
            ],
          ),
        ],
      ),
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

  double _calculatePercentage() {
    final range = maxValue! - minValue!;
    final clampedValue = value.clamp(minValue!, maxValue!);
    return ((clampedValue - minValue!) / range) * 100.0;
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
    BorderRadiusGeometry? borderRadius,
    Duration? animationDuration,
    Curve? animationCurve,
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
      borderRadius: borderRadius ?? this.borderRadius,
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
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

  const _ProgressFill({
    required this.percentage,
    required this.height,
    required this.progressColor,
    required this.borderRadius,
    required this.animated,
    required this.striped,
    required this.animationDuration,
    required this.animationCurve,
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
    );

    _widthAnimation = Tween<double>(
      begin: 0,
      end: widget.percentage,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: widget.animationCurve,
    ));

    if (widget.animated) {
      _animationController.forward();
    } else {
      _animationController.value = 1.0; // Set to final state immediately
    }
  }

  @override
  void didUpdateWidget(_ProgressFill oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.percentage != oldWidget.percentage && widget.animated) {
      _widthAnimation = Tween<double>(
        begin: oldWidget.percentage,
        end: widget.percentage,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: widget.animationCurve,
      ));
      _animationController.forward(from: 0);
    } else if (!widget.animated) {
      _animationController.value = 1.0; // Ensure final state
    }
  }

  @override
  void dispose() {
    _animationController.dispose(); // ✅ CRITICAL: Prevent memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _widthAnimation,
      builder: (context, child) {
        return Container(
          height: widget.height,
          width: _calculateWidth(_widthAnimation.value, context),
          decoration: BoxDecoration(
            color: widget.progressColor,
            borderRadius: widget.borderRadius,
            gradient: widget.striped ? _createStripedGradient() : null,
          ),
        );
      },
    );
  }

  double _calculateWidth(double percentage, BuildContext context) {
    return percentage * 0.01 * MediaQuery.of(context).size.width;
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

  const FlutstrapProgressGroup({
    super.key,
    required this.children,
    this.spacing = _ProgressConstants.defaultSpacing,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < children.length; i++) ...[
          children[i],
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
