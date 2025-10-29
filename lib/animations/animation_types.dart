/// Flutstrap Animation Types and Enums
///
/// Defines standardized animation types, directions, and configurations
/// for consistent animation patterns throughout the Flutstrap ecosystem.
///
/// {@category Animations}
/// {@category Foundation}

import 'package:flutter/animation.dart'; // ✅ ADDED
import '../../core/theme.dart'; // ✅ ADDED

/// Standard animation types for common UI patterns
enum FSAnimationType {
  fadeIn,
  fadeOut,
  slideIn,
  slideOut,
  scale,
  bounce,
  shake,
  pulse,
  spin,
  flip,
}

/// Animation directions for directional animations
enum FSAnimationDirection {
  top,
  bottom,
  left,
  right,
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
  center,
}

/// Animation states for component lifecycle
enum FSAnimationState {
  idle,
  entering,
  exiting,
  active,
  disabled,
}

/// Animation presets for common durations and curves
class FSAnimationPreset {
  // Duration presets
  static const Duration instant = Duration(milliseconds: 100);
  static const Duration quick = Duration(milliseconds: 200);
  static const Duration standard = Duration(milliseconds: 300);
  static const Duration deliberate = Duration(milliseconds: 500);
  static const Duration slow = Duration(milliseconds: 800);
  static const Duration dramatic = Duration(milliseconds: 1200);

  // Curve presets - ✅ FIXED: Using actual Curve objects
  static const Curve linear = Curves.linear;
  static const Curve ease = Curves.easeInOut;
  static const Curve easeIn = Curves.easeIn;
  static const Curve easeOut = Curves.easeOut;
  static const Curve bounce = Curves.bounceOut;
  static const Curve elastic = Curves.elasticOut;
  static const Curve sharp = Curves.easeInCubic;
  static const Curve smooth = Curves.easeOutCubic;

  // Pre-configured animation configurations - ✅ FIXED: Using const constructors
  static const FSAnimation buttonPress = FSAnimation(
    duration: quick,
    curve: sharp,
  );

  static const FSAnimation pageTransition = FSAnimation(
    duration: standard,
    curve: ease,
  );

  static const FSAnimation modalEnter = FSAnimation(
    duration: deliberate,
    curve: smooth,
  );

  static const FSAnimation attentionGrabber = FSAnimation(
    duration: slow,
    curve: elastic,
  );

  static const FSAnimation subtleEntrance = FSAnimation(
    duration: standard,
    curve: easeOut,
  );
}

/// Animation sequence configuration for complex animations
class FSAnimationSequence {
  final List<FSAnimationStep> steps;
  final bool repeat;
  final int repeatCount;
  final bool reverseOnRepeat;

  const FSAnimationSequence({
    required this.steps,
    this.repeat = false,
    this.repeatCount = 0,
    this.reverseOnRepeat = false,
  });

  /// Total duration of the entire sequence
  Duration get totalDuration {
    return steps.fold<Duration>(
      Duration.zero,
      (total, step) => total + step.duration,
    );
  }

  /// Create a simple sequence from a single animation
  factory FSAnimationSequence.single(FSAnimation animation) {
    return FSAnimationSequence(
      steps: [FSAnimationStep(animation: animation)],
    );
  }

  /// Create a staggered sequence for multiple elements
  factory FSAnimationSequence.staggered({
    required FSAnimation baseAnimation,
    required int count,
    Duration staggerDelay = const Duration(milliseconds: 100),
  }) {
    final steps = List<FSAnimationStep>.generate(
      count,
      (index) => FSAnimationStep(
        animation: baseAnimation,
        delay: Duration(milliseconds: staggerDelay.inMilliseconds * index),
      ),
    );
    return FSAnimationSequence(steps: steps);
  }
}

/// Individual step in an animation sequence
class FSAnimationStep {
  final FSAnimation animation;
  final Duration delay;
  final Curve? curveOverride;

  const FSAnimationStep({
    required this.animation,
    this.delay = Duration.zero,
    this.curveOverride,
  });

  Duration get duration => animation.duration + delay;
  Curve get effectiveCurve => curveOverride ?? animation.curve;
}
