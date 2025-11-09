# Flutstrap Animation Type System Guide

## Introduction

The Flutstrap Animation Type System provides a comprehensive foundation for creating smooth, consistent animations throughout your Flutter applications. It offers a standardized way to configure, manage, and apply animations with proper timing curves and durations.

### What It Does

- Defines standardized animation configurations with proper durations and curves
- Provides pre-configured animation presets for common UI patterns
- Supports complex animation sequences with delays and multiple steps
- Offers utility extensions for clean animation logic

### When to Use

- Creating consistent animations across your application
- Implementing complex animation sequences
- Ensuring proper animation timing and performance
- Building reusable animated components

### Prerequisites

- Flutter 3.0 or higher
- Basic understanding of Flutter's animation system
- Flutstrap core library installed

## Installation & Setup

### Required Dependencies

```dart
import 'package:flutstrap/flutstrap.dart';
```

### Basic Configuration

The animation system works out of the box with sensible defaults:

```dart
// No setup required - use directly
const animation = FSAnimation.standard();
```

## Core Animation Types

### FSAnimationBase

**Base Animation Configuration**

Abstract base class that all animation configurations extend from.

```dart
abstract class FSAnimationBase {
  final Duration duration;
  final Curve curve;

  const FSAnimationBase({
    required this.duration,
    required this.curve,
  });
}
```

### FSAnimation

**Standard Animation Configuration**

The primary configuration class for single animations in Flutstrap.

```dart
// Basic usage
const basicAnimation = FSAnimation(
  duration: Duration(milliseconds: 300),
  curve: Curves.easeOut,
);

// Using presets
const quickAnimation = FSAnimation.quick();
const standardAnimation = FSAnimation.standard();
```

### FSAnimationSequence

**Animation Sequence Configuration**

Configures complex multi-step animation sequences.

```dart
const sequence = FSAnimationSequence(
  duration: Duration(milliseconds: 1200),
  curve: Curves.easeOut,
  steps: [
    FSAnimationStep(
      animation: FSAnimation(duration: Duration(milliseconds: 400)),
      delay: Duration(milliseconds: 100),
    ),
    FSAnimationStep(
      animation: FSAnimation(duration: Duration(milliseconds: 300)),
      delay: Duration(milliseconds: 200),
    ),
  ],
);
```

### FSAnimationStep

**Animation Step in Sequence**

Represents a single step in an animation sequence.

```dart
const step = FSAnimationStep(
  animation: FSAnimation(duration: Duration(milliseconds: 500)),
  delay: Duration(milliseconds: 200),
);
```

## Basic Usage

### Simple Animation Configuration

```dart
// Create a custom animation
const customAnimation = FSAnimation(
  duration: Duration(milliseconds: 500),
  curve: Curves.elasticOut,
);

// Copy and modify existing animation
const original = FSAnimation.standard();
const faster = original.copyWith(duration: Duration(milliseconds: 200));
```

### Using Preset Animations

```dart
// Common animation presets
const buttonPress = FSAnimationPreset.buttonPress;
const pageTransition = FSAnimationPreset.pageTransition;
const modalEnter = FSAnimationPreset.modalEnter;
const attentionGrabber = FSAnimationPreset.attentionGrabber;
```

## Animation Types & Variants

### FSAnimationType Enum

Standardized animation types for consistent behavior across components.

```dart
enum FSAnimationType {
  fadeIn,    // Element fades into view
  fadeOut,   // Element fades out of view
  slideIn,   // Element slides into position
  slideOut,  // Element slides out of view
  scale,     // Element scales up or down
  bounce,    // Element animates with bounce effect
  shake,     // Element shakes for attention
  pulse,     // Element pulses for emphasis
  spin,      // Element rotates continuously
  flip,      // Element flips in 3D space
}
```

### Animation Type Usage

```dart
// Check animation properties
if (FSAnimationType.fadeIn.isEntrance) {
  print('This is an entrance animation');
}

if (FSAnimationType.fadeOut.isExit) {
  print('This is an exit animation');
}

// Get default configuration for animation type
final fadeAnimation = FSAnimationType.fadeIn.defaultAnimation;
final slideAnimation = FSAnimationType.slideIn.defaultAnimation;
```

## Animation Directions

### FSAnimationDirection Enum

Defines directional origins for movement-based animations.

```dart
enum FSAnimationDirection {
  top, bottom, left, right,           // Cardinal directions
  topLeft, topRight,                  // Diagonal directions
  bottomLeft, bottomRight,            // Diagonal directions
  center;                             // No specific direction
}
```

### Direction Usage Examples

```dart
// Check direction properties
if (FSAnimationDirection.topLeft.isDiagonal) {
  print('Diagonal slide animation');
}

if (FSAnimationDirection.left.isCardinal) {
  print('Cardinal direction animation');
}

// Get slide offsets for directional animations
final offset = FSAnimationDirection.top.slideOffset; // (0.0, -1.0)
```

## Properties & Parameters

### FSAnimation Parameters

| Parameter  | Type       | Default          | Description                            |
| ---------- | ---------- | ---------------- | -------------------------------------- |
| `duration` | `Duration` | Required         | Total animation duration               |
| `curve`    | `Curve`    | `Curves.easeOut` | Timing curve for animation progression |

### FSAnimationSequence Parameters

| Parameter  | Type                    | Default  | Description                 |
| ---------- | ----------------------- | -------- | --------------------------- |
| `duration` | `Duration`              | Required | Total sequence duration     |
| `curve`    | `Curve`                 | Required | Base timing curve           |
| `steps`    | `List<FSAnimationStep>` | Required | Animation steps in sequence |

### FSAnimationStep Parameters

| Parameter   | Type          | Default         | Description                   |
| ----------- | ------------- | --------------- | ----------------------------- |
| `animation` | `FSAnimation` | Required        | Animation configuration       |
| `delay`     | `Duration`    | `Duration.zero` | Delay before animation starts |

## Animation Presets

### Duration Presets

```dart
// Standard duration presets
Duration instant = FSAnimationPreset.instant;      // 100ms
Duration quick = FSAnimationPreset.quick;          // 200ms
Duration standard = FSAnimationPreset.standard;    // 300ms
Duration deliberate = FSAnimationPreset.deliberate; // 500ms
Duration slow = FSAnimationPreset.slow;            // 800ms
Duration dramatic = FSAnimationPreset.dramatic;    // 1200ms
```

### Curve Presets

```dart
// Standard curve presets
Curve linear = FSAnimationPreset.linear;
Curve ease = FSAnimationPreset.ease;
Curve easeIn = FSAnimationPreset.easeIn;
Curve easeOut = FSAnimationPreset.easeOut;  // Recommended default
Curve bounce = FSAnimationPreset.bounce;
Curve elastic = FSAnimationPreset.elastic;
Curve sharp = FSAnimationPreset.sharp;
Curve smooth = FSAnimationPreset.smooth;
```

### Pre-configured Animations

```dart
// Complete animation configurations
FSAnimation buttonPress = FSAnimationPreset.buttonPress;
FSAnimation pageTransition = FSAnimationPreset.pageTransition;
FSAnimation modalEnter = FSAnimationPreset.modalEnter;
FSAnimation attentionGrabber = FSAnimationPreset.attentionGrabber;
FSAnimation subtleEntrance = FSAnimationPreset.subtleEntrance;
FSAnimation quickFade = FSAnimationPreset.quickFade;
FSAnimation bounceAnimation = FSAnimationPreset.bounceAnimation;
```

## Customization

### Creating Custom Animations

```dart
// Custom animation with specific requirements
const customBounce = FSAnimation(
  duration: Duration(milliseconds: 600),
  curve: Curves.bounceOut,
);

// Custom sequence for complex interactions
const customSequence = FSAnimationSequence(
  duration: Duration(milliseconds: 1500),
  curve: Curves.easeInOut,
  steps: [
    FSAnimationStep(
      animation: FSAnimation(duration: Duration(milliseconds: 400)),
      delay: Duration(milliseconds: 200),
    ),
    FSAnimationStep(
      animation: FSAnimation(duration: Duration(milliseconds: 300)),
      delay: Duration(milliseconds: 100),
    ),
    FSAnimationStep(
      animation: FSAnimation(duration: Duration(milliseconds: 500)),
      delay: Duration.zero,
    ),
  ],
);
```

### Animation Type Extensions

```dart
// Using extensions for default configurations
final fadeInConfig = FSAnimationType.fadeIn.defaultAnimation;
final slideConfig = FSAnimationType.slideIn.defaultAnimation;

// Access default values directly
Duration defaultFadeDuration = FSAnimationType.fadeIn.defaultDuration;
Curve defaultBounceCurve = FSAnimationType.bounce.defaultCurve;
```

## Advanced Usage

### Complex Animation Sequences

```dart
class StaggeredAnimation extends StatelessWidget {
  const StaggeredAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    const sequence = FSAnimationSequence(
      duration: Duration(milliseconds: 2000),
      curve: Curves.easeOut,
      steps: [
        FSAnimationStep(
          animation: FSAnimation(
            duration: Duration(milliseconds: 400),
            curve: Curves.easeOutBack,
          ),
          delay: Duration(milliseconds: 100),
        ),
        FSAnimationStep(
          animation: FSAnimation(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          ),
          delay: Duration(milliseconds: 200),
        ),
        FSAnimationStep(
          animation: FSAnimation(
            duration: Duration(milliseconds: 500),
            curve: Curves.elasticOut,
          ),
          delay: Duration.zero,
        ),
      ],
    );

    return FadeIn(
      animation: sequence,
      child: YourAnimatedWidget(),
    );
  }
}
```

### Directional Animation Offsets

```dart
class DirectionalSlide extends StatelessWidget {
  final FSAnimationDirection direction;

  const DirectionalSlide({super.key, required this.direction});

  @override
  Widget build(BuildContext context) {
    final (offsetX, offsetY) = direction.slideOffset;

    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(offsetX, offsetY),
        end: Offset.zero,
      ).animate(animationController),
      child: YourWidget(),
    );
  }
}

// Usage
DirectionalSlide(direction: FSAnimationDirection.topLeft);
DirectionalSlide(direction: FSAnimationDirection.right);
```

## Integration Examples

### With Flutstrap Components

```dart
class AnimatedButtonExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FSButton(
      onPressed: () {},
      animation: FSAnimationPreset.buttonPress,
      child: const Text('Animated Button'),
    );
  }
}

class AnimatedCardExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FSCard(
      animation: FSAnimationPreset.subtleEntrance,
      child: const Text('Animated Card'),
    );
  }
}
```

### Custom Animation Controller

```dart
class CustomAnimationController extends StatefulWidget {
  @override
  State<CustomAnimationController> createState() => _CustomAnimationControllerState();
}

class _CustomAnimationControllerState extends State<CustomAnimationController>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    const animationConfig = FSAnimationPreset.modalEnter;

    _controller = AnimationController(
      duration: animationConfig.duration,
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: animationConfig.curve,
    );

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: YourWidget(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
```

### Responsive Animations

```dart
class ResponsiveAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final breakpoint = const FSCustomBreakpoints().getBreakpoint(screenWidth);

    // Adjust animation based on screen size
    final animation = breakpoint.isLargerThan(FSBreakpoint.md)
        ? FSAnimationPreset.deliberate  // Slower on desktop
        : FSAnimationPreset.quick;      // Faster on mobile

    return FadeIn(
      animation: animation,
      child: YourContent(),
    );
  }
}
```

## Best Practices

### Performance Recommendations

```dart
// ✅ GOOD: Use const constructors for static animations
const standardAnimation = FSAnimation.standard();
const buttonAnimation = FSAnimationPreset.buttonPress;

// ✅ GOOD: Reuse animation configurations
class AnimationConstants {
  static const pageTransition = FSAnimationPreset.pageTransition;
  static const buttonPress = FSAnimationPreset.buttonPress;
  static const subtleEntrance = FSAnimationPreset.subtleEntrance;
}

// ❌ AVOID: Creating new instances in build methods
Widget build(BuildContext context) {
  // This creates a new instance on every build
  final animation = FSAnimation(duration: Duration(milliseconds: 300));
}
```

### Animation Timing Guidelines

```dart
// Quick interactions (buttons, toggles)
const quickAnimation = FSAnimation.quick();

// Standard transitions (page changes, modal entries)
const standardAnimation = FSAnimation.standard();

// Prominent animations (attention grabbers, celebrations)
const prominentAnimation = FSAnimation(
  duration: FSAnimationPreset.slow,
  curve: FSAnimationPreset.elastic,
);
```

### Sequence Validation

```dart
// Always validate sequences
final sequence = FSAnimationSequence.validated(
  duration: Duration(milliseconds: 1000),
  curve: Curves.easeOut,
  steps: [
    FSAnimationStep.validated(
      animation: FSAnimation(duration: Duration(milliseconds: 400)),
      delay: Duration(milliseconds: 100),
    ),
  ],
);

// Check sequence validity
if (sequence.isValidDuration) {
  print('Sequence duration is correctly configured');
}
```

## Troubleshooting

### Common Issues and Solutions

**Animation not playing**

```dart
// ✅ Ensure proper controller lifecycle
@override
void initState() {
  super.initState();
  _controller.forward(); // Don't forget to start the animation
}

// ✅ Check animation configuration
const animation = FSAnimation(
  duration: Duration(milliseconds: 500), // Non-zero duration
  curve: Curves.easeOut,
);
```

**Sequence duration mismatch**

```dart
// ❌ Invalid: Duration doesn't match steps
FSAnimationSequence(
  duration: Duration(milliseconds: 500), // Too short
  steps: [
    FSAnimationStep(
      animation: FSAnimation(duration: Duration(milliseconds: 400)),
      delay: Duration(milliseconds: 200), // Total: 600ms
    ),
  ],
);

// ✅ Valid: Use calculated duration
final steps = [
  FSAnimationStep(
    animation: FSAnimation(duration: Duration(milliseconds: 400)),
    delay: Duration(milliseconds: 200),
  ),
];

final totalDuration = steps.fold<Duration>(
  Duration.zero,
  (total, step) => total + step.totalDuration,
);

FSAnimationSequence(
  duration: totalDuration, // Matches calculated total
  curve: Curves.easeOut,
  steps: steps,
);
```

**Performance issues with complex sequences**

```dart
// ✅ Optimize: Use simpler curves for better performance
const optimizedSequence = FSAnimationSequence(
  duration: Duration(milliseconds: 1000),
  curve: Curves.easeOut, // Better performance than elastic/bounce
  steps: [/* ... */],
);

// ✅ Optimize: Limit simultaneous animations
// Avoid too many complex animations running at once
```

## Full Example

### Complete Animated Component

```dart
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:flutstrap/flutstrap.dart';

class AnimatedProductCard extends StatefulWidget {
  final String title;
  final String description;
  final String imageUrl;
  final bool isFeatured;

  const AnimatedProductCard({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    this.isFeatured = false,
  });

  @override
  State<AnimatedProductCard> createState() => _AnimatedProductCardState();
}

class _AnimatedProductCardState extends State<AnimatedProductCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Use Flutstrap animation presets
    final entranceAnimation = widget.isFeatured
        ? FSAnimationPreset.attentionGrabber
        : FSAnimationPreset.subtleEntrance;

    _controller = AnimationController(
      duration: entranceAnimation.duration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: entranceAnimation.curve,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: entranceAnimation.curve,
    ));

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: FSCard(
          elevation: 4,
          margin: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                widget.imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const SizedBox(height: 8),
                    Text(widget.description),
                    const SizedBox(height: 16),
                    FSButton(
                      onPressed: _handleAddToCart,
                      animation: FSAnimationPreset.buttonPress,
                      child: const Text('Add to Cart'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleAddToCart() {
    // Use quick animation for immediate feedback
    const feedbackAnimation = FSAnimationPreset.buttonPress;
    // Handle add to cart logic
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// Usage
class ProductGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return AnimatedProductCard(
          title: products[index].title,
          description: products[index].description,
          imageUrl: products[index].imageUrl,
          isFeatured: index == 0, // First card gets special animation
        );
      },
    );
  }
}
```

This comprehensive animation type system provides the foundation for creating beautiful, consistent, and performant animations throughout your Flutter applications while maintaining excellent developer experience and code maintainability.
