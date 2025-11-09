# Flutstrap FadeIn Animation Guide

## Introduction

The Flutstrap FadeIn animation provides a high-performance widget that smoothly fades its child into view. It features theme integration, memory optimization, flexible configuration options, and comprehensive state management for creating beautiful entrance animations.

### What It Does

- Smoothly fades widgets into view with customizable timing
- Integrates with Flutstrap's theme system
- Provides manual animation control methods
- Includes performance optimizations and error handling
- Offers pre-configured animation variations

### When to Use

- Creating smooth content reveals
- Building loading states and skeleton screens
- Implementing modal dialogs and overlays
- Adding subtle entrance animations to UI elements

### Prerequisites

- Flutter 3.0 or higher
- Flutstrap core library
- Basic understanding of Flutter animations

## Installation & Setup

### Required Dependencies

```dart
import 'package:flutstrap/flutstrap.dart';
```

## Basic Usage

### Simple FadeIn

```dart
FadeIn(
  child: Container(
    width: 200,
    height: 200,
    color: Colors.blue,
    child: Center(child: Text('Hello World!')),
  ),
  duration: Duration(milliseconds: 500),
  delay: Duration(milliseconds: 200),
)
```

### Themed FadeIn

```dart
FadeIn.themed(
  context: context,
  child: YourWidget(),
  delay: Duration(milliseconds: 300),
  onComplete: () => print('Animation completed!'),
)
```

### Quick FadeIn

```dart
FadeInQuick(
  child: Text('Quick fade!'),
  delay: Duration(milliseconds: 100),
)
```

## Component Variants

### Pre-configured FadeIn Variations

#### FadeInQuick

200ms duration for fast, subtle animations

```dart
FadeInQuick(
  child: ButtonWidget(),
  onComplete: () => print('Button appeared'),
)
```

#### FadeInStandard

500ms duration for balanced animations

```dart
FadeInStandard(
  child: CardContent(),
  delay: Duration(milliseconds: 150),
)
```

#### FadeInSlow

800ms duration for prominent animations

```dart
FadeInSlow(
  child: HeroImage(),
  onComplete: () => _startNextAnimation(),
)
```

#### FadeInBounce

Bounce curve for playful animations

```dart
FadeInBounce(
  child: CelebrationBadge(),
  duration: Duration(milliseconds: 600),
)
```

#### FadeInElastic

Elastic curve for attention-grabbing animations

```dart
FadeInElastic(
  child: ImportantNotification(),
  duration: Duration(milliseconds: 800),
)
```

## Properties & Parameters

### FadeIn Parameters

| Parameter                  | Type            | Default          | Description                        |
| -------------------------- | --------------- | ---------------- | ---------------------------------- |
| `child`                    | `Widget`        | **Required**     | Widget to animate                  |
| `duration`                 | `Duration`      | `500ms`          | Animation duration                 |
| `delay`                    | `Duration`      | `0ms`            | Delay before animation starts      |
| `curve`                    | `Curve`         | `Curves.easeOut` | Animation timing curve             |
| `autoPlay`                 | `bool`          | `true`           | Start animation automatically      |
| `onComplete`               | `VoidCallback?` | `null`           | Called when animation completes    |
| `onCancel`                 | `VoidCallback?` | `null`           | Called if animation is interrupted |
| `maintainState`            | `bool`          | `true`           | Keep widget state when invisible   |
| `respectSystemPreferences` | `bool`          | `true`           | Respect system animation settings  |

## Customization

### Custom Duration and Curves

```dart
FadeIn(
  child: CustomWidget(),
  duration: Duration(milliseconds: 750),
  curve: Curves.easeInOutBack,
  delay: Duration(milliseconds: 500),
)
```

### Manual Animation Control

```dart
class ControlledFadeIn extends StatefulWidget {
  @override
  State<ControlledFadeIn> createState() => _ControlledFadeInState();
}

class _ControlledFadeInState extends State<ControlledFadeIn> {
  final GlobalKey<FadeInState> _fadeInKey = GlobalKey();

  void _handleButtonPress() async {
    // Manually control the animation
    await _fadeInKey.currentState?.play();

    // Wait 2 seconds then fade out
    await Future.delayed(Duration(seconds: 2));
    await _fadeInKey.currentState?.reverse();
  }

  void _resetAnimation() {
    _fadeInKey.currentState?.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FadeIn(
          key: _fadeInKey,
          child: Container(
            padding: EdgeInsets.all(20),
            color: Colors.green,
            child: Text('Controlled Fade'),
          ),
          autoPlay: false, // Manual control
        ),
        SizedBox(height: 20),
        Row(
          children: [
            ElevatedButton(
              onPressed: _handleButtonPress,
              child: Text('Fade In/Out'),
            ),
            ElevatedButton(
              onPressed: _resetAnimation,
              child: Text('Reset'),
            ),
          ],
        ),
      ],
    );
  }
}
```

## Interactivity & Behavior

### Animation State Management

```dart
class StateManagedFadeIn extends StatefulWidget {
  @override
  State<StateManagedFadeIn> createState() => _StateManagedFadeInState();
}

class _StateManagedFadeInState extends State<StateManagedFadeIn> {
  final GlobalKey<FadeInState> _fadeKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FadeIn(
          key: _fadeKey,
          child: YourContent(),
          onComplete: _onFadeComplete,
          onCancel: _onFadeCancel,
        ),
        ElevatedButton(
          onPressed: _checkAnimationState,
          child: Text('Check State'),
        ),
      ],
    );
  }

  void _onFadeComplete() {
    print('Fade animation completed successfully');
    // Perform actions after animation completes
  }

  void _onFadeCancel() {
    print('Fade animation was cancelled');
    // Handle animation cancellation
  }

  void _checkAnimationState() {
    final state = _fadeKey.currentState;
    if (state != null) {
      print('Is animating: ${state.isAnimating}');
      print('Is completed: ${state.isCompleted}');
      print('Current opacity: ${state.opacity}');
    }
  }
}
```

### Programmatic Opacity Control

```dart
class OpacityControlExample extends StatefulWidget {
  @override
  State<OpacityControlExample> createState() => _OpacityControlExampleState();
}

class _OpacityControlExampleState extends State<OpacityControlExample> {
  final GlobalKey<FadeInState> _fadeKey = GlobalKey();
  double _currentOpacity = 0.0;

  void _setOpacity(double value) {
    _fadeKey.currentState?.setOpacity(value);
    setState(() {
      _currentOpacity = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FadeIn(
          key: _fadeKey,
          child: Container(
            height: 100,
            color: Colors.blue,
            child: Center(child: Text('Opacity: ${_currentOpacity.toStringAsFixed(2)}')),
          ),
          autoPlay: false,
        ),
        SizedBox(height: 20),
        Slider(
          value: _currentOpacity,
          onChanged: _setOpacity,
          min: 0.0,
          max: 1.0,
        ),
        Text('Drag slider to control opacity'),
      ],
    );
  }
}
```

## Accessibility Notes

### Respecting System Preferences

```dart
// Respect user's animation preferences (default)
FadeIn(
  child: Content(),
  respectSystemPreferences: true,
)

// Force animations for critical UX
FadeIn(
  child: ImportantAlert(),
  respectSystemPreferences: false, // Always animate
)
```

### Semantic Labels

While FadeIn doesn't have a built-in semantic label, you can wrap it with Semantics:

```dart
Semantics(
  label: 'Content loading animation',
  child: FadeIn(
    child: YourContent(),
  ),
)
```

## Integration Examples

### With Flutstrap Components

```dart
class AnimatedCardGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FSGrid(
      children: [
        FadeIn(
          child: FSCard(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Icon(Icons.star, size: 48, color: Colors.amber),
                  SizedBox(height: 8),
                  Text('Premium Feature', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  FSButton(
                    onPressed: () {},
                    child: Text('Learn More'),
                  ),
                ],
              ),
            ),
          ),
          duration: Duration(milliseconds: 600),
          delay: Duration(milliseconds: 200),
        ),
        // More animated cards...
      ],
    );
  }
}
```

### Loading States

```dart
class ContentLoader extends StatelessWidget {
  final bool isLoading;
  final Widget content;

  const ContentLoader({
    super.key,
    required this.isLoading,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Content
        FadeIn(
          child: content,
          duration: Duration(milliseconds: 400),
          autoPlay: !isLoading,
        ),

        // Loading overlay
        FadeIn(
          child: Container(
            color: Colors.black54,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
          duration: Duration(milliseconds: 300),
          autoPlay: isLoading,
        ),
      ],
    );
  }
}
```

### Sequential Animations

```dart
class SequentialFadeIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FadeIn(
          child: HeaderSection(),
          duration: Duration(milliseconds: 500),
          delay: Duration(milliseconds: 100),
          onComplete: () => print('Header appeared'),
        ),
        FadeIn(
          child: ContentSection(),
          duration: Duration(milliseconds: 600),
          delay: Duration(milliseconds: 300),
          onComplete: () => print('Content appeared'),
        ),
        FadeIn(
          child: ActionSection(),
          duration: Duration(milliseconds: 400),
          delay: Duration(milliseconds: 600),
          onComplete: () => print('Actions appeared'),
        ),
      ],
    );
  }
}
```

## Best Practices

### Performance Optimization

```dart
// ✅ GOOD: Use const children when possible
FadeIn(
  child: const MyStaticWidget(), // Const constructor
  duration: Duration(milliseconds: 400),
)

// ✅ GOOD: Avoid rebuilding during animation
class _OptimizedExampleState extends State<OptimizedExample> {
  final Widget _cachedChild = ExpensiveWidget();

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: _cachedChild, // Reuse same instance
      duration: Duration(milliseconds: 500),
    );
  }
}

// ❌ AVOID: Rebuilding child in build method
Widget build(BuildContext context) {
  return FadeIn(
    child: ExpensiveWidget(), // Rebuilt every time
  );
}
```

### Memory Management

```dart
class ManagedFadeIn extends StatefulWidget {
  @override
  State<ManagedFadeIn> createState() => _ManagedFadeInState();
}

class _ManagedFadeInState extends State<ManagedFadeIn> {
  final GlobalKey<FadeInState> _fadeKey = GlobalKey();

  @override
  void dispose() {
    // Stop any running animations
    _fadeKey.currentState?.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      key: _fadeKey,
      child: YourContent(),
    );
  }
}
```

## Troubleshooting

### Common Issues and Solutions

**Animation not playing**

```dart
// ✅ Check autoPlay and system preferences
FadeIn(
  child: YourWidget(),
  autoPlay: true, // Ensure auto-play is enabled
  respectSystemPreferences: false, // Force animation if needed
)

// ✅ Ensure widget is properly mounted
class _WorkingExampleState extends State<WorkingExample> {
  @override
  void initState() {
    super.initState();
    // Animation will start after widget is mounted
  }
}
```

**Animation completes immediately**

```dart
// ✅ Check duration value
FadeIn(
  child: YourWidget(),
  duration: Duration(milliseconds: 500), // Non-zero duration
  curve: Curves.easeOut, // Valid curve
)

// ✅ Ensure no conflicting animations
FadeIn(
  child: YourWidget(),
  autoPlay: true,
  // Only one auto-playing animation per widget
)
```

**Memory leaks**

```dart
// ✅ Always dispose controllers in StatefulWidget
@override
void dispose() {
  _fadeKey.currentState?.stop(); // Stop animations
  super.dispose();
}

// ✅ Use maintainState: false for large widgets
FadeIn(
  child: LargeWidget(),
  maintainState: false, // Don't keep state when invisible
)
```

## Full Example

### Complete Animated Product Card

```dart
import 'package:flutter/material.dart';
import 'package:flutstrap/flutstrap.dart';

class AnimatedProductCard extends StatelessWidget {
  final Product product;
  final bool isNew;

  const AnimatedProductCard({
    super.key,
    required this.product,
    this.isNew = false,
  });

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      duration: Duration(milliseconds: 600),
      delay: isNew ? Duration(milliseconds: 300) : Duration.zero,
      curve: isNew ? Curves.elasticOut : Curves.easeOut,
      onComplete: isNew ? () => _showNewBadge(context) : null,
      child: FSCard(
        elevation: 4,
        margin: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image with badge
            Stack(
              children: [
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(product.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                if (isNew)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: FadeInBounce(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'NEW',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            // Product info
            Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeIn(
                    child: Text(
                      product.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    duration: Duration(milliseconds: 400),
                    delay: Duration(milliseconds: 200),
                  ),

                  SizedBox(height: 4),

                  FadeIn(
                    child: Text(
                      product.category,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                    duration: Duration(milliseconds: 400),
                    delay: Duration(milliseconds: 300),
                  ),

                  SizedBox(height: 8),

                  FadeIn(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${product.price}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade700,
                          ),
                        ),
                        FSButton(
                          onPressed: () => _addToCart(product),
                          child: Text('Add to Cart'),
                        ),
                      ],
                    ),
                    duration: Duration(milliseconds: 500),
                    delay: Duration(milliseconds: 400),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showNewBadge(BuildContext context) {
    // Could show a tooltip or perform other actions
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('New product added!')),
    );
  }

  void _addToCart(Product product) {
    // Add to cart logic
    print('Added ${product.name} to cart');
  }
}

class Product {
  final String name;
  final String category;
  final double price;
  final String imageUrl;

  Product({
    required this.name,
    required this.category,
    required this.price,
    required this.imageUrl,
  });
}
```

This comprehensive FadeIn animation system provides powerful, flexible, and performance-optimized fade animations that integrate seamlessly with the Flutstrap ecosystem while maintaining excellent developer experience and user accessibility.
