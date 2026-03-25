# Flutstrap Responsive System Guide

## Introduction

Flutstrap Responsive System is a comprehensive, performance-optimized solution for creating adaptive layouts in Flutter applications. It provides a robust set of utilities that work seamlessly with Flutstrap's breakpoint system to deliver exceptional responsive experiences across all device sizes.

### What It Does

- Provides responsive value selection based on screen breakpoints
- Offers conditional rendering utilities for adaptive UIs
- Includes performance-optimized caching and efficient algorithms
- Delivers type-safe responsive programming with comprehensive generic support
- Supports mobile-first responsive design approach

### When to Use

- Building layouts that adapt to different screen sizes
- Creating responsive design systems with consistent spacing and sizing
- Implementing conditional UI elements based on device capabilities
- Optimizing performance in responsive applications
- Developing mobile-first Flutter applications

### Prerequisites

- Flutter 3.0 or higher
- Flutstrap Breakpoints system
- Understanding of responsive design principles

## Installation & Setup

### Required Dependencies

```dart
import 'package:flutter/material.dart';
import 'package:flutstrap/flutstrap.dart';
```

### Basic Configuration

The responsive system works out of the box with default breakpoints:

```dart
// No setup required - use directly
final responsive = FSResponsive.of(MediaQuery.of(context).size.width);
```

## Core Responsive System

### FSResponsive Class

The main responsive utility class that provides comprehensive responsive capabilities:

```dart
// Create from screen width
final responsive = FSResponsive.of(screenWidth);

// Create from BuildContext
final responsive = FSResponsive.fromContext(context);

// With custom breakpoints
final responsive = FSResponsive.of(
  screenWidth,
  breakpoints: customBreakpoints,
);
```

### Key Properties

| Property      | Type                  | Description                            |
| ------------- | --------------------- | -------------------------------------- |
| `screenWidth` | `double`              | Current screen width in logical pixels |
| `breakpoints` | `FSCustomBreakpoints` | Breakpoint configuration               |
| `breakpoint`  | `FSBreakpoint`        | Current breakpoint (cached)            |

## Basic Usage

### Responsive Value Selection

```dart
final responsive = FSResponsive.of(MediaQuery.of(context).size.width);

// Simple value selection
final padding = responsive.value<double>(
  xs: 16.0,    // Mobile
  sm: 20.0,    // Small tablet
  md: 24.0,    // Tablet
  lg: 32.0,    // Desktop
  xl: 40.0,    // Large desktop
  xxl: 48.0,   // Extra large desktop
  fallback: 24.0,
);

// Use in widget
Container(
  padding: EdgeInsets.all(padding),
  child: Text('Responsive Content'),
);
```

### Conditional Rendering

```dart
responsive.show(
  child: FloatingActionButton(
    onPressed: () {},
    child: Icon(Icons.add),
  ),
  showOnXs: false, // Hide FAB on mobile
  showOnSm: false, // Hide FAB on small tablets
  showOnMd: true,  // Show on tablets
  showOnLg: true,  // Show on desktop
);

// Alternative: hide method
responsive.hide(
  child: SidebarNavigation(),
  hideOnXs: true,  // Hide on mobile
  hideOnSm: true,  // Hide on small tablets
  fallback: BottomNavigation(), // Show alternative
);
```

### Responsive Builder Pattern

```dart
responsive.builder(
  builder: (breakpoint) {
    switch (breakpoint) {
      case FSBreakpoint.xs:
        return MobileLayout();
      case FSBreakpoint.sm:
      case FSBreakpoint.md:
        return TabletLayout();
      case FSBreakpoint.lg:
      case FSBreakpoint.xl:
      case FSBreakpoint.xxl:
        return DesktopLayout();
    }
  },
);
```

## Advanced Usage Patterns

### LayoutBuilder Integration

```dart
FSResponsive.layoutBuilder(
  context,
  builder: (responsive) {
    return Column(
      children: [
        // Responsive padding
        Padding(
          padding: EdgeInsets.all(
            responsive.value<double>(
              xs: 16.0,
              sm: 20.0,
              md: 24.0,
              lg: 32.0,
              fallback: 24.0,
            ),
          ),
          child: Header(),
        ),

        // Conditional rendering
        responsive.show(
          child: Sidebar(),
          showOnXs: false,
          showOnSm: false,
        ),

        // Main content
        Expanded(
          child: MainContent(),
        ),
      ],
    );
  },
);
```

### Value Builder Pattern

```dart
FSResponsive.valueBuilder(
  context: context,
  valueSelector: (responsive) => responsive.value<int>(
    xs: 1,
    sm: 2,
    md: 3,
    lg: 4,
    fallback: 2,
  ),
  builder: (columns) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemBuilder: (context, index) => GridItem(index: index),
    );
  },
);
```

## FSResponsiveValue Container

### Creating Responsive Value Containers

```dart
// Define responsive values statically
static const responsivePadding = FSResponsiveValue<double>(
  xs: 16.0,
  sm: 20.0,
  md: 24.0,
  lg: 32.0,
  xl: 40.0,
  xxl: 48.0,
);

static const responsiveColumns = FSResponsiveValue<int>(
  xs: 1,
  sm: 2,
  md: 3,
  lg: 4,
  xl: 5,
  xxl: 6,
);

// Use in widgets
final padding = responsivePadding.value(responsive.breakpoint);
final columns = responsiveColumns.value(responsive.breakpoint);
```

### Value Transformations

```dart
// Map to different type
const baseSizes = FSResponsiveValue<double>(
  xs: 16.0, sm: 20.0, md: 24.0, lg: 32.0, xl: 40.0, xxl: 48.0,
);

final edgeInsets = baseSizes.map((size) => EdgeInsets.all(size));

// Combine multiple responsive values
const horizontalPadding = FSResponsiveValue<double>(
  xs: 16.0, sm: 20.0, md: 24.0, lg: 32.0, xl: 40.0, xxl: 48.0,
);

const verticalPadding = FSResponsiveValue<double>(
  xs: 8.0, sm: 12.0, md: 16.0, lg: 20.0, xl: 24.0, xxl: 28.0,
);

final combinedPadding = horizontalPadding.combine(
  verticalPadding,
  (h, v) => EdgeInsets.symmetric(horizontal: h, vertical: v),
);
```

### Constant Values

```dart
// All breakpoints same value
const uniformPadding = FSResponsiveValue<double>.all(16.0);

// Copy with modifications
const modifiedPadding = uniformPadding.copyWith(
  lg: 24.0,
  xl: 32.0,
);
```

## Context Extensions

### Simplified Context Access

```dart
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Direct breakpoint access
    if (context.isMobile) {
      return MobileView();
    } else if (context.isTablet) {
      return TabletView();
    } else {
      return DesktopView();
    }
  }
}
```

### Quick Responsive Values

```dart
Widget build(BuildContext context) {
  return Container(
    padding: context.responsivePadding,
    margin: context.responsiveMargin,
    child: Column(
      children: [
        Text(
          'Responsive Title',
          style: TextStyle(
            fontSize: context.responsiveValue<double>(
              xs: 16.0,
              sm: 18.0,
              md: 20.0,
              lg: 24.0,
              fallback: 20.0,
            ),
          ),
        ),

        // Grid with responsive columns
        GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: context.responsiveValue<int>(
              xs: 1,
              sm: 2,
              md: 3,
              lg: 4,
              fallback: 2,
            ),
          ),
          itemBuilder: (context, index) => GridItem(index: index),
        ),
      ],
    ),
  );
}
```

## Performance Optimization

### Caching and Performance Monitoring

```dart
// Monitor cache performance
final (hits, misses, hitRate) = FSResponsive.cacheStats;
print('Cache hit rate: ${(hitRate * 100).toStringAsFixed(1)}%');

// Clear cache if needed (e.g., during testing)
FSResponsive.clearCache();

// Custom breakpoints with caching
final responsive = FSResponsive.of(
  screenWidth,
  breakpoints: const FSCustomBreakpoints(
    sm: 600,
    lg: 1100,
  ),
);
```

### Efficient Breakpoint Checks

```dart
final responsive = FSResponsive.of(screenWidth);

// Efficient breakpoint comparisons
if (responsive.isMobile) {
  // Optimized for mobile
} else if (responsive.isTablet) {
  // Tablet optimizations
} else if (responsive.isDesktop) {
  // Desktop features
}

// Specific breakpoint checks
if (responsive.isBreakpoint(FSBreakpoint.lg)) {
  // Exactly large breakpoint
}

if (responsive.isLargerThan(FSBreakpoint.md)) {
  // Tablet and larger
}

if (responsive.isEqualOrSmallerThan(FSBreakpoint.sm)) {
  // Mobile only
}
```

## Real-World Integration Examples

### Complete Responsive Layout

```dart
class ResponsiveHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FSResponsive.layoutBuilder(
      context,
      builder: (responsive) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Responsive App'),
            actions: [
              // Show actions only on larger screens
              responsive.show(
                child: Row(
                  children: [
                    IconButton(icon: Icon(Icons.search), onPressed: () {}),
                    IconButton(icon: Icon(Icons.settings), onPressed: () {}),
                  ],
                ),
                showOnXs: false,
                showOnSm: false,
              ),
            ],
          ),
          drawer: responsive.show(
            child: Drawer(child: NavigationDrawer()),
            showOnXs: true,
            showOnSm: true,
            showOnMd: false, // Hide on tablets and larger
          ),
          body: Row(
            children: [
              // Sidebar only on desktop
              responsive.show(
                child: Container(
                  width: 250,
                  child: Sidebar(),
                ),
                showOnXs: false,
                showOnSm: false,
                showOnMd: false,
              ),

              // Main content
              Expanded(
                child: Padding(
                  padding: responsive.value<EdgeInsets>(
                    xs: EdgeInsets.all(16.0),
                    sm: EdgeInsets.all(20.0),
                    md: EdgeInsets.all(24.0),
                    lg: EdgeInsets.all(32.0),
                    fallback: EdgeInsets.all(24.0),
                  ),
                  child: HomeContent(),
                ),
              ),
            ],
          ),
          bottomNavigationBar: responsive.show(
            child: BottomNavigation(),
            showOnXs: true,
            showOnSm: true,
            showOnMd: false,
          ),
        );
      },
    );
  }
}
```

### Responsive Form Layout

```dart
class ResponsiveForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.responsivePadding,
      child: Column(
        children: [
          // Single column on mobile, two columns on desktop
          context.responsive.builder(
            builder: (breakpoint) {
              if (breakpoint.isMobile) {
                return Column(
                  children: [
                    FlutstrapTextField(label: 'First Name'),
                    FlutstrapTextField(label: 'Last Name'),
                  ],
                );
              } else {
                return Row(
                  children: [
                    Expanded(child: FlutstrapTextField(label: 'First Name')),
                    SizedBox(width: 16),
                    Expanded(child: FlutstrapTextField(label: 'Last Name')),
                  ],
                );
              }
            },
          ),

          SizedBox(height: context.responsiveValue<double>(
            xs: 16.0, sm: 20.0, md: 24.0, fallback: 20.0
          )),

          // Additional fields only on larger screens
          context.responsive.show(
            child: FlutstrapTextField(label: 'Company Name'),
            showOnXs: false,
            showOnSm: false,
          ),

          SizedBox(height: context.responsiveValue<double>(
            xs: 24.0, sm: 32.0, md: 40.0, fallback: 32.0
          )),

          // Responsive button size
          FlutstrapButton(
            onPressed: () {},
            child: Text('Submit'),
            size: context.responsiveValue<FSSize>(
              xs: FSSize.sm,
              sm: FSSize.md,
              md: FSSize.lg,
              fallback: FSSize.md,
            ),
          ),
        ],
      ),
    );
  }
}
```

### E-commerce Product Grid

```dart
class ProductGrid extends StatelessWidget {
  final List<Product> products;

  const ProductGrid({required this.products});

  @override
  Widget build(BuildContext context) {
    return FSResponsive.valueBuilder(
      context: context,
      valueSelector: (responsive) => responsive.value<int>(
        xs: 1, sm: 2, md: 3, lg: 4, xl: 5, xxl: 6, fallback: 3
      ),
      builder: (columns) {
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: context.responsiveValue<double>(
              xs: 8.0, sm: 12.0, md: 16.0, fallback: 12.0
            ),
            mainAxisSpacing: context.responsiveValue<double>(
              xs: 8.0, sm: 12.0, md: 16.0, fallback: 12.0
            ),
            childAspectRatio: context.responsiveValue<double>(
              xs: 0.8, sm: 0.9, md: 1.0, lg: 1.1, fallback: 1.0
            ),
          ),
          itemCount: products.length,
          itemBuilder: (context, index) => ProductCard(
            product: products[index],
            compact: context.isMobile,
          ),
        );
      },
    );
  }
}
```

## Best Practices

### Performance Optimization

```dart
// ✅ GOOD: Cache responsive instances in stateful widgets
class _MyWidgetState extends State<MyWidget> {
  late FSResponsive _responsive;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _responsive = FSResponsive.fromContext(context);
  }
}

// ✅ GOOD: Use const FSResponsiveValue for static values
static const _responsiveSpacing = FSResponsiveValue<double>(
  xs: 8.0, sm: 12.0, md: 16.0, lg: 20.0, xl: 24.0, xxl: 28.0
);

// ❌ AVOID: Recreating responsive values in build methods
Widget build(BuildContext context) {
  // This recreates the value on every build
  final padding = FSResponsiveValue<double>(...);
}
```

### Code Organization

```dart
// ✅ GOOD: Extract responsive configurations
class AppResponsiveConfig {
  static const padding = FSResponsiveValue<EdgeInsets>(
    xs: EdgeInsets.all(16.0),
    sm: EdgeInsets.all(20.0),
    md: EdgeInsets.all(24.0),
    lg: EdgeInsets.all(32.0),
    xl: EdgeInsets.all(40.0),
    xxl: EdgeInsets.all(48.0),
  );

  static const columns = FSResponsiveValue<int>(
    xs: 1, sm: 2, md: 3, lg: 4, xl: 5, xxl: 6
  );

  static const fontSize = FSResponsiveValue<double>(
    xs: 14.0, sm: 16.0, md: 18.0, lg: 20.0, xl: 22.0, xxl: 24.0
  );
}

// ✅ GOOD: Use extension methods for common patterns
extension ResponsiveLayoutExtensions on FSResponsive {
  Widget get adaptiveAppBar {
    return builder(
      builder: (breakpoint) {
        if (breakpoint.isMobile) {
          return MobileAppBar();
        } else {
          return DesktopAppBar();
        }
      },
    );
  }
}
```

## Troubleshooting

### Common Issues and Solutions

**Responsive values not updating**

```dart
// ✅ Ensure using LayoutBuilder for automatic updates
FSResponsive.layoutBuilder(
  context,
  builder: (responsive) {
    // This will update when screen size changes
    return YourWidget(responsive: responsive);
  },
);

// ❌ Avoid: Using MediaQuery directly without LayoutBuilder
Widget build(BuildContext context) {
  final responsive = FSResponsive.fromContext(context);
  // May not update on orientation changes without LayoutBuilder
}
```

**Cache performance issues**

```dart
// Monitor cache performance
final (hits, misses, hitRate) = FSResponsive.cacheStats;
if (hitRate < 0.8) {
  // Consider increasing cache size or optimizing breakpoint usage
  FSResponsive.clearCache(); // Reset cache if needed
}
```

**Type safety issues**

```dart
// ✅ Use type annotations for safety
final padding = responsive.value<double>(
  xs: 16.0, // double
  sm: 20.0,
  fallback: 24.0,
);

// ❌ Avoid: Mixed types
final invalid = responsive.value(
  xs: 16,    // int
  sm: 20.0,  // double - will cause runtime errors
  fallback: 24.0,
);
```

This comprehensive responsive system provides everything needed to create beautifully adaptive Flutter applications that work seamlessly across all device sizes while maintaining excellent performance and developer experience.
