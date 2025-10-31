// Flutstrap FadeIn Animation
//
// A high-performance widget that gradually fades in its child with
// theme integration, memory optimization, and flexible configuration.
//
// ## Usage Examples
//
// ```dart
// // Basic usage
// FadeIn(
//   child: Text('Hello World'),
// )
//
// // Custom duration and curve
// FadeIn(
//   child: MyWidget(),
//   duration: Duration(milliseconds: 1000),
//   curve: Curves.easeInOut,
//   delay: Duration(milliseconds: 200),
// )
//
// // Using theme configuration
// FadeIn.themed(
//   context: context,
//   child: MyWidget(),
// )
//
// // Manual control
// final fadeKey = GlobalKey<FadeInState>();
// FadeIn(
//   key: fadeKey,
//   child: MyWidget(),
//   autoPlay: false,
// )
// // Later...
// fadeKey.currentState?.play();
// ```
//
// {@template flutstrap_fade_in.performance}
// ## Performance Features
//
// - **Memory Optimized**: Proper controller disposal and timer cleanup
// - **Efficient Rebuilds**: Uses `AnimatedBuilder` for minimal rebuilds
// - **State Management**: Configurable state maintenance for off-screen widgets
// - **Frame Rate Aware**: Smooth 60fps animations with proper timing
//
// ### Best Practices
//
// - Use `maintainState: false` for large lists to improve performance
// - Set `autoPlay: false` for manually triggered animations
// - Use pre-configured variations (`FadeInQuick`, `FadeInStandard`) for consistency
// - Consider using `respectSystemPreferences: true` for accessibility
// {@endtemplate}
//
// {@template flutstrap_fade_in.accessibility}
// ## Accessibility
//
// - Respects system animation preferences when `respectSystemPreferences` is true
// - Maintains semantic focus order during animations
// - Screen reader compatible animation states
// - Reduced motion consideration for users with vestibular disorders
// {@endtemplate}
//
// {@category Animations}
// {@category Components}

import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../../core/error_boundary.dart';

/// FadeIn Animation Widget
///
/// A widget that gradually fades in its child over a specified duration.
/// Features memory-optimized controllers, theme integration, and
/// performance enhancements.
class FadeIn extends StatefulWidget {
  /// The child widget to animate
  final Widget child;

  /// The duration of the fade-in animation
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

  /// Whether to maintain the widget's state when not visible
  final bool maintainState;

  /// Whether to respect system animation preferences
  final bool respectSystemPreferences;

  /// Creates a fade-in animation widget
  const FadeIn({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.delay = Duration.zero,
    this.curve = Curves.easeInOut,
    this.autoPlay = true,
    this.onComplete,
    this.onCancel,
    this.maintainState = true,
    this.respectSystemPreferences = true,
  });

  /// Create a fade-in animation using theme configuration
  factory FadeIn.themed({
    Key? key,
    required BuildContext context,
    required Widget child,
    Duration? duration,
    Duration delay = Duration.zero,
    Curve? curve,
    bool autoPlay = true,
    VoidCallback? onComplete,
    VoidCallback? onCancel,
    bool maintainState = true,
    bool respectSystemPreferences = true,
  }) {
    final theme = FSTheme.of(context);
    final animationConfig = theme.animation;

    return FadeIn(
      key: key,
      child: child,
      duration: duration ?? animationConfig.duration,
      delay: delay,
      curve: curve ?? animationConfig.curve,
      autoPlay: autoPlay,
      onComplete: onComplete,
      onCancel: onCancel,
      maintainState: maintainState,
      respectSystemPreferences: respectSystemPreferences,
    );
  }

  @override
  State<FadeIn> createState() => FadeInState();
}

class FadeInState extends State<FadeIn> with SingleTickerProviderStateMixin {
  static const double _beginOpacity = 0.0;
  static const double _endOpacity = 1.0;

  late AnimationController _controller;
  late Animation<double> _animation;
  Timer? _delayTimer;
  bool _isDisposed = false;

  /// Whether animations should play based on system preferences
  bool get _shouldAnimate {
    if (!widget.respectSystemPreferences) return true;
    final mediaQuery = MediaQuery.maybeOf(context);
    return mediaQuery?.disableAnimations != true;
  }

  /// Current opacity value (0.0 to 1.0)
  double get opacity => _animation.value.clamp(_beginOpacity, _endOpacity);

  /// Whether the animation is currently running
  bool get isAnimating => _controller.isAnimating;

  /// Whether the animation has completed
  bool get isCompleted => _controller.isCompleted;

  @override
  void initState() {
    super.initState();
    _initializeAnimation();

    if (widget.autoPlay && _shouldAnimate) {
      _startAnimation();
    }
  }

  void _initializeAnimation() {
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = Tween<double>(
      begin: _beginOpacity,
      end: _endOpacity,
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

  Future<void> _startAnimation() async {
    if (!mounted || _isDisposed) return;

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

  /// Manually start the fade-in animation
  Future<void> play() async {
    if (!mounted || _controller.isAnimating || !_shouldAnimate) return;
    await _controller.forward().orCancel;
  }

  /// Manually reverse the animation (fade out)
  Future<void> reverse() async {
    if (!mounted || _controller.isAnimating) return;
    await _controller.reverse().orCancel;
  }

  /// Manually reset the animation to its initial state
  void reset() {
    if (mounted && !_isDisposed && !_controller.isAnimating) {
      _controller.reset();
    }
  }

  /// Manually stop the animation
  void stop() {
    if (mounted && !_isDisposed) {
      _controller.stop();
    }
  }

  /// Set the animation to a specific value (0.0 to 1.0)
  void setValue(double value) {
    if (mounted && !_isDisposed) {
      _controller.value = value.clamp(0.0, 1.0);
    }
  }

  @override
  void didUpdateWidget(FadeIn oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Cancel any pending delay timer
    _delayTimer?.cancel();

    // Update controller duration if changed
    if (widget.duration != oldWidget.duration) {
      _controller.duration = widget.duration;
    }

    // Update animation if curve changed
    if (widget.curve != oldWidget.curve) {
      _animation = Tween<double>(
        begin: _beginOpacity,
        end: _endOpacity,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: widget.curve,
        ),
      );
    }

    // Restart animation if autoPlay changed to true and should animate
    if (widget.autoPlay && !oldWidget.autoPlay && _shouldAnimate) {
      _startAnimation();
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    _delayTimer?.cancel();
    _controller.removeStatusListener(_handleStatusChange);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ErrorBoundary(
      componentName: 'FadeIn',
      fallbackBuilder: (context) =>
          widget.child, // ✅ FIXED: Removed dynamic parameter
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          // Pre-calculate opacity once
          final currentOpacity = _animation.value.clamp(0.0, 1.0);
          return Opacity(
            opacity: currentOpacity,
            // Use Visibility to properly handle state maintenance
            child: widget.maintainState
                ? child
                : Visibility(
                    visible: currentOpacity > 0.0,
                    maintainState: widget.maintainState,
                    child: child!,
                  ),
          );
        },
        child: widget.child,
      ),
    );
  }
}

// =============================================================================
// PRE-CONFIGURED FADE IN VARIATIONS
// =============================================================================

/// Quick fade-in animation (200ms)
class FadeInQuick extends StatelessWidget {
  final Widget child;
  final Duration delay;
  final bool autoPlay;
  final VoidCallback? onComplete;
  final bool maintainState;
  final bool respectSystemPreferences;

  const FadeInQuick({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.autoPlay = true,
    this.onComplete,
    this.maintainState = true,
    this.respectSystemPreferences = true,
  });

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      key: key,
      child: child,
      duration: const Duration(milliseconds: 200),
      delay: delay,
      autoPlay: autoPlay,
      onComplete: onComplete,
      maintainState: maintainState,
      respectSystemPreferences: respectSystemPreferences,
    );
  }
}

/// Standard fade-in animation (500ms)
class FadeInStandard extends StatelessWidget {
  final Widget child;
  final Duration delay;
  final bool autoPlay;
  final VoidCallback? onComplete;
  final bool maintainState;
  final bool respectSystemPreferences;

  const FadeInStandard({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.autoPlay = true,
    this.onComplete,
    this.maintainState = true,
    this.respectSystemPreferences = true,
  });

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      key: key,
      child: child,
      duration: const Duration(milliseconds: 500),
      delay: delay,
      autoPlay: autoPlay,
      onComplete: onComplete,
      maintainState: maintainState,
      respectSystemPreferences: respectSystemPreferences,
    );
  }
}

/// Slow fade-in animation (1000ms)
class FadeInSlow extends StatelessWidget {
  final Widget child;
  final Duration delay;
  final bool autoPlay;
  final VoidCallback? onComplete;
  final bool maintainState;
  final bool respectSystemPreferences;

  const FadeInSlow({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.autoPlay = true,
    this.onComplete,
    this.maintainState = true,
    this.respectSystemPreferences = true,
  });

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      key: key,
      child: child,
      duration: const Duration(milliseconds: 1000),
      delay: delay,
      autoPlay: autoPlay,
      onComplete: onComplete,
      maintainState: maintainState,
      respectSystemPreferences: respectSystemPreferences,
    );
  }
}

/// Fade-in with bounce curve for playful animations
class FadeInBounce extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final bool autoPlay;
  final VoidCallback? onComplete;
  final bool maintainState;
  final bool respectSystemPreferences;

  const FadeInBounce({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 600),
    this.delay = Duration.zero,
    this.autoPlay = true,
    this.onComplete,
    this.maintainState = true,
    this.respectSystemPreferences = true,
  });

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      key: key,
      child: child,
      duration: duration,
      delay: delay,
      curve: Curves.bounceOut,
      autoPlay: autoPlay,
      onComplete: onComplete,
      maintainState: maintainState,
      respectSystemPreferences: respectSystemPreferences,
    );
  }
}

/// Fade-in with elastic curve for attention-grabbing animations
class FadeInElastic extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final bool autoPlay;
  final VoidCallback? onComplete;
  final bool maintainState;
  final bool respectSystemPreferences;

  const FadeInElastic({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 800),
    this.delay = Duration.zero,
    this.autoPlay = true,
    this.onComplete,
    this.maintainState = true,
    this.respectSystemPreferences = true,
  });

  @override
  State<FadeInElastic> createState() => _FadeInElasticState();
}

class _FadeInElasticState extends State<FadeInElastic>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  Timer? _delayTimer;
  bool _isDisposed = false;

  /// Whether animations should play based on system preferences
  bool get _shouldAnimate {
    if (!widget.respectSystemPreferences) return true;
    final mediaQuery = MediaQuery.maybeOf(context);
    return mediaQuery?.disableAnimations != true;
  }

  @override
  void initState() {
    super.initState();
    _initializeAnimation();

    if (widget.autoPlay && _shouldAnimate) {
      _startAnimation();
    }
  }

  void _initializeAnimation() {
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const ElasticOutCurve(0.7),
      ),
    );

    // Status listener for completion callback
    _controller.addStatusListener((status) {
      if (_isDisposed) return;
      if (status == AnimationStatus.completed) {
        widget.onComplete?.call();
      }
    });
  }

  Future<void> _startAnimation() async {
    if (!mounted || _isDisposed) return;

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
      if (mounted && !_isDisposed) {
        // Animation was cancelled
      }
    }
  }

  @override
  void didUpdateWidget(FadeInElastic oldWidget) {
    super.didUpdateWidget(oldWidget);
    _delayTimer?.cancel();

    if (widget.duration != oldWidget.duration) {
      _controller.duration = widget.duration;
    }

    if (widget.autoPlay && !oldWidget.autoPlay && _shouldAnimate) {
      _startAnimation();
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    _delayTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ErrorBoundary(
      componentName: 'FadeInElastic',
      fallbackBuilder: (context) =>
          widget.child, // ✅ FIXED: Removed dynamic parameter
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final currentOpacity = _animation.value.clamp(0.0, 1.0);
          return Opacity(
            opacity: currentOpacity,
            child: widget.maintainState
                ? child
                : Visibility(
                    visible: currentOpacity > 0.0,
                    maintainState: widget.maintainState,
                    child: child!,
                  ),
          );
        },
        child: widget.child,
      ),
    );
  }
}

/// Custom elastic curve that stays within reasonable bounds
class ElasticOutCurve extends Curve {
  final double period;

  // Cache calculations for better performance
  static const double _twoPi = 2.0 * 3.1415926535897932;

  const ElasticOutCurve([this.period = 0.4]);

  @override
  double transform(double t) {
    final double s = period / 4.0;
    // Use pre-calculated constants
    return (math.pow(2.0, -10.0 * t) * math.sin((t - s) * _twoPi / period)) +
        1.0;
  }

  // Better debugging
  @override
  String toString() => 'ElasticOutCurve(period: $period)';
}
