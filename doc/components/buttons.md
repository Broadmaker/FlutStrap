# Flutstrap Button Component Guide

## Introduction

Flutstrap Button is a versatile button component with Bootstrap-inspired variants, sizes, and states. It provides a robust button solution for Flutter applications with enterprise-grade performance and accessibility features.

**This comprehensive guide covers all aspects of using the Flutstrap Button component. The button system is designed to be highly flexible, performant, and accessible while providing a robust solution for user interactions across various contexts, states, and design requirements.**

### What It Does

- Provides customizable buttons with multiple visual variants and sizes
- Supports loading states, icons, and accessibility features
- Offers outline and filled button styles
- Includes performance optimizations with style caching

### When to Use

- Primary actions in forms, dialogs, and workflows
- Secondary actions and alternative options
- Destructive actions requiring user confirmation
- Navigation and link-style interactions
- Loading states for asynchronous operations

### Prerequisites

- Flutter 3.0 or higher
- Flutstrap theme system (`FSTheme`)

## Installation & Setup

### Required Dependencies

```dart
import 'package:flutstrap/flutstrap.dart';
```

### Basic Project Setup

Ensure your app is wrapped with the Flutstrap theme:

```dart
void main() {
  runApp(
    MaterialApp(
      home: FSTheme(
        data: FSThemeData.light(), // or FSThemeData.dark()
        child: MyApp(),
      ),
    ),
  );
}
```

## Basic Usage

### Basic Button

```dart
FlutstrapButton(
  onPressed: () {},
  text: 'Primary Button',
  variant: FSButtonVariant.primary,
)
```

### Button with Icon and Loading State

```dart
FlutstrapButton(
  onPressed: _submitForm,
  text: 'Submit',
  variant: FSButtonVariant.success,
  leading: Icon(Icons.check),
  loading: _isSubmitting,
  expanded: true,
)
```

### Using Const Constructor

```dart
const FlutstrapButton.primary(
  onPressed: _handlePress,
  text: 'Primary Button',
)
```

### Disabled Outline Button

```dart
FlutstrapButton(
  onPressed: null,
  text: 'Disabled',
  variant: FSButtonVariant.outlinePrimary,
)
```

## Component Variants

### Filled Variants

```dart
// Primary - main actions
FlutstrapButton(
  variant: FSButtonVariant.primary,
  text: 'Primary',
)

// Secondary - secondary actions
FlutstrapButton(
  variant: FSButtonVariant.secondary,
  text: 'Secondary',
)

// Success - positive actions
FlutstrapButton(
  variant: FSButtonVariant.success,
  text: 'Success',
)

// Danger - destructive actions
FlutstrapButton(
  variant: FSButtonVariant.danger,
  text: 'Danger',
)

// Warning - cautionary actions
FlutstrapButton(
  variant: FSButtonVariant.warning,
  text: 'Warning',
)

// Info - informational actions
FlutstrapButton(
  variant: FSButtonVariant.info,
  text: 'Info',
)

// Light - subtle actions
FlutstrapButton(
  variant: FSButtonVariant.light,
  text: 'Light',
)

// Dark - high contrast actions
FlutstrapButton(
  variant: FSButtonVariant.dark,
  text: 'Dark',
)

// Link - navigation actions
FlutstrapButton(
  variant: FSButtonVariant.link,
  text: 'Link',
)
```

### Outline Variants

```dart
// Outline Primary
FlutstrapButton(
  variant: FSButtonVariant.outlinePrimary,
  text: 'Outline Primary',
)

// Outline Secondary
FlutstrapButton(
  variant: FSButtonVariant.outlineSecondary,
  text: 'Outline Secondary',
)

// Outline Success
FlutstrapButton(
  variant: FSButtonVariant.outlineSuccess,
  text: 'Outline Success',
)

// Outline Danger
FlutstrapButton(
  variant: FSButtonVariant.outlineDanger,
  text: 'Outline Danger',
)

// Outline Warning
FlutstrapButton(
  variant: FSButtonVariant.outlineWarning,
  text: 'Outline Warning',
)

// Outline Info
FlutstrapButton(
  variant: FSButtonVariant.outlineInfo,
  text: 'Outline Info',
)

// Outline Light
FlutstrapButton(
  variant: FSButtonVariant.outlineLight,
  text: 'Outline Light',
)

// Outline Dark
FlutstrapButton(
  variant: FSButtonVariant.outlineDark,
  text: 'Outline Dark',
)
```

### Size Variants

```dart
// Small - compact buttons
FlutstrapButton(
  size: FSButtonSize.sm,
  text: 'Small Button',
)

// Medium - standard buttons (default)
FlutstrapButton(
  size: FSButtonSize.md,
  text: 'Medium Button',
)

// Large - prominent buttons
FlutstrapButton(
  size: FSButtonSize.lg,
  text: 'Large Button',
)
```

## Properties & Parameters

### Parameter Reference Table

| Parameter     | Type              | Default   | Description                    |
| ------------- | ----------------- | --------- | ------------------------------ |
| `onPressed`   | `VoidCallback?`   | `null`    | Button press callback          |
| `onLongPress` | `VoidCallback?`   | `null`    | Long press callback            |
| `variant`     | `FSButtonVariant` | `primary` | Visual style variant           |
| `size`        | `FSButtonSize`    | `md`      | Button size (sm, md, lg)       |
| `disabled`    | `bool`            | `false`   | Disable the button             |
| `loading`     | `bool`            | `false`   | Show loading indicator         |
| `text`        | `String?`         | `null`    | Button text content            |
| `child`       | `Widget?`         | `null`    | Custom button content          |
| `leading`     | `Widget?`         | `null`    | Leading icon/widget            |
| `trailing`    | `Widget?`         | `null`    | Trailing icon/widget           |
| `expanded`    | `bool`            | `false`   | Expand to fill available width |
| `focusNode`   | `FocusNode?`      | `null`    | Focus management               |
| `autofocus`   | `bool`            | `false`   | Auto-focus the button          |
| `style`       | `ButtonStyle?`    | `null`    | Custom button style            |

### FSButtonVariant Enum

```dart
enum FSButtonVariant {
  primary,           // Filled primary button
  secondary,         // Filled secondary button
  success,           // Filled success button
  danger,            // Filled danger button
  warning,           // Filled warning button
  info,              // Filled info button
  light,             // Filled light button
  dark,              // Filled dark button
  link,              // Link-style button
  outlinePrimary,    // Outline primary button
  outlineSecondary,  // Outline secondary button
  outlineSuccess,    // Outline success button
  outlineDanger,     // Outline danger button
  outlineWarning,    // Outline warning button
  outlineInfo,       // Outline info button
  outlineLight,      // Outline light button
  outlineDark,       // Outline dark button
}
```

### FSButtonSize Enum

```dart
enum FSButtonSize {
  sm,  // Small - compact (32px height)
  md,  // Medium - standard (40px height)
  lg,  // Large - prominent (48px height)
}
```

## Customization

### Button with Icons

```dart
FlutstrapButton(
  onPressed: () {},
  text: 'Download',
  leading: Icon(Icons.download, size: 16),
  variant: FSButtonVariant.primary,
)

FlutstrapButton(
  onPressed: () {},
  text: 'Settings',
  trailing: Icon(Icons.arrow_forward, size: 16),
  variant: FSButtonVariant.outlineSecondary,
)
```

### Custom Button Content

```dart
FlutstrapButton(
  onPressed: () {},
  child: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.star, color: Colors.amber),
      SizedBox(width: 8),
      Text('Custom Content'),
      SizedBox(width: 8),
      Badge(
        label: Text('3'),
        backgroundColor: Colors.red,
      ),
    ],
  ),
)
```

### Expanded Buttons

```dart
Column(
  children: [
    FlutstrapButton(
      onPressed: () {},
      text: 'Full Width Button',
      expanded: true,
    ),
    SizedBox(height: 16),
    Row(
      children: [
        Expanded(
          child: FlutstrapButton(
            onPressed: () {},
            text: 'Left',
            variant: FSButtonVariant.primary,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: FlutstrapButton(
            onPressed: () {},
            text: 'Right',
            variant: FSButtonVariant.secondary,
          ),
        ),
      ],
    ),
  ],
)
```

## Interactivity & Behavior

### Loading States

```dart
class FormWithLoading extends StatefulWidget {
  @override
  _FormWithLoadingState createState() => _FormWithLoadingState();
}

class _FormWithLoadingState extends State<FormWithLoading> {
  bool _isSubmitting = false;

  void _submitForm() async {
    setState(() => _isSubmitting = true);

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    setState(() => _isSubmitting = false);
    // Handle form submission result
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FlutstrapButton(
          onPressed: _isSubmitting ? null : _submitForm,
          text: 'Submit Form',
          variant: FSButtonVariant.primary,
          loading: _isSubmitting,
          expanded: true,
        ),

        SizedBox(height: 16),

        FlutstrapButton(
          onPressed: _isSubmitting ? null : () {},
          text: 'Secondary Action',
          variant: FSButtonVariant.outlineSecondary,
          disabled: _isSubmitting,
        ),
      ],
    );
  }
}
```

### Button Groups

```dart
Row(
  children: [
    FlutstrapButton(
      onPressed: () {},
      text: 'Save',
      variant: FSButtonVariant.primary,
      leading: Icon(Icons.save, size: 16),
    ),

    SizedBox(width: 8),

    FlutstrapButton(
      onPressed: () {},
      text: 'Cancel',
      variant: FSButtonVariant.outlineSecondary,
    ),

    Spacer(),

    FlutstrapButton(
      onPressed: () {},
      text: 'Delete',
      variant: FSButtonVariant.danger,
      leading: Icon(Icons.delete, size: 16),
    ),
  ],
)
```

### Using CopyWith for State Management

```dart
class DynamicButton extends StatefulWidget {
  @override
  _DynamicButtonState createState() => _DynamicButtonState();
}

class _DynamicButtonState extends State<DynamicButton> {
  var _button = FlutstrapButton(
    onPressed: () {},
    text: 'Initial State',
    variant: FSButtonVariant.primary,
  );

  void _makeSuccess() {
    setState(() {
      _button = _button.success().withLoading(true);
    });

    // Simulate async operation
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _button = _button.success().withLoading(false);
        });
      }
    });
  }

  void _makeDanger() {
    setState(() {
      _button = _button.danger().expand();
    });
  }

  void _reset() {
    setState(() {
      _button = FlutstrapButton(
        onPressed: () {},
        text: 'Reset',
        variant: FSButtonVariant.primary,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _button,

        SizedBox(height: 16),

        Row(
          children: [
            FlutstrapButton(
              onPressed: _makeSuccess,
              text: 'Make Success',
              size: FSButtonSize.sm,
            ),

            SizedBox(width: 8),

            FlutstrapButton(
              onPressed: _makeDanger,
              text: 'Make Danger',
              size: FSButtonSize.sm,
              variant: FSButtonVariant.outlineSecondary,
            ),

            SizedBox(width: 8),

            FlutstrapButton(
              onPressed: _reset,
              text: 'Reset',
              size: FSButtonSize.sm,
              variant: FSButtonVariant.outlineDanger,
            ),
          ],
        ),
      ],
    );
  }
}
```

## Accessibility Notes

Flutstrap Button includes comprehensive accessibility features:

- **Screen Reader Support**: Full semantic labels for button text and states
- **Loading State Announcements**: Screen readers announce when buttons are loading
- **Focus Management**: Proper focus indicators and keyboard navigation
- **Disabled State Semantics**: Clear communication of disabled state to assistive technologies
- **High Contrast Support**: Meets WCAG contrast guidelines for all variants

```dart
FlutstrapButton(
  onPressed: () {},
  text: 'Save Changes',
  semanticLabel: 'Save changes to document',
  loading: _isSaving,
  // Screen readers will announce "Loading" when loading is true
)
```

## Integration Examples

### Complete Action Bar

```dart
class ActionBar extends StatelessWidget {
  final bool hasChanges;
  final bool isSaving;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final VoidCallback onDelete;

  const ActionBar({
    super.key,
    required this.hasChanges,
    required this.isSaving,
    required this.onSave,
    required this.onCancel,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(
          top: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: Row(
        children: [
          FlutstrapButton(
            onPressed: hasChanges && !isSaving ? onSave : null,
            text: 'Save Changes',
            variant: FSButtonVariant.primary,
            leading: isSaving ? null : Icon(Icons.save, size: 16),
            loading: isSaving,
          ),

          SizedBox(width: 12),

          FlutstrapButton(
            onPressed: isSaving ? null : onCancel,
            text: 'Cancel',
            variant: FSButtonVariant.outlineSecondary,
          ),

          Spacer(),

          FlutstrapButton(
            onPressed: isSaving ? null : onDelete,
            text: 'Delete',
            variant: FSButtonVariant.outlineDanger,
            leading: Icon(Icons.delete_outline, size: 16),
          ),
        ],
      ),
    );
  }
}
```

### Multi-step Form Navigation

```dart
class FormNavigation extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final bool isValid;
  final bool isSubmitting;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final VoidCallback onSubmit;

  const FormNavigation({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    required this.isValid,
    required this.isSubmitting,
    required this.onPrevious,
    required this.onNext,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final isFirstStep = currentStep == 1;
    final isLastStep = currentStep == totalSteps;

    return Row(
      children: [
        // Previous Button
        if (!isFirstStep)
          FlutstrapButton(
            onPressed: isSubmitting ? null : onPrevious,
            text: 'Previous',
            variant: FSButtonVariant.outlineSecondary,
            leading: Icon(Icons.arrow_back, size: 16),
          ),

        Spacer(),

        // Next/Submit Button
        if (!isLastStep)
          FlutstrapButton(
            onPressed: isValid && !isSubmitting ? onNext : null,
            text: 'Next',
            variant: FSButtonVariant.primary,
            trailing: Icon(Icons.arrow_forward, size: 16),
          )
        else
          FlutstrapButton(
            onPressed: isValid && !isSubmitting ? onSubmit : null,
            text: 'Submit',
            variant: FSButtonVariant.success,
            leading: isSubmitting ? null : Icon(Icons.check, size: 16),
            loading: isSubmitting,
          ),
      ],
    );
  }
}
```

### Toolbar with Multiple Button Types

```dart
class EditorToolbar extends StatelessWidget {
  final bool isEditing;
  final bool hasSelection;
  final VoidCallback onBold;
  final VoidCallback onItalic;
  final VoidCallback onLink;
  final VoidCallback onImage;

  const EditorToolbar({
    super.key,
    required this.isEditing,
    required this.hasSelection,
    required this.onBold,
    required this.onItalic,
    required this.onLink,
    required this.onImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          // Formatting Buttons
          FlutstrapButton(
            onPressed: isEditing && hasSelection ? onBold : null,
            child: Text('B', style: TextStyle(fontWeight: FontWeight.bold)),
            variant: FSButtonVariant.outlineSecondary,
            size: FSButtonSize.sm,
          ),

          SizedBox(width: 8),

          FlutstrapButton(
            onPressed: isEditing && hasSelection ? onItalic : null,
            child: Text('I', style: TextStyle(fontStyle: FontStyle.italic)),
            variant: FSButtonVariant.outlineSecondary,
            size: FSButtonSize.sm,
          ),

          SizedBox(width: 16),

          // Insert Buttons
          FlutstrapButton(
            onPressed: isEditing ? onLink : null,
            text: 'Link',
            leading: Icon(Icons.link, size: 14),
            variant: FSButtonVariant.outlineInfo,
            size: FSButtonSize.sm,
          ),

          SizedBox(width: 8),

          FlutstrapButton(
            onPressed: isEditing ? onImage : null,
            text: 'Image',
            leading: Icon(Icons.image, size: 14),
            variant: FSButtonVariant.outlineInfo,
            size: FSButtonSize.sm,
          ),

          Spacer(),

          // Status Indicator
          FlutstrapButton(
            onPressed: null,
            text: isEditing ? 'Editing' : 'Read Only',
            variant: isEditing ? FSButtonVariant.outlineSuccess : FSButtonVariant.outlineSecondary,
            size: FSButtonSize.sm,
          ),
        ],
      ),
    );
  }
}
```

## Performance Optimization

### Style Caching Benefits

```dart
// ✅ GOOD: Multiple buttons with same configuration reuse cached styles
Column(
  children: [
    FlutstrapButton(
      onPressed: () {},
      text: 'Button 1',
      variant: FSButtonVariant.primary,
      size: FSButtonSize.md,
    ),
    FlutstrapButton(
      onPressed: () {},
      text: 'Button 2',
      variant: FSButtonVariant.primary, // Same variant and size
      size: FSButtonSize.md,           // Styles are cached and reused
    ),
  ],
)

// ✅ BETTER: Using const constructors when possible
const FlutstrapButton.primary(
  onPressed: _handleAction,
  text: 'Const Button',
)
```

### Efficient State Updates

```dart
// ✅ GOOD: Using copyWith for state modifications
class EfficientButtonManager extends StatefulWidget {
  @override
  _EfficientButtonManagerState createState() => _EfficientButtonManagerState();
}

class _EfficientButtonManagerState extends State<EfficientButtonManager> {
  var _button = FlutstrapButton(
    onPressed: () {},
    text: 'Initial',
    variant: FSButtonVariant.primary,
  );

  void _updateButton() {
    setState(() {
      _button = _button
          .success()          // Changes variant
          .withLoading(true)  // Sets loading state
          .expand();          // Makes button expanded
    });
  }

  @override
  Widget build(BuildContext context) {
    return _button;
  }
}
```

## Best Practices

### Button Usage Guidelines

```dart
// ✅ PRIMARY: Main action in a view
FlutstrapButton(
  onPressed: _submitForm,
  text: 'Save Changes',
  variant: FSButtonVariant.primary,
  expanded: true,
)

// ✅ SECONDARY: Alternative actions
FlutstrapButton(
  onPressed: _cancel,
  text: 'Cancel',
  variant: FSButtonVariant.outlineSecondary,
)

// ✅ DANGER: Destructive actions
FlutstrapButton(
  onPressed: _deleteItem,
  text: 'Delete',
  variant: FSButtonVariant.danger,
  leading: Icon(Icons.delete),
)

// ✅ SUCCESS: Positive confirmation actions
FlutstrapButton(
  onPressed: _confirmSuccess,
  text: 'Confirm',
  variant: FSButtonVariant.success,
  leading: Icon(Icons.check),
)

// ✅ LINK: Navigation actions
FlutstrapButton(
  onPressed: _navigate,
  text: 'Learn More',
  variant: FSButtonVariant.link,
)
```

### Loading State Patterns

```dart
// ✅ GOOD: Disable related actions during loading
Row(
  children: [
    FlutstrapButton(
      onPressed: _isLoading ? null : _primaryAction,
      text: 'Primary',
      variant: FSButtonVariant.primary,
      loading: _isLoading,
    ),

    SizedBox(width: 12),

    FlutstrapButton(
      onPressed: _isLoading ? null : _secondaryAction,
      text: 'Secondary',
      variant: FSButtonVariant.outlineSecondary,
      disabled: _isLoading, // Visual disabled state
    ),
  ],
)

// ✅ BETTER: Provide loading feedback for all async operations
FlutstrapButton(
  onPressed: _asyncOperation,
  text: 'Process Data',
  loading: _isProcessing,
  // Always show loading state for async operations
)
```

## Troubleshooting

### Common Issues and Solutions

**Button Not Responding**

```dart
// ❌ onPressed is null or disabled is true
FlutstrapButton(
  onPressed: null, // Button won't respond
  text: 'Click Me',
)

// ✅ Ensure onPressed is provided and disabled is false
FlutstrapButton(
  onPressed: () => print('Clicked'),
  text: 'Click Me',
)

// ✅ Or manage state properly
FlutstrapButton(
  onPressed: _isLoading ? null : _handleClick,
  text: 'Click Me',
  disabled: _isLoading,
)
```

**Loading State Not Showing**

```dart
// ❌ Loading state but button is still enabled
FlutstrapButton(
  onPressed: _handleAction, // Still callable
  loading: true,
  text: 'Loading...',
)

// ✅ Correct: Disable button when loading
FlutstrapButton(
  onPressed: _isLoading ? null : _handleAction,
  loading: _isLoading,
  text: _isLoading ? 'Loading...' : 'Action',
)
```

**Style Not Applying**

```dart
// ❌ Custom style overriding variant styles
FlutstrapButton(
  style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.red),
  ), // Overrides variant colors
  variant: FSButtonVariant.primary, // This won't apply
  text: 'Button',
)

// ✅ Better: Use variant for color, custom style for layout
FlutstrapButton(
  variant: FSButtonVariant.primary, // Handles colors
  style: ButtonStyle(
    padding: MaterialStateProperty.all(EdgeInsets.all(20)),
  ), // Only override non-color properties
  text: 'Button',
)
```

### Debugging Tips

1. **Check Button State**: Verify `onPressed`, `disabled`, and `loading` states
2. **Monitor Performance**: Use `FlutstrapButton.cacheSize` to monitor style caching
3. **Test Accessibility**: Use screen readers to verify semantic labels
4. **Verify Focus**: Test keyboard navigation and focus indicators
5. **Check Constraints**: Ensure parent widgets provide adequate space for expanded buttons

---

**This comprehensive guide covers all aspects of using the Flutstrap Button component. The button system is designed to be highly flexible, performant, and accessible while providing a robust solution for user interactions across various contexts, states, and design requirements. With features like style caching, multiple variants, and comprehensive accessibility, Flutstrap Button offers enterprise-grade button capabilities for modern Flutter applications.**
