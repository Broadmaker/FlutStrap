// Flutstrap Scale Animation
//
// A high-performance widget that scales its child with smooth animations,
// theme integration, and flexible configuration options.
//
// ## Usage Examples
//
// ```dart
// // Basic scale in animation
// FSScaleAnimation(
//   child: MyWidget(),
// )
//
// // Custom scale with bounce effect
// FSScaleAnimation(
//   child: MyButton(),
//   beginScale: 0.5,
//   endScale: 1.2,
//   curve: Curves.bounceOut,
//   duration: Duration(milliseconds: 600),
// )
//
// // Scale from top left
// FSScaleAnimation(
//   child: MyCard(),
//   alignment: Alignment.topLeft,
//   beginScale: 0.0,
//   endScale: 1.0,
// )
//
// // Using theme configuration
// FSScaleAnimation.themed(
//   context: context,
//   child: MyWidget(),
// )
//
// // Manual control
// final scaleKey = GlobalKey<FSScaleAnimationState>();
// FSScaleAnimation(
//   key: scaleKey,
//   child: MyWidget(),
//   autoPlay: false,
// )
// // Later...
// scaleKey.currentState?.play();
// ```
//
// {@template flutstrap_scale_animation.performance}
// ## Performance Features
//
// - **Memory Optimized**: Proper controller disposal and timer cleanup
// - **Efficient Rebuilds**: Uses `AnimatedBuilder` for minimal rebuilds
// - **State Management**: Configurable state maintenance for scaled-down widgets
// - **Frame Rate Aware**: Smooth 60fps animations with proper timing
//
// ### Best Practices
//
// - Use `maintainState: false` for large lists to improve performance
// - Set `autoPlay: false` for manually triggered animations
// - Use pre-configured variations for consistent timing
// - Consider using `respectSystemPreferences: true` for accessibility
// {@endtemplate}
//
// {@template flutstrap_scale_animation.accessibility}
// ## Accessibility
//
// - Respects system animation preferences when `respectSystemPreferences` is true
// - Maintains semantic focus order during scale animations
// - Screen reader compatible animation states
// - Reduced motion consideration for users with vestibular disorders
// {@endtemplate}
//
// {@category Animations}
// {@category Components}

import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../../core/error_boundary.dart'; // ✅ ADDED: Error boundary import

/// Scale animation widget with performance optimizations and theme integration
class FSScaleAnimation extends StatefulWidget {
  /// The child widget to animate
  final Widget child;

  /// The starting scale value (0.0 = completely scaled down, 1.0 = normal size)
  final double beginScale;

  /// The ending scale value (1.0 = normal size, >1.0 = scaled up)
  final double endScale;

  /// The duration of the scale animation
  final Duration duration;

  /// The delay before the animation starts
  final Duration delay;

  /// The curve of the animation
  final Curve curve;

  /// The alignment origin for the scale transformation
  final Alignment alignment;

  /// Whether the animation should play automatically when the widget is built
  final bool autoPlay;

  /// Callback function called when the animation completes
  final VoidCallback? onComplete;

  /// Callback function called if the animation is interrupted
  final VoidCallback? onCancel;

  /// Whether to maintain the widget's state when scaled down
  final bool maintainState;

  /// Whether to respect system animation preferences
  final bool respectSystemPreferences;

  /// Creates a scale animation widget
  const FSScaleAnimation({
    super.key,
    required this.child,
    this.beginScale = 0.0,
    this.endScale = 1.0,
    this.duration = const Duration(milliseconds: 500),
    this.delay = Duration.zero,
    this.curve = Curves.easeOut,
    this.alignment = Alignment.center,
    this.autoPlay = true,
    this.onComplete,
    this.onCancel,
    this.maintainState = true,
    this.respectSystemPreferences = true, // ✅ ADDED: Accessibility
  })  : assert(beginScale >= 0.0, 'Begin scale must be non-negative'),
        assert(endScale >= 0.0, 'End scale must be non-negative');

  /// Create a scale animation using theme configuration
  factory FSScaleAnimation.themed({
    Key? key,
    required BuildContext context,
    required Widget child,
    double beginScale = 0.0,
    double endScale = 1.0,
    Duration? duration,
    Duration delay = Duration.zero,
    Curve? curve,
    Alignment alignment = Alignment.center,
    bool autoPlay = true,
    VoidCallback? onComplete,
    VoidCallback? onCancel,
    bool maintainState = true,
    bool respectSystemPreferences = true,
  }) {
    final theme = FSTheme.of(context);
    final animationConfig = theme.animation;

    return FSScaleAnimation(
      key: key,
      child: child,
      beginScale: beginScale,
      endScale: endScale,
      duration: duration ?? animationConfig.duration,
      delay: delay,
      curve: curve ?? animationConfig.curve,
      alignment: alignment,
      autoPlay: autoPlay,
      onComplete: onComplete,
      onCancel: onCancel,
      maintainState: maintainState,
      respectSystemPreferences: respectSystemPreferences,
    );
  }

  @override
  State<FSScaleAnimation> createState() => FSScaleAnimationState();
}

class FSScaleAnimationState extends State<FSScaleAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  Timer? _delayTimer;
  bool _isDisposed = false; // ✅ ADDED: Memory management

  /// Whether animations should play based on system preferences
  bool get _shouldAnimate {
    if (!widget.respectSystemPreferences) return true;
    final mediaQuery = MediaQuery.maybeOf(context);
    return mediaQuery?.disableAnimations != true;
  }

  /// Current scale value
  double get scale => _animation.value;

  /// Whether the animation is currently running
  bool get isAnimating => _controller.isAnimating;

  /// Whether the animation has completed
  bool get isCompleted => _controller.isCompleted;

  @override
  void initState() {
    super.initState();
    _initializeAnimation();

    if (widget.autoPlay && _shouldAnimate) {
      // ✅ CHECK: System preferences
      _startAnimation();
    }
  }

  void _initializeAnimation() {
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = Tween<double>(
      begin: widget.beginScale,
      end: widget.endScale,
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
    if (_isDisposed) return; // ✅ ADDED: Safety check

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

  /// Manually start the scale animation
  Future<void> play() async {
    if (!mounted || _controller.isAnimating || !_shouldAnimate) return;
    await _controller.forward().orCancel;
  }

  /// Manually reverse the animation (scale down)
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

  /// Set the animation to a specific scale value
  void setScale(double value) {
    if (mounted && !_isDisposed) {
      _controller.value = value.clamp(0.0, 1.0);
    }
  }

  /// Pulse animation - scale up and down
  Future<void> pulse({int count = 1, double pulseScale = 1.1}) async {
    if (!mounted || _controller.isAnimating || !_shouldAnimate) return;

    for (int i = 0; i < count; i++) {
      await _controller.forward().orCancel;
      await _controller.reverse().orCancel;
      if (!mounted || _isDisposed) break;
    }
  }

  @override
  void didUpdateWidget(FSScaleAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Cancel any pending delay timer
    _delayTimer?.cancel();

    // Update controller duration if changed
    if (widget.duration != oldWidget.duration) {
      _controller.duration = widget.duration;
    }

    // Update animation if scale values or curve changed
    if (widget.beginScale != oldWidget.beginScale ||
        widget.endScale != oldWidget.endScale ||
        widget.curve != oldWidget.curve) {
      _animation = Tween<double>(
        begin: widget.beginScale,
        end: widget.endScale,
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
    _delayTimer = null; // ✅ ADDED: Explicit null assignment
    _controller.removeStatusListener(_handleStatusChange);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ErrorBoundary(
      // ✅ ADDED: Error boundary
      componentName: 'FSScaleAnimation',
      fallbackBuilder: (context) => widget.child,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          // ✅ OPTIMIZED: Pre-calculate scale once
          final currentScale = _animation.value.clamp(0.0, double.maxFinite);
          return Transform.scale(
            scale: currentScale,
            alignment: widget.alignment,
            child: widget.maintainState
                ? child
                : _buildVisibilityWrapper(child!, currentScale),
          );
        },
        child: widget.child,
      ),
    );
  }

  Widget _buildVisibilityWrapper(Widget child, double scale) {
    // Only render when scale is above a minimal visible threshold
    final isVisible = scale > 0.01;

    return Visibility(
      visible: isVisible,
      maintainState: widget.maintainState,
      child: child,
    );
  }
}

// =============================================================================
// PRE-CONFIGURED SCALE ANIMATION VARIATIONS
// =============================================================================

/// Quick scale animation (300ms)
class FSScaleAnimationQuick extends StatelessWidget {
  final Widget child;
  final double beginScale;
  final double endScale;
  final Duration delay;
  final bool autoPlay;
  final VoidCallback? onComplete;
  final VoidCallback? onCancel;
  final Alignment alignment;
  final bool maintainState;
  final bool respectSystemPreferences;

  const FSScaleAnimationQuick({
    // ✅ CONST: Better performance
    super.key,
    required this.child,
    this.beginScale = 0.0,
    this.endScale = 1.0,
    this.delay = Duration.zero,
    this.autoPlay = true,
    this.onComplete,
    this.onCancel,
    this.alignment = Alignment.center,
    this.maintainState = true,
    this.respectSystemPreferences = true,
  });

  @override
  Widget build(BuildContext context) {
    return FSScaleAnimation(
      key: key,
      child: child,
      beginScale: beginScale,
      endScale: endScale,
      duration: const Duration(milliseconds: 300),
      delay: delay,
      autoPlay: autoPlay,
      onComplete: onComplete,
      onCancel: onCancel,
      alignment: alignment,
      maintainState: maintainState,
      respectSystemPreferences: respectSystemPreferences,
    );
  }
}

/// Standard scale animation (500ms)
class FSScaleAnimationStandard extends StatelessWidget {
  final Widget child;
  final double beginScale;
  final double endScale;
  final Duration delay;
  final bool autoPlay;
  final VoidCallback? onComplete;
  final VoidCallback? onCancel;
  final Alignment alignment;
  final bool maintainState;
  final bool respectSystemPreferences;

  const FSScaleAnimationStandard({
    // ✅ CONST: Better performance
    super.key,
    required this.child,
    this.beginScale = 0.0,
    this.endScale = 1.0,
    this.delay = Duration.zero,
    this.autoPlay = true,
    this.onComplete,
    this.onCancel,
    this.alignment = Alignment.center,
    this.maintainState = true,
    this.respectSystemPreferences = true,
  });

  @override
  Widget build(BuildContext context) {
    return FSScaleAnimation(
      key: key,
      child: child,
      beginScale: beginScale,
      endScale: endScale,
      duration: const Duration(milliseconds: 500),
      delay: delay,
      autoPlay: autoPlay,
      onComplete: onComplete,
      onCancel: onCancel,
      alignment: alignment,
      maintainState: maintainState,
      respectSystemPreferences: respectSystemPreferences,
    );
  }
}

/// Slow scale animation (800ms)
class FSScaleAnimationSlow extends StatelessWidget {
  final Widget child;
  final double beginScale;
  final double endScale;
  final Duration delay;
  final bool autoPlay;
  final VoidCallback? onComplete;
  final VoidCallback? onCancel;
  final Alignment alignment;
  final bool maintainState;
  final bool respectSystemPreferences;

  const FSScaleAnimationSlow({
    // ✅ CONST: Better performance
    super.key,
    required this.child,
    this.beginScale = 0.0,
    this.endScale = 1.0,
    this.delay = Duration.zero,
    this.autoPlay = true,
    this.onComplete,
    this.onCancel,
    this.alignment = Alignment.center,
    this.maintainState = true,
    this.respectSystemPreferences = true,
  });

  @override
  Widget build(BuildContext context) {
    return FSScaleAnimation(
      key: key,
      child: child,
      beginScale: beginScale,
      endScale: endScale,
      duration: const Duration(milliseconds: 800),
      delay: delay,
      autoPlay: autoPlay,
      onComplete: onComplete,
      onCancel: onCancel,
      alignment: alignment,
      maintainState: maintainState,
      respectSystemPreferences: respectSystemPreferences,
    );
  }
}

/// Scale animation with bounce effect
class FSScaleAnimationBounce extends StatelessWidget {
  final Widget child;
  final double beginScale;
  final double endScale;
  final Duration duration;
  final Duration delay;
  final bool autoPlay;
  final VoidCallback? onComplete;
  final VoidCallback? onCancel;
  final Alignment alignment;
  final bool maintainState;
  final bool respectSystemPreferences;

  const FSScaleAnimationBounce({
    // ✅ CONST: Better performance
    super.key,
    required this.child,
    this.beginScale = 0.0,
    this.endScale = 1.1,
    this.duration = const Duration(milliseconds: 600),
    this.delay = Duration.zero,
    this.autoPlay = true,
    this.onComplete,
    this.onCancel,
    this.alignment = Alignment.center,
    this.maintainState = true,
    this.respectSystemPreferences = true,
  });

  @override
  Widget build(BuildContext context) {
    return FSScaleAnimation(
      key: key,
      child: child,
      beginScale: beginScale,
      endScale: endScale,
      duration: duration,
      delay: delay,
      curve: Curves.bounceOut,
      autoPlay: autoPlay,
      onComplete: onComplete,
      onCancel: onCancel,
      alignment: alignment,
      maintainState: maintainState,
      respectSystemPreferences: respectSystemPreferences,
    );
  }
}

/// Scale animation with elastic effect
class FSScaleAnimationElastic extends StatelessWidget {
  final Widget child;
  final double beginScale;
  final double endScale;
  final Duration duration;
  final Duration delay;
  final bool autoPlay;
  final VoidCallback? onComplete;
  final VoidCallback? onCancel;
  final Alignment alignment;
  final bool maintainState;
  final bool respectSystemPreferences;

  const FSScaleAnimationElastic({
    // ✅ CONST: Better performance
    super.key,
    required this.child,
    this.beginScale = 0.0,
    this.endScale = 1.0,
    this.duration = const Duration(milliseconds: 800),
    this.delay = Duration.zero,
    this.autoPlay = true,
    this.onComplete,
    this.onCancel,
    this.alignment = Alignment.center,
    this.maintainState = true,
    this.respectSystemPreferences = true,
  });

  @override
  Widget build(BuildContext context) {
    return FSScaleAnimation(
      key: key,
      child: child,
      beginScale: beginScale,
      endScale: endScale,
      duration: duration,
      delay: delay,
      curve: Curves.elasticOut,
      autoPlay: autoPlay,
      onComplete: onComplete,
      onCancel: onCancel,
      alignment: alignment,
      maintainState: maintainState,
      respectSystemPreferences: respectSystemPreferences,
    );
  }
}

/// Pop-in animation (quick scale from 0 to 1.1 to 1.0)
class FSScaleAnimationPop extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final bool autoPlay;
  final VoidCallback? onComplete;
  final Alignment alignment;
  final bool maintainState;
  final bool respectSystemPreferences;

  const FSScaleAnimationPop({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 400),
    this.delay = Duration.zero,
    this.autoPlay = true,
    this.onComplete,
    this.alignment = Alignment.center,
    this.maintainState = true,
    this.respectSystemPreferences = true,
  });

  @override
  State<FSScaleAnimationPop> createState() => _FSScaleAnimationPopState();
}

class _FSScaleAnimationPopState extends State<FSScaleAnimationPop>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  Timer? _delayTimer;
  bool _isDisposed = false; // ✅ ADDED: Memory management

  /// Whether animations should play based on system preferences
  bool get _shouldAnimate {
    final mediaQuery = MediaQuery.maybeOf(context);
    return widget.autoPlay && (mediaQuery?.disableAnimations != true);
  }

  @override
  void initState() {
    super.initState();
    _initializeAnimation();

    if (widget.autoPlay && _shouldAnimate) {
      // ✅ CHECK: System preferences
      _startAnimation();
    }
  }

  void _initializeAnimation() {
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    // Pop animation: 0.0 -> 1.1 -> 1.0
    _animation = TweenSequence<double>([
      TweenSequenceItem(
          tween: Tween<double>(begin: 0.0, end: 1.1), weight: 0.6),
      TweenSequenceItem(
          tween: Tween<double>(begin: 1.1, end: 1.0), weight: 0.4),
    ]).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
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
      // ✅ ADDED: Error handling
      await _controller.forward().orCancel;
      if (!_isDisposed) {
        widget.onComplete?.call();
      }
    } catch (error) {
      // Handle animation cancellation
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    _delayTimer?.cancel();
    _delayTimer = null; // ✅ ADDED: Explicit null assignment
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ErrorBoundary(
      // ✅ ADDED: Error boundary
      componentName: 'FSScaleAnimationPop',
      fallbackBuilder: (context) => widget.child,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final currentScale = _animation.value.clamp(0.0, double.maxFinite);
          return Transform.scale(
            scale: currentScale,
            alignment: widget.alignment,
            child: widget.maintainState
                ? child
                : Visibility(
                    visible: currentScale > 0.01,
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
