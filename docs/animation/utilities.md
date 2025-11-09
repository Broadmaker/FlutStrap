# Flutstrap Animation Utilities Guide

## Introduction

Flutstrap Animation Utilities provides a comprehensive set of helper functions, builders, and management tools for creating and managing animations in the Flutstrap ecosystem. These utilities simplify complex animation patterns and provide performance-optimized solutions for common animation scenarios.

### What It Does

- Provides staggered animation builders for lists and grids
- Manages complex animation sequences and states
- Offers crossfade transitions and utility animations
- Handles animation caching and performance optimization

### When to Use

- Creating staggered list animations
- Managing multiple animation controllers
- Implementing complex animation sequences
- Building performance-sensitive animated interfaces

### Prerequisites

- Flutter 3.0 or higher
- Flutstrap core library
- Basic understanding of Flutter's animation system

## Installation & Setup

### Required Dependencies

```dart
import 'package:flutstrap/flutstrap.dart';
```

## Core Utilities

### FSAnimationUtils

The main utility class providing static methods for common animation patterns.

## Basic Usage

### Staggered List Animations

Create beautiful staggered animations for lists and grids:

```dart
class AnimatedListView extends StatelessWidget {
  final List<String> items = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];

  @override
  Widget build(BuildContext context) {
    final staggeredBuilder = FSAnimationUtils.createStaggeredBuilder(
      context: context,
      type: FSAnimationType.fadeIn,
      direction: FSAnimationDirection.bottom,
      staggerDelay: Duration(milliseconds: 100),
    );

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return staggeredBuilder(
          ListTile(
            title: Text(items[index]),
            leading: Icon(Icons.check),
          ),
          index,
        );
      },
    );
  }
}
```

### Custom Staggered Animations

```dart
// Custom slide animation with specific timing
final customStaggeredBuilder = FSAnimationUtils.createStaggeredBuilder(
  context: context,
  type: FSAnimationType.slideIn,
  direction: FSAnimationDirection.right,
  duration: Duration(milliseconds: 500),
  curve: Curves.elasticOut,
  staggerDelay: Duration(milliseconds: 150),
);

// Fade animation from top
final fadeStaggeredBuilder = FSAnimationUtils.createStaggeredBuilder(
  context: context,
  type: FSAnimationType.fadeIn,
  direction: FSAnimationDirection.top,
  staggerDelay: Duration(milliseconds: 80),
);
```

## Animation Management

### FSAnimationManager

A powerful state manager for complex animation sequences and multiple controllers.

#### Basic Manager Usage

```dart
class ManagedAnimationWidget extends StatefulWidget {
  @override
  State<ManagedAnimationWidget> createState() => _ManagedAnimationWidgetState();
}

class _ManagedAnimationWidgetState extends State<ManagedAnimationWidget>
    with SingleTickerProviderStateMixin {
  late FSAnimationManager _animationManager;
  late AnimationController _fadeController;
  late AnimationController _slideController;

  @override
  void initState() {
    super.initState();

    _animationManager = FSAnimationManager();

    _fadeController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    // Register controllers with the manager
    _animationManager.registerController('fade', _fadeController);
    _animationManager.registerController('slide', _slideController);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Your animated widgets here
        ElevatedButton(
          onPressed: () => _animationManager.play('fade'),
          child: Text('Fade In'),
        ),
        ElevatedButton(
          onPressed: () => _animationManager.reverse('fade'),
          child: Text('Fade Out'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _animationManager.dispose();
    super.dispose();
  }
}
```

#### Complex Sequence Management

```dart
class SequentialAnimationExample extends StatefulWidget {
  @override
  State<SequentialAnimationExample> createState() => _SequentialAnimationExampleState();
}

class _SequentialAnimationExampleState extends State<SequentialAnimationExample>
    with SingleTickerProviderStateMixin {
  late FSAnimationManager _manager;
  late List<AnimationController> _controllers;

  @override
  void initState() {
    super.initState();

    _manager = FSAnimationManager();
    _controllers = [
      AnimationController(duration: Duration(milliseconds: 300), vsync: this),
      AnimationController(duration: Duration(milliseconds: 400), vsync: this),
      AnimationController(duration: Duration(milliseconds: 500), vsync: this),
    ];

    // Register all controllers
    for (int i = 0; i < _controllers.length; i++) {
      _manager.registerController('step$i', _controllers[i]);
    }
  }

  Future<void> _playSequence() async {
    // Play animations in sequence
    await _manager.play('step0');
    await _manager.play('step1');
    await _manager.play('step2');
  }

  Future<void> _reverseSequence() async {
    // Reverse animations in sequence
    await _manager.reverse('step2');
    await _manager.reverse('step1');
    await _manager.reverse('step0');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: _playSequence,
          child: Text('Play Sequence'),
        ),
        ElevatedButton(
          onPressed: _reverseSequence,
          child: Text('Reverse Sequence'),
        ),
      ],
    );
  }
}
```

## Utility Animations

### Crossfade Transitions

```dart
class CrossfadeExample extends StatelessWidget {
  final bool showFirst = true;

  @override
  Widget build(BuildContext context) {
    return FSAnimationUtils.crossFade(
      firstChild: Container(
        padding: EdgeInsets.all(20),
        color: Colors.blue,
        child: Text('First Content'),
      ),
      secondChild: Container(
        padding: EdgeInsets.all(20),
        color: Colors.green,
        child: Text('Second Content'),
      ),
      showFirst: showFirst,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
```

### Fade Out Animation

```dart
class FadeOutExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _FadeOut(
      child: Container(
        padding: EdgeInsets.all(20),
        color: Colors.red,
        child: Text('Fading Out'),
      ),
      duration: Duration(milliseconds: 500),
      delay: Duration(milliseconds: 1000), // Wait 1 second before fading
      curve: Curves.easeOut,
      autoPlay: true,
    );
  }
}
```

## Extension Methods

### BuildContext Extensions

Quick access to animation utilities through BuildContext extensions:

```dart
class ExtensionExample extends StatelessWidget {
  final List<String> items = ['A', 'B', 'C', 'D'];

  @override
  Widget build(BuildContext context) {
    // Quick access to theme animation
    final themeAnimation = context.fsAnimation;

    // Create staggered animations easily
    final staggeredBuilder = context.createStaggeredAnimations(
      type: FSAnimationType.slideIn,
      direction: FSAnimationDirection.left,
      staggerDelay: Duration(milliseconds: 120),
    );

    // Quick crossfade
    return context.crossFade(
      firstChild: PrimaryContent(),
      secondChild: SecondaryContent(),
      showFirst: true,
      duration: Duration(milliseconds: 400),
    );
  }
}
```

## Advanced Usage

### Performance Optimization

```dart
class OptimizedAnimations extends StatelessWidget {
  final List<Widget> expensiveWidgets;

  @override
  Widget build(BuildContext context) {
    // Cache the builder to avoid recreation
    final cachedBuilder = context.createStaggeredAnimations(
      type: FSAnimationType.fadeIn,
      direction: FSAnimationDirection.bottom,
    );

    return ListView.builder(
      itemCount: expensiveWidgets.length,
      itemBuilder: (context, index) {
        return cachedBuilder(
          expensiveWidgets[index],
          index,
        );
      },
    );
  }
}

// Clear cache when no longer needed (e.g., in dispose)
void cleanup() {
  FSAnimationUtils.clearCache();
}
```

### Responsive Animations

```dart
class ResponsiveAnimationExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    // Adjust animation based on screen size
    final staggerDelay = screenSize.width > 600
        ? Duration(milliseconds: 50)  // Faster on larger screens
        : Duration(milliseconds: 100); // Slower on mobile

    final builder = context.createStaggeredAnimations(
      type: FSAnimationType.fadeIn,
      staggerDelay: staggerDelay,
    );

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: screenSize.width > 600 ? 4 : 2,
      ),
      itemBuilder: (context, index) => builder(YourGridItem(), index),
    );
  }
}
```

### Complex Animation Coordination

```dart
class CoordinatedAnimations extends StatefulWidget {
  @override
  State<CoordinatedAnimations> createState() => _CoordinatedAnimationsState();
}

class _CoordinatedAnimationsState extends State<CoordinatedAnimations>
    with SingleTickerProviderStateMixin {
  late FSAnimationManager _manager;
  late Map<String, AnimationController> _controllers;

  @override
  void initState() {
    super.initState();
    _manager = FSAnimationManager();
    _controllers = {};

    _setupAnimations();
  }

  void _setupAnimations() {
    // Create multiple coordinated animations
    final animations = {
      'header': AnimationController(duration: Duration(milliseconds: 400), vsync: this),
      'content': AnimationController(duration: Duration(milliseconds: 600), vsync: this),
      'footer': AnimationController(duration: Duration(milliseconds: 300), vsync: this),
    };

    animations.forEach((key, controller) {
      _controllers[key] = controller;
      _manager.registerController(key, controller);
    });
  }

  Future<void> _animateAll() async {
    // Coordinated sequence
    await _manager.play('header');
    await Future.delayed(Duration(milliseconds: 100));
    await _manager.play('content');
    await _manager.play('footer');
  }

  Future<void> _checkAnimationStates() async {
    // Monitor animation states
    final headerState = _manager.getState('header');
    final contentState = _manager.getState('content');

    if (headerState == FSAnimationState.active &&
        contentState == FSAnimationState.entering) {
      // Perform some action based on animation states
    }
  }

  @override
  Widget build(BuildContext context) {
    return YourAnimatedWidget(
      animationManager: _manager,
      onAnimate: _animateAll,
    );
  }
}
```

## Integration Examples

### With Flutstrap Components

```dart
class AnimatedProductGrid extends StatelessWidget {
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    final staggeredBuilder = context.createStaggeredAnimations(
      type: FSAnimationType.fadeIn,
      direction: FSAnimationDirection.bottom,
      staggerDelay: Duration(milliseconds: 80),
    );

    return FSGrid(
      children: products.map((product) {
        return staggeredBuilder(
          FSCard(
            child: Column(
              children: [
                Image.network(product.imageUrl),
                Text(product.name),
                FSButton(
                  onPressed: () {},
                  child: Text('Add to Cart'),
                ),
              ],
            ),
          ),
          products.indexOf(product),
        );
      }).toList(),
    );
  }
}
```

### Complex UI Animation Flow

```dart
class OnboardingFlow extends StatefulWidget {
  @override
  State<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow>
    with SingleTickerProviderStateMixin {
  late FSAnimationManager _animationManager;
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _animationManager = FSAnimationManager();
    _pageController = PageController();
    _setupPageAnimations();
  }

  void _setupPageAnimations() {
    // Setup animations for each page element
    final elements = ['title', 'image', 'description', 'button'];

    for (final element in elements) {
      final controller = AnimationController(
        duration: Duration(milliseconds: 500),
        vsync: this,
      );
      _animationManager.registerController('${_currentPage}_$element', controller);
    }
  }

  Future<void> _animatePageEnter() async {
    // Staggered entrance for page elements
    final elements = ['title', 'image', 'description', 'button'];

    for (int i = 0; i < elements.length; i++) {
      await Future.delayed(Duration(milliseconds: 100 * i));
      await _animationManager.play('${_currentPage}_${elements[i]}');
    }
  }

  Future<void> _nextPage() async {
    // Animate out current page
    final elements = ['button', 'description', 'image', 'title'];

    for (final element in elements) {
      await _animationManager.reverse('${_currentPage}_$element');
    }

    // Change page
    _currentPage++;
    _pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    // Setup and animate new page
    _setupPageAnimations();
    await _animatePageEnter();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      children: [
        // Your onboarding pages
        OnboardingPage1(animationManager: _animationManager, pageIndex: 0),
        OnboardingPage2(animationManager: _animationManager, pageIndex: 1),
        OnboardingPage3(animationManager: _animationManager, pageIndex: 2),
      ],
    );
  }
}
```

## Best Practices

### Performance Optimization

```dart
// ✅ GOOD: Cache animation builders
class _MyWidgetState extends State<MyWidget> {
  late final Widget Function(Widget, int) _cachedBuilder;

  @override
  void initState() {
    super.initState();
    _cachedBuilder = context.createStaggeredAnimations(
      type: FSAnimationType.fadeIn,
      staggerDelay: Duration(milliseconds: 100),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => _cachedBuilder(ItemWidget(), index),
    );
  }
}

// ❌ AVOID: Recreating builders in build method
Widget build(BuildContext context) {
  // This recreates the builder on every build
  final builder = context.createStaggeredAnimations(...);
}
```

### Memory Management

```dart
class ManagedAnimationState extends State<MyWidget>
    with SingleTickerProviderStateMixin {
  late FSAnimationManager _animationManager;
  late List<AnimationController> _controllers;

  @override
  void initState() {
    super.initState();
    _animationManager = FSAnimationManager();
    _setupAnimations();
  }

  @override
  void dispose() {
    // Always dispose managers and controllers
    _animationManager.dispose();
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
```

## Troubleshooting

### Common Issues and Solutions

**Animation builders not working**

```dart
// ✅ Ensure context is available
Widget build(BuildContext context) {
  // Context is properly available here
  final builder = context.createStaggeredAnimations(...);
}

// ✅ Check if animations are disabled in system
final shouldAnimate = MediaQuery.of(context).disableAnimations != true;
if (!shouldAnimate) {
  // Provide fallback behavior
}
```

**Animation manager state issues**

```dart
// ✅ Check if manager is still mounted
if (_animationManager.mounted) {
  await _animationManager.play('myAnimation');
}

// ✅ Handle animation cancellation
try {
  await _animationManager.play('myAnimation');
} catch (e) {
  // Animation was cancelled or disposed
  debugPrint('Animation cancelled: $e');
}
```

**Performance issues with large lists**

```dart
// ✅ Use const constructors for animated children
final builder = context.createStaggeredAnimations(...);

ListView.builder(
  itemBuilder: (context, index) => builder(
    const MyListItem(), // Const constructor helps performance
    index,
  ),
);

// ✅ Clear cache when done
@override
void dispose() {
  FSAnimationUtils.clearCache();
  super.dispose();
}
```

## Full Example

### Complete Animated List Implementation

```dart
import 'package:flutter/material.dart';
import 'package:flutstrap/flutstrap.dart';

class AnimatedTaskList extends StatefulWidget {
  @override
  State<AnimatedTaskList> createState() => _AnimatedTaskListState();
}

class _AnimatedTaskListState extends State<AnimatedTaskList> {
  final List<Task> _tasks = [];
  final _animationManager = FSAnimationManager();
  late Widget Function(Widget, int) _staggeredBuilder;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _loadInitialTasks();
  }

  void _initializeAnimations() {
    _staggeredBuilder = FSAnimationUtils.createStaggeredBuilder(
      context: context,
      type: FSAnimationType.slideIn,
      direction: FSAnimationDirection.right,
      duration: Duration(milliseconds: 400),
      curve: Curves.easeOut,
      staggerDelay: Duration(milliseconds: 80),
    );
  }

  void _loadInitialTasks() {
    // Simulate loading tasks
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _tasks.addAll([
          Task('Buy groceries', false),
          Task('Finish Flutter project', false),
          Task('Call dentist', true),
          Task('Read book', false),
        ]);
      });
    });
  }

  void _addTask(String title) {
    setState(() {
      _tasks.insert(0, Task(title, false));
    });
  }

  void _removeTask(int index) async {
    final task = _tasks[index];

    // Animate removal
    await _animationManager.reverse('task_$index');

    setState(() {
      _tasks.removeAt(index);
    });
  }

  void _toggleTask(int index) {
    setState(() {
      _tasks[index] = _tasks[index].copyWith(completed: !_tasks[index].completed);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animated Task List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
              onSubmitted: _addTask,
              decoration: InputDecoration(
                hintText: 'Add a new task...',
                suffixIcon: Icon(Icons.add),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final task = _tasks[index];
                return _staggeredBuilder(
                  Dismissible(
                    key: Key('task_$index'),
                    onDismissed: (_) => _removeTask(index),
                    background: Container(color: Colors.red),
                    child: FSCard(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      child: ListTile(
                        leading: Checkbox(
                          value: task.completed,
                          onChanged: (_) => _toggleTask(index),
                        ),
                        title: Text(
                          task.title,
                          style: TextStyle(
                            decoration: task.completed
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _removeTask(index),
                        ),
                      ),
                    ),
                  ),
                  index,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationManager.dispose();
    FSAnimationUtils.clearCache();
    super.dispose();
  }
}

class Task {
  final String title;
  final bool completed;

  Task(this.title, this.completed);

  Task copyWith({String? title, bool? completed}) {
    return Task(
      title ?? this.title,
      completed ?? this.completed,
    );
  }
}
```

This comprehensive animation utilities system provides powerful tools for creating sophisticated, performance-optimized animations while maintaining clean, maintainable code architecture.
