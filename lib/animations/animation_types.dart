/// Flutstrap Animation Type System
///
/// Defines the core animation type hierarchy and configuration system
/// for the Flutstrap animation ecosystem.
///
/// {@category Animations}
/// {@category Foundation}

import 'package:flutter/animation.dart';

// =============================================================================
// CORE ANIMATION TYPES
// =============================================================================

/// Base class for all animation configurations
abstract class FSAnimationBase {
  final Duration duration;
  final Curve curve;

  const FSAnimationBase({
    required this.duration,
    required this.curve,
  });
}

/// Standard animation configuration for single animations
class FSAnimation extends FSAnimationBase {
  const FSAnimation({
    required super.duration,
    super.curve = Curves.linear,
  });

  /// Create a copy with modified parameters
  FSAnimation copyWith({
    Duration? duration,
    Curve? curve,
  }) {
    return FSAnimation(
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
    );
  }

  @override
  String toString() => 'FSAnimation(duration: $duration, curve: $curve)';
}

/// Animation sequence configuration for complex multi-step animations
class FSAnimationSequence extends FSAnimationBase {
  final List<FSAnimationStep> steps;

  const FSAnimationSequence({
    required super.duration,
    required super.curve,
    required this.steps,
  });

  /// Total duration including all steps and delays
  Duration get totalDuration {
    return steps.fold<Duration>(
      Duration.zero,
      (total, step) => total + step.animation.duration + step.delay,
    );
  }

  @override
  String toString() =>
      'FSAnimationSequence(steps: $steps, totalDuration: $totalDuration)';
}

/// Individual step in an animation sequence
class FSAnimationStep {
  final FSAnimation animation;
  final Duration delay;

  const FSAnimationStep({
    required this.animation,
    this.delay = Duration.zero,
  });

  /// Get effective curve (handles null case)
  Curve get effectiveCurve => animation.curve;

  @override
  String toString() => 'FSAnimationStep(animation: $animation, delay: $delay)';
}

// =============================================================================
// ANIMATION ENUMS AND DIRECTIONS
// =============================================================================

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
  flip;

  @override
  String toString() => 'FSAnimationType.$name';
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
  center;

  @override
  String toString() => 'FSAnimationDirection.$name';
}

/// Animation states for component lifecycle
enum FSAnimationState {
  idle,
  entering,
  exiting,
  active,
  disabled;

  @override
  String toString() => 'FSAnimationState.$name';
}

// =============================================================================
// ANIMATION PRESETS
// =============================================================================

/// Pre-configured animation settings for common UI patterns
class FSAnimationPreset {
  // Duration presets
  static const Duration instant = Duration(milliseconds: 100);
  static const Duration quick = Duration(milliseconds: 200);
  static const Duration standard = Duration(milliseconds: 300);
  static const Duration deliberate = Duration(milliseconds: 500);
  static const Duration slow = Duration(milliseconds: 800);
  static const Duration dramatic = Duration(milliseconds: 1200);

  // Curve presets
  static const Curve linear = Curves.linear;
  static const Curve ease = Curves.easeInOut;
  static const Curve easeIn = Curves.easeIn;
  static const Curve easeOut = Curves.easeOut;
  static const Curve bounce = Curves.bounceOut;
  static const Curve elastic = Curves.elasticOut;
  static const Curve sharp = Curves.easeInCubic;
  static const Curve smooth = Curves.easeOutCubic;

  // Pre-configured animation configurations
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

// =============================================================================
// EXTENSIONS
// =============================================================================

/// Extension methods for FSAnimationType
extension FSAnimationTypeExtension on FSAnimationType {
  /// Get default duration for each animation type
  Duration get defaultDuration {
    switch (this) {
      case FSAnimationType.fadeIn:
      case FSAnimationType.fadeOut:
        return FSAnimationPreset.standard;
      case FSAnimationType.slideIn:
      case FSAnimationType.slideOut:
        return FSAnimationPreset.deliberate;
      case FSAnimationType.bounce:
      case FSAnimationType.pulse:
        return FSAnimationPreset.slow;
      case FSAnimationType.shake:
        return FSAnimationPreset.quick;
      case FSAnimationType.spin:
        return const Duration(milliseconds: 1000);
      case FSAnimationType.flip:
        return FSAnimationPreset.dramatic;
      case FSAnimationType.scale:
        return FSAnimationPreset.standard;
    }
  }

  /// Get default curve for each animation type
  Curve get defaultCurve {
    switch (this) {
      case FSAnimationType.bounce:
        return FSAnimationPreset.bounce;
      case FSAnimationType.shake:
        return FSAnimationPreset.sharp;
      default:
        return FSAnimationPreset.easeOut;
    }
  }
}
