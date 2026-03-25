# Flutstrap Animation Sequences Guide

## Introduction

Flutstrap Animation Sequences provides powerful, pre-configured animation sequences and complex animation patterns for sophisticated UI interactions. These components make it easy to create stunning staggered animations, sequential reveals, and complex animation flows with minimal code.

### What It Does

- Provides staggered fade-in and slide-in animations for lists
- Enables complex sequential animation sequences
- Includes performance monitoring and error handling
- Supports system animation preferences

### When to Use

- Creating animated lists and grids
- Building onboarding flows and tutorials
- Implementing complex multi-step animations
- Adding polish to content reveals

### Prerequisites

- Flutter 3.0 or higher
- Flutstrap core library
- Basic understanding of animation concepts

## Installation & Setup

### Required Dependencies

```dart
import 'package:flutstrap/flutstrap.dart';
```

## Core Components

### FSStaggeredFadeIn

Creates beautiful staggered fade-in animations for lists of widgets.

#### Basic Usage

```dart
FSStaggeredFadeIn(
  children: [
    Card(child: Text('Item 1')),
    Card(child: Text('Item 2')),
    Card(child: Text('Item 3')),
    Card(child: Text('Item 4')),
  ],
  duration: Duration(milliseconds: 500),
  staggerDelay: Duration(milliseconds: 100),
  curve: Curves.easeOut,
)
```

#### Themed Usage

```dart
FSStaggeredFadeIn.themed(
  context: context,
  children: yourWidgets,
  staggerDelay: Duration(milliseconds: 150),
)
```

#### Convenience Methods

```dart
// Faster animation
FSStaggeredFadeIn(
  children: widgets,
).withFastAnimation()

// Slower animation
FSStaggeredFadeIn(
  children: widgets,
).withSlowAnimation()

// Custom copy
original.copyWith(
  duration: Duration(milliseconds: 800),
  staggerDelay: Duration(milliseconds: 200),
)
```

### FSStaggeredSlideIn

Creates staggered slide-in animations with customizable directions.

#### Basic Usage

```dart
FSStaggeredSlideIn(
  children: [
    Card(child: Text('Slide 1')),
    Card(child: Text('Slide 2')),
    Card(child: Text('Slide 3')),
  ],
  direction: FSSlideDirection.fromBottom,
  duration: Duration(milliseconds: 500),
  staggerDelay: Duration(milliseconds: 100),
  offsetFraction: 1.0,
)
```

#### Different Directions

```dart
// Slide from left
FSStaggeredSlideIn(
  direction: FSSlideDirection.fromLeft,
  children: widgets,
)

// Slide from top
FSStaggeredSlideIn(
  direction: FSSlideDirection.fromTop,
  children: widgets,
)

// Diagonal slide
FSStaggeredSlideIn(
  direction: FSSlideDirection.fromTopRight,
  children: widgets,
)
```

#### Themed Usage

```dart
FSStaggeredSlideIn.themed(
  context: context,
  children: yourWidgets,
  direction: FSSlideDirection.fromRight,
  staggerDelay: Duration(milliseconds: 120),
)
```

### FSSequentialAnimation

Creates complex sequential animations with precise timing control.

#### Basic Usage

```dart
FSSequentialAnimation(
  children: [
    HeaderWidget(),
    ContentWidget(),
    FooterWidget(),
  ],
  sequence: FSAnimationSequence(
    duration: Duration(milliseconds: 1500),
    curve: Curves.easeOut,
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
  ),
  onComplete: () => print('Animation complete!'),
  onStart: () => print('Animation starting...'),
)
```

#### Convenience Constructor

```dart
// Simple fade-in sequence
FSSequentialAnimation.fadeIn(
  children: [
    Text('Step 1'),
    Text('Step 2'),
    Text('Step 3'),
  ],
  stepDuration: Duration(milliseconds: 400),
  stepDelay: Duration(milliseconds: 200),
  curve: Curves.easeOut,
  onComplete: () => print('All items revealed!'),
)
```

## Properties & Parameters

### FSStaggeredFadeIn Parameters

| Parameter                  | Type           | Default          | Description                        |
| -------------------------- | -------------- | ---------------- | ---------------------------------- |
| `children`                 | `List<Widget>` | **Required**     | Widgets to animate                 |
| `duration`                 | `Duration`     | `500ms`          | Individual animation duration      |
| `staggerDelay`             | `Duration`     | `100ms`          | Delay between each animation       |
| `curve`                    | `Curve`        | `Curves.easeOut` | Animation timing curve             |
| `autoPlay`                 | `bool`         | `true`           | Start animation automatically      |
| `maintainState`            | `bool`         | `true`           | Keep widget state during animation |
| `semanticLabel`            | `String?`      | `null`           | Accessibility label                |
| `respectSystemPreferences` | `bool`         | `true`           | Respect system animation settings  |

### FSStaggeredSlideIn Parameters

| Parameter                  | Type               | Default          | Description                        |
| -------------------------- | ------------------ | ---------------- | ---------------------------------- |
| `children`                 | `List<Widget>`     | **Required**     | Widgets to animate                 |
| `direction`                | `FSSlideDirection` | `fromBottom`     | Slide direction                    |
| `duration`                 | `Duration`         | `500ms`          | Individual animation duration      |
| `staggerDelay`             | `Duration`         | `100ms`          | Delay between each animation       |
| `curve`                    | `Curve`            | `Curves.easeOut` | Animation timing curve             |
| `autoPlay`                 | `bool`             | `true`           | Start animation automatically      |
| `offsetFraction`           | `double`           | `1.0`            | Slide distance multiplier          |
| `maintainState`            | `bool`             | `true`           | Keep widget state during animation |
| `semanticLabel`            | `String?`          | `null`           | Accessibility label                |
| `respectSystemPreferences` | `bool`             | `true`           | Respect system animation settings  |

### FSSequentialAnimation Parameters

| Parameter                  | Type                  | Default      | Description                       |
| -------------------------- | --------------------- | ------------ | --------------------------------- |
| `children`                 | `List<Widget>`        | **Required** | Widgets to animate                |
| `sequence`                 | `FSAnimationSequence` | **Required** | Animation sequence configuration  |
| `autoPlay`                 | `bool`                | `true`       | Start animation automatically     |
| `semanticLabel`            | `String?`             | `null`       | Accessibility label               |
| `onComplete`               | `VoidCallback?`       | `null`       | Called when sequence completes    |
| `onStart`                  | `VoidCallback?`       | `null`       | Called when sequence starts       |
| `respectSystemPreferences` | `bool`                | `true`       | Respect system animation settings |

## Advanced Usage

### Complex Animation Sequences

```dart
class ProductRevealAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FSSequentialAnimation(
      children: [
        ProductImage(),
        ProductTitle(),
        ProductDescription(),
        ProductPrice(),
        AddToCartButton(),
      ],
      sequence: FSAnimationSequence(
        duration: Duration(milliseconds: 2000),
        curve: Curves.easeInOut,
        steps: [
          // Image slides in quickly
          FSAnimationStep(
            animation: FSAnimation(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeOutBack,
            ),
            delay: Duration.zero,
          ),
          // Title fades in
          FSAnimationStep(
            animation: FSAnimation(
              duration: Duration(milliseconds: 400),
              curve: Curves.easeOut,
            ),
            delay: Duration(milliseconds: 100),
          ),
          // Description slides up
          FSAnimationStep(
            animation: FSAnimation(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeOut,
            ),
            delay: Duration(milliseconds: 200),
          ),
          // Price bounces in
          FSAnimationStep(
            animation: FSAnimation(
              duration: Duration(milliseconds: 600),
              curve: Curves.bounceOut,
            ),
            delay: Duration(milliseconds: 300),
          ),
          // Button scales in
          FSAnimationStep(
            animation: FSAnimation(
              duration: Duration(milliseconds: 400),
              curve: Curves.elasticOut,
            ),
            delay: Duration(milliseconds: 400),
          ),
        ],
      ),
      onStart: () => print('Product reveal starting...'),
      onComplete: () => print('Product reveal complete!'),
    );
  }
}
```

### Manual Animation Control

```dart
class ControlledAnimation extends StatefulWidget {
  @override
  State<ControlledAnimation> createState() => _ControlledAnimationState();
}

class _ControlledAnimationState extends State<ControlledAnimation> {
  final GlobalKey<FSSequentialAnimationState> _animationKey = GlobalKey();

  void _playAnimation() async {
    await _animationKey.currentState?.play();
  }

  void _resetAnimation() {
    _animationKey.currentState?.reset();
  }

  void _stopAnimation() {
    _animationKey.currentState?.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FSSequentialAnimation(
          key: _animationKey,
          children: [/* your widgets */],
          sequence: FSAnimationSequence(/* your sequence */),
          autoPlay: false, // Manual control
        ),
        Row(
          children: [
            ElevatedButton(
              onPressed: _playAnimation,
              child: Text('Play'),
            ),
            ElevatedButton(
              onPressed: _resetAnimation,
              child: Text('Reset'),
            ),
            ElevatedButton(
              onPressed: _stopAnimation,
              child: Text('Stop'),
            ),
          ],
        ),
      ],
    );
  }
}
```

## Integration Examples

### Animated List View

```dart
class AnimatedTaskList extends StatelessWidget {
  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    return FSStaggeredFadeIn(
      children: tasks.map((task) => TaskCard(task: task)).toList(),
      duration: Duration(milliseconds: 400),
      staggerDelay: Duration(milliseconds: 80),
      curve: Curves.easeOut,
    );
  }
}

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Checkbox(value: task.completed, onChanged: null),
        title: Text(task.title),
        subtitle: Text(task.description),
        trailing: Icon(Icons.arrow_forward),
      ),
    );
  }
}
```

### Onboarding Flow

```dart
class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FSSequentialAnimation.fadeIn(
        children: [
          _buildWelcomeSection(),
          _buildFeatureSection(),
          _buildActionSection(),
        ],
        stepDuration: Duration(milliseconds: 600),
        stepDelay: Duration(milliseconds: 300),
        onComplete: () => _showCompletionDialog(context),
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Column(
      children: [
        Icon(Icons.waving_hand, size: 64),
        Text('Welcome!', style: TextStyle(fontSize: 24)),
        Text('Let us show you around...'),
      ],
    );
  }

  Widget _buildFeatureSection() {
    return Column(/* feature items */);
  }

  Widget _buildActionSection() {
    return Column(/* action buttons */);
  }

  void _showCompletionDialog(BuildContext context) {
    // Show completion dialog after animation
  }
}
```

### E-commerce Product Grid

```dart
class ProductGrid extends StatelessWidget {
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return FSStaggeredSlideIn(
      direction: FSSlideDirection.fromBottom,
      children: products.map((product) => ProductCard(product: product)).toList(),
      duration: Duration(milliseconds: 500),
      staggerDelay: Duration(milliseconds: 60),
      curve: Curves.easeOutBack,
      offsetFraction: 0.5, // Shorter slide distance
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        children: [
          Image.network(product.imageUrl),
          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name, style: TextStyle(fontWeight: FontWeight.bold)),
                Text('\$${product.price}'),
                FSButton(
                  onPressed: () => _addToCart(product),
                  child: Text('Add to Cart'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
```

## Performance Best Practices

### Efficient Animation Usage

```dart
// ✅ GOOD: Use const widgets where possible
FSStaggeredFadeIn(
  children: [
    const ProductCard(product: featuredProduct),
    const ProductCard(product: popularProduct),
    // ...
  ],
)

// ✅ GOOD: Cache expensive widget creation
class _MyWidgetState extends State<MyWidget> {
  late final List<Widget> _animatedChildren;

  @override
  void initState() {
    super.initState();
    _animatedChildren = _buildExpensiveChildren();
  }

  @override
  Widget build(BuildContext context) {
    return FSStaggeredFadeIn(children: _animatedChildren);
  }
}

// ❌ AVOID: Rebuilding children in build method
Widget build(BuildContext context) {
  return FSStaggeredFadeIn(
    children: _buildExpensiveChildren(), // Rebuilt every time
  );
}
```

### Performance Monitoring

```dart
// Check animation performance metrics
final metrics = _AnimationPerformance.metrics;
final averageTime = _AnimationPerformance.getAverageTime('sequence_play');

// Clear metrics when no longer needed
_AnimationPerformance.clearMetrics();
```

## Accessibility

### Semantic Labels

```dart
FSStaggeredFadeIn(
  children: newsItems,
  semanticLabel: 'News items loading animation',
)

FSStaggeredSlideIn(
  children: productCards,
  semanticLabel: 'Product cards sliding into view',
)

FSSequentialAnimation(
  children: tutorialSteps,
  semanticLabel: 'Tutorial steps revealing in sequence',
)
```

### Respecting System Preferences

```dart
// Respect user's animation preferences
FSStaggeredFadeIn(
  children: widgets,
  respectSystemPreferences: true, // Default - honors system settings
)

// Force animations (for critical UX)
FSStaggeredSlideIn(
  children: importantWidgets,
  respectSystemPreferences: false, // Always animate
)
```

## Troubleshooting

### Common Issues and Solutions

**Animations not playing**

```dart
// ✅ Check system animation preferences
FSStaggeredFadeIn(
  children: widgets,
  respectSystemPreferences: false, // Force animation
  autoPlay: true, // Ensure auto-play is enabled
)

// ✅ Ensure widgets are properly built
FSStaggeredSlideIn(
  children: _buildValidWidgets(), // Returns non-empty list
)
```

**Performance issues with large lists**

```dart
// ✅ Use smaller stagger delays for large lists
FSStaggeredFadeIn(
  children: largeList,
  staggerDelay: Duration(milliseconds: 30), // Faster staggering
  duration: Duration(milliseconds: 300), // Shorter animations
)

// ✅ Consider pagination for very large lists
PageView(
  children: [
    FSStaggeredFadeIn(children: page1Items),
    FSStaggeredFadeIn(children: page2Items),
  ],
)
```

**Sequence timing issues**

```dart
// ✅ Ensure sequence duration matches steps
final totalDuration = Duration(
  milliseconds: (stepDuration + stepDelay) * children.length
);

FSSequentialAnimation(
  children: children,
  sequence: FSAnimationSequence(
    duration: totalDuration, // Matches calculated total
    // ...
  ),
)
```

## Full Example

### Complete Animated Dashboard

```dart
import 'package:flutter/material.dart';
import 'package:flutstrap/flutstrap.dart';

class AnimatedDashboard extends StatefulWidget {
  @override
  State<AnimatedDashboard> createState() => _AnimatedDashboardState();
}

class _AnimatedDashboardState extends State<AnimatedDashboard> {
  final List<DashboardItem> _items = [
    DashboardItem('Sales', Icons.trending_up, Colors.blue, '1,234'),
    DashboardItem('Users', Icons.people, Colors.green, '567'),
    DashboardItem('Revenue', Icons.attach_money, Colors.orange, '\$89,012'),
    DashboardItem('Orders', Icons.shopping_cart, Colors.purple, '345'),
  ];

  final List<ActivityItem> _activities = [
    ActivityItem('New user registered', '2 min ago'),
    ActivityItem('Order #1234 completed', '5 min ago'),
    ActivityItem('Payment received', '10 min ago'),
    ActivityItem('Product review added', '15 min ago'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stats cards with staggered slide-in
            Text('Overview', style: Theme.of(context).textTheme.headline5),
            SizedBox(height: 16),
            FSStaggeredSlideIn(
              direction: FSSlideDirection.fromLeft,
              children: _items.map((item) => _buildStatCard(item)).toList(),
              duration: Duration(milliseconds: 400),
              staggerDelay: Duration(milliseconds: 80),
              curve: Curves.easeOutBack,
            ),

            SizedBox(height: 32),

            // Recent activity with staggered fade-in
            Text('Recent Activity', style: Theme.of(context).textTheme.headline5),
            SizedBox(height: 16),
            FSStaggeredFadeIn(
              children: _activities.map((activity) => _buildActivityItem(activity)).toList(),
              duration: Duration(milliseconds: 500),
              staggerDelay: Duration(milliseconds: 100),
              curve: Curves.easeOut,
            ),

            SizedBox(height: 32),

            // Quick actions with sequential animation
            Text('Quick Actions', style: Theme.of(context).textTheme.headline5),
            SizedBox(height: 16),
            FSSequentialAnimation.fadeIn(
              children: [
                _buildActionButton('Add Product', Icons.add),
                _buildActionButton('Generate Report', Icons.analytics),
                _buildActionButton('Settings', Icons.settings),
              ],
              stepDuration: Duration(milliseconds: 300),
              stepDelay: Duration(milliseconds: 150),
              onComplete: () => print('Quick actions revealed'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(DashboardItem item) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(item.icon, color: item.color, size: 32),
            SizedBox(height: 8),
            Text(item.value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text(item.title, style: TextStyle(color: Colors.grey.shade600)),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem(ActivityItem activity) {
    return Card(
      margin: EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(Icons.circle, color: Colors.green, size: 12),
        title: Text(activity.title),
        subtitle: Text(activity.time),
        trailing: Icon(Icons.chevron_right),
      ),
    );
  }

  Widget _buildActionButton(String text, IconData icon) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(text),
        trailing: Icon(Icons.arrow_forward),
        onTap: () => _handleAction(text),
      ),
    );
  }

  void _handleAction(String action) {
    // Handle action button tap
    print('Action: $action');
  }
}

class DashboardItem {
  final String title;
  final IconData icon;
  final Color color;
  final String value;

  DashboardItem(this.title, this.icon, this.color, this.value);
}

class ActivityItem {
  final String title;
  final String time;

  ActivityItem(this.title, this.time);
}
```

This comprehensive animation sequences system provides powerful, easy-to-use components for creating sophisticated animated interfaces while maintaining excellent performance and accessibility.
