/// Flutstrap Animation Sequences
///
/// Pre-configured animation sequences and complex animation patterns
/// for sophisticated UI interactions.
///
/// {@category Animations}
/// {@category Components}

import 'dart:async';
import 'package:flutter/material.dart';
import 'animation_types.dart';
import 'fade_in.dart';
import 'slide_transition.dart';
import '../../core/theme.dart';

/// Staggered fade-in animation for lists
class FSStaggeredFadeIn extends StatelessWidget {
  final List<Widget> children;
  final FSAnimationDirection direction;
  final Duration duration;
  final Duration staggerDelay;
  final Curve curve;
  final bool autoPlay;
  final bool maintainState;

  const FSStaggeredFadeIn({
    super.key,
    required this.children,
    this.direction = FSAnimationDirection.bottom,
    this.duration = const Duration(milliseconds: 500),
    this.staggerDelay = const Duration(milliseconds: 100),
    this.curve = Curves.easeOut,
    this.autoPlay = true,
    this.maintainState = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        children.length,
        (index) => FadeIn(
          child: children[index],
          duration: duration,
          delay: autoPlay
              ? Duration(milliseconds: staggerDelay.inMilliseconds * index)
              : Duration.zero,
          curve: curve,
          autoPlay: autoPlay,
          maintainState: maintainState,
        ),
      ),
    );
  }

  /// Create with theme configuration
  factory FSStaggeredFadeIn.themed({
    Key? key,
    required BuildContext context,
    required List<Widget> children,
    FSAnimationDirection direction = FSAnimationDirection.bottom,
    Duration? duration,
    Duration staggerDelay = const Duration(milliseconds: 100),
    Curve? curve,
    bool autoPlay = true,
    bool maintainState = true,
  }) {
    final theme = FSTheme.of(context);
    return FSStaggeredFadeIn(
      key: key,
      children: children,
      direction: direction,
      duration: duration ?? theme.animation.duration,
      staggerDelay: staggerDelay,
      curve: curve ?? theme.animation.curve,
      autoPlay: autoPlay,
      maintainState: maintainState,
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
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        children.length,
        (index) => FSSlideTransition(
          child: children[index],
          direction: direction,
          duration: duration,
          delay: autoPlay
              ? Duration(milliseconds: staggerDelay.inMilliseconds * index)
              : Duration.zero,
          curve: curve,
          autoPlay: autoPlay,
          offsetFraction: offsetFraction,
          maintainState: maintainState,
        ),
      ),
    );
  }
}

/// Sequential animation for complex sequences
/// Sequential animation for complex sequences
class FSSequentialAnimation extends StatefulWidget {
  final List<Widget> children;
  final FSAnimationSequence sequence;
  final bool autoPlay;

  const FSSequentialAnimation({
    super.key,
    required this.children,
    required this.sequence,
    this.autoPlay = true,
  });

  @override
  State<FSSequentialAnimation> createState() => _FSSequentialAnimationState();
}

class _FSSequentialAnimationState extends State<FSSequentialAnimation>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;
  Timer? _startTimer;

  @override
  void initState() {
    super.initState();

    // ✅ MOVED: Assert statements to initState
    assert(
        widget.sequence.steps.isNotEmpty, 'Animation sequence must have steps');
    assert(widget.children.length <= widget.sequence.steps.length,
        'Children count (${widget.children.length}) cannot exceed sequence steps count (${widget.sequence.steps.length})');

    _initializeAnimations();

    if (widget.autoPlay) {
      _startAnimations();
    }
  }

  void _initializeAnimations() {
    // ✅ FIXED: Handle case where children count < steps count
    final effectiveStepCount = widget.children.length;

    _controllers = List<AnimationController>.generate(
      effectiveStepCount,
      (index) => AnimationController(
        duration: widget.sequence.steps[index].animation.duration,
        vsync: this,
      ),
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
  }

  Future<void> _startAnimations() async {
    if (!mounted) return;

    for (int i = 0; i < _controllers.length; i++) {
      final step = widget.sequence.steps[i];

      if (step.delay > Duration.zero) {
        await Future.delayed(step.delay);
      }

      if (mounted && !_controllers[i].isAnimating) {
        await _controllers[i].forward().orCancel;
      }

      if (!mounted) break; // Exit if widget was disposed
    }
  }

  /// Manually start the sequence
  Future<void> play() async {
    if (mounted) {
      await _startAnimations();
    }
  }

  /// Reset all animations
  void reset() {
    if (mounted) {
      for (final controller in _controllers) {
        if (!controller.isAnimating) {
          controller.reset();
        }
      }
    }
  }

  @override
  void dispose() {
    _startTimer?.cancel();
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
