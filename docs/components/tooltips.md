# Flutstrap Tooltip Component Guide

## Introduction

The **FlutstrapTooltip** is a highly customizable, accessible tooltip with Bootstrap-inspired styling, smooth animations, and intelligent positioning. It provides a robust solution for displaying contextual information with comprehensive accessibility support and performance optimizations.

### What the Component Does

FlutstrapTooltip offers:

- Multiple visual variants (8 color options)
- 12 positioning options (top, bottom, left, right with start/end variations)
- Smooth fade-in animations
- Arrow indicators
- Intelligent text measurement and caching
- Global tooltip management (prevents multiple tooltips)
- Comprehensive trigger methods (hover, tap, focus, long press)
- Error boundaries for graceful error handling

### When and Why to Use It

Use FlutstrapTooltip when you need:

- Additional context for UI elements
- Form field descriptions
- Button action explanations
- Icon meaning clarifications
- Any scenario requiring supplemental information
- Accessible help text for screen readers

### Prerequisites

- Flutter 3.0 or higher
- Flutstrap theme package

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

### Basic Tooltip

```dart
FlutstrapTooltip(
  message: 'This is a helpful tooltip',
  child: Text('Hover me'),
)

FlutstrapTooltip(
  message: 'Delete this item permanently',
  child: IconButton(
    icon: Icon(Icons.delete),
    onPressed: () => _deleteItem(),
  ),
)
```

### Tooltip with Custom Styling

```dart
FlutstrapTooltip(
  message: 'Custom styled tooltip',
  variant: FSTooltipVariant.danger,
  padding: EdgeInsets.all(12),
  maxWidth: 250,
  borderRadius: BorderRadius.circular(8),
  child: Text('Custom Tooltip'),
)
```

## Component Variants

FlutstrapTooltip offers 8 visual variants:

### Primary

```dart
FlutstrapTooltip(
  message: 'Primary tooltip',
  variant: FSTooltipVariant.primary,
  child: Text('Primary'),
)
```

### Secondary

```dart
FlutstrapTooltip(
  message: 'Secondary tooltip',
  variant: FSTooltipVariant.secondary,
  child: Text('Secondary'),
)
```

### Success

```dart
FlutstrapTooltip(
  message: 'Success tooltip',
  variant: FSTooltipVariant.success,
  child: Text('Success'),
)
```

### Danger

```dart
FlutstrapTooltip(
  message: 'Danger action',
  variant: FSTooltipVariant.danger,
  child: Text('Danger'),
)
```

### Warning

```dart
FlutstrapTooltip(
  message: 'Warning message',
  variant: FSTooltipVariant.warning,
  child: Text('Warning'),
)
```

### Info

```dart
FlutstrapTooltip(
  message: 'Information tooltip',
  variant: FSTooltipVariant.info,
  child: Text('Info'),
)
```

### Light

```dart
FlutstrapTooltip(
  message: 'Light tooltip',
  variant: FSTooltipVariant.light,
  child: Text('Light'),
)
```

### Dark

```dart
FlutstrapTooltip(
  message: 'Dark tooltip',
  variant: FSTooltipVariant.dark,
  child: Text('Dark'),
)
```

## Tooltip Placement

### Top Positions

```dart
// Top center
FlutstrapTooltip(
  message: 'Top tooltip',
  placement: FSTooltipPlacement.top,
  child: Text('Top'),
)

// Top start (aligned to left)
FlutstrapTooltip(
  message: 'Top start tooltip',
  placement: FSTooltipPlacement.topStart,
  child: Text('Top Start'),
)

// Top end (aligned to right)
FlutstrapTooltip(
  message: 'Top end tooltip',
  placement: FSTooltipPlacement.topEnd,
  child: Text('Top End'),
)
```

### Bottom Positions

```dart
// Bottom center
FlutstrapTooltip(
  message: 'Bottom tooltip',
  placement: FSTooltipPlacement.bottom,
  child: Text('Bottom'),
)

// Bottom start
FlutstrapTooltip(
  message: 'Bottom start tooltip',
  placement: FSTooltipPlacement.bottomStart,
  child: Text('Bottom Start'),
)

// Bottom end
FlutstrapTooltip(
  message: 'Bottom end tooltip',
  placement: FSTooltipPlacement.bottomEnd,
  child: Text('Bottom End'),
)
```

### Right Positions

```dart
// Right center
FlutstrapTooltip(
  message: 'Right tooltip',
  placement: FSTooltipPlacement.right,
  child: Text('Right'),
)

// Right start
FlutstrapTooltip(
  message: 'Right start tooltip',
  placement: FSTooltipPlacement.rightStart,
  child: Text('Right Start'),
)

// Right end
FlutstrapTooltip(
  message: 'Right end tooltip',
  placement: FSTooltipPlacement.rightEnd,
  child: Text('Right End'),
)
```

### Left Positions

```dart
// Left center
FlutstrapTooltip(
  message: 'Left tooltip',
  placement: FSTooltipPlacement.left,
  child: Text('Left'),
)

// Left start
FlutstrapTooltip(
  message: 'Left start tooltip',
  placement: FSTooltipPlacement.leftStart,
  child: Text('Left Start'),
)

// Left end
FlutstrapTooltip(
  message: 'Left end tooltip',
  placement: FSTooltipPlacement.leftEnd,
  child: Text('Left End'),
)
```

## Properties & Parameters

### Parameter Reference Table

| Parameter           | Type                    | Default                                            | Description                        |
| ------------------- | ----------------------- | -------------------------------------------------- | ---------------------------------- |
| `message`           | `String`                | **Required**                                       | Tooltip text content               |
| `child`             | `Widget`                | **Required**                                       | Widget that triggers the tooltip   |
| `variant`           | `FSTooltipVariant`      | `primary`                                          | Visual style variant               |
| `placement`         | `FSTooltipPlacement`    | `top`                                              | Tooltip position relative to child |
| `showDelay`         | `Duration`              | `100ms`                                            | Delay before showing tooltip       |
| `hideDelay`         | `Duration`              | `100ms`                                            | Delay before hiding tooltip        |
| `animationDuration` | `Duration`              | `200ms`                                            | Fade animation duration            |
| `showArrow`         | `bool`                  | `true`                                             | Whether to show arrow indicator    |
| `maxWidth`          | `double`                | `200.0`                                            | Maximum tooltip width              |
| `padding`           | `EdgeInsetsGeometry`    | `EdgeInsets.symmetric(horizontal: 8, vertical: 4)` | Tooltip content padding            |
| `textStyle`         | `TextStyle?`            | `null`                                             | Custom text style                  |
| `backgroundColor`   | `Color?`                | `null`                                             | Custom background color            |
| `borderRadius`      | `BorderRadiusGeometry?` | `null`                                             | Custom border radius               |
| `onShowError`       | `Function?`             | `null`                                             | Error callback for show operations |
| `onHideError`       | `Function?`             | `null`                                             | Error callback for hide operations |

### FSTooltipVariant Enum

```dart
enum FSTooltipVariant {
  primary, secondary, success, danger, warning, info, light, dark
}
```

### FSTooltipPlacement Enum

```dart
enum FSTooltipPlacement {
  top, topStart, topEnd,
  right, rightStart, rightEnd,
  bottom, bottomStart, bottomEnd,
  left, leftStart, leftEnd
}
```

## Advanced Features

### Custom Timing and Animation

```dart
FlutstrapTooltip(
  message: 'Custom timing tooltip',
  showDelay: Duration(milliseconds: 500), // Show after 500ms
  hideDelay: Duration(milliseconds: 200), // Hide after 200ms
  animationDuration: Duration(milliseconds: 300), // 300ms fade
  child: Text('Custom Timing'),
)
```

### Without Arrow

```dart
FlutstrapTooltip(
  message: 'Tooltip without arrow',
  showArrow: false,
  child: Text('No Arrow'),
)
```

### Custom Styling

```dart
FlutstrapTooltip(
  message: 'Fully customized tooltip',
  backgroundColor: Colors.purple,
  textStyle: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  ),
  padding: EdgeInsets.all(16),
  borderRadius: BorderRadius.circular(12),
  maxWidth: 300,
  child: Text('Custom Style'),
)
```

### Error Handling

```dart
FlutstrapTooltip(
  message: 'Tooltip with error handling',
  onShowError: (error) {
    print('Tooltip show error: $error');
    // Log to analytics or show fallback
  },
  onHideError: (error) {
    print('Tooltip hide error: $error');
  },
  child: Text('With Error Handling'),
)
```

### Using Error Boundary

```dart
FlutstrapTooltip.buildWithErrorBoundary(
  message: complexMessage,
  child: MyComplexWidget(),
  fallback: Text('Tooltip unavailable'),
  variant: FSTooltipVariant.warning,
)
```

## Integration Examples

### Form Field Tooltips

```dart
Column(
  children: [
    FlutstrapTooltip(
      message: 'Enter your full legal name as it appears on official documents',
      placement: FSTooltipPlacement.right,
      variant: FSTooltipVariant.info,
      child: FlutstrapInput(
        label: 'Full Name',
        onChanged: (value) {},
      ),
    ),
    SizedBox(height: 16),
    FlutstrapTooltip(
      message: 'We\'ll send a confirmation email to this address',
      placement: FSTooltipPlacement.right,
      variant: FSTooltipVariant.info,
      child: FlutstrapInput(
        label: 'Email Address',
        onChanged: (value) {},
      ),
    ),
  ],
)
```

### Icon Button Tooltips

```dart
Row(
  children: [
    FlutstrapTooltip(
      message: 'Edit item',
      placement: FSTooltipPlacement.bottom,
      child: IconButton(
        icon: Icon(Icons.edit),
        onPressed: () => _editItem(),
      ),
    ),
    FlutstrapTooltip(
      message: 'Delete item permanently',
      placement: FSTooltipPlacement.bottom,
      variant: FSTooltipVariant.danger,
      child: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () => _deleteItem(),
      ),
    ),
    FlutstrapTooltip(
      message: 'Share with others',
      placement: FSTooltipPlacement.bottom,
      variant: FSTooltipVariant.success,
      child: IconButton(
        icon: Icon(Icons.share),
        onPressed: () => _shareItem(),
      ),
    ),
  ],
)
```

### Navigation Tooltips

```dart
BottomNavigationBar(
  items: [
    BottomNavigationBarItem(
      icon: FlutstrapTooltip(
        message: 'Home dashboard',
        placement: FSTooltipPlacement.top,
        child: Icon(Icons.home),
      ),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: FlutstrapTooltip(
        message: 'Search content',
        placement: FSTooltipPlacement.top,
        child: Icon(Icons.search),
      ),
      label: 'Search',
    ),
    BottomNavigationBarItem(
      icon: FlutstrapTooltip(
        message: 'Your profile settings',
        placement: FSTooltipPlacement.top,
        child: Icon(Icons.person),
      ),
      label: 'Profile',
    ),
  ],
)
```

### Data Table with Tooltips

```dart
DataTable(
  columns: [
    DataColumn(
      label: FlutstrapTooltip(
        message: 'Unique identifier for each user',
        placement: FSTooltipPlacement.bottom,
        child: Text('ID'),
      ),
    ),
    DataColumn(
      label: FlutstrapTooltip(
        message: 'User\'s full name',
        placement: FSTooltipPlacement.bottom,
        child: Text('Name'),
      ),
    ),
    DataColumn(
      label: FlutstrapTooltip(
        message: 'User role and permissions',
        placement: FSTooltipPlacement.bottom,
        child: Text('Role'),
      ),
    ),
  ],
  rows: users.map((user) => DataRow(
    cells: [
      DataCell(Text(user.id)),
      DataCell(Text(user.name)),
      DataCell(
        FlutstrapTooltip(
          message: _getRoleDescription(user.role),
          placement: FSTooltipPlacement.right,
          variant: _getRoleVariant(user.role),
          child: Text(user.role),
        ),
      ),
    ],
  )).toList(),
)
```

### Complex Tooltip with Custom Content

```dart
FlutstrapTooltip(
  message: 'Status: Online\nLast active: 2 minutes ago\nRole: Administrator',
  placement: FSTooltipPlacement.right,
  maxWidth: 200,
  padding: EdgeInsets.all(12),
  child: CircleAvatar(
    backgroundColor: Colors.green,
    child: Text('JD'),
  ),
)
```

## Trigger Methods

### Multiple Trigger Types

The tooltip supports multiple interaction methods:

```dart
FlutstrapTooltip(
  message: 'This tooltip responds to multiple interactions',
  child: Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text('Interact with me'),
  ),
)
```

**Supported interactions:**

- **Hover** (desktop/mouse) - Mouse over the element
- **Tap** (mobile/touch) - Tap and hold
- **Focus** (keyboard) - Tab navigation
- **Long Press** (mobile) - Alternative mobile trigger

## Accessibility Notes

FlutstrapTooltip includes comprehensive accessibility features:

- **Screen Reader Support**: Uses semantic labels and tooltip properties
- **Keyboard Navigation**: Full support for focus management
- **Touch Support**: Proper touch interactions for mobile devices
- **Live Regions**: Dynamic content announcements
- **ARIA Compliance**: Proper attributes for screen readers

```dart
FlutstrapTooltip(
  message: 'Accessible tooltip description',
  child: YourWidget(),
  // Automatically provides:
  // - Semantic tooltip property
  // - Focus management
  // - Touch and keyboard support
)
```

## Performance Features

### Text Measurement Caching

```dart
// Tooltip text measurements are automatically cached
FlutstrapTooltip(
  message: 'This text measurement is cached for performance',
  child: Text('Cached Tooltip'),
)

// Clear cache if needed (rarely necessary)
_TextMeasurementCache.clearCache();
```

### Global Tooltip Management

```dart
// Only one tooltip shows at a time automatically
Column(
  children: [
    FlutstrapTooltip(message: 'Tooltip 1', child: Text('Item 1')),
    FlutstrapTooltip(message: 'Tooltip 2', child: Text('Item 2')),
    FlutstrapTooltip(message: 'Tooltip 3', child: Text('Item 3')),
  ],
)
// When hovering between items, only one tooltip shows at a time
```

### Debounced Interactions

```dart
// Rapid interactions are debounced to prevent flickering
FlutstrapTooltip(
  message: 'Debounced tooltip',
  showDelay: Duration(milliseconds: 100), // Default debounce
  child: Text('Debounced'),
)
```

## Best Practices

### Content Guidelines

```dart
// ✅ Good - Concise and helpful
FlutstrapTooltip(
  message: 'Delete this item permanently',
  child: IconButton(icon: Icon(Icons.delete), onPressed: () {}),
)

// ✅ Good - Actionable information
FlutstrapTooltip(
  message: 'Click to edit this field',
  child: TextField(decoration: InputDecoration(labelText: 'Name')),
)

// ❌ Avoid - Too verbose
FlutstrapTooltip(
  message: 'This button when clicked will open a dialog that allows you to configure the settings for the current project which includes various options and preferences that can be customized according to your specific needs and requirements.',
  child: Text('Settings'),
)
```

### Placement Guidelines

```dart
// Choose placement based on available space
FlutstrapTooltip(
  message: 'Tooltip',
  placement: FSTooltipPlacement.bottom, // Good for top-aligned elements
  child: Text('Bottom Tooltip'),
)

FlutstrapTooltip(
  message: 'Tooltip',
  placement: FSTooltipPlacement.right, // Good for left-aligned elements
  child: Text('Right Tooltip'),
)
```

### Mobile Considerations

```dart
// Use appropriate timing for mobile
FlutstrapTooltip(
  message: 'Mobile-friendly tooltip',
  showDelay: Duration(milliseconds: 300), // Slightly longer for mobile
  hideDelay: Duration(milliseconds: 500), // Give users time to read
  child: Text('Mobile Tooltip'),
)
```

## Troubleshooting

### Common Issues and Solutions

**Tooltip Not Showing**

```dart
// Ensure the widget has sufficient size and is interactive
FlutstrapTooltip(
  message: 'Tooltip message',
  child: Container(
    width: 50, // Must have sufficient size
    height: 50,
    color: Colors.blue,
    child: Center(child: Text('Tap me')),
  ),
)

// Check if parent widgets are blocking interactions
AbsorbPointer(
  absorbing: false, // Must not block interactions
  child: FlutstrapTooltip(...),
)
```

**Positioning Issues**

```dart
// Use appropriate placement for your layout
FlutstrapTooltip(
  message: 'Tooltip',
  placement: FSTooltipPlacement.bottom, // Try different placements
  child: YourWidget(),
)

// Ensure the widget is in the viewport
SingleChildScrollView(
  child: FlutstrapTooltip(...), // Tooltip may position incorrectly if scrolled
)
```

**Performance Issues**

```dart
// Avoid too many tooltips in lists
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) => FlutstrapTooltip(
    message: items[index].tooltip,
    child: ListTile(title: Text(items[index].name)),
  ),
)

// Use error boundaries for dynamic content
FlutstrapTooltip.buildWithErrorBoundary(
  message: dynamicContent,
  child: YourWidget(),
  fallback: Text('Tooltip error'),
)
```

**Accessibility Issues**

```dart
// Provide meaningful tooltip content
FlutstrapTooltip(
  message: 'Submit the form data', // Descriptive and helpful
  child: ElevatedButton(
    onPressed: () {},
    child: Text('Submit'),
  ),
)

// Ensure tooltips don't block other interactive elements
Stack(
  children: [
    YourContent(),
    Positioned(
      child: FlutstrapTooltip(...), // Position carefully in overlays
    ),
  ],
)
```

This comprehensive guide covers all aspects of using the FlutstrapTooltip component. The tooltip system is designed to be highly flexible, performant, and accessible while providing a robust solution for contextual information across various interaction patterns and device types.
