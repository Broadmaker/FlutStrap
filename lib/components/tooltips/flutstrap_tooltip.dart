import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/theme.dart';

/// Flutstrap Tooltip Variants
///
/// Defines the visual style variants for tooltips
enum FSTooltipVariant {
  primary,
  secondary,
  success,
  danger,
  warning,
  info,
  light,
  dark,
}

/// Flutstrap Tooltip Placement
///
/// Defines the position of the tooltip relative to the target widget
enum FSTooltipPlacement {
  top,
  topStart,
  topEnd,
  right,
  rightStart,
  rightEnd,
  bottom,
  bottomStart,
  bottomEnd,
  left,
  leftStart,
  leftEnd,
}

/// Global tooltip manager to prevent multiple tooltips from showing at once
class _TooltipManager {
  static OverlayEntry? _currentEntry;
  static FlutstrapTooltipState? _currentTooltip;

  static void showTooltip(FlutstrapTooltipState tooltip, OverlayEntry entry) {
    // Hide any currently showing tooltip
    hideCurrentTooltip();

    _currentTooltip = tooltip;
    _currentEntry = entry;
    Overlay.of(tooltip.context)?.insert(entry);
  }

  static void hideCurrentTooltip() {
    _currentEntry?.remove();
    _currentEntry = null;
    _currentTooltip = null;
  }

  static bool isCurrentTooltip(FlutstrapTooltipState tooltip) {
    return _currentTooltip == tooltip;
  }
}

/// Flutstrap Tooltip
///
/// A customizable tooltip with Bootstrap-inspired styling and animations.
class FlutstrapTooltip extends StatefulWidget {
  final String message;
  final Widget child;
  final FSTooltipVariant variant;
  final FSTooltipPlacement placement;
  final Duration showDelay;
  final Duration hideDelay;
  final Duration animationDuration;
  final bool showArrow;
  final double maxWidth;
  final EdgeInsetsGeometry padding;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final BorderRadiusGeometry? borderRadius;

  const FlutstrapTooltip({
    Key? key,
    required this.message,
    required this.child,
    this.variant = FSTooltipVariant.primary,
    this.placement = FSTooltipPlacement.top,
    this.showDelay = const Duration(milliseconds: 100),
    this.hideDelay = const Duration(milliseconds: 100),
    this.animationDuration = const Duration(milliseconds: 200),
    this.showArrow = true,
    this.maxWidth = 200.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    this.textStyle,
    this.backgroundColor,
    this.borderRadius,
  }) : super(key: key);

  @override
  State<FlutstrapTooltip> createState() => FlutstrapTooltipState();
}

class FlutstrapTooltipState extends State<FlutstrapTooltip> {
  OverlayEntry? _overlayEntry;
  final _layerLink = LayerLink();
  bool _isVisible = false;
  Timer? _showTimer;
  Timer? _hideTimer;

  @override
  void dispose() {
    _showTimer?.cancel();
    _hideTimer?.cancel();
    if (_isVisible) {
      _TooltipManager.hideCurrentTooltip();
    }
    super.dispose();
  }

  void _showTooltip() {
    _hideTimer?.cancel();

    _showTimer = Timer(widget.showDelay, () {
      if (!_isVisible && mounted) {
        _isVisible = true;
        _overlayEntry = _createOverlayEntry();
        _TooltipManager.showTooltip(this, _overlayEntry!);
      }
    });
  }

  void _hideTooltip() {
    _showTimer?.cancel();

    _hideTimer = Timer(widget.hideDelay, () {
      if (_isVisible && mounted) {
        _isVisible = false;
        // Only hide if this is the current tooltip
        if (_TooltipManager.isCurrentTooltip(this)) {
          _TooltipManager.hideCurrentTooltip();
        }
        _overlayEntry = null;
      }
    });
  }

  void _forceHideTooltip() {
    _showTimer?.cancel();
    _hideTimer?.cancel();
    _isVisible = false;
    if (_TooltipManager.isCurrentTooltip(this)) {
      _TooltipManager.hideCurrentTooltip();
    }
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) {
        return Positioned(
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: _getTooltipOffset(),
            child: Material(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: _forceHideTooltip,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.transparent,
                  child: Stack(
                    children: [
                      Positioned(
                        child: _FadeInAnimation(
                          duration: widget.animationDuration,
                          child: _TooltipContent(
                            message: widget.message,
                            variant: widget.variant,
                            placement: widget.placement,
                            showArrow: widget.showArrow,
                            maxWidth: widget.maxWidth,
                            padding: widget.padding,
                            textStyle: widget.textStyle,
                            backgroundColor: widget.backgroundColor,
                            borderRadius: widget.borderRadius,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Offset _getTooltipOffset() {
    final renderBox = context.findRenderObject() as RenderBox?;
    final size = renderBox?.size ?? Size.zero;

    switch (widget.placement) {
      case FSTooltipPlacement.top:
        return Offset(0, -size.height - 8);
      case FSTooltipPlacement.topStart:
        return Offset(0, -size.height - 8);
      case FSTooltipPlacement.topEnd:
        return Offset(-_getTooltipWidth() + size.width, -size.height - 8);
      case FSTooltipPlacement.right:
        return Offset(size.width + 8, -(_getTooltipHeight() - size.height) / 2);
      case FSTooltipPlacement.rightStart:
        return Offset(size.width + 8, 0);
      case FSTooltipPlacement.rightEnd:
        return Offset(size.width + 8, -_getTooltipHeight() + size.height);
      case FSTooltipPlacement.bottom:
        return Offset(0, size.height + 8);
      case FSTooltipPlacement.bottomStart:
        return Offset(0, size.height + 8);
      case FSTooltipPlacement.bottomEnd:
        return Offset(-_getTooltipWidth() + size.width, size.height + 8);
      case FSTooltipPlacement.left:
        return Offset(
            -_getTooltipWidth() - 8, -(_getTooltipHeight() - size.height) / 2);
      case FSTooltipPlacement.leftStart:
        return Offset(-_getTooltipWidth() - 8, 0);
      case FSTooltipPlacement.leftEnd:
        return Offset(
            -_getTooltipWidth() - 8, -_getTooltipHeight() + size.height);
    }
  }

  double _getTooltipWidth() {
    final textPainter = TextPainter(
      text: TextSpan(
        text: widget.message,
        style: widget.textStyle ?? _TooltipStyle._defaultTextStyle,
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: widget.maxWidth);
    return textPainter.size.width + widget.padding.horizontal;
  }

  double _getTooltipHeight() {
    final textPainter = TextPainter(
      text: TextSpan(
        text: widget.message,
        style: widget.textStyle ?? _TooltipStyle._defaultTextStyle,
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: widget.maxWidth);
    return textPainter.size.height +
        widget.padding.vertical +
        (widget.showArrow ? 8 : 0);
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: MouseRegion(
        onEnter: (_) => _showTooltip(),
        onExit: (_) => _hideTooltip(),
        child: GestureDetector(
          onTapDown: (_) => _showTooltip(),
          onTapCancel: _forceHideTooltip,
          onTapUp: (_) => _forceHideTooltip,
          child: widget.child,
        ),
      ),
    );
  }
}

// ... (keep the rest of the file the same: _FadeInAnimation, _TooltipContent,
// _TooltipArrowPainter, and _TooltipStyle classes)
/// Simple fade-in animation widget (temporary until animations are created)
class _FadeInAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const _FadeInAnimation({
    required this.child,
    required this.duration,
  });

  @override
  __FadeInAnimationState createState() => __FadeInAnimationState();
}

class __FadeInAnimationState extends State<_FadeInAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: widget.child,
    );
  }
}

/// Tooltip content widget
class _TooltipContent extends StatelessWidget {
  final String message;
  final FSTooltipVariant variant;
  final FSTooltipPlacement placement;
  final bool showArrow;
  final double maxWidth;
  final EdgeInsetsGeometry padding;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final BorderRadiusGeometry? borderRadius;

  const _TooltipContent({
    required this.message,
    required this.variant,
    required this.placement,
    required this.showArrow,
    required this.maxWidth,
    required this.padding,
    this.textStyle,
    this.backgroundColor,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final theme = FSTheme.of(context);
    final style = _TooltipStyle(theme, variant);

    return Container(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_isBottomPlacement) _buildTooltipArrow(style, isTop: true),
          Container(
            padding: padding,
            decoration: BoxDecoration(
              color: backgroundColor ?? style.backgroundColor,
              borderRadius: borderRadius ?? style.borderRadius,
              boxShadow: style.boxShadow,
            ),
            child: Text(
              message,
              style: textStyle ?? style.textStyle,
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (!_isBottomPlacement) _buildTooltipArrow(style, isTop: false),
        ],
      ),
    );
  }

  bool get _isBottomPlacement => placement.toString().contains('bottom');

  Widget _buildTooltipArrow(_TooltipStyle style, {required bool isTop}) {
    if (!showArrow) return const SizedBox.shrink();

    return CustomPaint(
      size: const Size(16, 8),
      painter: _TooltipArrowPainter(
        color: backgroundColor ?? style.backgroundColor,
        isPointingUp: isTop,
      ),
    );
  }
}

/// Tooltip arrow painter
class _TooltipArrowPainter extends CustomPainter {
  final Color color;
  final bool isPointingUp;

  const _TooltipArrowPainter({
    required this.color,
    required this.isPointingUp,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path();

    if (isPointingUp) {
      path
        ..moveTo(size.width / 2, 0)
        ..lineTo(0, size.height)
        ..lineTo(size.width, size.height)
        ..close();
    } else {
      path
        ..moveTo(0, 0)
        ..lineTo(size.width, 0)
        ..lineTo(size.width / 2, size.height)
        ..close();
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Internal style configuration for tooltips
class _TooltipStyle {
  final FSThemeData theme;
  final FSTooltipVariant variant;

  _TooltipStyle(this.theme, this.variant);

  static const _defaultTextStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: Colors.white,
  );

  Color get backgroundColor => _getBackgroundColor();

  TextStyle get textStyle => _defaultTextStyle.copyWith(
        color: _getTextColor(),
      );

  BorderRadius get borderRadius => BorderRadius.circular(4);

  List<BoxShadow> get boxShadow => [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ];

  Color _getBackgroundColor() {
    final colors = theme.colors;
    switch (variant) {
      case FSTooltipVariant.primary:
        return colors.primary;
      case FSTooltipVariant.secondary:
        return colors.secondary;
      case FSTooltipVariant.success:
        return colors.success;
      case FSTooltipVariant.danger:
        return colors.danger;
      case FSTooltipVariant.warning:
        return colors.warning;
      case FSTooltipVariant.info:
        return colors.info;
      case FSTooltipVariant.light:
        return colors.surface;
      case FSTooltipVariant.dark:
        return colors.onBackground;
    }
  }

  Color _getTextColor() {
    switch (variant) {
      case FSTooltipVariant.light:
        return theme.colors.onSurface;
      default:
        return Colors.white;
    }
  }
}
