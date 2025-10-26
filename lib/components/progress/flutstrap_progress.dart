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
class FlutstrapProgress extends StatelessWidget {
  final double value;
  final double? minValue;
  final double? maxValue;
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
    Key? key,
    required this.value,
    this.minValue = 0.0,
    this.maxValue = 100.0,
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
  })  : assert(value >= 0, 'Value must be non-negative'),
        assert(minValue != null && maxValue != null && minValue < maxValue,
            'minValue must be less than maxValue'),
        super(key: key);

  /// Creates an indeterminate progress bar
  const FlutstrapProgress.indeterminate({
    Key? key,
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
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = FSTheme.of(context);
    final progressStyle = _ProgressStyle(theme, variant, size);

    final progressPercentage = _calculatePercentage();
    final showLabel = label != null || customLabel != null;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showLabel) ...[
          _buildLabel(progressStyle),
          const SizedBox(height: 8),
        ],
        Stack(
          children: [
            // Background track
            _ProgressTrack(
              height: height ?? progressStyle.height,
              backgroundColor: backgroundColor ?? progressStyle.backgroundColor,
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
            // Value label overlay (optional)
            if (progressPercentage >= 0.5) // Only show if there's enough space
              _ProgressValueLabel(
                percentage: progressPercentage,
                height: height ?? progressStyle.height,
                textStyle: progressStyle.valueTextStyle,
              ),
          ],
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

  double _calculatePercentage() {
    final range = maxValue! - minValue!;
    final clampedValue = value.clamp(minValue!, maxValue!);
    return ((clampedValue - minValue!) / range) * 100.0;
  }
}

/// Progress bar background track
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
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _widthAnimation,
      builder: (context, child) {
        return Container(
          height: widget.height,
          width:
              _widthAnimation.value * 0.01 * MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: widget.progressColor,
            borderRadius: widget.borderRadius,
            gradient: widget.striped ? _createStripedGradient() : null,
          ),
        );
      },
    );
  }

  LinearGradient? _createStripedGradient() {
    return LinearGradient(
      colors: [
        widget.progressColor,
        widget.progressColor.withOpacity(0.15),
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
class FlutstrapProgressGroup extends StatelessWidget {
  final List<FlutstrapProgress> children;
  final double spacing;

  const FlutstrapProgressGroup({
    Key? key,
    required this.children,
    this.spacing = 8.0,
  }) : super(key: key);

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
        return 4.0;
      case FSProgressSize.md:
        return 8.0;
      case FSProgressSize.lg:
        return 12.0;
    }
  }

  Color get backgroundColor => theme.colors.surface.withOpacity(0.3);

  Color get progressColor => _getProgressColor();

  BorderRadiusGeometry get borderRadius => BorderRadius.circular(height * 0.5);

  TextStyle get labelTextStyle => theme.typography.bodySmall!.copyWith(
        color: theme.colors.onBackground,
        fontWeight: FontWeight.w500,
      );

  TextStyle get valueTextStyle => theme.typography.bodySmall!.copyWith(
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
