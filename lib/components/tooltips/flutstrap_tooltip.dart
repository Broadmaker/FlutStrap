/// Flutstrap Tooltip
///
/// A highly customizable, accessible tooltip with Bootstrap-inspired styling,
/// smooth animations, and intelligent positioning.
///
/// {@tool snippet}
/// ### Basic Usage
///
/// ```dart
/// FlutstrapTooltip(
///   message: 'This is a tooltip',
///   child: Text('Hover me'),
/// )
/// ```
///
/// ### Advanced Configuration
///
/// ```dart
/// FlutstrapTooltip(
///   message: 'Danger action',
///   variant: FSTooltipVariant.danger,
///   placement: FSTooltipPlacement.bottom,
///   showDelay: Duration(milliseconds: 500),
///   maxWidth: 300,
///   child: IconButton(
///     icon: Icon(Icons.delete),
///     onPressed: () => _deleteItem(),
///   ),
/// )
/// ```
///
/// ### With Error Boundary
///
/// ```dart
/// FlutstrapTooltip.buildWithErrorBoundary(
///   message: complexMessage,
///   child: MyComplexWidget(),
///   fallback: Text('Tooltip unavailable'),
/// )
/// ```
/// {@end-tool}
///
/// {@template flutstrap_tooltip.performance}
/// ## Performance Features
///
/// - **Intelligent Caching**: Text measurements cached for identical tooltips
/// - **Debounced Interactions**: Prevents rapid show/hide cycles
/// - **Memory Management**: Proper timer and overlay disposal
/// - **Efficient Positioning**: Optimized offset calculations
/// {@endtemplate}
///
/// {@template flutstrap_tooltip.accessibility}
/// ## Accessibility
///
/// - Full screen reader support with semantic labels
/// - Keyboard navigation with focus management
/// - Touch, hover, and focus trigger support
/// - Long press support for mobile devices
/// {@endtemplate}
///
/// ## Trigger Methods
///
/// Tooltips can be triggered by:
/// - **Hover** (desktop/mouse)
/// - **Tap** (mobile/touch)
/// - **Focus** (keyboard navigation)
/// - **Long Press** (alternative mobile)
///
/// ## Best Practices
///
/// - Keep tooltip messages concise and actionable
/// - Use appropriate variants for message urgency
/// - Test positioning on different screen sizes
/// - Consider mobile touch interactions
/// - Use error boundaries for dynamic content
///
/// {@category Components}
/// {@category Overlays}

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../../core/error_boundary.dart'; // ✅ IMPORT SHARED ERROR BOUNDARY

/// Text measurement cache for performance optimization
class _TextMeasurementCache {
  static final _cache = <String, Size>{};

  static Size measureText(String text, TextStyle style, double maxWidth) {
    final cacheKey = '$text${style.fontSize}${style.fontWeight}$maxWidth';

    return _cache.putIfAbsent(cacheKey, () {
      final textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        textDirection: TextDirection.ltr,
        maxLines: 3,
      )..layout(maxWidth: maxWidth);
      return textPainter.size;
    });
  }

  static void clearCache() => _cache.clear();

  static int get cacheSize => _cache.length;
}

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
  static final _tooltipStack = <FlutstrapTooltipState>[];

  static void showTooltip(FlutstrapTooltipState tooltip, OverlayEntry entry) {
    // Hide any currently showing tooltip
    if (_currentTooltip != null) {
      _tooltipStack.add(_currentTooltip!);
    }

    _hideCurrentTooltipImmediate();
    _currentTooltip = tooltip;
    _currentEntry = entry;

    try {
      Overlay.of(tooltip.context, rootOverlay: true)?.insert(entry);
    } catch (e) {
      debugPrint('❌ TooltipManager: Failed to show tooltip - $e');
      _currentTooltip = null;
      _currentEntry = null;
    }
  }

  static void hideCurrentTooltip() {
    if (_currentTooltip != null) {
      _hideCurrentTooltipImmediate();

      // Show next tooltip in stack if available
      if (_tooltipStack.isNotEmpty) {
        final nextTooltip = _tooltipStack.removeLast();
        nextTooltip._showTooltip(); // Access private method via state
      }
    }
  }

  static void _hideCurrentTooltipImmediate() {
    _currentEntry?.remove();
    _currentEntry = null;
    _currentTooltip = null;
  }

  static void clearAllTooltips() {
    _hideCurrentTooltipImmediate();
    _tooltipStack.clear();
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
    super.key,
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
  });

  /// Build tooltip with error boundary for graceful error handling
  static Widget buildWithErrorBoundary({
    Key? key,
    required String message,
    required Widget child,
    Widget? fallback,
    FSTooltipVariant variant = FSTooltipVariant.primary,
    FSTooltipPlacement placement = FSTooltipPlacement.top,
    Duration showDelay = const Duration(milliseconds: 100),
    Duration hideDelay = const Duration(milliseconds: 100),
    Duration animationDuration = const Duration(milliseconds: 200),
    bool showArrow = true,
    double maxWidth = 200.0,
    EdgeInsetsGeometry padding =
        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    TextStyle? textStyle,
    Color? backgroundColor,
    BorderRadiusGeometry? borderRadius,
  }) {
    return ErrorBoundary(
      // ✅ USING SHARED ERROR BOUNDARY
      componentName: 'FlutstrapTooltip',
      fallbackBuilder: (context) => fallback ?? child,
      child: FlutstrapTooltip(
        key: key,
        message: message,
        child: child,
        variant: variant,
        placement: placement,
        showDelay: showDelay,
        hideDelay: hideDelay,
        animationDuration: animationDuration,
        showArrow: showArrow,
        maxWidth: maxWidth,
        padding: padding,
        textStyle: textStyle,
        backgroundColor: backgroundColor,
        borderRadius: borderRadius,
      ),
    );
  }

  @override
  State<FlutstrapTooltip> createState() => FlutstrapTooltipState();
}

class FlutstrapTooltipState extends State<FlutstrapTooltip> {
  OverlayEntry? _overlayEntry;
  final _layerLink = LayerLink();
  bool _isVisible = false;
  Timer? _showTimer;
  Timer? _hideTimer;

  // Performance optimizations
  static const Duration _debounceDelay = Duration(milliseconds: 50);
  DateTime? _lastInteractionTime;
  bool _isDisposing = false;

  @override
  void dispose() {
    _isDisposing = true;
    _showTimer?.cancel();
    _hideTimer?.cancel();
    if (_isVisible && _TooltipManager.isCurrentTooltip(this)) {
      _TooltipManager.hideCurrentTooltip();
    }
    _overlayEntry = null;
    super.dispose();
  }

  void _showTooltip() {
    final now = DateTime.now();
    if (_lastInteractionTime != null &&
        now.difference(_lastInteractionTime!) < _debounceDelay) {
      return;
    }
    _lastInteractionTime = now;

    _hideTimer?.cancel();
    _showTimer?.cancel();

    _showTimer = Timer(widget.showDelay, _showTooltipInternal);
  }

  void _showTooltipInternal() {
    if (!_isVisible && mounted && !_isDisposing) {
      _isVisible = true;
      _overlayEntry = _createOverlayEntry();
      _TooltipManager.showTooltip(this, _overlayEntry!);
    }
  }

  void _hideTooltip() {
    _showTimer?.cancel();

    _hideTimer = Timer(widget.hideDelay, () {
      if (_isVisible && mounted) {
        _isVisible = false;
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
        return ErrorBoundary(
          // ✅ USING SHARED ERROR BOUNDARY
          componentName: 'TooltipOverlay',
          fallbackBuilder: (context) => const SizedBox.shrink(),
          child: Positioned(
            child: CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: _getTooltipOffset(),
              child: _buildTooltipContent(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTooltipContent() {
    return Material(
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
    );
  }

  Offset _getTooltipOffset() {
    final renderBox = context.findRenderObject();
    if (renderBox is! RenderBox) {
      debugPrint('⚠️ Tooltip: Could not find RenderBox for positioning');
      return Offset.zero;
    }

    final size = renderBox.size;
    final tooltipWidth = _getTooltipWidth();
    final tooltipHeight = _getTooltipHeight();

    switch (widget.placement) {
      case FSTooltipPlacement.top:
        return Offset(-(tooltipWidth - size.width) / 2, -size.height - 12);
      case FSTooltipPlacement.topStart:
        return Offset(0, -size.height - 12);
      case FSTooltipPlacement.topEnd:
        return Offset(-(tooltipWidth - size.width), -size.height - 12);
      case FSTooltipPlacement.bottom:
        return Offset(-(tooltipWidth - size.width) / 2, size.height + 12);
      case FSTooltipPlacement.bottomStart:
        return Offset(0, size.height + 12);
      case FSTooltipPlacement.bottomEnd:
        return Offset(-(tooltipWidth - size.width), size.height + 12);
      case FSTooltipPlacement.right:
        return Offset(size.width + 12, -(tooltipHeight - size.height) / 2);
      case FSTooltipPlacement.rightStart:
        return Offset(size.width + 12, 0);
      case FSTooltipPlacement.rightEnd:
        return Offset(size.width + 12, -(tooltipHeight - size.height));
      case FSTooltipPlacement.left:
        return Offset(-tooltipWidth - 12, -(tooltipHeight - size.height) / 2);
      case FSTooltipPlacement.leftStart:
        return Offset(-tooltipWidth - 12, 0);
      case FSTooltipPlacement.leftEnd:
        return Offset(-tooltipWidth - 12, -(tooltipHeight - size.height));
    }
  }

  double _getTooltipWidth() {
    final size = _TextMeasurementCache.measureText(
      widget.message,
      widget.textStyle ?? _TooltipStyle._defaultTextStyle,
      widget.maxWidth,
    );
    return size.width + widget.padding.horizontal;
  }

  double _getTooltipHeight() {
    final size = _TextMeasurementCache.measureText(
      widget.message,
      widget.textStyle ?? _TooltipStyle._defaultTextStyle,
      widget.maxWidth,
    );
    return size.height + widget.padding.vertical + (widget.showArrow ? 8 : 0);
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Semantics(
        tooltip: widget.message,
        child: Focus(
          onFocusChange: (hasFocus) {
            if (hasFocus) {
              _showTooltip();
            } else {
              _hideTooltip();
            }
          },
          child: MouseRegion(
            onEnter: (_) => _showTooltip(),
            onExit: (_) => _hideTooltip(),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTapDown: (_) => _showTooltip(),
              onTapCancel: _forceHideTooltip,
              onTapUp: (_) => _forceHideTooltip,
              onLongPress: _showTooltip,
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}

/// Simple fade-in animation widget
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
