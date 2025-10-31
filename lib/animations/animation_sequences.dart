// Flutstrap Animation Sequences
//
// Pre-configured animation sequences and complex animation patterns
// for sophisticated UI interactions.
//
// {@tool snippet}
// ### Staggered Fade-In Example
//
// ```dart
// FSStaggeredFadeIn(
//   children: [
//     Text('Item 1'),
//     Text('Item 2'),
//     Text('Item 3'),
//   ],
//   staggerDelay: Duration(milliseconds: 150),
// )
// ```
//
// ### Sequential Animation Example
//
// ```dart
// FSSequentialAnimation(
//   sequence: FSAnimationSequence(
//     duration: Duration(milliseconds: 1000),
//     curve: Curves.easeOut,
//     steps: [
//       FSAnimationStep(
//         animation: FSAnimation(
//           duration: Duration(milliseconds: 400),
//           curve: Curves.easeOut,
//         ),
//         delay: Duration(milliseconds: 200),
//       ),
//       FSAnimationStep(
//         animation: FSAnimation(
//           duration: Duration(milliseconds: 300),
//           curve: Curves.easeInOut,
//         ),
//       ),
//     ],
//   ),
//   children: [
//     FadeIn(child: Text('First')),
//     SlideTransition(child: Text('Second')),
//   ],
// )
// ```
// {@end-tool}
//
// {@template flutstrap_animation_sequences.performance}
// ## Performance Features
//
// - **Memory Management**: Proper controller disposal and timer cleanup
// - **Efficient Builds**: Minimal rebuilds with optimized animation controllers
// - **Resource Optimization**: Automatic cleanup of unused animations
// - **Frame Rate Aware**: Smooth 60fps animations with proper timing
// {@endtemplate}
//
// {@template flutstrap_animation_sequences.accessibility}
// ## Accessibility
//
// - Respects system animation preferences
// - Provides semantic labels for animated content
// - Maintains focus order during animations
// - Screen reader compatible animation states
// {@endtemplate}
//
// {@category Animations}
// {@category Components}

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'animation_types.dart';
import 'fade_in.dart';
import 'slide_transition.dart';
import '../../core/theme.dart' as theme_lib;
import '../../core/error_boundary.dart';

/// Performance monitoring for animation operations
class _AnimationPerformance {
  static final Map<String, int> _animationTimes = <String, int>{};

  /// Log animation performance metrics
  static void logAnimationTime(String animationType, int milliseconds) {
    if (animationType.isNotEmpty) {
      _animationTimes[animationType] = milliseconds;

      if (milliseconds > 16) {
        debugPrint('⏱️ Slow animation: $animationType took ${milliseconds}ms');
      }
    }
  }

  /// Clear all performance metrics
  static void clearMetrics() => _animationTimes.clear();

  /// Get current performance metrics
  static Map<String, int> get metrics => Map<String, int>.from(_animationTimes);

  /// Get average animation time for a specific type
  static double getAverageTime(String animationType) {
    final times = _animationTimes.entries
        .where((entry) => entry.key.startsWith(animationType))
        .map((entry) => entry.value)
        .toList();

    if (times.isEmpty) return 0.0;
    return times.reduce((a, b) => a + b) / times.length;
  }
}

/// Staggered fade-in animation for lists
class FSStaggeredFadeIn extends StatelessWidget {
  final List<Widget> children;
  final Duration duration;
  final Duration staggerDelay;
  final Curve curve;
  final bool autoPlay;
  final bool maintainState;
  final String? semanticLabel;
  final bool respectSystemPreferences;

  const FSStaggeredFadeIn({
    super.key,
    required this.children,
    this.duration = const Duration(milliseconds: 500),
    this.staggerDelay = const Duration(milliseconds: 100),
    this.curve = Curves.easeOut,
    this.autoPlay = true,
    this.maintainState = true,
    this.semanticLabel,
    this.respectSystemPreferences = true,
  });

  /// Check if animations should play based on system preferences
  bool _shouldAnimate(BuildContext context) {
    return autoPlay &&
        respectSystemPreferences &&
        MediaQuery.of(context).disableAnimations != true;
  }

  @override
  Widget build(BuildContext context) {
    return ErrorBoundary(
      componentName: 'FSStaggeredFadeIn',
      fallbackBuilder: (context) => _buildFallback(context),
      child: Semantics(
        label: semanticLabel,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (int i = 0; i < children.length; i++)
              FadeIn(
                key: ValueKey('fade_in_$i'),
                child: children[i],
                duration: duration,
                delay: _shouldAnimate(context)
                    ? Duration(milliseconds: staggerDelay.inMilliseconds * i)
                    : Duration.zero,
                curve: curve,
                autoPlay: _shouldAnimate(context),
                maintainState: maintainState,
                respectSystemPreferences: respectSystemPreferences,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFallback(BuildContext context) {
    debugPrint('FSStaggeredFadeIn: Animation failed, showing fallback UI');
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }

  /// Create with theme configuration
  factory FSStaggeredFadeIn.themed({
    Key? key,
    required BuildContext context,
    required List<Widget> children,
    Duration? duration,
    Duration staggerDelay = const Duration(milliseconds: 100),
    Curve? curve,
    bool autoPlay = true,
    bool maintainState = true,
    String? semanticLabel,
    bool respectSystemPreferences = true,
  }) {
    final theme = theme_lib.FSTheme.of(context);
    return FSStaggeredFadeIn(
      key: key,
      children: children,
      duration: duration ?? theme.animation.duration,
      staggerDelay: staggerDelay,
      curve: curve ?? theme.animation.curve,
      autoPlay: autoPlay,
      maintainState: maintainState,
      semanticLabel: semanticLabel,
      respectSystemPreferences: respectSystemPreferences,
    );
  }

  // ✅ CONVENIENCE METHODS

  /// Create a faster version of the animation
  FSStaggeredFadeIn withFastAnimation() => copyWith(
        duration: const Duration(milliseconds: 300),
        staggerDelay: const Duration(milliseconds: 50),
      );

  /// Create a slower version of the animation
  FSStaggeredFadeIn withSlowAnimation() => copyWith(
        duration: const Duration(milliseconds: 800),
        staggerDelay: const Duration(milliseconds: 200),
      );

  /// Create a copy with modified parameters
  FSStaggeredFadeIn copyWith({
    Key? key,
    List<Widget>? children,
    Duration? duration,
    Duration? staggerDelay,
    Curve? curve,
    bool? autoPlay,
    bool? maintainState,
    String? semanticLabel,
    bool? respectSystemPreferences,
  }) {
    return FSStaggeredFadeIn(
      key: key ?? this.key,
      children: children ?? this.children,
      duration: duration ?? this.duration,
      staggerDelay: staggerDelay ?? this.staggerDelay,
      curve: curve ?? this.curve,
      autoPlay: autoPlay ?? this.autoPlay,
      maintainState: maintainState ?? this.maintainState,
      semanticLabel: semanticLabel ?? this.semanticLabel,
      respectSystemPreferences:
          respectSystemPreferences ?? this.respectSystemPreferences,
    );
  }
}

/// Staggered slide-in animation for lists
class FSStaggeredSlideIn extends StatelessWidget {
  final List<Widget> children;
  final FSSlideDirection direction;
  final Duration duration;
  final Duration staggerDelay;
  final Curve curve;
  final bool autoPlay;
  final double offsetFraction;
  final bool maintainState;
  final String? semanticLabel;
  final bool respectSystemPreferences;

  const FSStaggeredSlideIn({
    super.key,
    required this.children,
    this.direction = FSSlideDirection.fromBottom,
    this.duration = const Duration(milliseconds: 500),
    this.staggerDelay = const Duration(milliseconds: 100),
    this.curve = Curves.easeOut,
    this.autoPlay = true,
    this.offsetFraction = 1.0,
    this.maintainState = true,
    this.semanticLabel,
    this.respectSystemPreferences = true,
  });

  /// Check if animations should play based on system preferences
  bool _shouldAnimate(BuildContext context) {
    return autoPlay &&
        respectSystemPreferences &&
        MediaQuery.of(context).disableAnimations != true;
  }

  @override
  Widget build(BuildContext context) {
    return ErrorBoundary(
      componentName: 'FSStaggeredSlideIn',
      fallbackBuilder: (context) => _buildFallback(context),
      child: Semantics(
        label: semanticLabel,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (int i = 0; i < children.length; i++)
              FSSlideTransition(
                key: ValueKey('slide_in_$i'),
                child: children[i],
                direction: direction,
                duration: duration,
                delay: _shouldAnimate(context)
                    ? Duration(milliseconds: staggerDelay.inMilliseconds * i)
                    : Duration.zero,
                curve: curve,
                autoPlay: _shouldAnimate(context),
                offsetFraction: offsetFraction,
                maintainState: maintainState,
                respectSystemPreferences: respectSystemPreferences,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFallback(BuildContext context) {
    debugPrint('FSStaggeredSlideIn: Animation failed, showing fallback UI');
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }

  /// Create with theme configuration
  factory FSStaggeredSlideIn.themed({
    Key? key,
    required BuildContext context,
    required List<Widget> children,
    FSSlideDirection direction = FSSlideDirection.fromBottom,
    Duration? duration,
    Duration staggerDelay = const Duration(milliseconds: 100),
    Curve? curve,
    bool autoPlay = true,
    double offsetFraction = 1.0,
    bool maintainState = true,
    String? semanticLabel,
    bool respectSystemPreferences = true,
  }) {
    final theme = theme_lib.FSTheme.of(context);
    return FSStaggeredSlideIn(
      key: key,
      children: children,
      direction: direction,
      duration: duration ?? theme.animation.duration,
      staggerDelay: staggerDelay,
      curve: curve ?? theme.animation.curve,
      autoPlay: autoPlay,
      offsetFraction: offsetFraction,
      maintainState: maintainState,
      semanticLabel: semanticLabel,
      respectSystemPreferences: respectSystemPreferences,
    );
  }

  // ✅ CONVENIENCE METHODS

  /// Create a faster version of the animation
  FSStaggeredSlideIn withFastAnimation() => copyWith(
        duration: const Duration(milliseconds: 300),
        staggerDelay: const Duration(milliseconds: 50),
      );

  /// Create a slower version of the animation
  FSStaggeredSlideIn withSlowAnimation() => copyWith(
        duration: const Duration(milliseconds: 800),
        staggerDelay: const Duration(milliseconds: 200),
      );

  /// Create a copy with modified parameters
  FSStaggeredSlideIn copyWith({
    Key? key,
    List<Widget>? children,
    FSSlideDirection? direction,
    Duration? duration,
    Duration? staggerDelay,
    Curve? curve,
    bool? autoPlay,
    double? offsetFraction,
    bool? maintainState,
    String? semanticLabel,
    bool? respectSystemPreferences,
  }) {
    return FSStaggeredSlideIn(
      key: key ?? this.key,
      children: children ?? this.children,
      direction: direction ?? this.direction,
      duration: duration ?? this.duration,
      staggerDelay: staggerDelay ?? this.staggerDelay,
      curve: curve ?? this.curve,
      autoPlay: autoPlay ?? this.autoPlay,
      offsetFraction: offsetFraction ?? this.offsetFraction,
      maintainState: maintainState ?? this.maintainState,
      semanticLabel: semanticLabel ?? this.semanticLabel,
      respectSystemPreferences:
          respectSystemPreferences ?? this.respectSystemPreferences,
    );
  }
}

/// Sequential animation for complex sequences
class FSSequentialAnimation extends StatefulWidget {
  final List<Widget> children;
  final FSAnimationSequence sequence;
  final bool autoPlay;
  final String? semanticLabel;
  final VoidCallback? onComplete;
  final VoidCallback? onStart;
  final bool respectSystemPreferences;

  const FSSequentialAnimation({
    super.key,
    required this.children,
    required this.sequence,
    this.autoPlay = true,
    this.semanticLabel,
    this.onComplete,
    this.onStart,
    this.respectSystemPreferences = true,
  });

  @override
  State<FSSequentialAnimation> createState() => _FSSequentialAnimationState();

  // ✅ CONVENIENCE CONSTRUCTORS

  /// Create a simple fade-in sequential animation
  factory FSSequentialAnimation.fadeIn({
    Key? key,
    required List<Widget> children,
    Duration stepDuration = const Duration(milliseconds: 400),
    Duration stepDelay = const Duration(milliseconds: 200),
    Curve curve = Curves.easeOut,
    bool autoPlay = true,
    String? semanticLabel,
    VoidCallback? onComplete,
    VoidCallback? onStart,
    bool respectSystemPreferences = true,
  }) {
    final totalDuration = Duration(
        milliseconds: (stepDuration.inMilliseconds + stepDelay.inMilliseconds) *
            children.length);

    return FSSequentialAnimation(
      key: key,
      children: children,
      sequence: FSAnimationSequence(
        duration: totalDuration,
        curve: curve,
        steps: List<FSAnimationStep>.generate(
          children.length,
          (index) => FSAnimationStep(
            animation: FSAnimation(
              duration: stepDuration,
              curve: curve,
            ),
            delay: Duration(milliseconds: stepDelay.inMilliseconds * index),
          ),
        ),
      ),
      autoPlay: autoPlay,
      semanticLabel: semanticLabel,
      onComplete: onComplete,
      onStart: onStart,
      respectSystemPreferences: respectSystemPreferences,
    );
  }
}

class _FSSequentialAnimationState extends State<FSSequentialAnimation>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;
  Timer? _startTimer;
  bool _isDisposed = false;
  bool _isPlaying = false;
  bool _isComplete = false;

  @override
  void initState() {
    super.initState();

    // ✅ Runtime validation
    _validateInputs();

    _initializeAnimations();

    if (widget.autoPlay && _shouldAnimate()) {
      _startAnimations();
    }
  }

  /// Check if animations should play based on system preferences
  bool _shouldAnimate() {
    if (!widget.respectSystemPreferences) return true;
    final mediaQuery = MediaQuery.maybeOf(context);
    return mediaQuery?.disableAnimations != true;
  }

  void _validateInputs() {
    assert(
        widget.sequence.steps.isNotEmpty, 'Animation sequence must have steps');
    assert(widget.children.length <= widget.sequence.steps.length,
        'Children count (${widget.children.length}) cannot exceed sequence steps count (${widget.sequence.steps.length})');
  }

  void _initializeAnimations() {
    final stopwatch = Stopwatch()..start();

    try {
      // ✅ Handle case where children count < steps count
      final effectiveStepCount = widget.children.length;

      _controllers = List<AnimationController>.generate(
        effectiveStepCount,
        (index) {
          final step = widget.sequence.steps[index];
          return AnimationController(
            duration: step.animation.duration,
            vsync: this,
          )..addStatusListener((status) {
              // ✅ Monitor animation performance
              if (status == AnimationStatus.completed) {
                _AnimationPerformance.logAnimationTime(
                    'step_$index', step.animation.duration.inMilliseconds);
              }
            });
        },
      );

      _animations = List<Animation<double>>.generate(
        effectiveStepCount,
        (index) {
          final step = widget.sequence.steps[index];
          return Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: _controllers[index],
              curve: step.effectiveCurve,
            ),
          );
        },
      );
    } catch (e) {
      debugPrint('Error initializing animations: $e');
      rethrow;
    } finally {
      stopwatch.stop();
      _AnimationPerformance.logAnimationTime(
          'animation_init', stopwatch.elapsedMilliseconds);
    }
  }

  Future<void> _startAnimations() async {
    if (!mounted || _isDisposed || _isPlaying) return;

    _isPlaying = true;
    widget.onStart?.call();

    final stopwatch = Stopwatch()..start();

    try {
      for (int i = 0; i < _controllers.length; i++) {
        if (!mounted || _isDisposed) break;

        final step = widget.sequence.steps[i];

        if (step.delay > Duration.zero) {
          await Future.delayed(step.delay);
        }

        if (mounted && !_isDisposed && !_controllers[i].isAnimating) {
          await _controllers[i].forward().orCancel;
        }

        if (!mounted || _isDisposed) break; // Exit if widget was disposed
      }
    } catch (e) {
      debugPrint('Error during animation sequence: $e');
    } finally {
      stopwatch.stop();
      _AnimationPerformance.logAnimationTime(
          'sequence_play', stopwatch.elapsedMilliseconds);
    }

    if (mounted && !_isDisposed) {
      setState(() {
        _isPlaying = false;
        _isComplete = true;
      });
      widget.onComplete?.call();
    }
  }

  /// Manually start the sequence
  Future<void> play() async {
    if (mounted && !_isDisposed && !_isPlaying && _shouldAnimate()) {
      await _startAnimations();
    }
  }

  /// Reset all animations
  void reset() {
    if (mounted && !_isDisposed) {
      for (final controller in _controllers) {
        if (!controller.isAnimating) {
          controller.reset();
        }
      }
      setState(() {
        _isPlaying = false;
        _isComplete = false;
      });
    }
  }

  /// Stop all animations
  void stop() {
    if (mounted && !_isDisposed) {
      for (final controller in _controllers) {
        if (controller.isAnimating) {
          controller.stop();
        }
      }
      setState(() {
        _isPlaying = false;
      });
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    _startTimer?.cancel();
    _startTimer = null; // ✅ Explicit null assignment

    for (final controller in _controllers) {
      controller.dispose();
    }
    _controllers.clear(); // ✅ Clear the list

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ErrorBoundary(
      componentName: 'FSSequentialAnimation',
      fallbackBuilder: (context) => _buildFallback(context),
      child: Semantics(
        label: widget.semanticLabel,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            widget.children.length,
            (index) => AnimatedBuilder(
              animation: _animations[index],
              builder: (context, child) {
                return Opacity(
                  opacity: _animations[index].value.clamp(0.0, 1.0),
                  child: Transform.translate(
                    offset: Offset(0.0, (1 - _animations[index].value) * 20),
                    child: child,
                  ),
                );
              },
              child: widget.children[index],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFallback(BuildContext context) {
    debugPrint('FSSequentialAnimation: Animation failed, showing fallback UI');
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: widget.children,
    );
  }
}
