/// Flutstrap Animation Utilities
///
/// Helper functions, builders, and utilities for creating and managing
/// animations in the Flutstrap ecosystem.
///
/// {@category Animations}
/// {@category Utilities}

import 'dart:async'; // ✅ ADDED: For Timer
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'animation_types.dart';
import 'fade_in.dart';
import 'slide_transition.dart';
import '../../core/theme.dart';

/// Animation utility functions and builders
class FSAnimationUtils {
  /// Creates a staggered animation builder for lists
  static Widget Function(Widget, int) createStaggeredBuilder({
    required BuildContext context,
    required FSAnimationType type,
    FSAnimationDirection direction = FSAnimationDirection.bottom,
    Duration? duration,
    Curve? curve,
    Duration staggerDelay = const Duration(milliseconds: 100),
  }) {
    final theme = FSTheme.of(context);
    final animationConfig = duration != null || curve != null
        ? FSAnimation(
            duration: duration ?? theme.animation.duration,
            curve: curve ?? theme.animation.curve,
          )
        : theme.animation;

    return (Widget child, int index) {
      final delay = Duration(milliseconds: staggerDelay.inMilliseconds * index);

      return _buildAnimationByType(
        child: child,
        type: type,
        direction: direction,
        animation: animationConfig,
        delay: delay,
      );
    };
  }

  /// Builds the appropriate animation widget based on type
  static Widget _buildAnimationByType({
    required Widget child,
    required FSAnimationType type,
    required FSAnimationDirection direction,
    required FSAnimation animation,
    Duration delay = Duration.zero,
  }) {
    switch (type) {
      case FSAnimationType.fadeIn:
        return FadeIn(
          child: child,
          duration: animation.duration,
          delay: delay,
          curve: animation.curve,
        );
      case FSAnimationType.slideIn:
        return FSSlideTransition(
          child: child,
          direction: _convertDirection(direction),
          duration: animation.duration,
          delay: delay,
          curve: animation.curve,
        );
      case FSAnimationType.fadeOut:
        return _FadeOut(
          // ✅ NEW: Separate fade out component
          child: child,
          duration: animation.duration,
          delay: delay,
          curve: animation.curve,
        );
      default:
        return FadeIn(
          child: child,
          duration: animation.duration,
          delay: delay,
          curve: animation.curve,
        );
    }
  }

  /// Converts FSAnimationDirection to FSSlideDirection
  static FSSlideDirection _convertDirection(FSAnimationDirection direction) {
    switch (direction) {
      case FSAnimationDirection.top:
        return FSSlideDirection.fromTop;
      case FSAnimationDirection.bottom:
        return FSSlideDirection.fromBottom;
      case FSAnimationDirection.left:
        return FSSlideDirection.fromLeft;
      case FSAnimationDirection.right:
        return FSSlideDirection.fromRight;
      case FSAnimationDirection.topLeft:
        return FSSlideDirection.fromTopLeft;
      case FSAnimationDirection.topRight:
        return FSSlideDirection.fromTopRight;
      case FSAnimationDirection.bottomLeft:
        return FSSlideDirection.fromBottomLeft;
      case FSAnimationDirection.bottomRight:
        return FSSlideDirection.fromBottomRight;
      case FSAnimationDirection.center:
        return FSSlideDirection.fromBottom;
    }
  }

  /// Creates a crossfade transition between two widgets
  static Widget crossFade({
    required Widget firstChild,
    required Widget secondChild,
    required bool showFirst,
    required Duration duration,
    Curve curve = Curves.easeInOut,
  }) {
    return AnimatedCrossFade(
      firstChild: firstChild,
      secondChild: secondChild,
      crossFadeState:
          showFirst ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: duration,
      firstCurve: curve,
      secondCurve: curve,
      sizeCurve: curve,
      alignment: Alignment.topCenter,
    );
  }

  // ✅ REMOVED: Unsafe scale method that creates undisposed controllers
  // Use FSScaleTransition component instead for proper memory management
}

/// Simple fade out animation for utility purposes
class _FadeOut extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Curve curve;
  final bool autoPlay;

  const _FadeOut({
    required this.child,
    required this.duration,
    required this.delay,
    required this.curve,
    this.autoPlay = true,
  });

  @override
  State<_FadeOut> createState() => __FadeOutState();
}

class __FadeOutState extends State<_FadeOut>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  Timer? _delayTimer;

  @override
  void initState() {
    super.initState();
    _initializeAnimation();

    if (widget.autoPlay) {
      _startAnimation();
    }
  }

  void _initializeAnimation() {
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.curve,
      ),
    );
  }

  Future<void> _startAnimation() async {
    if (!mounted) return;

    if (widget.delay > Duration.zero) {
      _delayTimer = Timer(widget.delay, _executeAnimation);
    } else {
      await _executeAnimation();
    }
  }

  Future<void> _executeAnimation() async {
    if (!mounted) return;
    await _controller.forward().orCancel;
  }

  @override
  void dispose() {
    _delayTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          opacity: _animation.value.clamp(0.0, 1.0),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

/// Animation state manager for complex animation sequences
class FSAnimationManager extends ChangeNotifier {
  final Map<String, AnimationController> _controllers = {};
  final Map<String, FSAnimationState> _states = {};

  /// Register an animation controller with a unique key
  void registerController(String key, AnimationController controller) {
    _controllers[key] = controller;
    _states[key] = FSAnimationState.idle;
  }

  /// Unregister an animation controller
  void unregisterController(String key) {
    final controller = _controllers[key];
    if (controller != null) {
      if (!controller.isAnimating) {
        controller.dispose();
      }
      _controllers.remove(key);
      _states.remove(key);
    }
  }

  /// Play animation by key
  Future<void> play(String key) async {
    final controller = _controllers[key];
    if (controller != null && !controller.isAnimating) {
      _states[key] = FSAnimationState.entering;
      notifyListeners();

      try {
        await controller.forward().orCancel;
        if (_states.containsKey(key)) {
          // Check if still registered
          _states[key] = FSAnimationState.active;
          notifyListeners();
        }
      } catch (error) {
        // Handle animation cancellation gracefully
        if (_states.containsKey(key)) {
          _states[key] = FSAnimationState.idle;
          notifyListeners();
        }
      }
    }
  }

  /// Reverse animation by key
  Future<void> reverse(String key) async {
    final controller = _controllers[key];
    if (controller != null && !controller.isAnimating) {
      _states[key] = FSAnimationState.exiting;
      notifyListeners();

      try {
        await controller.reverse().orCancel;
        if (_states.containsKey(key)) {
          _states[key] = FSAnimationState.idle;
          notifyListeners();
        }
      } catch (error) {
        if (_states.containsKey(key)) {
          _states[key] = FSAnimationState.idle;
          notifyListeners();
        }
      }
    }
  }

  /// Get current animation state
  FSAnimationState? getState(String key) => _states[key];

  /// Check if animation is registered
  bool isRegistered(String key) => _controllers.containsKey(key);

  @override
  void dispose() {
    // ✅ FIXED: Use for-in loop instead of forEach
    for (final controller in _controllers.values) {
      if (!controller.isAnimating) {
        controller.dispose();
      }
    }
    _controllers.clear();
    _states.clear();
    super.dispose();
  }
}

/// Extension methods for easier animation creation
extension FSAnimationExtensions on BuildContext {
  /// Quick access to theme animation configuration
  FSAnimation get fsAnimation => FSTheme.of(this).animation;

  /// Create a staggered animation builder for lists
  Widget Function(Widget, int) createStaggeredAnimations({
    required FSAnimationType type,
    FSAnimationDirection direction = FSAnimationDirection.bottom,
    Duration? duration,
    Curve? curve,
    Duration staggerDelay = const Duration(milliseconds: 100),
  }) {
    return FSAnimationUtils.createStaggeredBuilder(
      context: this,
      type: type,
      direction: direction,
      duration: duration,
      curve: curve,
      staggerDelay: staggerDelay,
    );
  }

  /// Quick crossfade utility
  Widget crossFade({
    required Widget firstChild,
    required Widget secondChild,
    required bool showFirst,
    Duration? duration,
    Curve? curve,
  }) {
    final theme = FSTheme.of(this);
    return FSAnimationUtils.crossFade(
      firstChild: firstChild,
      secondChild: secondChild,
      showFirst: showFirst,
      duration: duration ?? theme.animation.duration,
      curve: curve ?? theme.animation.curve,
    );
  }
}
