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

  /// ✅ ADDED: Equality and hashcode for better state management
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FSAnimationBase &&
          runtimeType == other.runtimeType &&
          duration == other.duration &&
          curve == other.curve;

  @override
  int get hashCode => duration.hashCode ^ curve.hashCode;
}

/// Standard animation configuration for single animations
class FSAnimation extends FSAnimationBase {
  const FSAnimation({
    required super.duration,
    super.curve = Curves.easeOut, // ✅ CHANGED: Better default than linear
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

  /// ✅ ADDED: Convenience constructor for quick animations
  const FSAnimation.quick()
      : super(
          duration: FSAnimationPreset.quick,
          curve: FSAnimationPreset.easeOut,
        );

  /// ✅ ADDED: Convenience constructor for standard animations
  const FSAnimation.standard()
      : super(
          duration: FSAnimationPreset.standard,
          curve: FSAnimationPreset.easeOut,
        );

  @override
  String toString() => 'FSAnimation(duration: $duration, curve: $curve)';

  // ✅ ADDED: Enhanced equality check
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is FSAnimation &&
          runtimeType == other.runtimeType;

  @override
  int get hashCode => super.hashCode;
}

/// Animation sequence configuration for complex multi-step animations
class FSAnimationSequence extends FSAnimationBase {
  final List<FSAnimationStep> steps;

  // ✅ FIXED: Removed assert from const constructor, moved validation to factory
  const FSAnimationSequence({
    required super.duration,
    required super.curve,
    required this.steps,
  });

  /// ✅ ADDED: Factory constructor with validation
  factory FSAnimationSequence.validated({
    required Duration duration,
    required Curve curve,
    required List<FSAnimationStep> steps,
  }) {
    assert(steps.isNotEmpty, 'Animation sequence must have at least one step');
    return FSAnimationSequence(
      duration: duration,
      curve: curve,
      steps: steps,
    );
  }

  /// Total duration including all steps and delays
  Duration get totalDuration {
    return steps.fold<Duration>(
      Duration.zero,
      (total, step) => total + step.animation.duration + step.delay,
    );
  }

  /// ✅ ADDED: Validate that sequence duration matches calculated total
  bool get isValidDuration => duration == totalDuration;

  /// ✅ ADDED: Validate steps are not empty
  bool get hasSteps => steps.isNotEmpty;

  @override
  String toString() =>
      'FSAnimationSequence(steps: $steps, totalDuration: $totalDuration, isValid: $isValidDuration)';

  // ✅ ADDED: Equality check
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is FSAnimationSequence &&
          runtimeType == other.runtimeType &&
          steps == other.steps;

  @override
  int get hashCode => super.hashCode ^ steps.hashCode;
}

/// Individual step in an animation sequence
class FSAnimationStep {
  final FSAnimation animation;
  final Duration delay;

  // ✅ FIXED: Removed assert from const constructor
  const FSAnimationStep({
    required this.animation,
    this.delay = Duration.zero,
  });

  /// ✅ ADDED: Factory constructor with validation
  factory FSAnimationStep.validated({
    required FSAnimation animation,
    Duration delay = Duration.zero,
  }) {
    assert(delay >= Duration.zero, 'Delay cannot be negative');
    return FSAnimationStep(
      animation: animation,
      delay: delay,
    );
  }

  /// Get effective curve (handles null case)
  Curve get effectiveCurve => animation.curve;

  /// ✅ ADDED: Total duration for this step
  Duration get totalDuration => animation.duration + delay;

  /// ✅ ADDED: Validate delay is not negative
  bool get isValidDelay => delay >= Duration.zero;

  @override
  String toString() =>
      'FSAnimationStep(animation: $animation, delay: $delay, total: $totalDuration)';

  // ✅ ADDED: Equality check
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FSAnimationStep &&
          runtimeType == other.runtimeType &&
          animation == other.animation &&
          delay == other.delay;

  @override
  int get hashCode => animation.hashCode ^ delay.hashCode;
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

  /// ✅ ADDED: Better string representation for debugging
  @override
  String toString() => name;

  /// ✅ ADDED: Check if this is an entrance animation
  bool get isEntrance => this == fadeIn || this == slideIn || this == scale;

  /// ✅ ADDED: Check if this is an exit animation
  bool get isExit => this == fadeOut || this == slideOut;
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

  /// ✅ ADDED: Better string representation
  @override
  String toString() => name;

  /// ✅ ADDED: Check if this is a diagonal direction
  bool get isDiagonal =>
      this == topLeft ||
      this == topRight ||
      this == bottomLeft ||
      this == bottomRight;

  /// ✅ ADDED: Check if this is a cardinal direction
  bool get isCardinal =>
      this == top || this == bottom || this == left || this == right;
}

/// Animation states for component lifecycle
enum FSAnimationState {
  idle,
  entering,
  exiting,
  active,
  disabled;

  /// ✅ ADDED: Better string representation
  @override
  String toString() => name;

  /// ✅ ADDED: Check if animation is currently running
  bool get isAnimating => this == entering || this == exiting;

  /// ✅ ADDED: Check if component is visible
  bool get isVisible => this == entering || this == active;
}

// =============================================================================
// ANIMATION PRESETS
// =============================================================================

/// Pre-configured animation settings for common UI patterns
class FSAnimationPreset {
  // ✅ ADDED: Private constructor to prevent instantiation
  const FSAnimationPreset._();

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

  /// ✅ ADDED: Quick fade animation preset
  static const FSAnimation quickFade = FSAnimation(
    duration: quick,
    curve: easeOut,
  );

  /// ✅ ADDED: Bounce animation preset
  static const FSAnimation bounceAnimation = FSAnimation(
    duration: slow,
    curve: bounce,
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
      case FSAnimationType.pulse:
        return FSAnimationPreset.ease;
      default:
        return FSAnimationPreset.easeOut;
    }
  }

  /// ✅ ADDED: Get complete animation configuration
  FSAnimation get defaultAnimation => FSAnimation(
        duration: defaultDuration,
        curve: defaultCurve,
      );
}

/// ✅ ADDED: Extension for FSAnimationDirection for slide calculations
extension FSAnimationDirectionExtension on FSAnimationDirection {
  /// Get offset for slide animations
  (double, double) get slideOffset {
    switch (this) {
      case FSAnimationDirection.top:
        return (0.0, -1.0);
      case FSAnimationDirection.bottom:
        return (0.0, 1.0);
      case FSAnimationDirection.left:
        return (-1.0, 0.0);
      case FSAnimationDirection.right:
        return (1.0, 0.0);
      case FSAnimationDirection.topLeft:
        return (-1.0, -1.0);
      case FSAnimationDirection.topRight:
        return (1.0, -1.0);
      case FSAnimationDirection.bottomLeft:
        return (-1.0, 1.0);
      case FSAnimationDirection.bottomRight:
        return (1.0, 1.0);
      case FSAnimationDirection.center:
        return (0.0, 0.0);
    }
  }
}
