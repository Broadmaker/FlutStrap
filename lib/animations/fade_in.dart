// Flutstrap FadeIn Animation
//
// A high-performance widget that fades its child into view with
// theme integration, memory optimization, and flexible configuration.
//
// {@category Animations}
// {@category Components}

import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../../core/error_boundary.dart';

/// FadeIn Animation Widget
///
/// A widget that fades its child into view with smooth animations.
/// Features memory-optimized controllers, theme integration, and
/// performance enhancements.
class FadeIn extends StatefulWidget {
  /// The child widget to animate
  final Widget child;

  /// The duration of the fade animation
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

  /// Whether to maintain the widget's state when invisible
  final bool maintainState;

  /// Whether to respect system animation preferences
  final bool respectSystemPreferences;

  /// Creates a fade-in animation widget
  const FadeIn({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.delay = Duration.zero,
    this.curve = Curves.easeOut,
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
  late AnimationController _controller;
  late Animation<double> _animation;
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

  /// Current opacity value
  double get opacity => _animation.value;

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

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
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

  /// Manually start the fade animation
  Future<void> play() async {
    if (!mounted || _controller.isAnimating || !_isInitialized) return;
    if (!_shouldAnimate(context)) return;
    await _controller.forward().orCancel;
  }

  /// Manually reverse the animation (fade out)
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

  /// Set the animation to a specific opacity value (0.0 to 1.0)
  void setOpacity(double value) {
    if (mounted && !_isDisposed && _isInitialized) {
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
        begin: 0.0,
        end: 1.0,
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
      componentName: 'FadeIn',
      fallbackBuilder: (context) => widget.child,
      child: _isInitialized ? _buildAnimatedContent() : _buildStaticContent(),
    );
  }

  Widget _buildAnimatedContent() {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final currentOpacity = _animation.value.clamp(0.0, 1.0);
        return Opacity(
          opacity: currentOpacity,
          child: widget.maintainState
              ? child
              : _buildVisibilityWrapper(child!, currentOpacity),
        );
      },
      child: widget.child,
    );
  }

  Widget _buildStaticContent() {
    return Opacity(
      opacity: 0.0,
      child: widget.child,
    );
  }

  Widget _buildVisibilityWrapper(Widget child, double opacity) {
    final isVisible = opacity > 0.01;
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
// PRE-CONFIGURED FADE IN VARIATIONS
// =============================================================================

/// Quick fade animation (200ms)
class FadeInQuick extends StatelessWidget {
  final Widget child;
  final Duration delay;
  final bool autoPlay;
  final VoidCallback? onComplete;
  final VoidCallback? onCancel;
  final bool maintainState;
  final bool respectSystemPreferences;

  const FadeInQuick({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.autoPlay = true,
    this.onComplete,
    this.onCancel,
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
      onCancel: onCancel,
      maintainState: maintainState,
      respectSystemPreferences: respectSystemPreferences,
    );
  }
}

/// Standard fade animation (500ms)
class FadeInStandard extends StatelessWidget {
  final Widget child;
  final Duration delay;
  final bool autoPlay;
  final VoidCallback? onComplete;
  final VoidCallback? onCancel;
  final bool maintainState;
  final bool respectSystemPreferences;

  const FadeInStandard({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.autoPlay = true,
    this.onComplete,
    this.onCancel,
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
      onCancel: onCancel,
      maintainState: maintainState,
      respectSystemPreferences: respectSystemPreferences,
    );
  }
}

/// Slow fade animation (800ms)
class FadeInSlow extends StatelessWidget {
  final Widget child;
  final Duration delay;
  final bool autoPlay;
  final VoidCallback? onComplete;
  final VoidCallback? onCancel;
  final bool maintainState;
  final bool respectSystemPreferences;

  const FadeInSlow({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.autoPlay = true,
    this.onComplete,
    this.onCancel,
    this.maintainState = true,
    this.respectSystemPreferences = true,
  });

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      key: key,
      child: child,
      duration: const Duration(milliseconds: 800),
      delay: delay,
      autoPlay: autoPlay,
      onComplete: onComplete,
      onCancel: onCancel,
      maintainState: maintainState,
      respectSystemPreferences: respectSystemPreferences,
    );
  }
}

/// Fade with bounce curve
class FadeInBounce extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final bool autoPlay;
  final VoidCallback? onComplete;
  final VoidCallback? onCancel;
  final bool maintainState;
  final bool respectSystemPreferences;

  const FadeInBounce({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 600),
    this.delay = Duration.zero,
    this.autoPlay = true,
    this.onComplete,
    this.onCancel,
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
      onCancel: onCancel,
      maintainState: maintainState,
      respectSystemPreferences: respectSystemPreferences,
    );
  }
}

/// Fade with elastic curve
class FadeInElastic extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final bool autoPlay;
  final VoidCallback? onComplete;
  final VoidCallback? onCancel;
  final bool maintainState;
  final bool respectSystemPreferences;

  const FadeInElastic({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 800),
    this.delay = Duration.zero,
    this.autoPlay = true,
    this.onComplete,
    this.onCancel,
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
      curve: Curves.elasticOut,
      autoPlay: autoPlay,
      onComplete: onComplete,
      onCancel: onCancel,
      maintainState: maintainState,
      respectSystemPreferences: respectSystemPreferences,
    );
  }
}
