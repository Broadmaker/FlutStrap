# Flutstrap SlideTransition Animation Guide

## Introduction

The Flutstrap SlideTransition provides a high-performance widget that smoothly slides its child into position from specified directions. It features theme integration, memory optimization, flexible configuration options, and comprehensive state management for creating dynamic entrance animations.

### What It Does

- Slides widgets into view from 8 different directions
- Integrates with Flutstrap's theme system
- Provides manual animation control methods
- Includes performance optimizations and error handling
- Offers pre-configured animation variations

### When to Use

- Creating page transitions and navigation animations
- Building modal dialogs and overlays
- Implementing list item entrances
- Adding directional animations to UI elements

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

### Simple SlideTransition

```dart
FSSlideTransition(
  child: Container(
    width: 200,
    height: 200,
    color: Colors.blue,
    child: Center(child: Text('Sliding In!')),
  ),
  direction: FSSlideDirection.fromBottom,
  duration: Duration(milliseconds: 500),
  delay: Duration(milliseconds: 200),
)
```

### Themed SlideTransition

```dart
FSSlideTransition.themed(
  context: context,
  child: YourWidget(),
  direction: FSSlideDirection.fromRight,
  delay: Duration(milliseconds: 300),
  onComplete: () => print('Slide animation completed!'),
)
```

### Quick SlideTransition

```dart
FSSlideTransitionQuick(
  child: Text('Quick slide!'),
  direction: FSSlideDirection.fromLeft,
  delay: Duration(milliseconds: 100),
)
```

## Component Variants

### Pre-configured SlideTransition Variations

#### FSSlideTransitionQuick

300ms duration for fast, responsive animations

```dart
FSSlideTransitionQuick(
  child: NotificationBadge(),
  direction: FSSlideDirection.fromTop,
  onComplete: () => print('Notification appeared'),
)
```

#### FSSlideTransitionStandard

500ms duration for balanced animations

```dart
FSSlideTransitionStandard(
  child: ContentCard(),
  direction: FSSlideDirection.fromBottom,
  delay: Duration(milliseconds: 150),
)
```

#### FSSlideTransitionSlow

800ms duration for prominent animations

```dart
FSSlideTransitionSlow(
  child: HeroSection(),
  direction: FSSlideDirection.fromLeft,
  onComplete: () => _startContentAnimation(),
)
```

#### FSSlideTransitionBounce

Bounce curve for playful top-entry animations

```dart
FSSlideTransitionBounce(
  child: CelebrationMessage(),
  duration: Duration(milliseconds: 600),
)
```

#### FSSlideTransitionElastic

Elastic curve for attention-grabbing right-entry animations

```dart
FSSlideTransitionElastic(
  child: ImportantAlert(),
  duration: Duration(milliseconds: 800),
)
```

#### FSSlideTransitionPage

Optimized for page transitions (400ms, easeInOut)

```dart
FSSlideTransitionPage(
  child: NextPageContent(),
  onComplete: () => print('Page transition complete'),
)
```

## Properties & Parameters

### FSSlideTransition Parameters

| Parameter                  | Type               | Default          | Description                         |
| -------------------------- | ------------------ | ---------------- | ----------------------------------- |
| `child`                    | `Widget`           | **Required**     | Widget to animate                   |
| `direction`                | `FSSlideDirection` | `fromBottom`     | Slide direction                     |
| `duration`                 | `Duration`         | `500ms`          | Animation duration                  |
| `delay`                    | `Duration`         | `0ms`            | Delay before animation starts       |
| `curve`                    | `Curve`            | `Curves.easeOut` | Animation timing curve              |
| `autoPlay`                 | `bool`             | `true`           | Start animation automatically       |
| `onComplete`               | `VoidCallback?`    | `null`           | Called when animation completes     |
| `onCancel`                 | `VoidCallback?`    | `null`           | Called if animation is interrupted  |
| `offsetFraction`           | `double`           | `1.0`            | Slide distance multiplier (0.0-2.0) |
| `maintainState`            | `bool`             | `true`           | Keep widget state when off-screen   |
| `respectSystemPreferences` | `bool`             | `true`           | Respect system animation settings   |

### FSSlideDirection Options

| Direction         | Description                | Use Case                    |
| ----------------- | -------------------------- | --------------------------- |
| `fromTop`         | Slides down from top       | Notifications, headers      |
| `fromBottom`      | Slides up from bottom      | Action sheets, footers      |
| `fromLeft`        | Slides in from left        | Page transitions, menus     |
| `fromRight`       | Slides in from right       | Page transitions, dialogs   |
| `fromTopLeft`     | Diagonal from top-left     | Attention-grabbing elements |
| `fromTopRight`    | Diagonal from top-right    | Attention-grabbing elements |
| `fromBottomLeft`  | Diagonal from bottom-left  | Secondary content           |
| `fromBottomRight` | Diagonal from bottom-right | Secondary content           |

## Customization

### Custom Directions and Offsets

```dart
FSSlideTransition(
  child: CustomWidget(),
  direction: FSSlideDirection.fromTopRight,
  duration: Duration(milliseconds: 750),
  curve: Curves.easeInOutBack,
  offsetFraction: 1.5, // Slide 1.5x the normal distance
  delay: Duration(milliseconds: 500),
)
```

### Manual Animation Control

```dart
class ControlledSlideTransition extends StatefulWidget {
  @override
  State<ControlledSlideTransition> createState() => _ControlledSlideTransitionState();
}

class _ControlledSlideTransitionState extends State<ControlledSlideTransition> {
  final GlobalKey<FSSlideTransitionState> _slideKey = GlobalKey();

  void _handleButtonPress() async {
    // Manually control the animation
    await _slideKey.currentState?.play();

    // Wait then slide out
    await Future.delayed(Duration(seconds: 2));
    await _slideKey.currentState?.reverse();
  }

  void _resetAnimation() {
    _slideKey.currentState?.reset();
  }

  void _setAnimationValue(double value) {
    _slideKey.currentState?.setValue(value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FSSlideTransition(
          key: _slideKey,
          child: Container(
            padding: EdgeInsets.all(20),
            color: Colors.green,
            child: Text('Controlled Slide'),
          ),
          direction: FSSlideDirection.fromLeft,
          autoPlay: false, // Manual control
        ),
        SizedBox(height: 20),
        Row(
          children: [
            ElevatedButton(
              onPressed: _handleButtonPress,
              child: Text('Slide In/Out'),
            ),
            ElevatedButton(
              onPressed: _resetAnimation,
              child: Text('Reset'),
            ),
          ],
        ),
        Slider(
          value: 0.0,
          onChanged: _setAnimationValue,
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
class StateManagedSlideTransition extends StatefulWidget {
  @override
  State<StateManagedSlideTransition> createState() => _StateManagedSlideTransitionState();
}

class _StateManagedSlideTransitionState extends State<StateManagedSlideTransition> {
  final GlobalKey<FSSlideTransitionState> _slideKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FSSlideTransition(
          key: _slideKey,
          child: YourContent(),
          direction: FSSlideDirection.fromBottom,
          onComplete: _onSlideComplete,
          onCancel: _onSlideCancel,
        ),
        ElevatedButton(
          onPressed: _checkAnimationState,
          child: Text('Check State'),
        ),
      ],
    );
  }

  void _onSlideComplete() {
    print('Slide animation completed successfully');
    // Perform actions after animation completes
  }

  void _onSlideCancel() {
    print('Slide animation was cancelled');
    // Handle animation cancellation
  }

  void _checkAnimationState() {
    final state = _slideKey.currentState;
    if (state != null) {
      print('Is animating: ${state.isAnimating}');
      print('Is completed: ${state.isCompleted}');
      print('Current offset: ${state.offset}');
    }
  }
}
```

### Complex Directional Animations

```dart
class MultiDirectionSlide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header slides from top
        FSSlideTransition(
          child: HeaderSection(),
          direction: FSSlideDirection.fromTop,
          duration: Duration(milliseconds: 400),
          curve: Curves.easeOut,
        ),

        // Content slides from left and right alternately
        Row(
          children: [
            Expanded(
              child: FSSlideTransition(
                child: LeftContent(),
                direction: FSSlideDirection.fromLeft,
                duration: Duration(milliseconds: 500),
                delay: Duration(milliseconds: 200),
              ),
            ),
            Expanded(
              child: FSSlideTransition(
                child: RightContent(),
                direction: FSSlideDirection.fromRight,
                duration: Duration(milliseconds: 500),
                delay: Duration(milliseconds: 400),
              ),
            ),
          ],
        ),

        // Footer slides from bottom
        FSSlideTransition(
          child: FooterSection(),
          direction: FSSlideDirection.fromBottom,
          duration: Duration(milliseconds: 400),
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
FSSlideTransition(
  child: Content(),
  respectSystemPreferences: true,
)

// Force animations for critical UX
FSSlideTransition(
  child: ImportantNotification(),
  respectSystemPreferences: false, // Always animate
)
```

### Semantic Labels

Wrap with Semantics for better accessibility:

```dart
Semantics(
  label: 'Content sliding into view from bottom',
  child: FSSlideTransition(
    child: YourContent(),
    direction: FSSlideDirection.fromBottom,
  ),
)
```

## Integration Examples

### With Flutstrap Components

```dart
class AnimatedModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FSSlideTransition(
      child: FSModal(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, size: 64, color: Colors.green),
              SizedBox(height: 16),
              Text('Success!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('Your action was completed successfully.'),
              SizedBox(height: 24),
              FSButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Close'),
              ),
            ],
          ),
        ),
      ),
      direction: FSSlideDirection.fromBottom,
      duration: Duration(milliseconds: 400),
      curve: Curves.easeOutBack,
    );
  }
}
```

### Page Transitions

```dart
class SlidePageRoute extends PageRouteBuilder {
  final Widget page;

  SlidePageRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FSSlideTransition(
              child: child,
              direction: FSSlideDirection.fromRight,
              autoPlay: false,
            );
          },
          transitionDuration: Duration(milliseconds: 400),
        );
}

// Usage
Navigator.push(context, SlidePageRoute(page: NextPage()));
```

### List Item Animations

```dart
class AnimatedListView extends StatelessWidget {
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return FSSlideTransition(
          child: ListTile(
            leading: Icon(Icons.arrow_forward),
            title: Text(items[index]),
            onTap: () => _handleItemTap(index),
          ),
          direction: index.isEven ? FSSlideDirection.fromLeft : FSSlideDirection.fromRight,
          duration: Duration(milliseconds: 400),
          delay: Duration(milliseconds: 100 * index),
          curve: Curves.easeOut,
        );
      },
    );
  }

  void _handleItemTap(int index) {
    print('Tapped item: $index');
  }
}
```

## Best Practices

### Performance Optimization

```dart
// ✅ GOOD: Use const children when possible
FSSlideTransition(
  child: const MyStaticWidget(), // Const constructor
  duration: Duration(milliseconds: 400),
)

// ✅ GOOD: Adjust offsetFraction for performance
FSSlideTransition(
  child: LargeWidget(),
  offsetFraction: 0.5, // Shorter slide distance
  maintainState: false, // Don't maintain off-screen state
)

// ❌ AVOID: Large offset fractions with complex widgets
FSSlideTransition(
  child: ComplexWidget(),
  offsetFraction: 2.0, // Very long slide distance
  // This can cause performance issues
)
```

### Memory Management

```dart
class ManagedSlideTransition extends StatefulWidget {
  @override
  State<ManagedSlideTransition> createState() => _ManagedSlideTransitionState();
}

class _ManagedSlideTransitionState extends State<ManagedSlideTransition> {
  final GlobalKey<FSSlideTransitionState> _slideKey = GlobalKey();

  @override
  void dispose() {
    // Stop any running animations
    _slideKey.currentState?.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FSSlideTransition(
      key: _slideKey,
      child: YourContent(),
      direction: FSSlideDirection.fromBottom,
    );
  }
}
```

## Troubleshooting

### Common Issues and Solutions

**Animation not playing**

```dart
// ✅ Check autoPlay and system preferences
FSSlideTransition(
  child: YourWidget(),
  autoPlay: true, // Ensure auto-play is enabled
  respectSystemPreferences: false, // Force animation if needed
)

// ✅ Ensure offsetFraction is within valid range
FSSlideTransition(
  child: YourWidget(),
  offsetFraction: 1.0, // Valid range: 0.0 to 2.0
)
```

**Animation completes immediately**

```dart
// ✅ Check duration value
FSSlideTransition(
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

**Animation direction issues**

```dart
// ✅ Verify direction enum values
FSSlideTransition(
  child: YourWidget(),
  direction: FSSlideDirection.fromLeft, // Correct enum value
  // Not: FSSlideDirection.left (incorrect)
)

// ✅ Check offsetFraction for subtle adjustments
FSSlideTransition(
  child: YourWidget(),
  direction: FSSlideDirection.fromTop,
  offsetFraction: 0.3, // Shorter slide for subtle effect
)
```

## Full Example

### Complete Animated Dashboard

```dart
import 'package:flutter/material.dart';
import 'package:flutstrap/flutstrap.dart';

class AnimatedDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FSSlideTransition(
          child: Text('Dashboard'),
          direction: FSSlideDirection.fromTop,
          duration: Duration(milliseconds: 500),
        ),
        backgroundColor: Colors.blue.shade700,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stats overview with staggered slides
            FSSlideTransition(
              child: Text('Overview', style: Theme.of(context).textTheme.headline5),
              direction: FSSlideDirection.fromLeft,
              duration: Duration(milliseconds: 400),
            ),
            SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              childAspectRatio: 1.5,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                FSSlideTransition(
                  child: _buildStatCard('Revenue', '\$12,456', Icons.attach_money, Colors.green),
                  direction: FSSlideDirection.fromLeft,
                  duration: Duration(milliseconds: 500),
                  delay: Duration(milliseconds: 100),
                ),
                FSSlideTransition(
                  child: _buildStatCard('Users', '1,234', Icons.people, Colors.blue),
                  direction: FSSlideDirection.fromRight,
                  duration: Duration(milliseconds: 500),
                  delay: Duration(milliseconds: 200),
                ),
                FSSlideTransition(
                  child: _buildStatCard('Orders', '567', Icons.shopping_cart, Colors.orange),
                  direction: FSSlideDirection.fromLeft,
                  duration: Duration(milliseconds: 500),
                  delay: Duration(milliseconds: 300),
                ),
                FSSlideTransition(
                  child: _buildStatCard('Growth', '+23%', Icons.trending_up, Colors.purple),
                  direction: FSSlideDirection.fromRight,
                  duration: Duration(milliseconds: 500),
                  delay: Duration(milliseconds: 400),
                ),
              ],
            ),

            SizedBox(height: 32),

            // Recent activity with slide-up animation
            FSSlideTransition(
              child: Text('Recent Activity', style: Theme.of(context).textTheme.headline5),
              direction: FSSlideDirection.fromLeft,
              duration: Duration(milliseconds: 400),
              delay: Duration(milliseconds: 500),
            ),
            SizedBox(height: 16),
            FSSlideTransition(
              child: _buildActivityList(),
              direction: FSSlideDirection.fromBottom,
              duration: Duration(milliseconds: 600),
              delay: Duration(milliseconds: 600),
              curve: Curves.easeOutBack,
            ),

            SizedBox(height: 32),

            // Quick actions with elastic slide
            FSSlideTransition(
              child: Text('Quick Actions', style: Theme.of(context).textTheme.headline5),
              direction: FSSlideDirection.fromLeft,
              duration: Duration(milliseconds: 400),
              delay: Duration(milliseconds: 700),
            ),
            SizedBox(height: 16),
            FSSlideTransitionElastic(
              child: _buildActionButtons(),
              delay: Duration(milliseconds: 800),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 32),
            SizedBox(height: 8),
            Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text(title, style: TextStyle(color: Colors.grey.shade600)),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityList() {
    final activities = [
      'New user registration',
      'Order #1234 completed',
      'Payment received',
      'Product review added',
      'System update completed',
    ];

    return Card(
      child: Column(
        children: activities.map((activity) => ListTile(
          leading: Icon(Icons.circle, color: Colors.green, size: 12),
          title: Text(activity),
          trailing: Icon(Icons.chevron_right),
        )).toList(),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: FSButton(
            onPressed: () => _handleAction('Report'),
            child: Text('Generate Report'),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: FSButton(
            onPressed: () => _handleAction('Settings'),
            child: Text('Settings'),
          ),
        ),
      ],
    );
  }

  void _handleAction(String action) {
    print('Action: $action');
  }
}
```

This comprehensive SlideTransition animation system provides powerful, flexible, and performance-optimized slide animations that integrate seamlessly with the Flutstrap ecosystem while maintaining excellent developer experience and user accessibility.
