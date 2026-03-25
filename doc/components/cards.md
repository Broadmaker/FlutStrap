# Flutstrap Card Component Guide

## Introduction

The **FlutstrapCard** is a high-performance, flexible card component with comprehensive theming, multiple variants, and optimized rendering patterns. It provides a robust container for displaying content and actions with built-in performance optimizations and accessibility features.

### What the Component Does

FlutstrapCard offers:

- Multiple visual variants (elevated, outlined, filled, surface)
- Flexible content sections (header, body, footer)
- Performance optimizations with style caching
- Built-in error boundaries for graceful error handling
- Interactive card support with tap actions
- Factory methods for common card patterns
- Comprehensive accessibility support

### When and Why to Use It

Use FlutstrapCard when you need:

- Consistent card layouts across your app
- Performance-optimized cards in lists or grids
- Interactive content containers
- Cards with structured content sections
- Graceful error handling for dynamic content
- Bootstrap-inspired card designs

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

### Simple Card with Text Content

```dart
FlutstrapCard(
  headerText: 'Card Title',
  bodyText: 'This is the main content of the card. It can contain any text content you need to display to the user.',
  footerText: 'Footer information',
)
```

### Using Factory Methods

```dart
// Simple card pattern
FlutstrapCard.simple(
  title: 'Simple Card',
  content: 'This uses the simple factory pattern for better performance.',
  footer: 'Cached pattern',
)

// Action card with buttons
FlutstrapCard.action(
  title: 'Action Card',
  content: 'This card includes action buttons in the footer.',
  actions: [
    FlutstrapButton(
      onPressed: () {},
      text: 'Action 1',
    ),
    SizedBox(width: 8),
    FlutstrapButton(
      onPressed: () {},
      text: 'Action 2',
    ),
  ],
)
```

## Component Variants

FlutstrapCard offers 4 visual variants:

### Elevated Card (Default)

```dart
FlutstrapCard(
  headerText: 'Elevated Card',
  bodyText: 'This card has a shadow and appears elevated above the surface.',
  variant: FSCardVariant.elevated,
)
```

### Outlined Card

```dart
FlutstrapCard(
  headerText: 'Outlined Card',
  bodyText: 'This card has a border outline instead of a shadow.',
  variant: FSCardVariant.outlined,
)
```

### Filled Card

```dart
FlutstrapCard(
  headerText: 'Filled Card',
  bodyText: 'This card has a subtle background fill color.',
  variant: FSCardVariant.filled,
)
```

### Surface Card

```dart
FlutstrapCard(
  headerText: 'Surface Card',
  bodyText: 'This card uses the surface color from the theme.',
  variant: FSCardVariant.surface,
)
```

## Properties & Parameters

### Parameter Reference Table

| Parameter         | Type                  | Default        | Description                               |
| ----------------- | --------------------- | -------------- | ----------------------------------------- |
| `header`          | `Widget?`             | `null`         | Custom header widget                      |
| `headerText`      | `String?`             | `null`         | Text content for header                   |
| `body`            | `Widget?`             | `null`         | Custom body widget                        |
| `bodyText`        | `String?`             | `null`         | Text content for body                     |
| `footer`          | `Widget?`             | `null`         | Custom footer widget                      |
| `footerText`      | `String?`             | `null`         | Text content for footer                   |
| `padding`         | `EdgeInsetsGeometry?` | `FSSpacing.md` | Padding for content sections              |
| `backgroundColor` | `Color?`              | `null`         | Custom background color                   |
| `borderColor`     | `Color?`              | `null`         | Custom border color                       |
| `elevation`       | `double?`             | `null`         | Custom elevation                          |
| `borderRadius`    | `double`              | `8.0`          | Border radius for card                    |
| `borderWidth`     | `double`              | `1.0`          | Border width for outlined variant         |
| `shadow`          | `List<BoxShadow>?`    | `null`         | Custom shadows                            |
| `showDividers`    | `bool`                | `true`         | Whether to show dividers between sections |
| `variant`         | `FSCardVariant`       | `elevated`     | Visual style variant                      |
| `onTap`           | `VoidCallback?`       | `null`         | Callback when card is tapped              |
| `onLongPress`     | `VoidCallback?`       | `null`         | Callback for long press                   |
| `interactive`     | `bool`                | `false`        | Whether card is interactive               |

### FSCardVariant Enum

```dart
enum FSCardVariant {
  elevated,  // Shadow elevation
  outlined,  // Border outline
  filled,    // Background fill
  surface,   // Surface color
}
```

## Customization

### Custom Content Sections

```dart
FlutstrapCard(
  header: Row(
    children: [
      Icon(Icons.star, color: Colors.amber),
      SizedBox(width: 8),
      Text('Custom Header'),
    ],
  ),
  body: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Custom body content'),
      SizedBox(height: 8),
      FlutstrapButton(
        onPressed: () {},
        text: 'Button in body',
      ),
    ],
  ),
  footer: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text('Left footer'),
      Text('Right footer'),
    ],
  ),
)
```

### Custom Styling

```dart
FlutstrapCard(
  headerText: 'Custom Styled Card',
  bodyText: 'This card has custom styling applied.',
  backgroundColor: Colors.blue.shade50,
  borderColor: Colors.blue,
  borderRadius: 16.0,
  borderWidth: 2.0,
  padding: EdgeInsets.all(20),
)
```

### Using copyWith for Modifications

```dart
// Base card
final baseCard = FlutstrapCard(
  headerText: 'Base Card',
  bodyText: 'This is the base content.',
);

// Modified versions
final outlinedCard = baseCard.asOutlined();
final filledCard = baseCard.asFilled();
final noDividersCard = baseCard.withoutDividers();
final interactiveCard = baseCard.asInteractive();
```

## Factory Methods

### Simple Card Factory

```dart
FlutstrapCard.simple(
  title: 'User Profile',
  content: 'John Doe\nSoftware Developer\nSan Francisco, CA',
  footer: 'Last updated: 2 hours ago',
  variant: FSCardVariant.outlined,
)
```

### Image Card Factory

```dart
FlutstrapCard.image(
  image: Image.network(
    'https://picsum.photos/400/200',
    fit: BoxFit.cover,
    height: 200,
  ),
  title: 'Beautiful Landscape',
  content: 'This is an example of an image card with a title and content below the image.',
  actions: [
    FlutstrapButton(
      onPressed: () {},
      text: 'Like',
    ),
    FlutstrapButton(
      onPressed: () {},
      text: 'Share',
    ),
  ],
)
```

### Interactive Card Factory

```dart
FlutstrapCard.interactive(
  title: 'Interactive Card',
  content: 'Tap this card to perform an action. The card provides visual feedback when interactive.',
  onTap: () {
    print('Card tapped!');
  },
  trailing: Icon(Icons.chevron_right),
)
```

### Action Card Factory

```dart
FlutstrapCard.action(
  title: 'Confirm Action',
  content: 'Are you sure you want to proceed with this action?',
  actions: [
    FlutstrapButton(
      onPressed: () => Navigator.pop(context),
      text: 'Cancel',
      variant: FSButtonVariant.outlineSecondary,
    ),
    FlutstrapButton(
      onPressed: _confirmAction,
      text: 'Confirm',
      variant: FSButtonVariant.primary,
    ),
  ],
)
```

## Interactivity & Behavior

### Interactive Cards

```dart
FlutstrapCard(
  headerText: 'Clickable Card',
  bodyText: 'This entire card is clickable and provides visual feedback.',
  onTap: () {
    print('Card was tapped!');
    // Navigate to detail page or show dialog
  },
  onLongPress: () {
    print('Card was long pressed!');
    // Show context menu or additional options
  },
  interactive: true, // Enables hover and focus states
)
```

### Conditional Interactivity

```dart
bool _isCardEnabled = true;

FlutstrapCard(
  headerText: 'Conditional Card',
  bodyText: 'This card is only interactive when enabled.',
  onTap: _isCardEnabled ? _handleCardTap : null,
  interactive: _isCardEnabled,
)
```

## Accessibility Notes

FlutstrapCard includes comprehensive accessibility features:

- **Screen Reader Support**: Uses `Semantics` widget with proper labels
- **Interactive Semantics**: Cards with `onTap` are announced as buttons
- **Focus Management**: Interactive cards support keyboard navigation
- **Error Boundaries**: Graceful error handling for screen readers
- **Visual Feedback**: Proper cursor changes for interactive cards

```dart
FlutstrapCard(
  headerText: 'Accessible Card', // Used in semantic label
  bodyText: 'This content is properly announced by screen readers.',
  interactive: true, // Announces as button
)
```

## Performance Features

### Style Caching

```dart
// Styles are automatically cached by variant and theme
// Multiple cards with same configuration reuse computed styles
FlutstrapCard(
  headerText: 'Cached Style',
  bodyText: 'This card uses cached styles for better performance.',
  variant: FSCardVariant.elevated,
)

// Monitor cache performance (debug mode)
debugPrint('Card cache size: ${_CardStyleCache.cacheSize}');
```

### Factory Caching

```dart
// Factory methods automatically cache common patterns
final card1 = FlutstrapCard.simple(
  title: 'User',
  content: 'Profile data',
);

// Same configuration returns cached instance
final card2 = FlutstrapCard.simple(
  title: 'User',
  content: 'Profile data',
);

// card1 and card2 are the same cached instance
```

### Error Boundaries

```dart
// Cards automatically handle content rendering errors
FlutstrapCard(
  header: MyCustomWidgetThatMightFail(),
  bodyText: 'This card will show error UI if header fails to render',
)
// If MyCustomWidgetThatMightFail throws, card shows graceful error
```

## Integration Examples

### Card Grid Layout

```dart
GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: 16,
    mainAxisSpacing: 16,
    childAspectRatio: 0.8,
  ),
  itemCount: items.length,
  itemBuilder: (context, index) {
    return FlutstrapCard.simple(
      title: 'Item ${index + 1}',
      content: 'Description for item ${index + 1}',
      variant: FSCardVariant.elevated,
    );
  },
)
```

### Card List with Interactions

```dart
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: FlutstrapCard.interactive(
        title: items[index].title,
        content: items[index].description,
        onTap: () => _navigateToDetail(items[index]),
        trailing: Icon(Icons.arrow_forward),
      ),
    );
  },
)
```

### Mixed Content Cards

```dart
FlutstrapCard(
  header: Padding(
    padding: EdgeInsets.all(16),
    child: Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage('https://picsum.photos/100'),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('John Doe', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Software Developer', style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
        Icon(Icons.more_vert),
      ],
    ),
  ),
  body: Padding(
    padding: EdgeInsets.all(16),
    child: Text('This is a card with a complex header layout containing user information and actions.'),
  ),
  footer: Padding(
    padding: EdgeInsets.all(16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('2 hours ago', style: TextStyle(color: Colors.grey)),
        Row(
          children: [
            Icon(Icons.favorite_border, size: 16),
            SizedBox(width: 4),
            Text('24'),
            SizedBox(width: 16),
            Icon(Icons.comment, size: 16),
            SizedBox(width: 4),
            Text('8'),
          ],
        ),
      ],
    ),
  ),
)
```

## Best Practices

### Performance Recommendations

- **Use Factory Methods**: For common patterns, use factory methods that benefit from caching
- **Const Constructors**: Use `const` when content is static
- **Avoid Deep Nesting**: Keep card content reasonably simple
- **Reuse Configurations**: Use `copyWith()` for similar cards

```dart
// ✅ Good - Uses factory caching
FlutstrapCard.simple(title: 'User', content: 'Data')

// ✅ Good - Uses copyWith for variations
baseCard.copyWith(headerText: 'New Title')

// ❌ Avoid - Creates new computations each time
FlutstrapCard(headerText: 'User', bodyText: 'Data') // Repeatedly
```

### Content Guidelines

- **Clear Hierarchy**: Use header for titles, body for content, footer for metadata
- **Consistent Padding**: Use theme spacing constants for consistent layouts
- **Appropriate Variants**:
  - `elevated`: For primary content
  - `outlined`: For secondary content or in well-lit backgrounds
  - `filled`: For emphasis without elevation
  - `surface`: When you need to match surface color

### Error Handling

```dart
// Cards automatically handle rendering errors
FlutstrapCard(
  header: FutureBuilder(
    future: _loadData(),
    builder: (context, snapshot) {
      if (snapshot.hasError) {
        // Error will be caught by card's error boundary
        throw Exception('Data load failed');
      }
      return Text(snapshot.data ?? 'Loading...');
    },
  ),
  bodyText: 'This card handles async content safely',
)
```

## Troubleshooting

### Common Issues and Solutions

**Card Not Responding to Tap**

```dart
// Ensure interactive is true for full interactivity
FlutstrapCard(
  onTap: () => print('Tapped'),
  interactive: true, // Required for full interactive behavior
)

// For simple taps, onTap alone may be sufficient
FlutstrapCard(
  onTap: () => print('Tapped'), // Works without interactive
)
```

**Content Not Displaying**

```dart
// Ensure you provide either widget or text for each section
FlutstrapCard(
  headerText: 'Title', // OR header: CustomWidget()
  bodyText: 'Content', // OR body: CustomWidget()
  // Don't provide both header and headerText
)
```

**Performance Issues in Lists**

```dart
// Use simple factory for better performance in lists
ListView.builder(
  itemBuilder: (context, index) {
    return FlutstrapCard.simple(
      title: 'Item $index',
      content: 'Content $index',
    );
  },
)

// Clear cache if needed (rarely necessary)
_CardFactoryCache.clearCache();
_CardStyleCache.clearCache();
```

**Border Not Appearing**

```dart
// Use outlined variant for borders
FlutstrapCard(
  headerText: 'Outlined Card',
  variant: FSCardVariant.outlined, // Required for border
  borderColor: Colors.blue, // Optional custom color
  borderWidth: 2.0, // Optional custom width
)
```

This comprehensive guide covers all aspects of using the FlutstrapCard component. The card system is designed to be highly flexible, performant, and accessible while providing a consistent design language for your content containers.
