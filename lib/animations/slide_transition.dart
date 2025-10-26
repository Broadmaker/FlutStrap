// slide_transition.dart
import 'package:flutter/material.dart';

/// Slide Direction for FSSlideTransition
enum FSSlideDirection {
  fromTop,
  fromBottom,
  fromLeft,
  fromRight,
  fromTopLeft,
  fromTopRight,
  fromBottomLeft,
  fromBottomRight,
}

/// FSSlideTransition Animation Widget
///
/// A widget that slides its child into position from a specified direction.
/// Useful for entrance animations, page transitions, and dynamic content reveals.
class FSSlideTransition extends StatefulWidget {
  /// The child widget to animate
  final Widget child;

  /// The direction from which the child slides in
  final FSSlideDirection direction;

  /// The duration of the slide animation
  final Duration duration;

  /// The delay before the animation starts
  final Duration delay;

  /// The curve of the animation
  final Curve curve;

  /// Whether the animation should play automatically when the widget is built
  final bool autoPlay;

  /// Callback function called when the animation completes
  final VoidCallback? onComplete;

  /// The offset distance as a fraction of the child's size (0.0 to 1.0)
  final double offsetFraction;

  /// Creates a slide transition animation widget
  const FSSlideTransition({
    Key? key,
    required this.child,
    this.direction = FSSlideDirection.fromBottom,
    this.duration = const Duration(milliseconds: 500),
    this.delay = Duration.zero,
    this.curve = Curves.easeOut,
    this.autoPlay = true,
    this.onComplete,
    this.offsetFraction = 1.0,
  })  : assert(offsetFraction >= 0.0 && offsetFraction <= 2.0,
            'offsetFraction must be between 0.0 and 2.0'),
        super(key: key);

  @override
  State<FSSlideTransition> createState() => _FSSlideTransitionState();
}

class _FSSlideTransitionState extends State<FSSlideTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = Tween<Offset>(
      begin: _getBeginOffset(),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.curve,
      ),
    );

    if (widget.autoPlay) {
      _startAnimation();
    }
  }

  Offset _getBeginOffset() {
    final fraction = widget.offsetFraction;

    switch (widget.direction) {
      case FSSlideDirection.fromTop:
        return Offset(0.0, -fraction);
      case FSSlideDirection.fromBottom:
        return Offset(0.0, fraction);
      case FSSlideDirection.fromLeft:
        return Offset(-fraction, 0.0);
      case FSSlideDirection.fromRight:
        return Offset(fraction, 0.0);
      case FSSlideDirection.fromTopLeft:
        return Offset(-fraction, -fraction);
      case FSSlideDirection.fromTopRight:
        return Offset(fraction, -fraction);
      case FSSlideDirection.fromBottomLeft:
        return Offset(-fraction, fraction);
      case FSSlideDirection.fromBottomRight:
        return Offset(fraction, fraction);
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

  /// Manually start the slide animation
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
  void didUpdateWidget(FSSlideTransition oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Update controller if duration changed
    if (widget.duration != oldWidget.duration) {
      _controller.duration = widget.duration;
    }

    // Update animation if direction or offset changed
    if (widget.direction != oldWidget.direction ||
        widget.offsetFraction != oldWidget.offsetFraction) {
      _animation = Tween<Offset>(
        begin: _getBeginOffset(),
        end: Offset.zero,
      ).animate(
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
        return Transform.translate(
          offset: _animation.value,
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

/// Pre-configured FSSlideTransition variations for common use cases

/// Quick slide animation (300ms)
class FSSlideTransitionQuick extends StatelessWidget {
  final Widget child;
  final FSSlideDirection direction;
  final Duration delay;
  final bool autoPlay;
  final VoidCallback? onComplete;
  final double offsetFraction;

  const FSSlideTransitionQuick({
    Key? key,
    required this.child,
    this.direction = FSSlideDirection.fromBottom,
    this.delay = Duration.zero,
    this.autoPlay = true,
    this.onComplete,
    this.offsetFraction = 1.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FSSlideTransition(
      child: child,
      direction: direction,
      duration: const Duration(milliseconds: 300),
      delay: delay,
      autoPlay: autoPlay,
      onComplete: onComplete,
      offsetFraction: offsetFraction,
    );
  }
}

/// Standard slide animation (500ms)
class FSSlideTransitionStandard extends StatelessWidget {
  final Widget child;
  final FSSlideDirection direction;
  final Duration delay;
  final bool autoPlay;
  final VoidCallback? onComplete;
  final double offsetFraction;

  const FSSlideTransitionStandard({
    Key? key,
    required this.child,
    this.direction = FSSlideDirection.fromBottom,
    this.delay = Duration.zero,
    this.autoPlay = true,
    this.onComplete,
    this.offsetFraction = 1.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FSSlideTransition(
      child: child,
      direction: direction,
      duration: const Duration(milliseconds: 500),
      delay: delay,
      autoPlay: autoPlay,
      onComplete: onComplete,
      offsetFraction: offsetFraction,
    );
  }
}

/// Slow slide animation (800ms)
class FSSlideTransitionSlow extends StatelessWidget {
  final Widget child;
  final FSSlideDirection direction;
  final Duration delay;
  final bool autoPlay;
  final VoidCallback? onComplete;
  final double offsetFraction;

  const FSSlideTransitionSlow({
    Key? key,
    required this.child,
    this.direction = FSSlideDirection.fromBottom,
    this.delay = Duration.zero,
    this.autoPlay = true,
    this.onComplete,
    this.offsetFraction = 1.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FSSlideTransition(
      child: child,
      direction: direction,
      duration: const Duration(milliseconds: 800),
      delay: delay,
      autoPlay: autoPlay,
      onComplete: onComplete,
      offsetFraction: offsetFraction,
    );
  }
}

/// Slide from top with bounce curve
class FSSlideTransitionBounce extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final bool autoPlay;
  final VoidCallback? onComplete;
  final double offsetFraction;

  const FSSlideTransitionBounce({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 600),
    this.delay = Duration.zero,
    this.autoPlay = true,
    this.onComplete,
    this.offsetFraction = 1.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FSSlideTransition(
      child: child,
      direction: FSSlideDirection.fromTop,
      duration: duration,
      delay: delay,
      curve: Curves.bounceOut,
      autoPlay: autoPlay,
      onComplete: onComplete,
      offsetFraction: offsetFraction,
    );
  }
}

/// Slide from right with elastic curve
class FSSlideTransitionElastic extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final bool autoPlay;
  final VoidCallback? onComplete;
  final double offsetFraction;

  const FSSlideTransitionElastic({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 800),
    this.delay = Duration.zero,
    this.autoPlay = true,
    this.onComplete,
    this.offsetFraction = 1.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FSSlideTransition(
      child: child,
      direction: FSSlideDirection.fromRight,
      duration: duration,
      delay: delay,
      curve: Curves.elasticOut,
      autoPlay: autoPlay,
      onComplete: onComplete,
      offsetFraction: offsetFraction,
    );
  }
}

/// Slide from left for page transitions
class FSSlideTransitionPage extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final bool autoPlay;
  final VoidCallback? onComplete;

  const FSSlideTransitionPage({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 400),
    this.delay = Duration.zero,
    this.autoPlay = true,
    this.onComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FSSlideTransition(
      child: child,
      direction: FSSlideDirection.fromRight,
      duration: duration,
      delay: delay,
      curve: Curves.easeInOut,
      autoPlay: autoPlay,
      onComplete: onComplete,
      offsetFraction: 1.0,
    );
  }
}
