/// Flutstrap Spinner
///
/// A customizable loading spinner with Bootstrap-inspired styling.
///
/// {@macro flutstrap_spinner.usage}
/// {@macro flutstrap_spinner.accessibility}
///
/// {@template flutstrap_spinner.usage}
/// ## Usage Examples
///
/// ```dart
/// // Basic border spinner
/// FlutstrapSpinner(
///   variant: FSSpinnerVariant.primary,
///   size: FSSpinnerSize.md,
/// )
///
/// // Growing spinner with label
/// FlutstrapSpinner(
///   variant: FSSpinnerVariant.success,
///   type: FSSpinnerType.growing,
///   label: 'Loading...',
///   centered: true,
/// )
///
/// // Dots spinner with custom color
/// FlutstrapSpinner(
///   type: FSSpinnerType.dots,
///   color: Colors.blue,
///   size: FSSpinnerSize.lg,
/// )
///
/// // Spinner button
/// FlutstrapSpinnerButton(
///   isLoading: isSubmitting,
///   onPressed: submitForm,
///   child: Text('Submit'),
///   spinner: FlutstrapSpinner(
///     variant: FSSpinnerVariant.light,
///     size: FSSpinnerSize.sm,
///   ),
/// )
/// ```
/// {@endtemplate}
///
/// {@template flutstrap_spinner.accessibility}
/// ## Accessibility
///
/// - Full screen reader support with proper semantic labels
/// - Live region updates for loading states
/// - High contrast support for all variants
/// - Clear visual indicators for different spinner types
/// {@endtemplate}
///
/// {@category Components}
/// {@category Feedback}

import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../../core/spacing.dart';

/// Flutstrap Spinner Variants
///
/// Defines the visual style variants for spinners
enum FSSpinnerVariant {
  primary,
  secondary,
  success,
  danger,
  warning,
  info,
  light,
  dark,
}

/// Flutstrap Spinner Sizes
///
/// Defines the size variants for spinners
enum FSSpinnerSize {
  sm,
  md,
  lg,
}

/// Flutstrap Spinner Types
///
/// Defines the animation types for spinners
enum FSSpinnerType {
  border, // Classic rotating border
  growing, // Pulsing circle
  dots, // Bouncing dots
}

/// Flutstrap Spinner
///
/// A customizable loading spinner with Bootstrap-inspired styling.
@immutable
class FlutstrapSpinner extends StatefulWidget {
  final FSSpinnerVariant variant;
  final FSSpinnerSize size;
  final FSSpinnerType type;
  final String? label;
  final Widget? customLabel;
  final Color? color;
  final double? strokeWidth;
  final Duration animationDuration;
  final bool centered;

  const FlutstrapSpinner({
    super.key,
    this.variant = FSSpinnerVariant.primary,
    this.size = FSSpinnerSize.md,
    this.type = FSSpinnerType.border,
    this.label,
    this.customLabel,
    this.color,
    this.strokeWidth,
    this.animationDuration = const Duration(milliseconds: 1000),
    this.centered = false,
  });

  /// Creates a copy of this spinner with the given properties replaced
  FlutstrapSpinner copyWith({
    Key? key,
    FSSpinnerVariant? variant,
    FSSpinnerSize? size,
    FSSpinnerType? type,
    String? label,
    Widget? customLabel,
    Color? color,
    double? strokeWidth,
    Duration? animationDuration,
    bool? centered,
  }) {
    return FlutstrapSpinner(
      key: key ?? this.key,
      variant: variant ?? this.variant,
      size: size ?? this.size,
      type: type ?? this.type,
      label: label ?? this.label,
      customLabel: customLabel ?? this.customLabel,
      color: color ?? this.color,
      strokeWidth: strokeWidth ?? this.strokeWidth,
      animationDuration: animationDuration ?? this.animationDuration,
      centered: centered ?? this.centered,
    );
  }

  /// Creates a primary variant spinner
  FlutstrapSpinner primary() => copyWith(variant: FSSpinnerVariant.primary);

  /// Creates a secondary variant spinner
  FlutstrapSpinner secondary() => copyWith(variant: FSSpinnerVariant.secondary);

  /// Creates a success variant spinner
  FlutstrapSpinner success() => copyWith(variant: FSSpinnerVariant.success);

  /// Creates a danger variant spinner
  FlutstrapSpinner danger() => copyWith(variant: FSSpinnerVariant.danger);

  /// Creates a warning variant spinner
  FlutstrapSpinner warning() => copyWith(variant: FSSpinnerVariant.warning);

  /// Creates an info variant spinner
  FlutstrapSpinner info() => copyWith(variant: FSSpinnerVariant.info);

  /// Creates a light variant spinner
  FlutstrapSpinner light() => copyWith(variant: FSSpinnerVariant.light);

  /// Creates a dark variant spinner
  FlutstrapSpinner dark() => copyWith(variant: FSSpinnerVariant.dark);

  /// Creates a small size spinner
  FlutstrapSpinner small() => copyWith(size: FSSpinnerSize.sm);

  /// Creates a medium size spinner
  FlutstrapSpinner medium() => copyWith(size: FSSpinnerSize.md);

  /// Creates a large size spinner
  FlutstrapSpinner large() => copyWith(size: FSSpinnerSize.lg);

  /// Creates a border type spinner
  FlutstrapSpinner asBorder() => copyWith(type: FSSpinnerType.border);

  /// Creates a growing type spinner
  FlutstrapSpinner asGrowing() => copyWith(type: FSSpinnerType.growing);

  /// Creates a dots type spinner
  FlutstrapSpinner asDots() => copyWith(type: FSSpinnerType.dots);

  /// Creates a centered spinner
  FlutstrapSpinner asCentered() => copyWith(centered: true);

  /// Creates a spinner with a label
  FlutstrapSpinner withLabel(String newLabel) => copyWith(label: newLabel);

  /// Creates a spinner with custom color
  FlutstrapSpinner withColor(Color newColor) => copyWith(color: newColor);

  @override
  State<FlutstrapSpinner> createState() => _FlutstrapSpinnerState();
}

class _FlutstrapSpinnerState extends State<FlutstrapSpinner>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    )..repeat();
  }

  @override
  void didUpdateWidget(FlutstrapSpinner oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animationDuration != oldWidget.animationDuration) {
      _animationController.duration = widget.animationDuration;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = FSTheme.of(context);
    final spinnerStyle = _SpinnerStyle(theme, widget.variant, widget.size);

    final spinnerContent = _buildSpinnerContent(spinnerStyle);
    final showLabel = widget.label != null || widget.customLabel != null;

    Widget content = Semantics(
      liveRegion: true,
      label: 'Loading',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          spinnerContent,
          if (showLabel) ...[
            SizedBox(height: _SpinnerConstants.labelSpacing),
            _buildLabel(spinnerStyle),
          ],
        ],
      ),
    );

    if (widget.centered) {
      content = Center(child: content);
    }

    return content;
  }

  Widget _buildSpinnerContent(_SpinnerStyle spinnerStyle) {
    switch (widget.type) {
      case FSSpinnerType.border:
        return _BorderSpinner(
          animationController: _animationController,
          size: spinnerStyle.spinnerSize,
          color: widget.color ?? spinnerStyle.color,
          strokeWidth: widget.strokeWidth ?? spinnerStyle.strokeWidth,
        );
      case FSSpinnerType.growing:
        return _GrowingSpinner(
          animationController: _animationController,
          size: spinnerStyle.spinnerSize,
          color: widget.color ?? spinnerStyle.color,
        );
      case FSSpinnerType.dots:
        return _DotsSpinner(
          animationController: _animationController,
          size: spinnerStyle.spinnerSize,
          color: widget.color ?? spinnerStyle.color,
        );
    }
  }

  Widget _buildLabel(_SpinnerStyle spinnerStyle) {
    if (widget.customLabel != null) {
      return widget.customLabel!;
    }

    return Text(
      widget.label!,
      style: spinnerStyle.labelTextStyle,
      textAlign: TextAlign.center,
    );
  }
}

/// Border spinner (classic rotating border)
@immutable
class _BorderSpinner extends AnimatedWidget {
  final double size;
  final Color color;
  final double strokeWidth;

  const _BorderSpinner({
    required AnimationController animationController,
    required this.size,
    required this.color,
    required this.strokeWidth,
  }) : super(listenable: animationController);

  Animation<double> get rotation => Tween<double>(
        begin: 0,
        end: 1,
      ).animate(CurvedAnimation(
        parent: listenable as AnimationController,
        curve: Curves.linear,
      ));

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotation.value * _SpinnerConstants.piTimesTwo,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(size / 2),
          border: Border.all(
            color: color.withOpacity(0.25),
            width: strokeWidth,
          ),
        ),
        child: CustomPaint(
          painter: _SpinnerArcPainter(
            color: color,
            strokeWidth: strokeWidth,
          ),
        ),
      ),
    );
  }
}

/// Painter for the spinner arc
@immutable
class _SpinnerArcPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  const _SpinnerArcPainter({
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: size.width / 2 - strokeWidth / 2,
    );

    canvas.drawArc(
      rect,
      _SpinnerConstants.arcStartAngle,
      _SpinnerConstants.arcSweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Growing spinner (pulsing circle)
@immutable
class _GrowingSpinner extends AnimatedWidget {
  final double size;
  final Color color;

  const _GrowingSpinner({
    required AnimationController animationController,
    required this.size,
    required this.color,
  }) : super(listenable: animationController);

  Animation<double> get scale => TweenSequence<double>([
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.0),
          weight: 50,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.0, end: 0.0),
          weight: 50,
        ),
      ]).animate(CurvedAnimation(
        parent: listenable as AnimationController,
        curve: Curves.easeInOut,
      ));

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scale,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

/// Dots spinner (bouncing dots)
@immutable
class _DotsSpinner extends AnimatedWidget {
  final double size;
  final Color color;

  const _DotsSpinner({
    required AnimationController animationController,
    required this.size,
    required this.color,
  }) : super(listenable: animationController);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size * _SpinnerConstants.dotsContainerMultiplier,
      height: size,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(3, (index) {
          final animation = Tween<double>(
            begin: 0.3,
            end: 1.0,
          ).animate(CurvedAnimation(
            parent: listenable as AnimationController,
            curve: Interval(
              index * 0.2,
              1.0,
              curve: Curves.easeInOut,
            ),
          ));

          return ScaleTransition(
            scale: animation,
            child: Container(
              width: size / _SpinnerConstants.dotSizeDivisor,
              height: size / _SpinnerConstants.dotSizeDivisor,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
          );
        }),
      ),
    );
  }
}

/// Spinner button - Button that shows spinner when loading
@immutable
class FlutstrapSpinnerButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onPressed;
  final Widget child;
  final FlutstrapSpinner spinner;
  final EdgeInsetsGeometry padding;

  const FlutstrapSpinnerButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
    required this.child,
    this.spinner = const FlutstrapSpinner(size: FSSpinnerSize.sm),
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      child: isLoading ? spinner : child,
    );
  }
}

/// Internal style configuration for spinners
class _SpinnerStyle {
  final FSThemeData theme;
  final FSSpinnerVariant variant;
  final FSSpinnerSize size;

  _SpinnerStyle(this.theme, this.variant, this.size);

  double get spinnerSize {
    switch (size) {
      case FSSpinnerSize.sm:
        return _SpinnerConstants.smallSize;
      case FSSpinnerSize.md:
        return _SpinnerConstants.mediumSize;
      case FSSpinnerSize.lg:
        return _SpinnerConstants.largeSize;
    }
  }

  double get strokeWidth {
    switch (size) {
      case FSSpinnerSize.sm:
        return _SpinnerConstants.smallStroke;
      case FSSpinnerSize.md:
        return _SpinnerConstants.mediumStroke;
      case FSSpinnerSize.lg:
        return _SpinnerConstants.largeStroke;
    }
  }

  Color get color => _getColor();

  TextStyle get labelTextStyle => theme.typography.bodySmall.copyWith(
        color: theme.colors.onBackground.withOpacity(0.7),
      );

  Color _getColor() {
    final colors = theme.colors;
    switch (variant) {
      case FSSpinnerVariant.primary:
        return colors.primary;
      case FSSpinnerVariant.secondary:
        return colors.secondary;
      case FSSpinnerVariant.success:
        return colors.success;
      case FSSpinnerVariant.danger:
        return colors.danger;
      case FSSpinnerVariant.warning:
        return colors.warning;
      case FSSpinnerVariant.info:
        return colors.info;
      case FSSpinnerVariant.light:
        return colors.surface;
      case FSSpinnerVariant.dark:
        return colors.onBackground;
    }
  }
}

// CONSTANTS FOR BETTER MAINTAINABILITY
class _SpinnerConstants {
  static const double smallSize = 16.0;
  static const double mediumSize = 24.0;
  static const double largeSize = 32.0;
  static const double smallStroke = 2.0;
  static const double mediumStroke = 3.0;
  static const double largeStroke = 4.0;
  static const double labelSpacing = 8.0;
  static const double dotsContainerMultiplier = 3.0;
  static const double dotSizeDivisor = 3.0;
  static const double arcStartAngle = -0.8;
  static const double arcSweepAngle = 2.2;
  static const double piTimesTwo = 6.28318;
}
