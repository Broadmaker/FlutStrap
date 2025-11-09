// Flutstrap SlideTransition Animation
//
// A high-performance widget that slides its child into position with
// theme integration, memory optimization, and flexible configuration.

import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../../core/error_boundary.dart';

/// Slide Direction for FSSlideTransition
enum FSSlideDirection {
  fromTop,
  fromBottom,
  fromLeft,
  fromRight,
  fromTopLeft,
  fromTopRight,
  fromBottomLeft,
  fromBottomRight,
}

/// FSSlideTransition Animation Widget
///
/// A widget that slides its child into position from a specified direction.
/// Features memory-optimized controllers, theme integration, and
/// performance enhancements.
class FSSlideTransition extends StatefulWidget {
  /// The child widget to animate
  final Widget child;

  /// The direction from which the child slides in
  final FSSlideDirection direction;

  /// The duration of the slide animation
  final Duration duration;

  /// The delay before the animation starts
  final Duration delay;

  /// The curve of the animation
  final Curve curve;

  /// Whether the animation should play automatically when the widget is built
  final bool autoPlay;

  /// Callback function called when the animation completes
  final VoidCallback? onComplete;

  /// Callback function called if the animation is interrupted
  final VoidCallback? onCancel;

  /// The offset distance as a fraction of the child's size (0.0 to 2.0)
  final double offsetFraction;

  /// Whether to maintain the widget's state when off-screen
  final bool maintainState;

  /// Whether to respect system animation preferences
  final bool respectSystemPreferences;

  /// Creates a slide transition animation widget
  const FSSlideTransition({
    super.key,
    required this.child,
    this.direction = FSSlideDirection.fromBottom,
    this.duration = const Duration(milliseconds: 500),
    this.delay = Duration.zero,
    this.curve = Curves.easeOut,
    this.autoPlay = true,
    this.onComplete,
    this.onCancel,
    this.offsetFraction = 1.0,
    this.maintainState = true,
    this.respectSystemPreferences = true,
  }) : assert(offsetFraction >= 0.0 && offsetFraction <= 2.0,
            'offsetFraction must be between 0.0 and 2.0');

  /// Create a slide transition animation using theme configuration
  factory FSSlideTransition.themed({
    Key? key,
    required BuildContext context,
    required Widget child,
    FSSlideDirection direction = FSSlideDirection.fromBottom,
    Duration? duration,
    Duration delay = Duration.zero,
    Curve? curve,
    bool autoPlay = true,
    VoidCallback? onComplete,
    VoidCallback? onCancel,
    double offsetFraction = 1.0,
    bool maintainState = true,
    bool respectSystemPreferences = true,
  }) {
    final theme = FSTheme.of(context);
    final animationConfig = theme.animation;

    return FSSlideTransition(
      key: key,
      child: child,
      direction: direction,
      duration: duration ?? animationConfig.duration,
      delay: delay,
      curve: curve ?? animationConfig.curve,
      autoPlay: autoPlay,
      onComplete: onComplete,
      onCancel: onCancel,
      offsetFraction: offsetFraction,
      maintainState: maintainState,
      respectSystemPreferences: respectSystemPreferences,
    );
  }

  @override
  State<FSSlideTransition> createState() => FSSlideTransitionState();
}

class FSSlideTransitionState extends State<FSSlideTransition>
    with SingleTickerProviderStateMixin {
  static const Offset _endOffset = Offset.zero;

  late AnimationController _controller;
  late Animation<Offset> _animation;
  Timer? _delayTimer;
  bool _isDisposed = false;
  bool _isInitialized = false; // ✅ ADDED: Track initialization state

  /// ✅ FIXED: Safe context access with mounted check
  bool _shouldAnimate(BuildContext context) {
    if (!widget.autoPlay) return false;
    if (!widget.respectSystemPreferences) return true;
    if (!mounted) return false;

    final mediaQuery = MediaQuery.maybeOf(context);
    return mediaQuery?.disableAnimations != true;
  }

  /// Current offset value
  Offset get offset => _animation.value;

  /// Whether the animation is currently running
  bool get isAnimating => _controller.isAnimating;

  /// Whether the animation has completed
  bool get isCompleted => _controller.isCompleted;

  @override
  void initState() {
    super.initState();
    _initializeAnimation();

    // ✅ FIXED: Delay context access until after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && !_isDisposed) {
        setState(() {
          _isInitialized = true;
        });
        if (widget.autoPlay && _shouldAnimate(context)) {
          _startAnimation();
        }
      }
    });
  }

  void _initializeAnimation() {
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = Tween<Offset>(
      begin: _getBeginOffset(),
      end: _endOffset,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.curve,
      ),
    );

    // Add status listener for completion callback
    _controller.addStatusListener(_handleStatusChange);
  }

  void _handleStatusChange(AnimationStatus status) {
    if (_isDisposed) return;

    if (status == AnimationStatus.completed) {
      widget.onComplete?.call();
    } else if (status == AnimationStatus.dismissed) {
      widget.onCancel?.call();
    }
  }

  Offset _getBeginOffset() {
    final fraction = widget.offsetFraction;

    switch (widget.direction) {
      case FSSlideDirection.fromTop:
        return Offset(0.0, -fraction);
      case FSSlideDirection.fromBottom:
        return Offset(0.0, fraction);
      case FSSlideDirection.fromLeft:
        return Offset(-fraction, 0.0);
      case FSSlideDirection.fromRight:
        return Offset(fraction, 0.0);
      case FSSlideDirection.fromTopLeft:
        return Offset(-fraction, -fraction);
      case FSSlideDirection.fromTopRight:
        return Offset(fraction, -fraction);
      case FSSlideDirection.fromBottomLeft:
        return Offset(-fraction, fraction);
      case FSSlideDirection.fromBottomRight:
        return Offset(fraction, fraction);
    }
  }

  Future<void> _startAnimation() async {
    if (!mounted || _isDisposed || !_isInitialized) return;

    if (widget.delay > Duration.zero) {
      _delayTimer = Timer(widget.delay, _executeAnimation);
    } else {
      await _executeAnimation();
    }
  }

  Future<void> _executeAnimation() async {
    if (!mounted || _isDisposed) return;

    try {
      await _controller.forward().orCancel;
    } catch (error) {
      // Handle animation cancellation gracefully
      if (mounted && !_isDisposed) {
        widget.onCancel?.call();
      }
    }
  }

  /// Manually start the slide animation
  Future<void> play() async {
    if (!mounted || _controller.isAnimating || !_isInitialized) return;
    if (!_shouldAnimate(context)) return;
    await _controller.forward().orCancel;
  }

  /// Manually reverse the animation (slide out)
  Future<void> reverse() async {
    if (!mounted || _controller.isAnimating || !_isInitialized) return;
    await _controller.reverse().orCancel;
  }

  /// Manually reset the animation to its initial state
  void reset() {
    if (mounted && !_isDisposed && !_controller.isAnimating && _isInitialized) {
      _controller.reset();
    }
  }

  /// Manually stop the animation
  void stop() {
    if (mounted && !_isDisposed && _isInitialized) {
      _controller.stop();
    }
  }

  /// Set the animation to a specific value (0.0 to 1.0)
  void setValue(double value) {
    if (mounted && !_isDisposed && _isInitialized) {
      _controller.value = value.clamp(0.0, 1.0);
    }
  }

  @override
  void didUpdateWidget(FSSlideTransition oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Cancel any pending delay timer
    _delayTimer?.cancel();

    // Update controller duration if changed
    if (widget.duration != oldWidget.duration) {
      _controller.duration = widget.duration;
    }

    // Update animation if direction, offset, or curve changed
    if (widget.direction != oldWidget.direction ||
        widget.offsetFraction != oldWidget.offsetFraction ||
        widget.curve != oldWidget.curve) {
      _animation = Tween<Offset>(
        begin: _getBeginOffset(),
        end: _endOffset,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: widget.curve,
        ),
      );
    }

    // Restart animation if autoPlay changed to true and should animate
    if (widget.autoPlay && !oldWidget.autoPlay && _shouldAnimate(context)) {
      _startAnimation();
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    _delayTimer?.cancel();
    _delayTimer = null;
    _controller.removeStatusListener(_handleStatusChange);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ErrorBoundary(
      componentName: 'FSSlideTransition',
      fallbackBuilder: (context) => widget.child,
      child: _isInitialized
          ? _buildAnimatedContent(context)
          : _buildStaticContent(),
    );
  }

  Widget _buildAnimatedContent(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final currentOffset = _animation.value;
        final isVisible = _calculateVisibility(currentOffset);

        return Transform.translate(
          offset: currentOffset,
          child: widget.maintainState
              ? child
              : _buildVisibilityWrapper(child!, isVisible),
        );
      },
      child: widget.child,
    );
  }

  Widget _buildStaticContent() {
    return Transform.translate(
      offset: _getBeginOffset(),
      child: widget.child,
    );
  }

  /// Calculate if widget should be visible based on current offset
  bool _calculateVisibility(Offset offset) {
    const visibilityThreshold = 1.5;
    return offset.dx.abs() < visibilityThreshold &&
        offset.dy.abs() < visibilityThreshold;
  }

  Widget _buildVisibilityWrapper(Widget child, bool isVisible) {
    return Visibility(
      visible: isVisible,
      maintainState: widget.maintainState,
      maintainAnimation: true,
      maintainSize: false,
      maintainInteractivity: false,
      child: child,
    );
  }
}

// =============================================================================
// PRE-CONFIGURED SLIDE TRANSITION VARIATIONS
// =============================================================================

/// Quick slide animation (300ms)
class FSSlideTransitionQuick extends StatelessWidget {
  final Widget child;
  final FSSlideDirection direction;
  final Duration delay;
  final bool autoPlay;
  final VoidCallback? onComplete;
  final VoidCallback? onCancel;
  final double offsetFraction;
  final bool maintainState;
  final bool respectSystemPreferences;

  const FSSlideTransitionQuick({
    super.key,
    required this.child,
    this.direction = FSSlideDirection.fromBottom,
    this.delay = Duration.zero,
    this.autoPlay = true,
    this.onComplete,
    this.onCancel,
    this.offsetFraction = 1.0,
    this.maintainState = true,
    this.respectSystemPreferences = true,
  });

  @override
  Widget build(BuildContext context) {
    return FSSlideTransition(
      key: key,
      child: child,
      direction: direction,
      duration: const Duration(milliseconds: 300),
      delay: delay,
      autoPlay: autoPlay,
      onComplete: onComplete,
      onCancel: onCancel,
      offsetFraction: offsetFraction,
      maintainState: maintainState,
      respectSystemPreferences: respectSystemPreferences,
    );
  }
}

/// Standard slide animation (500ms)
class FSSlideTransitionStandard extends StatelessWidget {
  final Widget child;
  final FSSlideDirection direction;
  final Duration delay;
  final bool autoPlay;
  final VoidCallback? onComplete;
  final VoidCallback? onCancel;
  final double offsetFraction;
  final bool maintainState;
  final bool respectSystemPreferences;

  const FSSlideTransitionStandard({
    super.key,
    required this.child,
    this.direction = FSSlideDirection.fromBottom,
    this.delay = Duration.zero,
    this.autoPlay = true,
    this.onComplete,
    this.onCancel,
    this.offsetFraction = 1.0,
    this.maintainState = true,
    this.respectSystemPreferences = true,
  });

  @override
  Widget build(BuildContext context) {
    return FSSlideTransition(
      key: key,
      child: child,
      direction: direction,
      duration: const Duration(milliseconds: 500),
      delay: delay,
      autoPlay: autoPlay,
      onComplete: onComplete,
      onCancel: onCancel,
      offsetFraction: offsetFraction,
      maintainState: maintainState,
      respectSystemPreferences: respectSystemPreferences,
    );
  }
}

/// Slow slide animation (800ms)
class FSSlideTransitionSlow extends StatelessWidget {
  final Widget child;
  final FSSlideDirection direction;
  final Duration delay;
  final bool autoPlay;
  final VoidCallback? onComplete;
  final VoidCallback? onCancel;
  final double offsetFraction;
  final bool maintainState;
  final bool respectSystemPreferences;

  const FSSlideTransitionSlow({
    super.key,
    required this.child,
    this.direction = FSSlideDirection.fromBottom,
    this.delay = Duration.zero,
    this.autoPlay = true,
    this.onComplete,
    this.onCancel,
    this.offsetFraction = 1.0,
    this.maintainState = true,
    this.respectSystemPreferences = true,
  });

  @override
  Widget build(BuildContext context) {
    return FSSlideTransition(
      key: key,
      child: child,
      direction: direction,
      duration: const Duration(milliseconds: 800),
      delay: delay,
      autoPlay: autoPlay,
      onComplete: onComplete,
      onCancel: onCancel,
      offsetFraction: offsetFraction,
      maintainState: maintainState,
      respectSystemPreferences: respectSystemPreferences,
    );
  }
}

/// Slide from top with bounce curve
class FSSlideTransitionBounce extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final bool autoPlay;
  final VoidCallback? onComplete;
  final VoidCallback? onCancel;
  final double offsetFraction;
  final bool maintainState;
  final bool respectSystemPreferences;

  const FSSlideTransitionBounce({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 600),
    this.delay = Duration.zero,
    this.autoPlay = true,
    this.onComplete,
    this.onCancel,
    this.offsetFraction = 1.0,
    this.maintainState = true,
    this.respectSystemPreferences = true,
  });

  @override
  Widget build(BuildContext context) {
    return FSSlideTransition(
      key: key,
      child: child,
      direction: FSSlideDirection.fromTop,
      duration: duration,
      delay: delay,
      curve: Curves.bounceOut,
      autoPlay: autoPlay,
      onComplete: onComplete,
      onCancel: onCancel,
      offsetFraction: offsetFraction,
      maintainState: maintainState,
      respectSystemPreferences: respectSystemPreferences,
    );
  }
}

/// Slide from right with elastic curve
class FSSlideTransitionElastic extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final bool autoPlay;
  final VoidCallback? onComplete;
  final VoidCallback? onCancel;
  final double offsetFraction;
  final bool maintainState;
  final bool respectSystemPreferences;

  const FSSlideTransitionElastic({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 800),
    this.delay = Duration.zero,
    this.autoPlay = true,
    this.onComplete,
    this.onCancel,
    this.offsetFraction = 1.0,
    this.maintainState = true,
    this.respectSystemPreferences = true,
  });

  @override
  Widget build(BuildContext context) {
    return FSSlideTransition(
      key: key,
      child: child,
      direction: FSSlideDirection.fromRight,
      duration: duration,
      delay: delay,
      curve: Curves.elasticOut,
      autoPlay: autoPlay,
      onComplete: onComplete,
      onCancel: onCancel,
      offsetFraction: offsetFraction,
      maintainState: maintainState,
      respectSystemPreferences: respectSystemPreferences,
    );
  }
}

/// Slide from right for page transitions
class FSSlideTransitionPage extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final bool autoPlay;
  final VoidCallback? onComplete;
  final VoidCallback? onCancel;
  final bool maintainState;
  final bool respectSystemPreferences;

  const FSSlideTransitionPage({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 400),
    this.delay = Duration.zero,
    this.autoPlay = true,
    this.onComplete,
    this.onCancel,
    this.maintainState = true,
    this.respectSystemPreferences = true,
  });

  @override
  Widget build(BuildContext context) {
    return FSSlideTransition(
      key: key,
      child: child,
      direction: FSSlideDirection.fromRight,
      duration: duration,
      delay: delay,
      curve: Curves.easeInOut,
      autoPlay: autoPlay,
      onComplete: onComplete,
      onCancel: onCancel,
      offsetFraction: 1.0,
      maintainState: maintainState,
      respectSystemPreferences: respectSystemPreferences,
    );
  }
}
