# Flutstrap Scale Animation Guide

## Introduction

The Flutstrap ScaleAnimation provides a high-performance widget that smoothly scales its child with customizable animations. It features theme integration, memory optimization, flexible configuration options, and comprehensive state management for creating dynamic scaling animations.

### What It Does

- Scales widgets with smooth animations from any starting to ending scale
- Integrates with Flutstrap's theme system
- Provides manual animation control methods including pulse effects
- Includes performance optimizations and error handling
- Offers pre-configured animation variations including pop effects

### When to Use

- Creating zoom-in/zoom-out animations
- Building attention-grabbing pop effects
- Implementing hover states and interactive feedback
- Adding scale transitions to UI elements

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

### Simple Scale Animation

```dart
FSScaleAnimation(
  child: Container(
    width: 200,
    height: 200,
    color: Colors.blue,
    child: Center(child: Text('Scaling In!')),
  ),
  beginScale: 0.0,
  endScale: 1.0,
  duration: Duration(milliseconds: 500),
  delay: Duration(milliseconds: 200),
)
```

### Themed Scale Animation

```dart
FSScaleAnimation.themed(
  context: context,
  child: YourWidget(),
  beginScale: 0.5,
  endScale: 1.2,
  delay: Duration(milliseconds: 300),
  onComplete: () => print('Scale animation completed!'),
)
```

### Quick Scale Animation

```dart
FSScaleAnimationQuick(
  child: Text('Quick scale!'),
  beginScale: 0.8,
  endScale: 1.0,
  delay: Duration(milliseconds: 100),
)
```

## Component Variants

### Pre-configured Scale Animation Variations

#### FSScaleAnimationQuick

300ms duration for fast, responsive animations

```dart
FSScaleAnimationQuick(
  child: InteractiveButton(),
  beginScale: 0.9,
  endScale: 1.0,
  onComplete: () => print('Button scaled in'),
)
```

#### FSScaleAnimationStandard

500ms duration for balanced animations

```dart
FSScaleAnimationStandard(
  child: ContentCard(),
  beginScale: 0.0,
  endScale: 1.0,
  delay: Duration(milliseconds: 150),
)
```

#### FSScaleAnimationSlow

800ms duration for prominent animations

```dart
FSScaleAnimationSlow(
  child: HeroElement(),
  beginScale: 0.5,
  endScale: 1.0,
  onComplete: () => _startNextAnimation(),
)
```

#### FSScaleAnimationBounce

Bounce curve with overshoot effect

```dart
FSScaleAnimationBounce(
  child: CelebrationElement(),
  beginScale: 0.0,
  endScale: 1.1, // Overshoots then settles
  duration: Duration(milliseconds: 600),
)
```

#### FSScaleAnimationElastic

Elastic curve for stretchy effects

```dart
FSScaleAnimationElastic(
  child: AttentionGrabber(),
  beginScale: 0.0,
  endScale: 1.0,
  duration: Duration(milliseconds: 800),
)
```

#### FSScaleAnimationPop

Pop-in animation (0.0 → 1.1 → 1.0)

```dart
FSScaleAnimationPop(
  child: NotificationBadge(),
  duration: Duration(milliseconds: 400),
  onComplete: () => print('Pop animation complete'),
)
```

## Properties & Parameters

### FSScaleAnimation Parameters

| Parameter                  | Type            | Default            | Description                        |
| -------------------------- | --------------- | ------------------ | ---------------------------------- |
| `child`                    | `Widget`        | **Required**       | Widget to animate                  |
| `beginScale`               | `double`        | `0.0`              | Starting scale (0.0 = invisible)   |
| `endScale`                 | `double`        | `1.0`              | Ending scale (1.0 = normal size)   |
| `duration`                 | `Duration`      | `500ms`            | Animation duration                 |
| `delay`                    | `Duration`      | `0ms`              | Delay before animation starts      |
| `curve`                    | `Curve`         | `Curves.easeOut`   | Animation timing curve             |
| `alignment`                | `Alignment`     | `Alignment.center` | Scale transformation origin        |
| `autoPlay`                 | `bool`          | `true`             | Start animation automatically      |
| `onComplete`               | `VoidCallback?` | `null`             | Called when animation completes    |
| `onCancel`                 | `VoidCallback?` | `null`             | Called if animation is interrupted |
| `maintainState`            | `bool`          | `true`             | Keep widget state when scaled down |
| `respectSystemPreferences` | `bool`          | `true`             | Respect system animation settings  |

### Alignment Options

| Alignment               | Description             | Use Case          |
| ----------------------- | ----------------------- | ----------------- |
| `Alignment.center`      | Scale from center       | Default, balanced |
| `Alignment.topLeft`     | Scale from top-left     | Context menus     |
| `Alignment.topRight`    | Scale from top-right    | Notifications     |
| `Alignment.bottomLeft`  | Scale from bottom-left  | Tooltips          |
| `Alignment.bottomRight` | Scale from bottom-right | Action buttons    |
| `Alignment.centerLeft`  | Scale from left         | Sidebars          |
| `Alignment.centerRight` | Scale from right        | Panels            |

## Customization

### Custom Scale Ranges and Alignment

```dart
FSScaleAnimation(
  child: CustomWidget(),
  beginScale: 0.5,    // Start at half size
  endScale: 1.5,      // End at 1.5x size
  alignment: Alignment.topLeft, // Scale from top-left corner
  duration: Duration(milliseconds: 750),
  curve: Curves.easeInOutBack,
  delay: Duration(milliseconds: 500),
)
```

### Manual Animation Control

```dart
class ControlledScaleAnimation extends StatefulWidget {
  @override
  State<ControlledScaleAnimation> createState() => _ControlledScaleAnimationState();
}

class _ControlledScaleAnimationState extends State<ControlledScaleAnimation> {
  final GlobalKey<FSScaleAnimationState> _scaleKey = GlobalKey();

  void _handleButtonPress() async {
    // Manually control the animation
    await _scaleKey.currentState?.play();

    // Wait then scale down
    await Future.delayed(Duration(seconds: 2));
    await _scaleKey.currentState?.reverse();
  }

  void _handlePulse() async {
    // Pulse animation (scale up and down)
    await _scaleKey.currentState?.pulse(count: 2, pulseScale: 1.2);
  }

  void _resetAnimation() {
    _scaleKey.currentState?.reset();
  }

  void _setScale(double value) {
    _scaleKey.currentState?.setScale(value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FSScaleAnimation(
          key: _scaleKey,
          child: Container(
            padding: EdgeInsets.all(20),
            color: Colors.orange,
            child: Text('Controlled Scale'),
          ),
          beginScale: 0.5,
          endScale: 1.0,
          autoPlay: false, // Manual control
        ),
        SizedBox(height: 20),
        Row(
          children: [
            ElevatedButton(
              onPressed: _handleButtonPress,
              child: Text('Scale In/Out'),
            ),
            ElevatedButton(
              onPressed: _handlePulse,
              child: Text('Pulse'),
            ),
            ElevatedButton(
              onPressed: _resetAnimation,
              child: Text('Reset'),
            ),
          ],
        ),
        Slider(
          value: 0.5,
          onChanged: _setScale,
          min: 0.0,
          max: 1.0,
        ),
      ],
    );
  }
}
```

## Interactivity & Behavior

### Animation State Management

```dart
class StateManagedScaleAnimation extends StatefulWidget {
  @override
  State<StateManagedScaleAnimation> createState() => _StateManagedScaleAnimationState();
}

class _StateManagedScaleAnimationState extends State<StateManagedScaleAnimation> {
  final GlobalKey<FSScaleAnimationState> _scaleKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FSScaleAnimation(
          key: _scaleKey,
          child: YourContent(),
          beginScale: 0.0,
          endScale: 1.0,
          onComplete: _onScaleComplete,
          onCancel: _onScaleCancel,
        ),
        ElevatedButton(
          onPressed: _checkAnimationState,
          child: Text('Check State'),
        ),
      ],
    );
  }

  void _onScaleComplete() {
    print('Scale animation completed successfully');
    // Perform actions after animation completes
  }

  void _onScaleCancel() {
    print('Scale animation was cancelled');
    // Handle animation cancellation
  }

  void _checkAnimationState() {
    final state = _scaleKey.currentState;
    if (state != null) {
      print('Is animating: ${state.isAnimating}');
      print('Is completed: ${state.isCompleted}');
      print('Current scale: ${state.scale}');
    }
  }
}
```

### Advanced Scale Effects

```dart
class MultiScaleAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Scale from center (default)
        FSScaleAnimation(
          child: CenterCard(),
          beginScale: 0.0,
          endScale: 1.0,
          duration: Duration(milliseconds: 400),
        ),

        // Scale from top-left for context menu effect
        FSScaleAnimation(
          child: ContextMenu(),
          beginScale: 0.0,
          endScale: 1.0,
          alignment: Alignment.topLeft,
          duration: Duration(milliseconds: 300),
          delay: Duration(milliseconds: 200),
        ),

        // Scale up for emphasis
        FSScaleAnimation(
          child: ImportantNotice(),
          beginScale: 1.0,
          endScale: 1.1,
          duration: Duration(milliseconds: 500),
          delay: Duration(milliseconds: 400),
          curve: Curves.elasticOut,
        ),

        // Pop animation for notifications
        FSScaleAnimationPop(
          child: NewNotification(),
          delay: Duration(milliseconds: 600),
        ),
      ],
    );
  }
}
```

## Accessibility Notes

### Respecting System Preferences

```dart
// Respect user's animation preferences (default)
FSScaleAnimation(
  child: Content(),
  respectSystemPreferences: true,
)

// Force animations for critical UX
FSScaleAnimation(
  child: ImportantAlert(),
  respectSystemPreferences: false, // Always animate
)
```

### Semantic Labels

Wrap with Semantics for better accessibility:

```dart
Semantics(
  label: 'Content scaling into view',
  child: FSScaleAnimation(
    child: YourContent(),
    beginScale: 0.0,
    endScale: 1.0,
  ),
)
```

## Integration Examples

### With Flutstrap Components

```dart
class AnimatedButtonWithScale extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FSScaleAnimation(
      child: FSButton(
        onPressed: () => _handleAction(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add),
            SizedBox(width: 8),
            Text('Add Item'),
          ],
        ),
      ),
      beginScale: 0.8,
      endScale: 1.0,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOutBack,
    );
  }

  void _handleAction() {
    print('Button pressed with scale animation');
  }
}
```

### Interactive Hover Effects

```dart
class HoverScaleCard extends StatefulWidget {
  @override
  State<HoverScaleCard> createState() => _HoverScaleCardState();
}

class _HoverScaleCardState extends State<HoverScaleCard> {
  final GlobalKey<FSScaleAnimationState> _scaleKey = GlobalKey();
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _handleHoverStart(),
      onExit: (_) => _handleHoverEnd(),
      child: FSScaleAnimation(
        key: _scaleKey,
        child: FSCard(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Icon(Icons.star, size: 48, color: Colors.amber),
                SizedBox(height: 8),
                Text('Hover over me!'),
                SizedBox(height: 8),
                Text('I scale up on hover'),
              ],
            ),
          ),
        ),
        beginScale: 1.0,
        endScale: 1.0, // Initial state
        autoPlay: false,
      ),
    );
  }

  void _handleHoverStart() async {
    setState(() => _isHovering = true);
    await _scaleKey.currentState?.setScale(1.05); // Scale up slightly
  }

  void _handleHoverEnd() async {
    setState(() => _isHovering = false);
    await _scaleKey.currentState?.setScale(1.0); // Return to normal
  }
}
```

### Loading States with Scale

```dart
class ScaleLoadingIndicator extends StatelessWidget {
  final bool isLoading;

  const ScaleLoadingIndicator({
    super.key,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return FSScaleAnimation(
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(strokeWidth: 2),
            SizedBox(width: 12),
            Text('Loading...'),
          ],
        ),
      ),
      beginScale: isLoading ? 0.0 : 1.0,
      endScale: isLoading ? 1.0 : 0.0,
      duration: Duration(milliseconds: 300),
      autoPlay: true,
      maintainState: false,
    );
  }
}
```

## Best Practices

### Performance Optimization

```dart
// ✅ GOOD: Use const children when possible
FSScaleAnimation(
  child: const MyStaticWidget(), // Const constructor
  duration: Duration(milliseconds: 400),
)

// ✅ GOOD: Adjust maintainState for performance
FSScaleAnimation(
  child: LargeWidget(),
  beginScale: 0.0,
  maintainState: false, // Don't maintain off-screen state
)

// ❌ AVOID: Extreme scale values with complex widgets
FSScaleAnimation(
  child: ComplexWidget(),
  beginScale: 0.0,
  endScale: 2.0, // Very large scale can cause performance issues
)
```

### Memory Management

```dart
class ManagedScaleAnimation extends StatefulWidget {
  @override
  State<ManagedScaleAnimation> createState() => _ManagedScaleAnimationState();
}

class _ManagedScaleAnimationState extends State<ManagedScaleAnimation> {
  final GlobalKey<FSScaleAnimationState> _scaleKey = GlobalKey();

  @override
  void dispose() {
    // Stop any running animations
    _scaleKey.currentState?.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FSScaleAnimation(
      key: _scaleKey,
      child: YourContent(),
      beginScale: 0.0,
      endScale: 1.0,
    );
  }
}
```

## Troubleshooting

### Common Issues and Solutions

**Animation not playing**

```dart
// ✅ Check autoPlay and system preferences
FSScaleAnimation(
  child: YourWidget(),
  autoPlay: true, // Ensure auto-play is enabled
  respectSystemPreferences: false, // Force animation if needed
)

// ✅ Ensure scale values are valid
FSScaleAnimation(
  child: YourWidget(),
  beginScale: 0.0, // Valid: >= 0.0
  endScale: 1.0,   // Valid: >= 0.0
)
```

**Animation completes immediately**

```dart
// ✅ Check duration value
FSScaleAnimation(
  child: YourWidget(),
  duration: Duration(milliseconds: 500), // Non-zero duration
  curve: Curves.easeOut, // Valid curve
)

// ✅ Ensure proper widget mounting
class _WorkingExampleState extends State<WorkingExample> {
  @override
  void initState() {
    super.initState();
    // Animation will start after widget is mounted
  }
}
```

**Scale alignment issues**

```dart
// ✅ Verify alignment values
FSScaleAnimation(
  child: YourWidget(),
  alignment: Alignment.topLeft, // Correct enum value
  // Not: Alignment.top-left (incorrect)
)

// ✅ Use appropriate alignment for your use case
FSScaleAnimation(
  child: TooltipWidget(),
  alignment: Alignment.bottomRight, // Scales from bottom-right
  beginScale: 0.0,
  endScale: 1.0,
)
```

## Full Example

### Complete Animated Dashboard with Scale Effects

```dart
import 'package:flutter/material.dart';
import 'package:flutstrap/flutstrap.dart';

class ScaledDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FSScaleAnimation(
          child: Text('Scaled Dashboard'),
          beginScale: 0.5,
          endScale: 1.0,
          duration: Duration(milliseconds: 600),
        ),
        backgroundColor: Colors.purple.shade700,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome message with pop effect
            FSScaleAnimationPop(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Icon(Icons.waving_hand, size: 48, color: Colors.amber),
                      SizedBox(height: 8),
                      Text('Welcome Back!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      Text('Here\'s your overview'),
                    ],
                  ),
                ),
              ),
              duration: Duration(milliseconds: 500),
            ),

            SizedBox(height: 24),

            // Stats cards with staggered scale
            FSScaleAnimation(
              child: Text('Statistics', style: Theme.of(context).textTheme.headline5),
              beginScale: 0.8,
              endScale: 1.0,
              duration: Duration(milliseconds: 400),
              delay: Duration(milliseconds: 200),
            ),
            SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              childAspectRatio: 1.3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                FSScaleAnimation(
                  child: _buildStatCard('Revenue', '\$12,456', Icons.attach_money, Colors.green),
                  beginScale: 0.0,
                  endScale: 1.0,
                  duration: Duration(milliseconds: 500),
                  delay: Duration(milliseconds: 300),
                ),
                FSScaleAnimation(
                  child: _buildStatCard('Users', '1,234', Icons.people, Colors.blue),
                  beginScale: 0.0,
                  endScale: 1.0,
                  duration: Duration(milliseconds: 500),
                  delay: Duration(milliseconds: 400),
                ),
                FSScaleAnimation(
                  child: _buildStatCard('Orders', '567', Icons.shopping_cart, Colors.orange),
                  beginScale: 0.0,
                  endScale: 1.0,
                  duration: Duration(milliseconds: 500),
                  delay: Duration(milliseconds: 500),
                ),
                FSScaleAnimation(
                  child: _buildStatCard('Growth', '+23%', Icons.trending_up, Colors.purple),
                  beginScale: 0.0,
                  endScale: 1.0,
                  duration: Duration(milliseconds: 500),
                  delay: Duration(milliseconds: 600),
                ),
              ],
            ),

            SizedBox(height: 32),

            // Quick actions with bounce scale
            FSScaleAnimation(
              child: Text('Quick Actions', style: Theme.of(context).textTheme.headline5),
              beginScale: 0.8,
              endScale: 1.0,
              duration: Duration(milliseconds: 400),
              delay: Duration(milliseconds: 700),
            ),
            SizedBox(height: 16),
            FSScaleAnimationBounce(
              child: _buildActionGrid(),
              delay: Duration(milliseconds: 800),
            ),

            SizedBox(height: 32),

            // Notifications with elastic scale
            FSScaleAnimation(
              child: Text('Notifications', style: Theme.of(context).textTheme.headline5),
              beginScale: 0.8,
              endScale: 1.0,
              duration: Duration(milliseconds: 400),
              delay: Duration(milliseconds: 900),
            ),
            SizedBox(height: 16),
            FSScaleAnimationElastic(
              child: _buildNotificationList(),
              delay: Duration(milliseconds: 1000),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 32),
            SizedBox(height: 8),
            Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text(title, style: TextStyle(color: Colors.grey.shade600)),
          ],
        ),
      ),
    );
  }

  Widget _buildActionGrid() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      childAspectRatio: 1.0,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      children: [
        _buildActionButton(Icons.add, 'Add', Colors.blue),
        _buildActionButton(Icons.edit, 'Edit', Colors.green),
        _buildActionButton(Icons.delete, 'Delete', Colors.red),
        _buildActionButton(Icons.share, 'Share', Colors.orange),
        _buildActionButton(Icons.download, 'Download', Colors.purple),
        _buildActionButton(Icons.settings, 'Settings', Colors.grey),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String label, Color color) {
    return FSScaleAnimation(
      child: Card(
        child: InkWell(
          onTap: () => _handleAction(label),
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: color, size: 24),
                SizedBox(height: 4),
                Text(label, style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
        ),
      ),
      beginScale: 0.0,
      endScale: 1.0,
      duration: Duration(milliseconds: 300),
    );
  }

  Widget _buildNotificationList() {
    final notifications = [
      'New message from John',
      'Your order has shipped',
      'System update available',
      'Meeting reminder at 2 PM',
    ];

    return Card(
      child: Column(
        children: notifications.asMap().entries.map((entry) {
          final index = entry.key;
          final notification = entry.value;
          return FSScaleAnimation(
            child: ListTile(
              leading: Icon(Icons.circle, color: Colors.blue, size: 8),
              title: Text(notification),
              trailing: Icon(Icons.chevron_right),
              onTap: () => _handleNotificationTap(index),
            ),
            beginScale: 0.0,
            endScale: 1.0,
            duration: Duration(milliseconds: 400),
            delay: Duration(milliseconds: 100 * index),
          );
        }).toList(),
      ),
    );
  }

  void _handleAction(String action) {
    print('Action: $action');
  }

  void _handleNotificationTap(int index) {
    print('Notification $index tapped');
  }
}
```

This comprehensive ScaleAnimation system provides powerful, flexible, and performance-optimized scaling animations that integrate seamlessly with the Flutstrap ecosystem while maintaining excellent developer experience and user accessibility.
