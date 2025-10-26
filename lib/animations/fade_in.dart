// fade_in.dart - Updated with import
import 'dart:math' as math;
import 'package:flutter/material.dart';

/// FadeIn Animation Widget
///
/// A widget that gradually fades in its child over a specified duration.
/// Useful for smooth entrance animations and page transitions.
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

  /// The alignment of the child during animation
  final AlignmentGeometry alignment;

  /// Creates a fade-in animation widget
  const FadeIn({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.delay = Duration.zero,
    this.curve = Curves.easeInOut,
    this.autoPlay = true,
    this.onComplete,
    this.alignment = Alignment.center,
  }) : super(key: key);

  @override
  State<FadeIn> createState() => _FadeInState();
}

class _FadeInState extends State<FadeIn> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    // Use a custom animation that clamps values for elastic curves
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.curve,
      ),
    );

    if (widget.autoPlay) {
      _startAnimation();
    }
  }

  void _startAnimation() async {
    if (widget.delay > Duration.zero) {
      await Future.delayed(widget.delay);
    }

    if (mounted) {
      await _controller.forward().orCancel;
      widget.onComplete?.call();
    }
  }

  /// Manually start the fade-in animation
  void play() {
    if (mounted) {
      _controller.forward().orCancel;
    }
  }

  /// Manually reset the animation to its initial state
  void reset() {
    if (mounted) {
      _controller.reset();
    }
  }

  /// Manually stop the animation
  void stop() {
    if (mounted) {
      _controller.stop();
    }
  }

  @override
  void didUpdateWidget(FadeIn oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Update controller if duration changed
    if (widget.duration != oldWidget.duration) {
      _controller.duration = widget.duration;
    }

    // Update animation if curve changed
    if (widget.curve != oldWidget.curve) {
      _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: widget.curve,
        ),
      );
    }

    // Restart animation if autoPlay changed to true
    if (widget.autoPlay && !oldWidget.autoPlay) {
      _startAnimation();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        // Clamp the opacity value to ensure it stays between 0.0 and 1.0
        // This is especially important for elastic curves that can overshoot
        final opacity = _animation.value.clamp(0.0, 1.0);

        return Opacity(
          opacity: opacity,
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

/// Pre-configured FadeIn variations for common use cases

/// Quick fade-in animation (200ms)
class FadeInQuick extends StatelessWidget {
  final Widget child;
  final Duration delay;
  final bool autoPlay;
  final VoidCallback? onComplete;

  const FadeInQuick({
    Key? key,
    required this.child,
    this.delay = Duration.zero,
    this.autoPlay = true,
    this.onComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: child,
      duration: const Duration(milliseconds: 200),
      delay: delay,
      autoPlay: autoPlay,
      onComplete: onComplete,
    );
  }
}

/// Standard fade-in animation (500ms)
class FadeInStandard extends StatelessWidget {
  final Widget child;
  final Duration delay;
  final bool autoPlay;
  final VoidCallback? onComplete;

  const FadeInStandard({
    Key? key,
    required this.child,
    this.delay = Duration.zero,
    this.autoPlay = true,
    this.onComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: child,
      duration: const Duration(milliseconds: 500),
      delay: delay,
      autoPlay: autoPlay,
      onComplete: onComplete,
    );
  }
}

/// Slow fade-in animation (1000ms)
class FadeInSlow extends StatelessWidget {
  final Widget child;
  final Duration delay;
  final bool autoPlay;
  final VoidCallback? onComplete;

  const FadeInSlow({
    Key? key,
    required this.child,
    this.delay = Duration.zero,
    this.autoPlay = true,
    this.onComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: child,
      duration: const Duration(milliseconds: 1000),
      delay: delay,
      autoPlay: autoPlay,
      onComplete: onComplete,
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

  const FadeInBounce({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 600),
    this.delay = Duration.zero,
    this.autoPlay = true,
    this.onComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: child,
      duration: duration,
      delay: delay,
      curve: Curves.bounceOut,
      autoPlay: autoPlay,
      onComplete: onComplete,
    );
  }
}

/// Fade-in with elastic curve for attention-grabbing animations
/// Uses a modified approach to handle elastic curve overshoot
class FadeInElastic extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final bool autoPlay;
  final VoidCallback? onComplete;

  const FadeInElastic({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 800),
    this.delay = Duration.zero,
    this.autoPlay = true,
    this.onComplete,
  }) : super(key: key);

  @override
  State<FadeInElastic> createState() => _FadeInElasticState();
}

class _FadeInElasticState extends State<FadeInElastic>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    // Create a custom elastic animation that stays within bounds
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve:
            const ElasticOutCurve(0.7), // Reduced elasticity to stay in bounds
      ),
    );

    if (widget.autoPlay) {
      _startAnimation();
    }
  }

  void _startAnimation() async {
    if (widget.delay > Duration.zero) {
      await Future.delayed(widget.delay);
    }

    if (mounted) {
      await _controller.forward().orCancel;
      widget.onComplete?.call();
    }
  }

  @override
  void didUpdateWidget(FadeInElastic oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.duration != oldWidget.duration) {
      _controller.duration = widget.duration;
    }

    if (widget.autoPlay && !oldWidget.autoPlay) {
      _startAnimation();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        // Ensure opacity stays within valid range
        final opacity = _animation.value.clamp(0.0, 1.0);

        return Opacity(
          opacity: opacity,
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

/// Custom elastic curve that stays within reasonable bounds
class ElasticOutCurve extends Curve {
  final double period;

  const ElasticOutCurve([this.period = 0.4]);

  @override
  double transform(double t) {
    // Modified elastic out curve that doesn't overshoot as much
    final double s = period / 4.0;
    return math.pow(2.0, -10.0 * t) *
            math.sin((t - s) * (2.0 * math.pi) / period) +
        1.0;
  }
}
