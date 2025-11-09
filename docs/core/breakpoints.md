# Flutstrap Breakpoints System Guide

## Introduction

Flutstrap Breakpoints is the foundation of Flutstrap's responsive design system. It provides a comprehensive set of utilities for creating adaptive layouts that work seamlessly across all device sizes, following a mobile-first approach inspired by Bootstrap but optimized for Flutter.

### What It Does

- Defines standardized screen breakpoints for responsive design
- Provides utilities for breakpoint detection and comparison
- Supports custom breakpoint configurations for specific design needs
- Offers extension methods for clean, readable breakpoint logic

### When to Use

- Building responsive layouts that adapt to screen size
- Creating mobile-first designs that enhance for larger screens
- Implementing conditional rendering based on device size
- Theming and styling components differently across breakpoints

### Prerequisites

- Flutter 3.0 or higher
- Basic understanding of responsive design principles
- Familiarity with Flutter's layout system

## Installation & Setup

### Required Dependencies

```dart
import 'package:flutter/material.dart';
import 'package:flutstrap/flutstrap.dart';
```

### Basic Configuration

The breakpoint system works out of the box with default values:

```dart
// No setup required - use directly
final breakpoint = FSBreakpoint.xs;
```

## Core Breakpoint System

### Default Breakpoint Values

Flutstrap uses six standardized breakpoints:

```dart
enum FSBreakpoint {
  xs,   // < 576px  - Portrait phones
  sm,   // ≥ 576px  - Landscape phones
  md,   // ≥ 768px  - Tablets
  lg,   // ≥ 992px  - Desktops
  xl,   // ≥ 1200px - Large desktops
  xxl,  // ≥ 1400px - Larger desktops
}
```

### Breakpoint Values Reference

| Breakpoint | Minimum Width | Typical Devices  | Use Case                     |
| ---------- | ------------- | ---------------- | ---------------------------- |
| **XS**     | 576px         | Portrait phones  | Mobile-optimized layouts     |
| **SM**     | 768px         | Landscape phones | Enhanced mobile layouts      |
| **MD**     | 992px         | Tablets          | Tablet-optimized interfaces  |
| **LG**     | 1200px        | Desktops         | Standard desktop layouts     |
| **XL**     | 1400px        | Large desktops   | Enhanced desktop experiences |
| **XXL**    | 1600px        | Larger desktops  | Large screen optimizations   |

## Basic Usage

### Using Default Breakpoints

```dart
// Get breakpoint from screen width
final screenWidth = MediaQuery.of(context).size.width;
final breakpoint = FSBreakpoints().getBreakpoint(screenWidth);

// Use in conditional logic
if (breakpoint == FSBreakpoint.xs) {
  return MobileLayout();
} else if (breakpoint == FSBreakpoint.md) {
  return TabletLayout();
} else {
  return DesktopLayout();
}
```

### Direct Breakpoint Access

```dart
// Access breakpoint values directly
print(FSBreakpoints.xs); // 576.0
print(FSBreakpoints.sm); // 768.0

// Get value for specific breakpoint
final lgValue = FSBreakpoints.value(FSBreakpoint.lg); // 1200.0
```

## Breakpoint Utilities

### FSBreakpoints Class

The `FSBreakpoints` class provides static utilities for working with breakpoints:

```dart
// Get human-readable names
FSBreakpoints.displayName(FSBreakpoint.xs); // 'Extra Small'
FSBreakpoints.displayName(FSBreakpoint.lg); // 'Large'

// Get string names
FSBreakpoints.name(FSBreakpoint.sm); // 'sm'
FSBreakpoints.name(FSBreakpoint.xl); // 'xl'
```

### Breakpoint Extensions

The `FSBreakpointExtensions` provide convenient methods on breakpoint enums:

```dart
final currentBreakpoint = FSBreakpoint.md;

// Access values directly
print(currentBreakpoint.value);      // 992.0
print(currentBreakpoint.name);       // 'md'
print(currentBreakpoint.displayName); // 'Medium'

// Comparison methods
currentBreakpoint.isLargerThan(FSBreakpoint.sm);      // true
currentBreakpoint.isSmallerThan(FSBreakpoint.lg);     // true
currentBreakpoint.isEqualOrLargerThan(FSBreakpoint.md); // true
currentBreakpoint.isEqualOrSmallerThan(FSBreakpoint.lg); // true
```

## Custom Breakpoints

### Creating Custom Breakpoint Configurations

```dart
// Custom breakpoints for specific design needs
const customBreakpoints = FSCustomBreakpoints(
  xs: 480,   // Custom mobile breakpoint
  sm: 640,   // Custom small breakpoint
  md: 800,   // Custom tablet breakpoint
  lg: 1024,  // Custom desktop breakpoint
  xl: 1280,  // Custom large desktop
  xxl: 1536, // Custom extra large desktop
);

// Use custom breakpoints
final breakpoint = customBreakpoints.getBreakpoint(screenWidth);
```

### Custom Breakpoints with Partial Overrides

```dart
// Override only specific breakpoints, keep others default
const tabletOptimized = FSCustomBreakpoints(
  md: 900,  // Adjust tablet breakpoint
  lg: 1100, // Adjust desktop breakpoint
);
// xs, sm, xl, xxl keep their default values
```

## Advanced Usage

### Breakpoint Detection and Logic

```dart
class ResponsiveWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final breakpoints = const FSCustomBreakpoints();
    final current = breakpoints.getBreakpoint(screenWidth);

    return LayoutBuilder(
      builder: (context, constraints) {
        // Complex breakpoint logic
        if (breakpoints.isAtLeast(screenWidth, FSBreakpoint.lg)) {
          return WideLayout();
        } else if (breakpoints.isBetween(screenWidth, FSBreakpoint.sm, FSBreakpoint.lg)) {
          return MediumLayout();
        } else {
          return CompactLayout();
        }
      },
    );
  }
}
```

### Breakpoint Navigation

```dart
final breakpoints = const FSCustomBreakpoints();
final current = FSBreakpoint.md;

// Navigate breakpoints
final next = breakpoints.nextBreakpoint(current);     // FSBreakpoint.lg
final previous = breakpoints.previousBreakpoint(current); // FSBreakpoint.sm
```

### Responsive Layout Patterns

```dart
// Pattern 1: Mobile-first conditional rendering
Widget buildContent(FSBreakpoint breakpoint) {
  switch (breakpoint) {
    case FSBreakpoint.xs:
    case FSBreakpoint.sm:
      return MobileView();
    case FSBreakpoint.md:
      return TabletView();
    case FSBreakpoint.lg:
    case FSBreakpoint.xl:
    case FSBreakpoint.xxl:
      return DesktopView();
  }
}

// Pattern 2: Progressive enhancement
Widget buildEnhancedLayout(FSBreakpoint breakpoint) {
  final baseContent = BaseContent();

  if (breakpoint.isEqualOrLargerThan(FSBreakpoint.md)) {
    return EnhancedLayout(child: baseContent);
  }

  return baseContent;
}
```

## Integration Examples

### With Flutstrap Visibility

```dart
Column(
  children: [
    FlutstrapVisibility.mobileOnly(
      child: MobileNavigation(),
    ),
    FlutstrapVisibility.desktopOnly(
      child: SidebarNavigation(),
    ),

    // Dynamic content based on breakpoint
    Builder(
      builder: (context) {
        final screenWidth = MediaQuery.of(context).size.width;
        final breakpoint = const FSCustomBreakpoints().getBreakpoint(screenWidth);

        return breakpoint.isLargerThan(FSBreakpoint.lg)
            ? WideContent()
            : StandardContent();
      },
    ),
  ],
)
```

### Responsive Grid System

```dart
class ResponsiveGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final breakpoint = const FSCustomBreakpoints().getBreakpoint(screenWidth);

    final columns = _getColumnCount(breakpoint);

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemBuilder: (context, index) => GridItem(index: index),
    );
  }

  int _getColumnCount(FSBreakpoint breakpoint) {
    switch (breakpoint) {
      case FSBreakpoint.xs: return 1;
      case FSBreakpoint.sm: return 2;
      case FSBreakpoint.md: return 3;
      case FSBreakpoint.lg: return 4;
      case FSBreakpoint.xl: return 5;
      case FSBreakpoint.xxl: return 6;
    }
  }
}
```

### Breakpoint-Aware Theming

```dart
class ResponsiveApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) {
          final screenWidth = MediaQuery.of(context).size.width;
          final breakpoint = const FSCustomBreakpoints().getBreakpoint(screenWidth);

          return FSTheme(
            data: _getThemeForBreakpoint(breakpoint),
            child: HomePage(),
          );
        },
      ),
    );
  }

  FSThemeData _getThemeForBreakpoint(FSBreakpoint breakpoint) {
    final baseTheme = FSThemeData.light();

    return baseTheme.copyWith(
      spacing: breakpoint.isLargerThan(FSBreakpoint.md)
          ? FSSpacing.large()
          : FSSpacing.standard(),
      typography: breakpoint.isLargerThan(FSBreakpoint.lg)
          ? FSTypography.desktop()
          : FSTypography.mobile(),
    );
  }
}
```

## Performance Best Practices

### Efficient Breakpoint Usage

```dart
// ✅ GOOD: Cache breakpoint calculations
class _MyWidgetState extends State<MyWidget> {
  FSBreakpoint? _cachedBreakpoint;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    _cachedBreakpoint ??= const FSCustomBreakpoints().getBreakpoint(screenWidth);

    return buildResponsiveContent(_cachedBreakpoint!);
  }
}

// ✅ GOOD: Use const constructors for default breakpoints
const defaultBreakpoints = FSCustomBreakpoints(); // Compile-time constant

// ❌ AVOID: Recalculating breakpoints in build methods
Widget build(BuildContext context) {
  // This recalculates on every build
  final breakpoint = FSCustomBreakpoints().getBreakpoint(
    MediaQuery.of(context).size.width
  );
}
```

### Optimized Breakpoint Logic

```dart
// ✅ Efficient breakpoint checking
final breakpoints = const FSCustomBreakpoints();

// Use extension methods for clean comparisons
if (currentBreakpoint.isLargerThan(FSBreakpoint.md)) {
  // Desktop logic
}

// Cache expensive calculations
class ResponsiveController {
  final FSCustomBreakpoints breakpoints;
  final double screenWidth;

  FSBreakpoint get currentBreakpoint =>
      breakpoints.getBreakpoint(screenWidth);

  bool get isMobile =>
      currentBreakpoint.isEqualOrSmallerThan(FSBreakpoint.sm);

  bool get isTablet =>
      currentBreakpoint == FSBreakpoint.md;

  bool get isDesktop =>
      currentBreakpoint.isEqualOrLargerThan(FSBreakpoint.lg);
}
```

## Troubleshooting

### Common Issues and Solutions

**Breakpoint not updating on orientation change**

```dart
// ✅ Ensure proper context usage
Widget build(BuildContext context) {
  // MediaQuery.of(context) will update on orientation changes
  final screenWidth = MediaQuery.of(context).size.width;
  final breakpoint = const FSCustomBreakpoints().getBreakpoint(screenWidth);

  return YourWidget(breakpoint: breakpoint);
}
```

**Custom breakpoints validation errors**

```dart
// ❌ Invalid: Breakpoints not in order
FSCustomBreakpoints(
  xs: 500,
  sm: 400, // ERROR: sm must be larger than xs
);

// ✅ Valid: Ascending order
FSCustomBreakpoints(
  xs: 400,
  sm: 500, // Correct order
);
```

**Performance issues with frequent rebuilds**

```dart
// ✅ Use LayoutBuilder for breakpoint-aware rebuilding
LayoutBuilder(
  builder: (context, constraints) {
    final breakpoint = const FSCustomBreakpoints()
        .getBreakpoint(constraints.maxWidth);

    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      child: buildContent(breakpoint),
    );
  },
)
```

**Breakpoint logic too complex**

```dart
// ❌ Complex nested conditions
// ✅ Extract to helper methods
bool _shouldShowFeature(FSBreakpoint breakpoint, User user) {
  return breakpoint.isLargerThan(FSBreakpoint.sm)
      && user.isPremium
      && featureFlag.isEnabled;
}
```

This comprehensive breakpoints system provides the foundation for creating truly responsive Flutter applications that adapt beautifully to any screen size while maintaining excellent performance and developer experience.
