Perfect! Now I have a solid understanding of the Flutstrap button component. I can see the design patterns, theming system, and how components are structured. Let me create the comprehensive user guide for the Flutstrap Button component.

# Flutstrap Button Component Guide

## Introduction

The **FlutstrapButton** is a versatile, high-performance button component with Bootstrap-inspired variants, sizes, and states. It provides a comprehensive button solution that integrates seamlessly with the Flutstrap design system while maintaining Flutter's Material Design principles.

### What the Component Does

FlutstrapButton offers:

- 18 visual variants (filled, outline, link styles)
- 3 size options (sm, md, lg)
- Loading states with automatic styling
- Comprehensive disabled states
- Performance-optimized style caching
- Full accessibility support
- Flexible content arrangement (leading/trailing icons)

### When and Why to Use It

Use FlutstrapButton when you need:

- Consistent button styling across your app
- Bootstrap-inspired design language
- Performance-optimized buttons in lists
- Complex button states (loading, disabled, etc.)
- Outline and link-style buttons
- Buttons that work with Flutstrap's theming system

### Prerequisites

- Flutter 3.0 or higher
- Flutstrap theme package
- Material Design Icons

## Installation & Setup

### Required Dependencies

```dart
import 'package:flutter/material.dart';
import 'package:flutstrap/core/theme.dart';
import 'package:flutstrap/core/spacing.dart';
import 'package:flutstrap/components/buttons/flutstrap_button.dart';
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

### Simple Button Example

```dart
FlutstrapButton(
  onPressed: () {
    print('Button pressed!');
  },
  text: 'Click Me',
  variant: FSButtonVariant.primary,
)
```

### Using Const Constructor

```dart
const FlutstrapButton.primary(
  onPressed: _handleAction,
  text: 'Primary Action',
)
```

### Button with Loading State

```dart
FlutstrapButton(
  onPressed: _submitForm,
  text: 'Submit',
  variant: FSButtonVariant.success,
  loading: _isSubmitting,
  expanded: true,
)
```

## Component Variants

FlutstrapButton offers 18 visual variants across three categories:

### Filled Variants

```dart
// Primary - Main brand color
FlutstrapButton.primary(
  onPressed: () {},
  text: 'Primary',
)

// Secondary - Secondary brand color
FlutstrapButton(
  onPressed: () {},
  text: 'Secondary',
  variant: FSButtonVariant.secondary,
)

// Semantic variants
FlutstrapButton.success(onPressed: () {}, text: 'Success')
FlutstrapButton.danger(onPressed: () {}, text: 'Danger')
FlutstrapButton.warning(onPressed: () {}, text: 'Warning')
FlutstrapButton.info(onPressed: () {}, text: 'Info')

// Background variants
FlutstrapButton.light(onPressed: () {}, text: 'Light')
FlutstrapButton.dark(onPressed: () {}, text: 'Dark')

// Link style
FlutstrapButton.link(onPressed: () {}, text: 'Link')
```

### Outline Variants

```dart
FlutstrapButton.outlinePrimary(onPressed: () {}, text: 'Outline Primary')
FlutstrapButton.outlineSecondary(onPressed: () {}, text: 'Outline Secondary')
FlutstrapButton.outlineSuccess(onPressed: () {}, text: 'Outline Success')
FlutstrapButton.outlineDanger(onPressed: () {}, text: 'Outline Danger')
FlutstrapButton.outlineWarning(onPressed: () {}, text: 'Outline Warning')
FlutstrapButton.outlineInfo(onPressed: () {}, text: 'Outline Info')
FlutstrapButton.outlineLight(onPressed: () {}, text: 'Outline Light')
FlutstrapButton.outlineDark(onPressed: () {}, text: 'Outline Dark')
```

## Button Sizes

### Size Examples

```dart
// Small buttons
FlutstrapButton(
  onPressed: () {},
  text: 'Small',
  size: FSButtonSize.sm,
)

// Medium buttons (default)
FlutstrapButton(
  onPressed: () {},
  text: 'Medium',
  size: FSButtonSize.md,
)

// Large buttons
FlutstrapButton(
  onPressed: () {},
  text: 'Large',
  size: FSButtonSize.lg,
)

// Using convenience methods
FlutstrapButton.primary(onPressed: () {}, text: 'Small').small()
FlutstrapButton.primary(onPressed: () {}, text: 'Large').large()
```

## Properties & Parameters

### Parameter Reference Table

| Parameter      | Type              | Default   | Description                          |
| -------------- | ----------------- | --------- | ------------------------------------ |
| `onPressed`    | `VoidCallback?`   | `null`    | Callback when button is pressed      |
| `onLongPress`  | `VoidCallback?`   | `null`    | Callback for long press gesture      |
| `variant`      | `FSButtonVariant` | `primary` | Visual style variant                 |
| `size`         | `FSButtonSize`    | `md`      | Button size (sm, md, lg)             |
| `disabled`     | `bool`            | `false`   | Whether button is disabled           |
| `loading`      | `bool`            | `false`   | Shows loading spinner                |
| `text`         | `String?`         | `null`    | Button text (alternative to child)   |
| `child`        | `Widget?`         | `null`    | Custom child widget                  |
| `leading`      | `Widget?`         | `null`    | Leading icon/widget                  |
| `trailing`     | `Widget?`         | `null`    | Trailing icon/widget                 |
| `expanded`     | `bool`            | `false`   | Whether button expands to fill width |
| `style`        | `ButtonStyle?`    | `null`    | Custom button style                  |
| `focusNode`    | `FocusNode?`      | `null`    | Focus node for keyboard navigation   |
| `autofocus`    | `bool`            | `false`   | Whether to autofocus                 |
| `clipBehavior` | `Clip`            | `none`    | Content clipping behavior            |

### FSButtonVariant Enum

```dart
enum FSButtonVariant {
  primary, secondary, success, danger, warning, info, light, dark, link,
  outlinePrimary, outlineSecondary, outlineSuccess, outlineDanger,
  outlineWarning, outlineInfo, outlineLight, outlineDark
}
```

### FSButtonSize Enum

```dart
enum FSButtonSize {
  sm,  // Small: 32px height, compact padding
  md,  // Medium: 40px height, standard padding
  lg   // Large: 48px height, generous padding
}
```

## Customization

### Icons and Custom Content

```dart
// Button with leading icon
FlutstrapButton(
  onPressed: () {},
  text: 'Download',
  leading: Icon(Icons.download, size: 20),
  variant: FSButtonVariant.primary,
)

// Button with trailing icon
FlutstrapButton(
  onPressed: () {},
  text: 'Next',
  trailing: Icon(Icons.arrow_forward, size: 20),
  variant: FSButtonVariant.success,
)

// Custom child widget
FlutstrapButton(
  onPressed: () {},
  child: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.star, color: Colors.amber),
      SizedBox(width: 8),
      Text('Custom Content'),
    ],
  ),
)
```

### Expanded Buttons

```dart
// Full-width button
FlutstrapButton(
  onPressed: () {},
  text: 'Full Width Button',
  expanded: true,
)

// In a row with other buttons
Row(
  children: [
    Expanded(
      child: FlutstrapButton(
        onPressed: () {},
        text: 'Cancel',
        variant: FSButtonVariant.outlineSecondary,
      ),
    ),
    SizedBox(width: 12),
    Expanded(
      child: FlutstrapButton(
        onPressed: () {},
        text: 'Confirm',
        variant: FSButtonVariant.primary,
      ),
    ),
  ],
)
```

### Custom Styling

```dart
FlutstrapButton(
  onPressed: () {},
  text: 'Custom Style',
  style: ButtonStyle(
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  ),
)
```

## Interactivity & Behavior

### Loading States

```dart
bool _isLoading = false;

FlutstrapButton(
  onPressed: _isLoading ? null : _startOperation,
  text: 'Process Data',
  variant: FSButtonVariant.primary,
  loading: _isLoading,
)

void _startOperation() async {
  setState(() => _isLoading = true);
  await _performLongOperation();
  setState(() => _isLoading = false);
}
```

### Disabled States

```dart
FlutstrapButton(
  onPressed: _isFormValid ? _submitForm : null,
  text: 'Submit',
  variant: FSButtonVariant.primary,
  // Automatically disabled when onPressed is null
)

// Explicit disabled state
FlutstrapButton(
  onPressed: _submitForm,
  text: 'Submit',
  variant: FSButtonVariant.primary,
  disabled: !_isFormValid,
)
```

### Using copyWith for State Management

```dart
class MyButtonState extends StatefulWidget {
  @override
  _MyButtonStateState createState() => _MyButtonStateState();
}

class _MyButtonStateState extends State<MyButtonState> {
  bool _isActive = true;

  @override
  Widget build(BuildContext context) {
    final baseButton = FlutstrapButton.primary(
      onPressed: _isActive ? _handlePress : null,
      text: 'Dynamic Button',
    );

    return Column(
      children: [
        _isActive
            ? baseButton.success()
            : baseButton.danger().asDisabled(),

        FlutstrapButton(
          onPressed: _toggleState,
          text: 'Toggle State',
        ),
      ],
    );
  }

  void _toggleState() {
    setState(() => _isActive = !_isActive);
  }
}
```

## Accessibility Notes

FlutstrapButton includes comprehensive accessibility features:

- **Screen Reader Support**: Uses `Semantics` widget with proper labels
- **Loading States**: Announces "Loading" when in loading state
- **Disabled States**: Properly communicates disabled state to screen readers
- **Keyboard Navigation**: Full support for focus and keyboard interaction
- **Touch Targets**: Meets Material Design minimum touch target sizes

```dart
// Screen readers will announce the button text and state
FlutstrapButton(
  onPressed: () {},
  text: 'Save Changes', // Used as semantic label
  loading: true, // Announces "Loading"
)
```

## Integration Examples

### With Flutstrap Alerts

```dart
FlutstrapAlert(
  message: 'Are you sure you want to delete this item?',
  variant: FSAlertVariant.warning,
  trailing: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      FlutstrapButton(
        onPressed: () => Navigator.pop(context),
        text: 'Cancel',
        variant: FSButtonVariant.outlineSecondary,
        size: FSButtonSize.sm,
      ),
      SizedBox(width: 8),
      FlutstrapButton(
        onPressed: _confirmDelete,
        text: 'Delete',
        variant: FSButtonVariant.danger,
        size: FSButtonSize.sm,
      ),
    ],
  ),
)
```

### Form Submission Pattern

```dart
class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Form fields here...
          FlutstrapInput(
            label: 'Email',
            onChanged: (value) {},
          ),

          SizedBox(height: 20),

          FlutstrapButton(
            onPressed: _isSubmitting ? null : _submitForm,
            text: 'Submit Form',
            variant: FSButtonVariant.primary,
            loading: _isSubmitting,
            expanded: true,
          ),
        ],
      ),
    );
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isSubmitting = true);
      await _apiCall();
      setState(() => _isSubmitting = false);
    }
  }
}
```

### Button Groups

```dart
Row(
  children: [
    FlutstrapButton(
      onPressed: () {},
      text: 'First',
      variant: FSButtonVariant.outlinePrimary,
    ),
    FlutstrapButton(
      onPressed: () {},
      text: 'Second',
      variant: FSButtonVariant.outlinePrimary,
    ),
    FlutstrapButton(
      onPressed: () {},
      text: 'Third',
      variant: FSButtonVariant.outlinePrimary,
    ),
  ],
)
```

## Best Practices

### Performance Recommendations

- **Style Caching**: The component automatically caches styles - multiple buttons with same configuration reuse computed styles
- **Use Const Constructors**: When possible, use `const FlutstrapButton.primary()` for compile-time constants
- **Avoid Frequent Rebuilds**: Use `copyWith()` for state changes instead of creating new widgets
- **Monitor Cache Size**: Use `FlutstrapButton.cacheSize` in debug mode to monitor caching

```dart
// ✅ Good - Uses style caching
final baseButton = FlutstrapButton.primary(onPressed: () {}, text: 'Base');
var modifiedButton = baseButton.success(); // Reuses cached styles

// ❌ Avoid - Creates new style computations each time
var button1 = FlutstrapButton(onPressed: () {}, text: '1', variant: FSButtonVariant.primary);
var button2 = FlutstrapButton(onPressed: () {}, text: '2', variant: FSButtonVariant.primary);
```

### UX Design Tips

- **Button Text**: Use action-oriented text ("Save", "Delete", "Continue")
- **Loading States**: Always provide loading feedback for async operations
- **Disabled States**: Use disabled states to prevent invalid actions
- **Size Guidelines**:
  - `sm`: For dense interfaces, tables
  - `md`: Standard button size (default)
  - `lg`: For prominent calls-to-action

### Content Guidelines

```dart
// ✅ Good - Clear, action-oriented
FlutstrapButton.primary(
  onPressed: _saveDocument,
  text: 'Save Changes',
)

// ❌ Avoid - Vague or passive
FlutstrapButton.primary(
  onPressed: _saveDocument,
  text: 'Click Here',
)

// ✅ Good - Icons enhance meaning
FlutstrapButton.success(
  onPressed: _confirm,
  text: 'Confirm',
  leading: Icon(Icons.check),
)

// ❌ Avoid - Redundant icons
FlutstrapButton(
  onPressed: _save,
  text: 'Save',
  leading: Icon(Icons.save), // Icon repeats text meaning
)
```

## Troubleshooting

### Common Issues and Solutions

**Button Not Responding to Press**

```dart
// Check if button is disabled or loading
FlutstrapButton(
  onPressed: _isAllowed ? _action : null, // null disables button
  text: 'Action',
  disabled: !_isAllowed, // explicit disabled state
  loading: _isLoading, // loading also prevents presses
)
```

**Style Not Applying Correctly**

```dart
// Ensure theme is properly set up
FSTheme(
  data: FSThemeData.light(), // or dark theme
  child: MyApp(),
)

// Custom style might be overriding variants
FlutstrapButton(
  onPressed: () {},
  text: 'Button',
  variant: FSButtonVariant.primary,
  style: ButtonStyle(), // This overrides variant styles
)
```

**Loading Spinner Color Issues**

```dart
// Loading color is automatically calculated based on variant
FlutstrapButton(
  onPressed: () {},
  text: 'Loading',
  variant: FSButtonVariant.dark, // Spinner will be light-colored
  loading: true,
)
```

**Performance Issues in Lists**

```dart
// Use const constructors when possible
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    return const FlutstrapButton.primary(
      onPressed: _handleItemClick,
      text: 'Action',
    );
  },
)

// Clear cache if needed (rarely necessary)
FlutstrapButton.clearCache();
```

## Full Example

### Complete Application Integration

```dart
import 'package:flutter/material.dart';
import 'package:flutstrap/core/theme.dart';
import 'package:flutstrap/components/buttons/flutstrap_button.dart';
import 'package:flutstrap/components/alerts/flutstrap_alert.dart';

void main() {
  runApp(
    FSTheme(
      data: FSThemeData.light(),
      child: ButtonDemoApp(),
    ),
  );
}

class ButtonDemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutstrap Button Demo',
      theme: ThemeData.light(),
      home: ButtonDemoPage(),
    );
  }
}

class ButtonDemoPage extends StatefulWidget {
  @override
  _ButtonDemoPageState createState() => _ButtonDemoPageState();
}

class _ButtonDemoPageState extends State<ButtonDemoPage> {
  bool _isLoading = false;
  int _counter = 0;

  void _simulateAsyncOperation() async {
    setState(() => _isLoading = true);
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _isLoading = false;
      _counter++;
    });
  }

  void _showAlert(String message, FSAlertVariant variant) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: FlutstrapAlert(
          message: message,
          variant: variant,
          dismissible: true,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutstrap Button Demo'),
        actions: [
          FlutstrapButton.link(
            onPressed: () => _showAlert('Info button clicked', FSAlertVariant.info),
            text: 'Info',
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Basic variants
            Text('Filled Variants', style: Theme.of(context).textTheme.titleMedium),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FlutstrapButton.primary(
                  onPressed: () => _showAlert('Primary clicked', FSAlertVariant.primary),
                  text: 'Primary',
                ),
                FlutstrapButton.secondary(
                  onPressed: () => _showAlert('Secondary clicked', FSAlertVariant.secondary),
                  text: 'Secondary',
                ),
                FlutstrapButton.success(
                  onPressed: () => _showAlert('Success!', FSAlertVariant.success),
                  text: 'Success',
                ),
                FlutstrapButton.danger(
                  onPressed: () => _showAlert('Danger action', FSAlertVariant.danger),
                  text: 'Danger',
                ),
                FlutstrapButton.warning(
                  onPressed: () => _showAlert('Warning shown', FSAlertVariant.warning),
                  text: 'Warning',
                ),
                FlutstrapButton.info(
                  onPressed: () => _showAlert('Information', FSAlertVariant.info),
                  text: 'Info',
                ),
              ],
            ),

            SizedBox(height: 24),

            // Outline variants
            Text('Outline Variants', style: Theme.of(context).textTheme.titleMedium),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FlutstrapButton.outlinePrimary(
                  onPressed: () {},
                  text: 'Outline',
                ),
                FlutstrapButton.outlineSuccess(
                  onPressed: () {},
                  text: 'Success',
                ),
                FlutstrapButton.outlineDanger(
                  onPressed: () {},
                  text: 'Danger',
                ),
              ],
            ),

            SizedBox(height: 24),

            // Sizes
            Text('Button Sizes', style: Theme.of(context).textTheme.titleMedium),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FlutstrapButton.primary(onPressed: () {}, text: 'Small').small(),
                FlutstrapButton.success(onPressed: () {}, text: 'Medium').medium(),
                FlutstrapButton.danger(onPressed: () {}, text: 'Large').large(),
              ],
            ),

            SizedBox(height: 24),

            // With icons
            Text('With Icons', style: Theme.of(context).textTheme.titleMedium),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FlutstrapButton(
                  onPressed: () {},
                  text: 'Download',
                  leading: Icon(Icons.download, size: 18),
                  variant: FSButtonVariant.primary,
                ),
                FlutstrapButton(
                  onPressed: () {},
                  text: 'Upload',
                  trailing: Icon(Icons.upload, size: 18),
                  variant: FSButtonVariant.success,
                ),
              ],
            ),

            SizedBox(height: 24),

            // Loading and state demo
            Text('Interactive Demo', style: Theme.of(context).textTheme.titleMedium),
            Column(
              children: [
                FlutstrapButton(
                  onPressed: _isLoading ? null : _simulateAsyncOperation,
                  text: 'Async Operation ($_counter)',
                  variant: FSButtonVariant.primary,
                  loading: _isLoading,
                  expanded: true,
                ),
                SizedBox(height: 8),
                FlutstrapButton(
                  onPressed: _isLoading ? null : () => _showAlert('Secondary action', FSAlertVariant.info),
                  text: 'Secondary Action',
                  variant: FSButtonVariant.outlineSecondary,
                  expanded: true,
                  disabled: _isLoading,
                ),
              ],
            ),

            SizedBox(height: 24),

            // Expanded buttons
            Text('Expanded Buttons', style: Theme.of(context).textTheme.titleMedium),
            Row(
              children: [
                Expanded(
                  child: FlutstrapButton(
                    onPressed: () {},
                    text: 'Cancel',
                    variant: FSButtonVariant.outlineSecondary,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: FlutstrapButton(
                    onPressed: () {},
                    text: 'Confirm',
                    variant: FSButtonVariant.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```
