/// Flutstrap Animation System
///
/// A comprehensive collection of reusable animations and transitions
/// that integrate seamlessly with the Flutstrap design system.
///
/// ## Usage Examples
///
/// ```dart
/// // Basic fade animation
/// FadeIn(
///   child: MyWidget(),
///   duration: Duration(milliseconds: 500),
/// )
///
/// // Themed animation using app theme
/// FadeIn.themed(
///   context: context,
///   child: MyWidget(),
/// )
///
/// // Staggered list animation
/// FSStaggeredFadeIn(
///   children: [
///     Item1(),
///     Item2(),
///     Item3(),
///   ],
/// )
///
/// // Using animation utilities
/// context.createStaggeredAnimations(
///   type: FSAnimationType.slideIn,
///   direction: FSAnimationDirection.bottom,
/// )
/// ```
///
/// {@category Animations}
/// {@category Utilities}

// Core animation components
export 'fade_in.dart';
export 'slide_transition.dart';

// Animation types and configuration
export 'animation_types.dart';

// Animation utilities and helpers
export 'animation_utils.dart';

// Pre-configured animation sequences
export 'animation_sequences.dart';
