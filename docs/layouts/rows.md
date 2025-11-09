# Flutstrap Row Component Guide

## Introduction

Flutstrap Row is a responsive row component that creates horizontal layout containers for organizing columns with consistent spacing and alignment. It provides a robust solution for horizontal layouts in Flutter applications with performance optimizations and convenient helper methods.

**This comprehensive guide covers all aspects of using the Flutstrap Row component. The row system is designed to be highly flexible, performant, and intuitive while providing a robust solution for horizontal layouts across various alignment requirements and spacing needs.**

### What It Does

- Creates horizontal layout containers with consistent gap spacing
- Provides convenient alignment and spacing helper methods
- Maintains all native Flutter Row functionality with performance optimizations
- Offers grid-specific layout configurations

### When to Use

- Horizontal layouts with consistent spacing between children
- Navigation bars, button groups, and toolbars
- Form fields arranged horizontally
- Card grids and horizontal lists
- Any scenario requiring precise horizontal alignment

### Prerequisites

- Flutter 3.0 or higher
- Flutstrap spacing system (`FSSpacing`)

## Installation & Setup

### Required Dependencies

```dart
import 'package:flutstrap/flutstrap.dart';
```

### Basic Project Setup

Ensure your app has access to Flutstrap spacing constants:

```dart
void main() {
  runApp(MyApp()); // FSSpacing is available globally
}
```

## Basic Usage

### Simple Row with Default Gap

```dart
FlutstrapRow(
  children: [
    Container(width: 50, height: 50, color: Colors.blue),
    Container(width: 50, height: 50, color: Colors.red),
    Container(width: 50, height: 50, color: Colors.green),
  ],
)
```

### Row with Custom Gap

```dart
FlutstrapRow(
  gap: 32.0,
  children: [
    FlutstrapButton(text: 'Cancel', variant: FSButtonVariant.outlineSecondary),
    FlutstrapButton(text: 'Save', variant: FSButtonVariant.primary),
  ],
)
```

### Row without Gap

```dart
FlutstrapRow(
  gap: 0,
  children: [
    Icon(Icons.star),
    Icon(Icons.star),
    Icon(Icons.star),
  ],
)
```

## Component Variants

### Alignment Variants

Flutstrap Row provides multiple alignment options through convenience methods:

```dart
// Center aligned (default)
FlutstrapRow(
  children: [/* ... */],
).center()

// Space between
FlutstrapRow(
  children: [/* ... */],
).spaceBetween()

// Space around
FlutstrapRow(
  children: [/* ... */],
).spaceAround()

// Space evenly
FlutstrapRow(
  children: [/* ... */],
).spaceEvenly()

// Start aligned
FlutstrapRow(
  children: [/* ... */],
).start()

// End aligned
FlutstrapRow(
  children: [/* ... */],
).end()

// Stretch to fill height
FlutstrapRow(
  children: [/* ... */],
).stretch()
```

### Gap Variants

```dart
// No gap
FlutstrapRow(
  children: [/* ... */],
).noGap()

// Custom gap
FlutstrapRow(
  children: [/* ... */],
).withGap(24.0)

// Using Flutstrap spacing constants
FlutstrapRow(
  children: [/* ... */],
).withGap(FSSpacing.lg)
```

## Properties & Parameters

### Parameter Reference Table

| Parameter            | Type                 | Default        | Description                  |
| -------------------- | -------------------- | -------------- | ---------------------------- |
| `children`           | `List<Widget>`       | **required**   | Row children widgets         |
| `mainAxisAlignment`  | `MainAxisAlignment`  | `start`        | Main axis alignment          |
| `crossAxisAlignment` | `CrossAxisAlignment` | `center`       | Cross axis alignment         |
| `mainAxisSize`       | `MainAxisSize`       | `max`          | Row width behavior           |
| `textDirection`      | `TextDirection?`     | `null`         | Text direction for alignment |
| `verticalDirection`  | `VerticalDirection`  | `down`         | Vertical layout direction    |
| `textBaseline`       | `TextBaseline?`      | `null`         | Text baseline for alignment  |
| `gap`                | `double?`            | `FSSpacing.md` | Space between children       |

### MainAxisAlignment Options

```dart
MainAxisAlignment.start    // Align children from the start
MainAxisAlignment.end      // Align children at the end
MainAxisAlignment.center   // Center children horizontally
MainAxisAlignment.spaceBetween  // Equal space between children
MainAxisAlignment.spaceAround   // Equal space around children
MainAxisAlignment.spaceEvenly   // Equal space between and around
```

### CrossAxisAlignment Options

```dart
CrossAxisAlignment.start   // Align children at the top
CrossAxisAlignment.end     // Align children at the bottom
CrossAxisAlignment.center  // Center children vertically (default)
CrossAxisAlignment.stretch // Stretch children to fill height
CrossAxisAlignment.baseline // Align by text baseline
```

## Customization

### Advanced Alignment Configuration

```dart
FlutstrapRow(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  crossAxisAlignment: CrossAxisAlignment.stretch,
  mainAxisSize: MainAxisSize.min,
  gap: 16.0,
  children: [
    Expanded(child: FlutstrapInput(labelText: 'First Name')),
    Expanded(child: FlutstrapInput(labelText: 'Last Name')),
  ],
)
```

### Complex Row with Mixed Content

```dart
FlutstrapRow(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  crossAxisAlignment: CrossAxisAlignment.center,
  gap: 12.0,
  children: [
    Row(
      children: [
        Icon(Icons.account_circle, size: 24),
        SizedBox(width: 8),
        Text('User Profile', style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    ),

    FlutstrapRow(
      gap: 8.0,
      children: [
        FlutstrapButton(
          text: 'Edit',
          variant: FSButtonVariant.outlinePrimary,
          size: FSButtonSize.sm,
        ),
        FlutstrapButton(
          text: 'Delete',
          variant: FSButtonVariant.outlineDanger,
          size: FSButtonSize.sm,
        ),
      ],
    ),
  ],
)
```

## Interactivity & Behavior

### Dynamic Row Content

```dart
class DynamicRowExample extends StatefulWidget {
  @override
  _DynamicRowExampleState createState() => _DynamicRowExampleState();
}

class _DynamicRowExampleState extends State<DynamicRowExample> {
  List<Widget> _items = [
    Container(width: 50, height: 50, color: Colors.blue),
    Container(width: 50, height: 50, color: Colors.red),
  ];

  void _addItem() {
    setState(() {
      _items.add(Container(
        width: 50,
        height: 50,
        color: Colors.primaries[_items.length % Colors.primaries.length],
      ));
    });
  }

  void _removeItem() {
    if (_items.length > 1) {
      setState(() {
        _items.removeLast();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FlutstrapRow(
          gap: 16.0,
          mainAxisAlignment: MainAxisAlignment.center,
          children: _items,
        ),

        SizedBox(height: 20),

        FlutstrapRow(
          gap: 12.0,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutstrapButton(
              onPressed: _addItem,
              text: 'Add Item',
              size: FSButtonSize.sm,
            ),
            FlutstrapButton(
              onPressed: _removeItem,
              text: 'Remove Item',
              variant: FSButtonVariant.outlineSecondary,
              size: FSButtonSize.sm,
            ),
          ],
        ),
      ],
    );
  }
}
```

### Responsive Row Behavior

```dart
class ResponsiveRowExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 600;

        return FlutstrapRow(
          gap: isSmallScreen ? 8.0 : 16.0,
          mainAxisAlignment: isSmallScreen ?
              MainAxisAlignment.spaceAround : MainAxisAlignment.spaceBetween,
          crossAxisAlignment: isSmallScreen ?
              CrossAxisAlignment.start : CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                'Responsive Content',
                style: TextStyle(
                  fontSize: isSmallScreen ? 14 : 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            isSmallScreen
                ? FlutstrapButton(
                    text: 'Action',
                    size: FSButtonSize.sm,
                  )
                : FlutstrapButton(
                    text: 'Large Screen Action',
                    size: FSButtonSize.md,
                  ),
          ],
        );
      },
    );
  }
}
```

## Integration Examples

### Navigation Bar

```dart
class CustomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabSelected;

  const CustomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          top: BorderSide(color: Theme.of(context).dividerColor),
        ),
      ),
      child: FlutstrapRow(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        gap: 0,
        children: [
          _buildNavItem(Icons.home, 'Home', 0),
          _buildNavItem(Icons.search, 'Search', 1),
          _buildNavItem(Icons.shopping_cart, 'Cart', 2),
          _buildNavItem(Icons.person, 'Profile', 3),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = currentIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => onTabSelected(index),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 24,
              color: isSelected ?
                  Theme.of(context).primaryColor :
                  Theme.of(context).disabledColor,
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ?
                    Theme.of(context).primaryColor :
                    Theme.of(context).disabledColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

### Form Layout with Multiple Rows

```dart
class ContactForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Name row
        FlutstrapRow(
          gap: 16.0,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: FlutstrapInput(
                labelText: 'First Name',
                placeholder: 'Enter first name',
              ),
            ),
            Expanded(
              child: FlutstrapInput(
                labelText: 'Last Name',
                placeholder: 'Enter last name',
              ),
            ),
          ],
        ),

        SizedBox(height: 16),

        // Contact row
        FlutstrapRow(
          gap: 16.0,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: FlutstrapInput(
                labelText: 'Email',
                placeholder: 'Enter email address',
              ),
            ),
            Expanded(
              flex: 1,
              child: FlutstrapInput(
                labelText: 'Phone',
                placeholder: 'Enter phone',
              ),
            ),
          ],
        ),

        SizedBox(height: 16),

        // Address row
        FlutstrapRow(
          gap: 16.0,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: FlutstrapInput(
                labelText: 'Street',
                placeholder: 'Enter street address',
              ),
            ),
            Expanded(
              child: FlutstrapInput(
                labelText: 'City',
                placeholder: 'Enter city',
              ),
            ),
            Expanded(
              child: FlutstrapInput(
                labelText: 'ZIP',
                placeholder: 'ZIP code',
              ),
            ),
          ],
        ),

        SizedBox(height: 24),

        // Action buttons row
        FlutstrapRow(
          gap: 12.0,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FlutstrapButton(
              text: 'Cancel',
              variant: FSButtonVariant.outlineSecondary,
            ),
            FlutstrapButton(
              text: 'Save Contact',
              variant: FSButtonVariant.primary,
            ),
          ],
        ),
      ],
    );
  }
}
```

### Data Table Header

```dart
class DataTableHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        border: Border(
          bottom: BorderSide(color: Theme.of(context).dividerColor),
        ),
      ),
      child: FlutstrapRow(
        gap: 0,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              'Product Name',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'Price',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'Stock',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'Actions',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
```

## Performance Optimization

### Efficient Gap Implementation

```dart
// ✅ GOOD: Uses SizedBox for gaps (optimal performance)
FlutstrapRow(
  gap: 16.0, // Uses SizedBox(width: 16) between children
  children: [/* ... */],
)

// ✅ BETTER: No gap when not needed for maximum performance
FlutstrapRow(
  gap: 0, // Uses regular Row without extra widgets
  children: [/* ... */],
)

// ❌ AVOID: Using Wrap for simple horizontal layouts (less performant)
// FlutstrapRow uses Row which is more efficient for linear layouts
```

### Using Const Children

```dart
// ✅ GOOD: Using const children when possible
FlutstrapRow(
  children: const [
    Icon(Icons.star),
    Icon(Icons.star),
    Icon(Icons.star),
  ],
)

// ✅ BETTER: Combining with Expanded for complex layouts
FlutstrapRow(
  children: [
    const Expanded(child: Text('Left content')),
    const Expanded(child: Text('Right content')),
  ],
)
```

## Best Practices

### Gap Selection Guidelines

```dart
// ✅ SMALL GAP: For tightly related items
FlutstrapRow(
  gap: FSSpacing.sm, // 8px
  children: [Icon(Icons.star), Text('Rating')],
)

// ✅ MEDIUM GAP: Standard spacing (default)
FlutstrapRow(
  gap: FSSpacing.md, // 16px
  children: [/* form fields, buttons */],
)

// ✅ LARGE GAP: For distinct sections
FlutstrapRow(
  gap: FSSpacing.lg, // 24px
  children: [/* major components */],
)

// ✅ CUSTOM GAP: For specific design requirements
FlutstrapRow(
  gap: 32.0,
  children: [/* custom layout */],
)
```

### Alignment Patterns

```dart
// ✅ FORM LAYOUT: Start alignment for forms
FlutstrapRow(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [/* form fields */],
)

// ✅ NAVIGATION: Center alignment for nav items
FlutstrapRow(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [/* nav items */],
)

// ✅ TOOLBAR: Space between for actions
FlutstrapRow(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [/* toolbar actions */],
)

// ✅ BUTTON GROUP: End alignment for action buttons
FlutstrapRow(
  mainAxisAlignment: MainAxisAlignment.end,
  children: [/* action buttons */],
)
```

## Troubleshooting

### Common Issues and Solutions

**Children Overflowing**

```dart
// ❌ Children may overflow on small screens
FlutstrapRow(
  children: [
    Container(width: 200, color: Colors.red),
    Container(width: 200, color: Colors.blue),
    Container(width: 200, color: Colors.green),
  ],
)

// ✅ Use Flexible or Expanded for responsive behavior
FlutstrapRow(
  children: [
    Expanded(child: Container(color: Colors.red)),
    Expanded(child: Container(color: Colors.blue)),
    Expanded(child: Container(color: Colors.green)),
  ],
)

// ✅ Or use mainAxisSize.min for intrinsic width
FlutstrapRow(
  mainAxisSize: MainAxisSize.min,
  children: [/* children that fit content */],
)
```

**Alignment Not Working as Expected**

```dart
// ❌ CrossAxisAlignment may not work without height constraints
FlutstrapRow(
  crossAxisAlignment: CrossAxisAlignment.stretch,
  children: [Text('No height'), Text('No height')],
)

// ✅ Provide height constraints or use Container
FlutstrapRow(
  crossAxisAlignment: CrossAxisAlignment.stretch,
  children: [
    Container(height: 50, child: Text('With height')),
    Container(height: 50, child: Text('With height')),
  ],
)
```

**Gap Not Applying**

```dart
// ❌ Single child doesn't need gap
FlutstrapRow(
  gap: 16.0,
  children: [Text('Single child')], // Gap has no effect
)

// ✅ Gap only applies between multiple children
FlutstrapRow(
  gap: 16.0,
  children: [Text('First'), Text('Second')], // Gap works
)
```

### Debugging Tips

1. **Check Child Count**: Ensure you have multiple children for gap to apply
2. **Verify Constraints**: Ensure parent provides adequate width for horizontal layout
3. **Test Responsive Behavior**: Check different screen sizes with Flexible/Expanded
4. **Inspect Alignment**: Use debug painting to visualize alignment boundaries
5. **Monitor Performance**: Use Flutter DevTools to check layout performance

---

**This comprehensive guide covers all aspects of using the Flutstrap Row component. The row system is designed to be highly flexible, performant, and intuitive while providing a robust solution for horizontal layouts across various alignment requirements and spacing needs. With features like consistent gap spacing, convenient alignment methods, and performance optimizations, Flutstrap Row offers enterprise-grade horizontal layout capabilities for modern Flutter applications.**
