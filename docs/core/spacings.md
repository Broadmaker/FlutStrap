# Flutstrap Spacing System Guide

## Introduction

Flutstrap Spacing System provides a consistent, scalable spacing scale inspired by Bootstrap's spacing utilities but optimized for Flutter's layout system. It establishes a systematic approach to spacing that ensures visual consistency and rhythm throughout your application.

### What It Does

- Provides a consistent 8px-based spacing scale
- Offers responsive spacing that adapts to different screen sizes
- Enables systematic spacing with predefined scale values
- Supports custom spacing configurations for brand-specific designs

### When to Use

- Maintaining consistent spacing throughout your app
- Creating responsive layouts with adaptive spacing
- Implementing design systems with standardized spacing
- Ensuring visual rhythm and hierarchy in UI layouts

### Prerequisites

- Flutter 3.0 or higher
- Flutstrap Breakpoints system (for responsive spacing)
- Basic understanding of Flutter's layout system

## Installation & Setup

### Required Dependencies

```dart
import 'package:flutter/material.dart';
import 'package:flutstrap/flutstrap.dart';
```

### Basic Configuration

The spacing system works out of the box with default values:

```dart
// No setup required - use directly
const padding = EdgeInsets.all(FSSpacing.md);
```

## Core Spacing System

### Default Spacing Scale

Flutstrap uses an 8px-based spacing scale with 8 predefined values:

```dart
class FSSpacing {
  static const double none = 0.0;  // 0px
  static const double xs = 4.0;    // 4px
  static const double sm = 8.0;    // 8px
  static const double md = 16.0;   // 16px
  static const double lg = 24.0;   // 24px
  static const double xl = 32.0;   // 32px
  static const double xxl = 48.0;  // 48px
  static const double xxxl = 64.0; // 64px
}
```

### Spacing Scale Reference

| Scale    | Value | Use Case                                               |
| -------- | ----- | ------------------------------------------------------ |
| **none** | 0.0   | Removing default spacing, tight layouts                |
| **xs**   | 4.0   | Tight spacing, icon padding, small gaps                |
| **sm**   | 8.0   | Default small spacing, list item padding               |
| **md**   | 16.0  | Standard spacing, card padding, section margins        |
| **lg**   | 24.0  | Large spacing, section padding, between major elements |
| **xl**   | 32.0  | Extra large spacing, between page sections             |
| **xxl**  | 48.0  | Double extra large, hero section spacing               |
| **xxxl** | 64.0  | Maximum spacing, large hero sections                   |

## Basic Usage

### Direct Spacing Values

```dart
// Padding examples
Container(
  padding: EdgeInsets.all(FSSpacing.md), // 16px all around
  child: Text('Content'),
);

Padding(
  padding: EdgeInsets.symmetric(
    horizontal: FSSpacing.lg, // 24px left and right
    vertical: FSSpacing.sm,   // 8px top and bottom
  ),
  child: Text('Content'),
);

// Margin examples
Container(
  margin: EdgeInsets.only(
    top: FSSpacing.xl,    // 32px top
    bottom: FSSpacing.sm, // 8px bottom
  ),
  child: Text('Content'),
);

// Gap between widgets
Column(
  children: [
    Text('First Item'),
    SizedBox(height: FSSpacing.md), // 16px gap
    Text('Second Item'),
  ],
);
```

### Using Spacing Scale Enum

```dart
// Using the enum for type safety
final spacing = FSSpacingScale.md.value; // 16.0

Container(
  padding: EdgeInsets.all(spacing),
  child: Text('Content'),
);

// Direct usage with extension
Container(
  margin: EdgeInsets.all(FSSpacingScale.lg.value),
  child: Text('Content'),
);
```

### Spacing Scale Utilities

```dart
// Get spacing by index
FSSpacing.byIndex(3); // Returns FSSpacing.md (16.0)

// Get all available spacing values
List<double> allSpacings = FSSpacing.values;

// Access as map
double smallSpacing = FSSpacing.map['sm']; // 8.0

// Using enum extensions
print(FSSpacingScale.md.name); // 'md'
print(FSSpacingScale.lg.value); // 24.0
```

## Custom Spacing Configurations

### Creating Custom Spacing

```dart
// Custom spacing scale for specific brand requirements
const brandSpacing = FSCustomSpacing(
  none: 0.0,
  xs: 2.0,    // Tighter than default
  sm: 6.0,    // Smaller base unit
  md: 12.0,   // Standard spacing
  lg: 20.0,   // Large spacing
  xl: 32.0,   // Extra large
  xxl: 48.0,  // Double extra large
  xxxl: 72.0, // Larger maximum
);

// Usage
Container(
  padding: EdgeInsets.all(brandSpacing.md), // 12.0
  child: Text('Brand Content'),
);
```

### Spacing Modifications

```dart
const baseSpacing = FSCustomSpacing();

// Create a copy with modifications
const compactSpacing = baseSpacing.copyWith(
  sm: 6.0,
  md: 12.0,
  lg: 18.0,
);

// Apply multiplier to all values
const largerSpacing = baseSpacing.withMultiplier(1.5);
// Results: sm=12.0, md=24.0, lg=36.0, etc.

// Get values using enum
double spacingValue = brandSpacing.value(FSSpacingScale.lg); // 20.0

// Get by index
double indexValue = brandSpacing.byIndex(3); // md value: 12.0
```

## Responsive Spacing

### Responsive Spacing Configuration

```dart
// Define responsive spacing that adapts to screen size
const responsiveSpacing = FSResponsiveSpacing(
  xs: FSCustomSpacing(sm: 6.0, md: 12.0, lg: 18.0), // Compact on mobile
  sm: FSCustomSpacing(sm: 8.0, md: 16.0, lg: 24.0), // Standard on small
  md: FSCustomSpacing(sm: 10.0, md: 20.0, lg: 30.0), // Larger on tablets
  lg: FSCustomSpacing(sm: 12.0, md: 24.0, lg: 36.0), // Desktop spacing
  xl: FSCustomSpacing(sm: 14.0, md: 28.0, lg: 42.0), // Large desktop
  xxl: FSCustomSpacing(sm: 16.0, md: 32.0, lg: 48.0), // Extra large
);

// Usage in responsive context
class ResponsiveSpacingExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final responsive = FSResponsive.fromContext(context);
    final spacing = responsiveSpacing.forBreakpoint(responsive.breakpoint);

    return Container(
      padding: EdgeInsets.all(spacing.md),
      margin: EdgeInsets.symmetric(vertical: spacing.lg),
      child: Text('Responsive Content'),
    );
  }
}
```

### Integrated with FSResponsive

```dart
FSResponsive.layoutBuilder(
  context,
  builder: (responsive) {
    final spacing = responsiveSpacing.forBreakpoint(responsive.breakpoint);

    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(spacing.md),
          child: Header(),
        ),
        SizedBox(height: spacing.lg),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: spacing.md),
            child: Content(),
          ),
        ),
        SizedBox(height: spacing.xl),
        Container(
          padding: EdgeInsets.all(spacing.sm),
          child: Footer(),
        ),
      ],
    );
  },
);
```

## Practical Usage Examples

### Consistent Layout Patterns

```dart
// Card layout with consistent spacing
Card(
  margin: EdgeInsets.all(FSSpacing.md),
  child: Padding(
    padding: EdgeInsets.all(FSSpacing.lg),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Card Title',
          style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(height: FSSpacing.sm),
        Text('Card content goes here...'),
        SizedBox(height: FSSpacing.md),
        Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: () {},
                child: Text('Action'),
              ),
            ),
            SizedBox(width: FSSpacing.sm),
            Expanded(
              child: FilledButton(
                onPressed: () {},
                child: Text('Primary'),
              ),
            ),
          ],
        ),
      ],
    ),
  ),
);
```

### List and Grid Spacing

```dart
// List with consistent item spacing
ListView.separated(
  padding: EdgeInsets.all(FSSpacing.md),
  itemCount: items.length,
  separatorBuilder: (context, index) => SizedBox(height: FSSpacing.sm),
  itemBuilder: (context, index) => ListTile(
    contentPadding: EdgeInsets.symmetric(
      horizontal: FSSpacing.sm,
      vertical: FSSpacing.xs,
    ),
    title: Text('Item $index'),
  ),
);

// Grid with responsive spacing
GridView.builder(
  padding: EdgeInsets.all(FSSpacing.md),
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: FSSpacing.sm,
    mainAxisSpacing: FSSpacing.sm,
    childAspectRatio: 1.0,
  ),
  itemCount: items.length,
  itemBuilder: (context, index) => Card(
    child: Padding(
      padding: EdgeInsets.all(FSSpacing.sm),
      child: Text('Grid Item $index'),
    ),
  ),
);
```

### Form Layout Spacing

```dart
// Form with consistent vertical rhythm
Form(
  child: Padding(
    padding: EdgeInsets.all(FSSpacing.lg),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact Form',
          style: Theme.of(context).textTheme.headline5,
        ),
        SizedBox(height: FSSpacing.xl),

        TextFormField(
          decoration: InputDecoration(
            labelText: 'Full Name',
            contentPadding: EdgeInsets.all(FSSpacing.sm),
          ),
        ),
        SizedBox(height: FSSpacing.md),

        TextFormField(
          decoration: InputDecoration(
            labelText: 'Email Address',
            contentPadding: EdgeInsets.all(FSSpacing.sm),
          ),
        ),
        SizedBox(height: FSSpacing.md),

        TextFormField(
          maxLines: 4,
          decoration: InputDecoration(
            labelText: 'Message',
            contentPadding: EdgeInsets.all(FSSpacing.sm),
          ),
        ),
        SizedBox(height: FSSpacing.xl),

        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {},
                child: Text('Cancel'),
              ),
            ),
            SizedBox(width: FSSpacing.md),
            Expanded(
              child: FilledButton(
                onPressed: () {},
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ],
    ),
  ),
);
```

## Advanced Usage Patterns

### Spacing Theme Integration

```dart
// Custom theme with spacing
class MyApp extends StatelessWidget {
  final FSCustomSpacing appSpacing = const FSCustomSpacing(
    sm: 8.0,
    md: 16.0,
    lg: 24.0,
    xl: 32.0,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        extensions: [
          _MySpacingTheme(spacing: appSpacing),
        ],
      ),
      home: HomePage(),
    );
  }
}

// Custom theme extension
class _MySpacingTheme extends ThemeExtension<_MySpacingTheme> {
  final FSCustomSpacing spacing;

  const _MySpacingTheme({required this.spacing});

  @override
  ThemeExtension<_MySpacingTheme> copyWith({FSCustomSpacing? spacing}) {
    return _MySpacingTheme(spacing: spacing ?? this.spacing);
  }

  @override
  ThemeExtension<_MySpacingTheme> lerp(
      ThemeExtension<_MySpacingTheme>? other, double t) {
    if (other is! _MySpacingTheme) return this;
    return _MySpacingTheme(spacing: spacing);
  }
}
```

### Responsive Spacing Helper

```dart
// Helper class for responsive spacing management
class SpacingManager {
  static final FSResponsiveSpacing responsiveSpacing = FSResponsiveSpacing(
    xs: FSCustomSpacing(sm: 6.0, md: 12.0, lg: 18.0),
    sm: FSCustomSpacing(sm: 8.0, md: 16.0, lg: 24.0),
    md: FSCustomSpacing(sm: 10.0, md: 20.0, lg: 30.0),
    lg: FSCustomSpacing(sm: 12.0, md: 24.0, lg: 36.0),
  );

  static FSCustomSpacing of(BuildContext context) {
    final responsive = FSResponsive.fromContext(context);
    return responsiveSpacing.forBreakpoint(responsive.breakpoint);
  }

  static EdgeInsets symmetricPadding(BuildContext context) {
    final spacing = of(context);
    return EdgeInsets.symmetric(
      horizontal: spacing.md,
      vertical: spacing.sm,
    );
  }

  static EdgeInsets cardPadding(BuildContext context) {
    final spacing = of(context);
    return EdgeInsets.all(spacing.md);
  }
}

// Usage
Widget build(BuildContext context) {
  return Padding(
    padding: SpacingManager.symmetricPadding(context),
    child: Card(
      child: Padding(
        padding: SpacingManager.cardPadding(context),
        child: Text('Consistently Spaced Content'),
      ),
    ),
  );
}
```

## Best Practices

### Spacing Hierarchy

```dart
// ✅ GOOD: Clear spacing hierarchy
Column(
  children: [
    // Large separation between major sections
    HeaderSection(),
    SizedBox(height: FSSpacing.xl),

    // Medium separation between related content
    ContentSection(),
    SizedBox(height: FSSpacing.lg),

    // Small separation between closely related items
    RelatedItemsSection(),
    SizedBox(height: FSSpacing.md),

    // Extra small for tight groupings
    MetadataSection(),
    SizedBox(height: FSSpacing.xs),

    FooterSection(),
  ],
);

// ❌ AVOID: Inconsistent spacing
Column(
  children: [
    HeaderSection(),
    SizedBox(height: 20), // Arbitrary value
    ContentSection(),
    SizedBox(height: 15), // Different arbitrary value
    FooterSection(),
  ],
);
```

### Responsive Spacing Strategy

```dart
// ✅ GOOD: Progressive spacing increase
FSResponsive.layoutBuilder(
  context,
  builder: (responsive) {
    final spacing = FSResponsiveSpacing(
      xs: FSCustomSpacing(md: 12.0, lg: 16.0),  // Compact on mobile
      sm: FSCustomSpacing(md: 16.0, lg: 20.0),  // Slightly larger
      md: FSCustomSpacing(md: 20.0, lg: 24.0),  // Tablet size
      lg: FSCustomSpacing(md: 24.0, lg: 32.0),  // Desktop
    ).forBreakpoint(responsive.breakpoint);

    return Container(
      padding: EdgeInsets.all(spacing.md),
      child: Content(),
    );
  },
);
```

### Performance Optimization

```dart
// ✅ GOOD: Cache spacing values in stateful widgets
class _MyWidgetState extends State<MyWidget> {
  late FSCustomSpacing _spacing;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final responsive = FSResponsive.fromContext(context);
    _spacing = responsiveSpacing.forBreakpoint(responsive.breakpoint);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(_spacing.md),
      child: Text('Content'),
    );
  }
}

// ✅ GOOD: Use const for static spacing values
static const _staticSpacing = FSCustomSpacing(md: 16.0, lg: 24.0);
```

## Troubleshooting

### Common Issues and Solutions

**Spacing feels too tight or too loose**

```dart
// Adjust the spacing scale for your needs
const comfortableSpacing = FSCustomSpacing(
  xs: 6.0,   // Slightly larger than default
  sm: 10.0,  // More breathing room
  md: 18.0,  // Standard spacing
  lg: 28.0,  // Generous separation
  xl: 40.0,  // Ample space for sections
);
```

**Responsive spacing not updating**

```dart
// ✅ Ensure using LayoutBuilder for automatic updates
FSResponsive.layoutBuilder(
  context,
  builder: (responsive) {
    final spacing = responsiveSpacing.forBreakpoint(responsive.breakpoint);
    return Container(padding: EdgeInsets.all(spacing.md));
  },
);

// ❌ This may not update on orientation changes
Widget build(BuildContext context) {
  final spacing = responsiveSpacing.forBreakpoint(
    FSResponsive.fromContext(context).breakpoint
  );
  return Container(padding: EdgeInsets.all(spacing.md));
}
```

**Inconsistent spacing across components**

```dart
// ✅ Create a centralized spacing configuration
class AppSpacing {
  static const FSCustomSpacing defaultSpacing = FSCustomSpacing();
  static const FSResponsiveSpacing responsiveSpacing = FSResponsiveSpacing();

  static EdgeInsets get cardPadding =>
      EdgeInsets.all(defaultSpacing.md);

  static EdgeInsets get sectionPadding =>
      EdgeInsets.symmetric(vertical: defaultSpacing.lg);

  static EdgeInsets get screenPadding =>
      EdgeInsets.all(defaultSpacing.md);
}

// Use consistently throughout the app
Card(
  margin: AppSpacing.cardPadding,
  child: Padding(
    padding: AppSpacing.cardPadding,
    child: Content(),
  ),
);
```

This comprehensive spacing system provides a solid foundation for creating visually consistent and professionally spaced Flutter applications that work beautifully across all device sizes and screen densities.
