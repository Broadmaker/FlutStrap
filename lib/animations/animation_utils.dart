/// Flutstrap Animation Utilities
///
/// Helper functions, builders, and utilities for creating and managing
/// animations in the Flutstrap ecosystem.
///
/// {@category Animations}
/// {@category Utilities}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

// ✅ FIXED: Import animation_types normally, hide theme's FSAnimation
import 'animation_types.dart';
import 'fade_in.dart';
import 'slide_transition.dart';
import '../../core/theme.dart' hide FSAnimation; // ✅ Hide conflicting class

/// Animation utility functions and builders
class FSAnimationUtils {
  // Cache for expensive animation builder creation
  static final Map<String, Widget Function(Widget, int)> _builderCache = {};

  /// Check if animations should play based on system preferences
  static bool _shouldAnimate(BuildContext context) {
    final mediaQuery = MediaQuery.maybeOf(context);
    return mediaQuery?.disableAnimations != true;
  }

  /// Creates a staggered animation builder for lists
  static Widget Function(Widget, int) createStaggeredBuilder({
    required BuildContext context,
    required FSAnimationType type,
    required FSAnimationDirection direction,
    Duration? duration,
    Curve? curve,
    Duration staggerDelay = const Duration(milliseconds: 100),
  }) {
    try {
      final shouldAnimate = _shouldAnimate(context);

      if (!shouldAnimate) {
        return (Widget child, int index) => child;
      }

      final cacheKey =
          '${type.name}_${direction.name}_${duration?.inMilliseconds}_${curve?.runtimeType}_${staggerDelay.inMilliseconds}';

      return _builderCache.putIfAbsent(cacheKey, () {
        final theme = FSTheme.of(context);

        // ✅ FIXED: Convert theme.animation to our FSAnimation type
        final FSAnimation animationConfig = (duration != null || curve != null)
            ? FSAnimation(
                duration: duration ?? theme.animation.duration,
                curve: curve ?? theme.animation.curve,
              )
            : _convertThemeAnimationToFSAnimation(theme.animation);

        return (Widget child, int index) {
          final delay =
              Duration(milliseconds: staggerDelay.inMilliseconds * index);
          return _buildAnimationByType(
            child: child,
            type: type,
            direction: direction,
            animation: animationConfig,
            delay: delay,
          );
        };
      });
    } catch (error, stackTrace) {
      debugPrint('Error creating staggered builder: $error\n$stackTrace');
      return (Widget child, int index) => child;
    }
  }

  /// Convert theme animation to FSAnimation type
  static FSAnimation _convertThemeAnimationToFSAnimation(
      Object themeAnimation) {
    // ✅ Convert the theme animation to our standard FSAnimation
    // This is a workaround for the type conflict
    if (themeAnimation is FSAnimation) {
      return themeAnimation;
    }

    // If it's a different type, extract properties dynamically
    try {
      final duration = _getDurationFromObject(themeAnimation);
      final curve = _getCurveFromObject(themeAnimation);
      return FSAnimation(duration: duration, curve: curve);
    } catch (e) {
      // Fallback to default animation
      debugPrint('Error converting theme animation: $e');
      return const FSAnimation(
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    }
  }

  /// Helper to extract duration from animation object
  static Duration _getDurationFromObject(Object animation) {
    try {
      // Try to access duration property dynamically
      final dynamic anim = animation;
      if (anim.duration is Duration) {
        return anim.duration;
      }
    } catch (e) {
      debugPrint('Error getting duration: $e');
    }
    return const Duration(milliseconds: 300);
  }

  /// Helper to extract curve from animation object
  static Curve _getCurveFromObject(Object animation) {
    try {
      // Try to access curve property dynamically
      final dynamic anim = animation;
      if (anim.curve is Curve) {
        return anim.curve;
      }
    } catch (e) {
      debugPrint('Error getting curve: $e');
    }
    return Curves.easeOut;
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
          child: child,
          duration: animation.duration,
          delay: delay,
          curve: animation.curve,
        );
      case FSAnimationType.slideOut:
      case FSAnimationType.scale:
      case FSAnimationType.bounce:
      case FSAnimationType.shake:
      case FSAnimationType.pulse:
      case FSAnimationType.spin:
      case FSAnimationType.flip:
        debugPrint(
            'Animation type $type not yet implemented in _buildAnimationByType');
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

  /// Clear the animation builder cache
  static void clearCache() => _builderCache.clear();
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
  bool _isDisposed = false;

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
    } catch (e) {
      // Animation cancelled or disposed
      debugPrint('FadeOut animation error: $e');
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    _delayTimer?.cancel();
    _delayTimer = null;
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
  bool _isDisposed = false;

  /// Register an animation controller with a unique key
  void registerController(String key, AnimationController controller) {
    if (_isDisposed) {
      controller.dispose();
      return;
    }

    if (_controllers.containsKey(key)) {
      debugPrint(
          'Warning: Controller with key "$key" already registered. Overwriting.');
      unregisterController(key);
    }

    _controllers[key] = controller;
    _states[key] = FSAnimationState.idle;

    controller.addListener(() {
      if (!controller.isAnimating && _states[key] == FSAnimationState.exiting) {
        _states[key] = FSAnimationState.idle;
        notifyListeners();
      }
    });
  }

  /// Unregister an animation controller
  void unregisterController(String key) {
    final controller = _controllers[key];
    if (controller != null) {
      controller.dispose();
      _controllers.remove(key);
      _states.remove(key);
    }
  }

  /// Play animation by key
  Future<void> play(String key) async {
    if (_isDisposed) return;

    final controller = _controllers[key];
    if (controller != null && mounted && !controller.isAnimating) {
      _states[key] = FSAnimationState.entering;
      notifyListeners();

      try {
        await controller.forward().orCancel;
        if (!_isDisposed && _states.containsKey(key)) {
          _states[key] = FSAnimationState.active;
          notifyListeners();
        }
      } catch (error) {
        if (!_isDisposed && _states.containsKey(key)) {
          _states[key] = FSAnimationState.idle;
          notifyListeners();
        }
      }
    }
  }

  /// Reverse animation by key
  Future<void> reverse(String key) async {
    if (_isDisposed) return;

    final controller = _controllers[key];
    if (controller != null && mounted && !controller.isAnimating) {
      _states[key] = FSAnimationState.exiting;
      notifyListeners();

      try {
        await controller.reverse().orCancel;
        if (!_isDisposed && _states.containsKey(key)) {
          _states[key] = FSAnimationState.idle;
          notifyListeners();
        }
      } catch (error) {
        if (!_isDisposed && _states.containsKey(key)) {
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

  /// Check if manager is still active
  bool get mounted => !_isDisposed;

  @override
  void dispose() {
    _isDisposed = true;
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    _controllers.clear();
    _states.clear();
    super.dispose();
  }
}

/// Extension methods for easier animation creation
extension FSAnimationExtensions on BuildContext {
  /// Quick access to theme animation configuration
  FSAnimation get fsAnimation {
    final theme = FSTheme.of(this);
    return FSAnimationUtils._convertThemeAnimationToFSAnimation(
        theme.animation);
  }

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
