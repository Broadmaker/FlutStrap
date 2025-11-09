# Flutstrap Container Component Guide

## Introduction

Flutstrap Container is a responsive container component that provides consistent spacing, max-width constraints, and responsive behavior based on breakpoints. It serves as the foundational layout component for creating structured, responsive designs in Flutter applications.

**This comprehensive guide covers all aspects of using the Flutstrap Container component. The container system is designed to be highly flexible, responsive, and consistent while providing a robust foundation for building structured layouts across various screen sizes and design requirements.**

### What It Does

- Provides responsive max-width constraints based on breakpoints
- Offers consistent spacing and padding patterns
- Includes pre-styled variants for common use cases (cards, sections, bordered containers)
- Maintains responsive behavior across all device sizes

### When to Use

- Creating main content areas with proper max-width constraints
- Building card components with consistent styling
- Structuring page sections with consistent spacing
- Creating bordered content areas
- Any scenario requiring responsive container behavior

### Prerequisites

- Flutter 3.0 or higher
- Flutstrap breakpoints system (`FSBreakpoints`)
- Flutstrap responsive utilities (`FSResponsive`)
- Flutstrap spacing system (`FSSpacing`)

## Installation & Setup

### Required Dependencies

```dart
import 'package:flutstrap/flutstrap.dart';
```

### Basic Project Setup

Ensure your app has access to Flutstrap responsive utilities:

```dart
void main() {
  runApp(MyApp()); // Flutstrap components available globally
}
```

## Basic Usage

### Simple Container with Default Behavior

```dart
FlutstrapContainer(
  child: Text('This container has responsive max-width and default padding'),
)
```

### Fluid Container (Full Width)

```dart
FlutstrapContainer(
  fluid: true,
  child: Container(
    height: 100,
    color: Colors.blue,
    child: Center(child: Text('Full width container')),
  ),
)
```

### Container with Custom Styling

```dart
FlutstrapContainer(
  padding: EdgeInsets.all(24),
  margin: EdgeInsets.symmetric(vertical: 16),
  color: Colors.grey[50],
  child: Column(
    children: [
      Text('Styled Container', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      Text('This container has custom padding, margin, and background color.'),
    ],
  ),
)
```

## Component Variants

### Container Types

Flutstrap Container provides multiple specialized variants through convenience methods:

```dart
// Fluid container (full width)
FlutstrapContainer(child: /* ... */).fluidWidth()

// Fixed width container
FlutstrapContainer(child: /* ... */).withMaxWidth(800)

// Card container (with shadow and styling)
FlutstrapContainer(child: /* ... */).card()

// Section container (with section spacing)
FlutstrapContainer(child: /* ... */).section()

// Bordered container
FlutstrapContainer(child: /* ... */).bordered()
```

### Responsive Breakpoint Behavior

```dart
// Default responsive behavior (adapts to screen size)
FlutstrapContainer(
  child: Text('Automatically adjusts max-width based on breakpoints'),
)

// Breakpoint max-width values:
// xs: full width (fluid)
// sm: 540px
// md: 720px
// lg: 960px
// xl: 1140px
// xxl: 1320px (falls back to xl if not defined)
```

## Properties & Parameters

### Parameter Reference Table

| Parameter      | Type                  | Default        | Description                        |
| -------------- | --------------------- | -------------- | ---------------------------------- |
| `child`        | `Widget`              | **required**   | Container content                  |
| `fluid`        | `bool`                | `false`        | Full width vs responsive max-width |
| `padding`      | `EdgeInsetsGeometry?` | `FSSpacing.md` | Internal padding                   |
| `margin`       | `EdgeInsetsGeometry?` | `null`         | External margin                    |
| `color`        | `Color?`              | `null`         | Background color                   |
| `decoration`   | `Decoration?`         | `null`         | Background decoration              |
| `width`        | `double?`             | `null`         | Fixed width (overrides responsive) |
| `height`       | `double?`             | `null`         | Fixed height                       |
| `alignment`    | `AlignmentGeometry?`  | `null`         | Child alignment                    |
| `clipBehavior` | `Clip`                | `none`         | Content clipping behavior          |

### Convenience Method Parameters

#### card()

| Parameter         | Type           | Default        | Description           |
| ----------------- | -------------- | -------------- | --------------------- |
| `backgroundColor` | `Color`        | `Colors.white` | Card background color |
| `elevation`       | `double`       | `2.0`          | Shadow elevation      |
| `borderRadius`    | `BorderRadius` | `8.0`          | Corner radius         |

#### section()

_Applies section-appropriate padding and margin_

#### bordered()

| Parameter      | Type           | Default             | Description   |
| -------------- | -------------- | ------------------- | ------------- |
| `borderColor`  | `Color`        | `Color(0xFFE2E8F0)` | Border color  |
| `borderWidth`  | `double`       | `1.0`               | Border width  |
| `borderRadius` | `BorderRadius` | `8.0`               | Corner radius |

## Customization

### Advanced Container Styling

```dart
FlutstrapContainer(
  fluid: false, // Responsive max-width
  padding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
  margin: EdgeInsets.all(16),
  decoration: BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Colors.blue.shade50, Colors.purple.shade50],
    ),
    borderRadius: BorderRadius.circular(16),
    border: Border.all(color: Colors.blue.shade200, width: 2),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 10,
        offset: Offset(0, 4),
      ),
    ],
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Premium Container',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 12),
      Text(
        'This container demonstrates advanced styling with gradient background, custom border, and shadow effects.',
        style: TextStyle(fontSize: 16, color: Colors.grey[700]),
      ),
      SizedBox(height: 20),
      FlutstrapButton(
        onPressed: () {},
        text: 'Get Started',
        variant: FSButtonVariant.primary,
      ),
    ],
  ),
)
```

### Responsive Container with Conditional Styling

```dart
LayoutBuilder(
  builder: (context, constraints) {
    final isMobile = constraints.maxWidth < FSBreakpoints.md;

    return FlutstrapContainer(
      padding: isMobile
          ? EdgeInsets.all(16)
          : EdgeInsets.symmetric(vertical: 24, horizontal: 32),
      margin: isMobile
          ? EdgeInsets.all(8)
          : EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isMobile ? 8 : 12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isMobile ? 0.05 : 0.1),
            blurRadius: isMobile ? 4 : 8,
            offset: Offset(0, isMobile ? 2 : 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Responsive Container',
            style: TextStyle(
              fontSize: isMobile ? 18 : 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: isMobile ? 8 : 16),
          Text(
            'This container adapts its styling based on screen size.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isMobile ? 14 : 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  },
)
```

## Interactivity & Behavior

### Dynamic Container Properties

```dart
class DynamicContainer extends StatefulWidget {
  @override
  _DynamicContainerState createState() => _DynamicContainerState();
}

class _DynamicContainerState extends State<DynamicContainer> {
  bool _isExpanded = false;
  Color _containerColor = Colors.blue.shade50;

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void _changeColor() {
    setState(() {
      _containerColor = _containerColor == Colors.blue.shade50
          ? Colors.green.shade50
          : Colors.blue.shade50;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutstrapContainer(
      padding: EdgeInsets.all(24),
      margin: EdgeInsets.all(16),
      color: _containerColor,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Dynamic Container',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  FlutstrapButton(
                    onPressed: _toggleExpansion,
                    text: _isExpanded ? 'Collapse' : 'Expand',
                    size: FSButtonSize.sm,
                    variant: FSButtonVariant.outlinePrimary,
                  ),
                  SizedBox(width: 8),
                  FlutstrapButton(
                    onPressed: _changeColor,
                    text: 'Change Color',
                    size: FSButtonSize.sm,
                    variant: FSButtonVariant.outlineSecondary,
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 16),

          AnimatedCrossFade(
            duration: Duration(milliseconds: 300),
            crossFadeState: _isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: Text(
              'This container can change its appearance dynamically...',
              style: TextStyle(color: Colors.grey[700]),
            ),
            secondChild: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Expanded Content',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'This is the expanded content that appears when you click the expand button. '
                  'The container smoothly animates between states.',
                  style: TextStyle(color: Colors.grey[700]),
                ),
                SizedBox(height: 12),
                FlutstrapRow(
                  children: [
                    FlutstrapCol(
                      size: FSColSize(xs: 12, md: 6),
                      child: FlutstrapInput(labelText: 'Name', placeholder: 'Enter name'),
                    ),
                    FlutstrapCol(
                      size: FSColSize(xs: 12, md: 6),
                      child: FlutstrapInput(labelText: 'Email', placeholder: 'Enter email'),
                    ),
                  ],
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

### Container with Interactive Background

```dart
class InteractiveContainer extends StatefulWidget {
  @override
  _InteractiveContainerState createState() => _InteractiveContainerState();
}

class _InteractiveContainerState extends State<InteractiveContainer> {
  double _elevation = 2.0;
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _elevation = 0.5),
        onTapUp: (_) => setState(() => _elevation = 2.0),
        onTapCancel: () => setState(() => _elevation = 2.0),
        child: FlutstrapContainer(
          padding: EdgeInsets.all(24),
          margin: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: _elevation * 4,
                offset: Offset(0, _elevation),
              ),
            ],
            border: Border.all(
              color: _isHovered ? Colors.blue.shade300 : Colors.grey.shade300,
              width: _isHovered ? 2 : 1,
            ),
          ),
          child: Column(
            children: [
              Icon(
                Icons.touch_app,
                size: 48,
                color: _isHovered ? Colors.blue : Colors.grey,
              ),
              SizedBox(height: 12),
              Text(
                'Interactive Container',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _isHovered ? Colors.blue : Colors.black,
                ),
              ),
              SizedBox(height: 8),
              Text(
                _isHovered
                    ? 'Hovering or touching the container!'
                    : 'Hover or tap this container to see interactive effects.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

## Integration Examples

### Complete Card-Based Layout

```dart
class CardLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          // Header Card
          FlutstrapContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Dashboard Overview', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('Welcome back! Here\'s what\'s happening with your projects today.'),
                SizedBox(height: 20),
                FlutstrapRow(
                  children: [
                    FlutstrapCol(
                      size: FSColSize(xs: 6, md: 3),
                      child: _buildMetricCard('Revenue', '\$12,456', Icons.attach_money, Colors.green),
                    ),
                    FlutstrapCol(
                      size: FSColSize(xs: 6, md: 3),
                      child: _buildMetricCard('Users', '1,234', Icons.people, Colors.blue),
                    ),
                    FlutstrapCol(
                      size: FSColSize(xs: 6, md: 3),
                      child: _buildMetricCard('Orders', '456', Icons.shopping_cart, Colors.orange),
                    ),
                    FlutstrapCol(
                      size: FSColSize(xs: 6, md: 3),
                      child: _buildMetricCard('Growth', '+12.5%', Icons.trending_up, Colors.purple),
                    ),
                  ],
                ),
              ],
            ),
          ).card(),

          SizedBox(height: 24),

          // Content Cards Row
          FlutstrapRow(
            children: [
              FlutstrapCol(
                size: FSColSize(xs: 12, lg: 8),
                child: FlutstrapContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Recent Activity', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(height: 16),
                      _buildActivityItem('New user registration', '5 minutes ago'),
                      _buildActivityItem('Order #1234 completed', '1 hour ago'),
                      _buildActivityItem('Payment received', '2 hours ago'),
                      _buildActivityItem('Product review submitted', '3 hours ago'),
                    ],
                  ),
                ).card(),
              ),
              FlutstrapCol(
                size: FSColSize(xs: 12, lg: 4),
                child: FlutstrapContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Quick Actions', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(height: 16),
                      FlutstrapButton(
                        onPressed: () {},
                        text: 'Add New Product',
                        variant: FSButtonVariant.primary,
                        expanded: true,
                      ),
                      SizedBox(height: 8),
                      FlutstrapButton(
                        onPressed: () {},
                        text: 'View Analytics',
                        variant: FSButtonVariant.outlinePrimary,
                        expanded: true,
                      ),
                      SizedBox(height: 8),
                      FlutstrapButton(
                        onPressed: () {},
                        text: 'Manage Users',
                        variant: FSButtonVariant.outlineSecondary,
                        expanded: true,
                      ),
                    ],
                  ),
                ).card(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, size: 20, color: color),
                ),
                Icon(Icons.more_vert, color: Colors.grey[400]),
              ],
            ),
            SizedBox(height: 16),
            Text(title, style: TextStyle(color: Colors.grey[600])),
            SizedBox(height: 4),
            Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem(String title, String time) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 12),
          Expanded(child: Text(title)),
          Text(time, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
        ],
      ),
    );
  }
}
```

### Form Container with Validation

```dart
class FormContainer extends StatefulWidget {
  @override
  _FormContainerState createState() => _FormContainerState();
}

class _FormContainerState extends State<FormContainer> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  bool _isSubmitting = false;

  void _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    // Simulate form submission
    await Future.delayed(Duration(seconds: 2));

    setState(() => _isSubmitting = false);
    // Show success message
  }

  @override
  Widget build(BuildContext context) {
    return FlutstrapContainer(
      padding: EdgeInsets.all(32),
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Contact Us',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Fill out the form below and we\'ll get back to you as soon as possible.',
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 24),

            // Name and Email Row
            FlutstrapRow(
              children: [
                FlutstrapCol(
                  size: FSColSize(xs: 12, md: 6),
                  child: FlutstrapInput(
                    controller: _nameController,
                    labelText: 'Full Name',
                    placeholder: 'Enter your full name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                ),
                FlutstrapCol(
                  size: FSColSize(xs: 12, md: 6),
                  child: FlutstrapInput(
                    controller: _emailController,
                    labelText: 'Email Address',
                    placeholder: 'Enter your email',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),

            // Message
            FlutstrapTextArea(
              controller: _messageController,
              label: 'Message',
              placeholder: 'Tell us how we can help you...',
              rows: 4,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a message';
                }
                if (value.length < 10) {
                  return 'Message must be at least 10 characters';
                }
                return null;
              },
            ),

            SizedBox(height: 24),

            // Submit Button
            FlutstrapButton(
              onPressed: _isSubmitting ? null : _submitForm,
              text: _isSubmitting ? 'Sending...' : 'Send Message',
              variant: FSButtonVariant.primary,
              loading: _isSubmitting,
              expanded: true,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }
}
```

## Performance Optimization

### Efficient Container Usage

```dart
// ✅ GOOD: Using appropriate container type
FlutstrapContainer(
  fluid: true, // When you need full width
  child: HeaderContent(),
)

FlutstrapContainer(
  fluid: false, // When you want responsive max-width
  child: MainContent(),
)

// ✅ BETTER: Using const children when possible
FlutstrapContainer(
  child: const Text('Static content'), // More efficient
)

// ❌ AVOID: Unnecessary nested containers
Container(
  child: FlutstrapContainer( // Redundant wrapping
    child: Content(),
  ),
)
```

### Responsive Breakpoint Strategy

```dart
// ✅ GOOD: Leveraging built-in responsive behavior
FlutstrapContainer(
  fluid: false, // Uses breakpoint-based max-width automatically
  child: Content(),
)

// ✅ BETTER: Custom responsive behavior when needed
LayoutBuilder(
  builder: (context, constraints) {
    return FlutstrapContainer(
      padding: constraints.maxWidth < FSBreakpoints.md
          ? EdgeInsets.all(16)
          : EdgeInsets.all(24),
      child: Content(),
    );
  },
)
```

## Best Practices

### Container Type Selection

```dart
// ✅ CARD CONTAINER: For content blocks with elevation
FlutstrapContainer(child: /* ... */).card()

// ✅ SECTION CONTAINER: For major content sections
FlutstrapContainer(child: /* ... */).section()

// ✅ BORDERED CONTAINER: For subtle separation
FlutstrapContainer(child: /* ... */).bordered()

// ✅ FLUID CONTAINER: For full-width elements
FlutstrapContainer(child: /* ... */).fluidWidth()

// ✅ RESPONSIVE CONTAINER: For main content areas (default)
FlutstrapContainer(child: /* ... */) // Uses breakpoint max-width
```

### Spacing Consistency

```dart
// ✅ USING FLUTSTRAP SPACING: Consistent spacing system
FlutstrapContainer(
  padding: EdgeInsets.all(FSSpacing.md), // 16px
  margin: EdgeInsets.symmetric(vertical: FSSpacing.lg), // 24px
)

// ✅ SECTION SPACING: Using predefined constants
FlutstrapContainer(
  padding: EdgeInsets.all(FlutstrapContainer.sectionPadding), // 24px
)

// ✅ CARD SPACING: Consistent card padding
FlutstrapContainer(child: /* ... */).card() // Uses cardPadding (16px)
```

## Troubleshooting

### Common Issues and Solutions

**Container Not Respecting Max-Width**

```dart
// ❌ Parent constraints may override container max-width
Container(
  width: double.infinity, // Overrides child constraints
  child: FlutstrapContainer(
    fluid: false, // Max-width won't apply
    child: Content(),
  ),
)

// ✅ Ensure parent allows child to determine its size
Align(
  alignment: Alignment.topCenter,
  child: FlutstrapContainer(
    fluid: false, // Max-width will apply
    child: Content(),
  ),
)

// OR use Center widget
Center(
  child: FlutstrapContainer(
    fluid: false,
    child: Content(),
  ),
)
```

**Background Color Not Showing**

```dart
// ❌ Color and decoration conflict
FlutstrapContainer(
  color: Colors.blue,
  decoration: BoxDecoration( // This will override color
    borderRadius: BorderRadius.circular(8),
  ),
  child: Content(),
)

// ✅ Use decoration for complex backgrounds
FlutstrapContainer(
  decoration: BoxDecoration(
    color: Colors.blue, // Include color in decoration
    borderRadius: BorderRadius.circular(8),
  ),
  child: Content(),
)

// OR use color for simple backgrounds
FlutstrapContainer(
  color: Colors.blue, // Simple background color
  child: Content(),
)
```

**Padding/Margin Not Applying as Expected**

```dart
// ❌ Container inside another constrained widget
SizedBox(
  width: 200,
  child: FlutstrapContainer(
    padding: EdgeInsets.all(20), // May overflow
    margin: EdgeInsets.all(10), // May not have space
    child: Content(),
  ),
)

// ✅ Ensure adequate space for padding and margin
Container(
  constraints: BoxConstraints(minWidth: 300),
  child: FlutstrapContainer(
    padding: EdgeInsets.all(20), // Has space to apply
    margin: EdgeInsets.all(10),
    child: Content(),
  ),
)
```

### Debugging Tips

1. **Check Parent Constraints**: Verify parent widgets don't override container sizing
2. **Test Responsive Behavior**: Check container on different screen sizes
3. **Inspect Box Constraints**: Use debug painting to visualize container boundaries
4. **Verify Color/Decoration**: Ensure only one background styling method is used
5. **Monitor Performance**: Check container rebuild behavior in DevTools

---

**This comprehensive guide covers all aspects of using the Flutstrap Container component. The container system is designed to be highly flexible, responsive, and consistent while providing a robust foundation for building structured layouts across various screen sizes and design requirements. With features like responsive max-width constraints, pre-styled variants, and consistent spacing, Flutstrap Container offers enterprise-grade layout capabilities for modern Flutter applications.**
