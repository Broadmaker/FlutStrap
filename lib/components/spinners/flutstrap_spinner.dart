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
    Key? key,
    this.variant = FSSpinnerVariant.primary,
    this.size = FSSpinnerSize.md,
    this.type = FSSpinnerType.border,
    this.label,
    this.customLabel,
    this.color,
    this.strokeWidth,
    this.animationDuration = const Duration(milliseconds: 1000),
    this.centered = false,
  }) : super(key: key);

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

    Widget content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        spinnerContent,
        if (showLabel) ...[
          const SizedBox(height: 8),
          _buildLabel(spinnerStyle),
        ],
      ],
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
      angle: rotation.value * 2 * 3.14159, // Full rotation
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

    // Draw an arc (about 3/4 of a circle)
    canvas.drawArc(rect, -0.8, 2.2, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Growing spinner (pulsing circle)
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
      width: size * 3, // Space for 3 dots
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
              width: size / 3,
              height: size / 3,
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
class FlutstrapSpinnerButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onPressed;
  final Widget child;
  final FlutstrapSpinner spinner;
  final EdgeInsetsGeometry padding;

  const FlutstrapSpinnerButton({
    Key? key,
    required this.isLoading,
    required this.onPressed,
    required this.child,
    this.spinner = const FlutstrapSpinner(size: FSSpinnerSize.sm),
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  }) : super(key: key);

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
        return 16.0;
      case FSSpinnerSize.md:
        return 24.0;
      case FSSpinnerSize.lg:
        return 32.0;
    }
  }

  double get strokeWidth {
    switch (size) {
      case FSSpinnerSize.sm:
        return 2.0;
      case FSSpinnerSize.md:
        return 3.0;
      case FSSpinnerSize.lg:
        return 4.0;
    }
    return 3.0;
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
