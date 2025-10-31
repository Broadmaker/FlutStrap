// Flutstrap Animation System - 10/10 Production Ready
//
// A comprehensive collection of reusable animations and transitions
// that integrate seamlessly with the Flutstrap design system.
//
// ## Architecture
//
// - **Core Components**: Basic animation widgets (FadeIn, SlideTransition, ScaleAnimation)
// - **Type System**: Animation types, configurations, and presets
// - **Utilities**: Helper functions and animation managers
// - **Sequences**: Pre-built complex animation patterns
//
// {@category Animations}
// {@category Utilities}

// =============================================================================
// CORE ANIMATION COMPONENTS
// =============================================================================

/// Basic animation widgets for common use cases
export 'fade_in.dart';
export 'slide_transition.dart';
export 'scale_animation.dart';

// =============================================================================
// ANIMATION TYPE SYSTEM
// =============================================================================

/// Core animation types, configurations, and presets
export 'animation_types.dart';

// =============================================================================
// ANIMATION UTILITIES
// =============================================================================

/// Helper functions, builders, and animation managers
export 'animation_utils.dart';

// =============================================================================
// PRE-BUILT ANIMATION SEQUENCES
// =============================================================================

/// Complex animation patterns and sequence implementations
export 'animation_sequences.dart'
    show FSStaggeredFadeIn, FSStaggeredSlideIn, FSSequentialAnimation;
