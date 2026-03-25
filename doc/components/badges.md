# Flutstrap Badge Component Guide

## Introduction

The **FlutstrapBadge** is a small label and counting component with Bootstrap-inspired styling. It provides flexible badge patterns for notifications, status indicators, and count displays with comprehensive theming and performance optimizations.

### What the Component Does

FlutstrapBadge offers:

- Multiple visual variants (8 color options)
- Three size options (sm, md, lg)
- Count badges with max limits
- Dot indicators for status
- Pill-shaped badges
- Positioned badges on other widgets
- Interactive badges with tap support
- Performance-optimized style caching

### When and Why to Use It

Use FlutstrapBadge when you need:

- Notification counters on icons
- Status indicators (online, busy, etc.)
- Small labels for categories or tags
- Count displays with overflow handling
- Visual indicators without text
- Interactive badge elements

### Prerequisites

- Flutter 3.0 or higher
- Flutstrap theme package
- Material Design Icons

## Installation & Setup

### Required Import

```dart
import 'package:flutstrap/flutstrap.dart';
```

### Theme Configuration

```dart
void main() {
  runApp(
    FSTheme(
      data: FSThemeData.light(), // or FSThemeData.dark()
      child: MyApp(),
    ),
  );
}
```

## Basic Usage

### Text Badges

```dart
FlutstrapBadge(
  text: 'New',
  variant: FSBadgeVariant.primary,
)

FlutstrapBadge(
  text: 'Featured',
  variant: FSBadgeVariant.success,
  size: FSBadgeSize.sm,
)
```

### Count Badges

```dart
FlutstrapBadge.count(
  count: 5,
  variant: FSBadgeVariant.danger,
)

FlutstrapBadge.count(
  count: 150,
  maxCount: 99, // Shows "99+" when count exceeds max
  variant: FSBadgeVariant.warning,
)
```

### Dot Indicators

```dart
FlutstrapBadge.dot(
  variant: FSBadgeVariant.success,
)

FlutstrapBadge.dot(
  variant: FSBadgeVariant.danger,
  size: FSBadgeSize.lg,
)
```

## Component Variants

FlutstrapBadge offers 8 visual variants:

### Primary

```dart
FlutstrapBadge(text: 'Primary', variant: FSBadgeVariant.primary)
```

### Secondary

```dart
FlutstrapBadge(text: 'Secondary', variant: FSBadgeVariant.secondary)
```

### Success

```dart
FlutstrapBadge(text: 'Success', variant: FSBadgeVariant.success)
```

### Danger

```dart
FlutstrapBadge(text: 'Danger', variant: FSBadgeVariant.danger)
```

### Warning

```dart
FlutstrapBadge(text: 'Warning', variant: FSBadgeVariant.warning)
```

### Info

```dart
FlutstrapBadge(text: 'Info', variant: FSBadgeVariant.info)
```

### Light

```dart
FlutstrapBadge(text: 'Light', variant: FSBadgeVariant.light)
```

### Dark

```dart
FlutstrapBadge(text: 'Dark', variant: FSBadgeVariant.dark)
```

## Badge Sizes

### Small (sm)

```dart
FlutstrapBadge(
  text: 'Small',
  variant: FSBadgeVariant.primary,
  size: FSBadgeSize.sm,
)
```

### Medium (md) - Default

```dart
FlutstrapBadge(
  text: 'Medium',
  variant: FSBadgeVariant.primary,
  size: FSBadgeSize.md,
)
```

### Large (lg)

```dart
FlutstrapBadge(
  text: 'Large',
  variant: FSBadgeVariant.primary,
  size: FSBadgeSize.lg,
)
```

## Properties & Parameters

### Parameter Reference Table

| Parameter         | Type             | Default      | Description                      |
| ----------------- | ---------------- | ------------ | -------------------------------- |
| `text`            | `String`         | **Required** | Badge text content               |
| `count`           | `int?`           | `null`       | Count number for count badges    |
| `variant`         | `FSBadgeVariant` | `primary`    | Visual style variant             |
| `size`            | `FSBadgeSize`    | `md`         | Badge size (sm, md, lg)          |
| `pill`            | `bool`           | `false`      | Whether to use pill shape        |
| `dot`             | `bool`           | `false`      | Whether to show as dot indicator |
| `child`           | `Widget?`        | `null`       | Widget to position badge on      |
| `onTap`           | `VoidCallback?`  | `null`       | Callback when badge is tapped    |
| `backgroundColor` | `Color?`         | `null`       | Custom background color          |
| `textColor`       | `Color?`         | `null`       | Custom text color                |
| `maxCount`        | `int?`           | `null`       | Maximum count before showing "+" |

### FSBadgeVariant Enum

```dart
enum FSBadgeVariant {
  primary, secondary, success, danger, warning, info, light, dark
}
```

### FSBadgeSize Enum

```dart
enum FSBadgeSize {
  sm,  // Small: compact padding, smaller text
  md,  // Medium: standard padding, normal text
  lg   // Large: generous padding, larger text
}
```

## Specialized Constructors

### Count Badge Constructor

```dart
FlutstrapBadge.count(
  count: 25,
  variant: FSBadgeVariant.danger,
  maxCount: 99, // Shows "99+" when count > 99
  pill: true, // Count badges are pill-shaped by default
)
```

### Dot Badge Constructor

```dart
FlutstrapBadge.dot(
  variant: FSBadgeVariant.success,
  size: FSBadgeSize.md,
)
```

## Customization

### Pill-shaped Badges

```dart
FlutstrapBadge(
  text: 'Pill Badge',
  variant: FSBadgeVariant.primary,
  pill: true, // Rounded ends
)

FlutstrapBadge.count(
  count: 42,
  pill: true, // Default for count badges
)
```

### Custom Colors

```dart
FlutstrapBadge(
  text: 'Custom',
  backgroundColor: Colors.purple,
  textColor: Colors.white,
)

FlutstrapBadge.dot(
  backgroundColor: Colors.orange,
)
```

### Interactive Badges

```dart
FlutstrapBadge(
  text: 'Clickable',
  variant: FSBadgeVariant.primary,
  onTap: () {
    print('Badge tapped!');
    // Handle badge tap
  },
)
```

## Positioned Badges

### Using FlutstrapBadgePositioned

```dart
FlutstrapBadgePositioned(
  child: Icon(Icons.notifications, size: 24),
  badge: FlutstrapBadge.count(count: 3),
  alignment: Alignment.topRight,
)
```

### Using Child Parameter

```dart
FlutstrapBadge(
  text: 'New',
  variant: FSBadgeVariant.danger,
  child: Icon(Icons.email, size: 24),
)
```

### Custom Positions

```dart
FlutstrapBadgePositioned(
  child: Container(
    width: 40,
    height: 40,
    color: Colors.blue,
    child: Icon(Icons.person, color: Colors.white),
  ),
  badge: FlutstrapBadge.dot(variant: FSBadgeVariant.success),
  alignment: Alignment.bottomLeft, // Position at bottom left
)
```

## Advanced Patterns

### Combined Text and Count

```dart
FlutstrapBadge(
  text: 'Messages',
  count: 5,
  variant: FSBadgeVariant.info,
)
// Displays: "Messages (5)"
```

### Status Indicators

```dart
// Online status
FlutstrapBadgePositioned(
  child: CircleAvatar(
    backgroundImage: NetworkImage('https://picsum.photos/100'),
  ),
  badge: FlutstrapBadge.dot(variant: FSBadgeVariant.success),
  alignment: Alignment.bottomRight,
)

// Busy status
FlutstrapBadgePositioned(
  child: CircleAvatar(
    backgroundImage: NetworkImage('https://picsum.photos/101'),
  ),
  badge: FlutstrapBadge.dot(variant: FSBadgeVariant.warning),
  alignment: Alignment.bottomRight,
)
```

### Using copyWith for Modifications

```dart
// Base badge
final baseBadge = FlutstrapBadge(
  text: 'Base',
  variant: FSBadgeVariant.primary,
);

// Modified versions
final successBadge = baseBadge.copyWith(
  text: 'Success',
  variant: FSBadgeVariant.success,
);

final largeBadge = baseBadge.copyWith(
  text: 'Large',
  size: FSBadgeSize.lg,
);

final countBadge = baseBadge.copyWith(
  text: '',
  count: 5,
  pill: true,
);
```

## Integration Examples

### Navigation Bar with Badges

```dart
BottomNavigationBar(
  items: [
    BottomNavigationBarItem(
      icon: FlutstrapBadgePositioned(
        child: Icon(Icons.home),
        badge: FlutstrapBadge.dot(variant: FSBadgeVariant.success),
        alignment: Alignment.topRight,
      ),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: FlutstrapBadgePositioned(
        child: Icon(Icons.message),
        badge: FlutstrapBadge.count(count: 3),
        alignment: Alignment.topRight,
      ),
      label: 'Messages',
    ),
    BottomNavigationBarItem(
      icon: FlutstrapBadgePositioned(
        child: Icon(Icons.notifications),
        badge: FlutstrapBadge.count(count: 12, maxCount: 9),
        alignment: Alignment.topRight,
      ),
      label: 'Notifications',
    ),
  ],
)
```

### List Items with Status Badges

```dart
ListView(
  children: [
    ListTile(
      leading: FlutstrapBadgePositioned(
        child: CircleAvatar(child: Icon(Icons.person)),
        badge: FlutstrapBadge.dot(variant: FSBadgeVariant.success),
        alignment: Alignment.bottomRight,
      ),
      title: Text('John Doe'),
      subtitle: Text('Online'),
      trailing: FlutstrapBadge(text: 'Admin', variant: FSBadgeVariant.primary),
    ),
    ListTile(
      leading: FlutstrapBadgePositioned(
        child: CircleAvatar(child: Icon(Icons.person)),
        badge: FlutstrapBadge.dot(variant: FSBadgeVariant.warning),
        alignment: Alignment.bottomRight,
      ),
      title: Text('Jane Smith'),
      subtitle: Text('Away'),
      trailing: FlutstrapBadge.count(count: 3, variant: FSBadgeVariant.danger),
    ),
  ],
)
```

### Card with Multiple Badges

```dart
FlutstrapCard(
  headerText: 'Project Task',
  bodyText: 'Implement user authentication system',
  footer: Wrap(
    spacing: 8,
    children: [
      FlutstrapBadge(
        text: 'High Priority',
        variant: FSBadgeVariant.danger,
        size: FSBadgeSize.sm,
      ),
      FlutstrapBadge(
        text: 'Backend',
        variant: FSBadgeVariant.info,
        size: FSBadgeSize.sm,
      ),
      FlutstrapBadge.count(
        count: 2,
        variant: FSBadgeVariant.warning,
        size: FSBadgeSize.sm,
      ),
    ],
  ),
)
```

## Accessibility Notes

FlutstrapBadge includes comprehensive accessibility features:

- **Screen Reader Support**: Uses `Semantics` widget with proper labels
- **Count Announcements**: Count badges announce "Count: X" to screen readers
- **Dot Indicators**: Dot badges announce as "Indicator"
- **Interactive Semantics**: Badges with `onTap` are announced as buttons
- **Color Contrast**: Follows WCAG guidelines for text and background colors

```dart
FlutstrapBadge(
  text: 'Important', // Used in semantic label
  count: 5, // Announces "Important count: 5"
  onTap: () {}, // Announces as button
)
```

## Performance Features

### Style Caching

```dart
// Styles are automatically cached by variant, size, and theme
// Multiple badges with same configuration reuse computed styles
FlutstrapBadge(
  text: 'Cached',
  variant: FSBadgeVariant.primary,
  size: FSBadgeSize.md,
)
```

## Best Practices

### Content Guidelines

- **Keep Text Short**: Badges work best with 1-3 words
- **Use Counts Sparingly**: Only show counts when they provide value
- **Choose Appropriate Variants**:
  - `primary`: Main actions or primary categories
  - `success`: Positive status or completed items
  - `danger`: Errors, warnings, or urgent items
  - `warning`: Caution or pending status
  - `info`: Informational or neutral status

### Size Guidelines

- `sm`: For dense interfaces or small containers
- `md`: Standard size for most use cases
- `lg`: For emphasis or in larger containers

### Count Display

```dart
// ✅ Good - Reasonable max count
FlutstrapBadge.count(count: 150, maxCount: 99) // Shows "99+"

// ✅ Good - No max for exact counts when needed
FlutstrapBadge.count(count: 42) // Shows "42"

// ❌ Avoid - Unbounded large numbers
FlutstrapBadge.count(count: 10000) // Shows "10000" (too long)
```

## Troubleshooting

### Common Issues and Solutions

**Badge Not Positioning Correctly**

```dart
// Use FlutstrapBadgePositioned for precise positioning
FlutstrapBadgePositioned(
  child: YourWidget(),
  badge: FlutstrapBadge.count(count: 5),
  alignment: Alignment.topRight, // Explicit alignment
)

// Ensure parent has enough space for positioned badge
Container(
  width: 40,
  height: 40,
  child: FlutstrapBadgePositioned(...),
)
```

**Count Not Displaying**

```dart
// Use count constructor or set count parameter
FlutstrapBadge.count(count: 5) // Correct
FlutstrapBadge(text: '', count: 5) // Also works

// Ensure text is empty when using count as primary display
FlutstrapBadge(text: 'Items', count: 5) // Shows "Items (5)"
```

**Dot Size Issues**

```dart
// Dot size is controlled by badge size
FlutstrapBadge.dot(size: FSBadgeSize.lg) // Larger dot
FlutstrapBadge.dot(size: FSBadgeSize.sm) // Smaller dot
```

**Custom Colors Not Applying**

```dart
FlutstrapBadge(
  text: 'Custom',
  backgroundColor: Colors.purple, // Custom background
  textColor: Colors.white, // Custom text color
  variant: FSBadgeVariant.primary, // Still required but overridden
)
```

This comprehensive guide covers all aspects of using the FlutstrapBadge component. The badge system is designed to be flexible, performant, and accessible while providing a consistent way to display labels, counts, and status indicators throughout your application.
