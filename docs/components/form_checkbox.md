# Flutstrap Checkbox Component Guide

## Introduction

Flutstrap Checkbox is a high-performance, accessible checkbox component with comprehensive theming, smooth animations, and Bootstrap-inspired variants. It provides a robust selection control solution for Flutter applications with enterprise-grade performance and accessibility features.

**This comprehensive guide covers all aspects of using the Flutstrap Checkbox component. The checkbox system is designed to be highly flexible, performant, and accessible while providing a robust solution for selection controls across various interaction patterns, validation requirements, and design contexts.**

### What It Does

- Provides customizable checkbox controls with multiple visual variants
- Supports standard binary selection and tri-state (indeterminate) modes
- Offers smooth animations and comprehensive validation support
- Includes accessibility features and performance optimizations

### When to Use

- Binary selection in forms, settings, and feature toggles
- Hierarchical selections with tri-state checkboxes (select all/none/some)
- Agreement acceptance (terms and conditions, privacy policies)
- Multi-select lists and filter options

### Prerequisites

- Flutter 3.0 or higher
- Flutstrap theme system (`FSTheme`)
- Material Design Icons

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

### Simple Checkbox

```dart
bool _isChecked = false;

FlutstrapCheckbox(
  value: _isChecked,
  onChanged: (value) => setState(() => _isChecked = value!),
  label: 'Accept terms and conditions',
)
```

### Checkbox with Variant

```dart
bool _isCompleted = false;

FlutstrapCheckbox(
  value: _isCompleted,
  onChanged: (value) => setState(() => _isCompleted = value!),
  variant: FSCheckboxVariant.success,
  label: 'Task completed',
)
```

### Disabled Checkbox

```dart
FlutstrapCheckbox(
  value: true,
  onChanged: null,
  label: 'Disabled checkbox',
  disabled: true,
)
```

### Tri-state Checkbox

```dart
bool? _triStateValue = null; // null = indeterminate

FlutstrapCheckbox(
  value: _triStateValue,
  onChanged: (value) => setState(() => _triStateValue = value),
  tristate: true,
  label: 'Select all options',
)
```

## Component Variants

### Visual Variants

Flutstrap Checkbox provides 6 visual variants to convey different states and meanings:

```dart
// Primary (default) - standard selection
FlutstrapCheckbox(
  value: _isChecked,
  onChanged: (value) => setState(() => _isChecked = value!),
  variant: FSCheckboxVariant.primary,
  label: 'Primary checkbox',
)

// Success - for positive/complete states
FlutstrapCheckbox(
  value: _isChecked,
  onChanged: (value) => setState(() => _isChecked = value!),
  variant: FSCheckboxVariant.success,
  label: 'Success checkbox',
)

// Danger - for critical/warning states
FlutstrapCheckbox(
  value: _isChecked,
  onChanged: (value) => setState(() => _isChecked = value!),
  variant: FSCheckboxVariant.danger,
  label: 'Danger checkbox',
)

// Warning - for cautionary states
FlutstrapCheckbox(
  value: _isChecked,
  onChanged: (value) => setState(() => _isChecked = value!),
  variant: FSCheckboxVariant.warning,
  label: 'Warning checkbox',
)

// Info - for informational states
FlutstrapCheckbox(
  value: _isChecked,
  onChanged: (value) => setState(() => _isChecked = value!),
  variant: FSCheckboxVariant.info,
  label: 'Info checkbox',
)

// Secondary - alternative styling
FlutstrapCheckbox(
  value: _isChecked,
  onChanged: (value) => setState(() => _isChecked = value!),
  variant: FSCheckboxVariant.secondary,
  label: 'Secondary checkbox',
)
```

### Size Variants

```dart
// Small - compact for dense interfaces
FlutstrapCheckbox(
  value: _isChecked,
  onChanged: (value) => setState(() => _isChecked = value!),
  size: FSCheckboxSize.sm,
  label: 'Small checkbox',
)

// Medium - standard size (default)
FlutstrapCheckbox(
  value: _isChecked,
  onChanged: (value) => setState(() => _isChecked = value!),
  size: FSCheckboxSize.md,
  label: 'Medium checkbox',
)

// Large - for better visibility and touch targets
FlutstrapCheckbox(
  value: _isChecked,
  onChanged: (value) => setState(() => _isChecked = value!),
  size: FSCheckboxSize.lg,
  label: 'Large checkbox',
)
```

## Properties & Parameters

### Parameter Reference Table

| Parameter           | Type                   | Default      | Description                      |
| ------------------- | ---------------------- | ------------ | -------------------------------- |
| `value`             | `bool?`                | **required** | Checkbox state (true/false/null) |
| `onChanged`         | `ValueChanged<bool?>?` | `null`       | State change callback            |
| `variant`           | `FSCheckboxVariant`    | `primary`    | Visual style variant             |
| `size`              | `FSCheckboxSize`       | `md`         | Checkbox size (sm, md, lg)       |
| `label`             | `String?`              | `null`       | Text label for checkbox          |
| `customLabel`       | `Widget?`              | `null`       | Custom label widget              |
| `disabled`          | `bool`                 | `false`      | Disable the checkbox             |
| `inline`            | `bool`                 | `false`      | Inline layout with label         |
| `semanticLabel`     | `String?`              | `null`       | Accessibility label              |
| `showValidation`    | `bool`                 | `false`      | Show validation state            |
| `isValid`           | `bool`                 | `true`       | Validation state                 |
| `validationMessage` | `String?`              | `null`       | Validation error message         |
| `tristate`          | `bool`                 | `false`      | Enable tri-state mode            |
| `activeColor`       | `Color?`               | `null`       | Custom active color              |
| `checkColor`        | `Color?`               | `null`       | Custom checkmark color           |
| `visualDensity`     | `VisualDensity?`       | `null`       | Visual density                   |
| `padding`           | `EdgeInsetsGeometry?`  | `null`       | Custom padding                   |

### FSCheckboxVariant Enum

```dart
enum FSCheckboxVariant {
  primary,    // Blue theme - standard selection
  secondary,  // Gray theme - alternative styling
  success,    // Green theme - positive/complete states
  danger,     // Red theme - error/critical states
  warning,    // Yellow theme - cautionary states
  info,       // Blue theme - informational states
}
```

### FSCheckboxSize Enum

```dart
enum FSCheckboxSize {
  sm,  // 16px - compact size
  md,  // 20px - standard size
  lg,  // 24px - large size for better touch targets
}
```

## Customization

### Custom Styling

```dart
FlutstrapCheckbox(
  value: _isChecked,
  onChanged: (value) => setState(() => _isChecked = value!),
  label: 'Custom styled checkbox',
  activeColor: Colors.purple,
  checkColor: Colors.white,
  size: FSCheckboxSize.lg,
  padding: EdgeInsets.all(8),
)
```

### Custom Label Widget

```dart
FlutstrapCheckbox(
  value: _isChecked,
  onChanged: (value) => setState(() => _isChecked = value!),
  customLabel: Row(
    children: [
      Icon(Icons.security, size: 16),
      SizedBox(width: 8),
      Text('Enable security features'),
      SizedBox(width: 8),
      FlutstrapBadge(
        text: 'Recommended',
        variant: FSBadgeVariant.success,
        size: FSBadgeSize.sm,
      ),
    ],
  ),
)
```

### Validation Styling

```dart
FlutstrapCheckbox(
  value: _isAgreed,
  onChanged: (value) => setState(() => _isAgreed = value!),
  label: 'I agree to the terms and conditions',
  showValidation: true,
  isValid: _isAgreed,
  validationMessage: 'You must accept the terms to continue',
)
```

## Interactivity & Behavior

### Tri-state Checkbox Pattern

```dart
class TriStateCheckboxExample extends StatefulWidget {
  @override
  _TriStateCheckboxExampleState createState() => _TriStateCheckboxExampleState();
}

class _TriStateCheckboxExampleState extends State<TriStateCheckboxExample> {
  bool? _selectAllValue;
  final List<bool> _itemStates = [false, false, false];

  void _updateSelectAllState() {
    final checkedCount = _itemStates.where((state) => state).length;

    if (checkedCount == 0) {
      _selectAllValue = false;
    } else if (checkedCount == _itemStates.length) {
      _selectAllValue = true;
    } else {
      _selectAllValue = null; // Indeterminate
    }
  }

  void _handleSelectAllChange(bool? value) {
    setState(() {
      _selectAllValue = value;
      final newState = value == true;
      for (int i = 0; i < _itemStates.length; i++) {
        _itemStates[i] = newState;
      }
    });
  }

  void _handleItemChange(int index, bool? value) {
    setState(() {
      _itemStates[index] = value ?? false;
      _updateSelectAllState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FlutstrapCheckbox(
          value: _selectAllValue,
          onChanged: _handleSelectAllChange,
          tristate: true,
          label: 'Select all items',
          variant: FSCheckboxVariant.primary,
        ),
        SizedBox(height: 16),
        ..._itemStates.asMap().entries.map((entry) {
          final index = entry.key;
          final value = entry.value;
          return Padding(
            padding: EdgeInsets.only(left: 32, bottom: 8),
            child: FlutstrapCheckbox(
              value: value,
              onChanged: (newValue) => _handleItemChange(index, newValue),
              label: 'Item ${index + 1}',
            ),
          );
        }).toList(),
      ],
    );
  }
}
```

### Form Integration with Validation

```dart
class CheckboxFormExample extends StatefulWidget {
  @override
  _CheckboxFormExampleState createState() => _CheckboxFormExampleState();
}

class _CheckboxFormExampleState extends State<CheckboxFormExample> {
  bool _acceptTerms = false;
  bool _newsletterSubscription = true;
  bool _showValidation = false;

  void _submitForm() {
    setState(() {
      _showValidation = true;
    });

    if (!_acceptTerms) {
      return; // Don't submit if terms not accepted
    }

    // Process form submission
    _processFormData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FlutstrapCheckbox(
          value: _acceptTerms,
          onChanged: (value) => setState(() => _acceptTerms = value!),
          label: 'I accept the terms and conditions',
          showValidation: _showValidation,
          isValid: _acceptTerms,
          validationMessage: 'You must accept the terms to continue',
        ),
        SizedBox(height: 16),
        FlutstrapCheckbox(
          value: _newsletterSubscription,
          onChanged: (value) => setState(() => _newsletterSubscription = value!),
          label: 'Subscribe to newsletter',
          variant: FSCheckboxVariant.success,
        ),
        SizedBox(height: 24),
        FlutstrapButton(
          onPressed: _submitForm,
          child: Text('Submit Form'),
        ),
      ],
    );
  }
}
```

## Accessibility Notes

Flutstrap Checkbox includes comprehensive accessibility features:

- **Screen Reader Support**: Full semantic labels for checkbox states and labels
- **Keyboard Navigation**: Support for keyboard interaction and focus management
- **State Announcements**: Screen readers announce checked, unchecked, and mixed states
- **Focus Indicators**: Clear visual focus indicators for keyboard users
- **High Contrast Support**: Meets WCAG contrast guidelines

```dart
FlutstrapCheckbox(
  value: _isChecked,
  onChanged: (value) => setState(() => _isChecked = value!),
  label: 'Enable notifications',
  semanticLabel: 'Enable push notifications for all alerts',
)
```

## Integration Examples

### Settings Panel with Multiple Checkboxes

```dart
class SettingsPanel extends StatefulWidget {
  @override
  _SettingsPanelState createState() => _SettingsPanelState();
}

class _SettingsPanelState extends State<SettingsPanel> {
  bool _emailNotifications = true;
  bool _pushNotifications = false;
  bool _smsNotifications = false;
  bool _darkMode = true;
  bool _autoSave = true;
  bool _analyticsTracking = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Notification Settings',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 16),
          FlutstrapCheckbox(
            value: _emailNotifications,
            onChanged: (value) => setState(() => _emailNotifications = value!),
            label: 'Email notifications',
            variant: FSCheckboxVariant.primary,
          ),
          SizedBox(height: 8),
          FlutstrapCheckbox(
            value: _pushNotifications,
            onChanged: (value) => setState(() => _pushNotifications = value!),
            label: 'Push notifications',
            variant: FSCheckboxVariant.info,
          ),
          SizedBox(height: 8),
          FlutstrapCheckbox(
            value: _smsNotifications,
            onChanged: (value) => setState(() => _smsNotifications = value!),
            label: 'SMS notifications',
            variant: FSCheckboxVariant.warning,
          ),
          SizedBox(height: 24),
          Text(
            'Appearance & Behavior',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 16),
          FlutstrapCheckbox(
            value: _darkMode,
            onChanged: (value) => setState(() => _darkMode = value!),
            label: 'Dark mode',
            variant: FSCheckboxVariant.secondary,
          ),
          SizedBox(height: 8),
          FlutstrapCheckbox(
            value: _autoSave,
            onChanged: (value) => setState(() => _autoSave = value!),
            label: 'Auto-save documents',
            variant: FSCheckboxVariant.success,
          ),
          SizedBox(height: 8),
          FlutstrapCheckbox(
            value: _analyticsTracking,
            onChanged: (value) => setState(() => _analyticsTracking = value!),
            label: 'Share usage analytics',
            variant: FSCheckboxVariant.info,
          ),
        ],
      ),
    );
  }
}
```

### Filter Panel with Checkbox Groups

```dart
class FilterPanel extends StatefulWidget {
  @override
  _FilterPanelState createState() => _FilterPanelState();
}

class _FilterPanelState extends State<FilterPanel> {
  final Map<String, bool> _categoryFilters = {
    'Electronics': true,
    'Clothing': false,
    'Books': true,
    'Home & Garden': false,
    'Sports': true,
  };

  final Map<String, bool> _priceFilters = {
    'Under \$25': false,
    '\$25 - \$50': true,
    '\$50 - \$100': false,
    'Over \$100': true,
  };

  void _toggleCategory(String category, bool? value) {
    setState(() {
      _categoryFilters[category] = value ?? false;
    });
  }

  void _togglePrice(String priceRange, bool? value) {
    setState(() {
      _priceFilters[priceRange] = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Categories',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 12),
          ..._categoryFilters.entries.map((entry) {
            return Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: FlutstrapCheckbox(
                value: entry.value,
                onChanged: (value) => _toggleCategory(entry.key, value),
                label: entry.key,
                inline: true,
              ),
            );
          }),
          SizedBox(height: 24),
          Text(
            'Price Range',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 12),
          ..._priceFilters.entries.map((entry) {
            return Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: FlutstrapCheckbox(
                value: entry.value,
                onChanged: (value) => _togglePrice(entry.key, value),
                label: entry.key,
                inline: true,
                variant: FSCheckboxVariant.success,
              ),
            );
          }),
        ],
      ),
    );
  }
}
```

## Performance Optimization

### Efficient State Management

```dart
// ✅ GOOD: Using stateful widget for local state
class EfficientCheckboxGroup extends StatefulWidget {
  @override
  _EfficientCheckboxGroupState createState() => _EfficientCheckboxGroupState();
}

class _EfficientCheckboxGroupState extends State<EfficientCheckboxGroup> {
  final List<bool> _states = List.filled(10, false);

  void _handleChange(int index, bool? value) {
    setState(() {
      _states[index] = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _states.asMap().entries.map((entry) {
        return FlutstrapCheckbox(
          value: entry.value,
          onChanged: (value) => _handleChange(entry.key, value),
          label: 'Option ${entry.key + 1}',
        );
      }).toList(),
    );
  }
}
```

### Using Convenience Methods

```dart
// ✅ GOOD: Method chaining for quick customization
FlutstrapCheckbox(
  value: _isChecked,
  onChanged: (value) => setState(() => _isChecked = value!),
)
.success()           // Change variant to success
.large()             // Change size to large
.withLabel('Completed') // Set label
```

## Best Practices

### Labeling and Semantics

```dart
// ✅ GOOD: Clear, descriptive labels
FlutstrapCheckbox(
  value: _emailNotifications,
  onChanged: (value) => setState(() => _emailNotifications = value!),
  label: 'Receive email notifications for new messages',
  semanticLabel: 'Enable email notifications for all incoming messages',
)

// ✅ GOOD: Group related checkboxes semantically
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text('Notification Preferences', style: TextStyle(fontWeight: FontWeight.bold)),
    FlutstrapCheckbox(value: _email, onChanged: (v) => setState(() => _email = v!), label: 'Email'),
    FlutstrapCheckbox(value: _push, onChanged: (v) => setState(() => _push = v!), label: 'Push'),
    FlutstrapCheckbox(value: _sms, onChanged: (v) => setState(() => _sms = v!), label: 'SMS'),
  ],
)
```

### Validation Patterns

```dart
// ✅ GOOD: Clear validation with helpful messages
FlutstrapCheckbox(
  value: _acceptTerms,
  onChanged: (value) => setState(() => _acceptTerms = value!),
  label: 'I have read and agree to the Terms of Service and Privacy Policy',
  showValidation: _showValidation,
  isValid: _acceptTerms,
  validationMessage: 'You must accept the terms to create an account',
)
```

## Troubleshooting

### Common Issues and Solutions

**Checkbox Not Updating**

```dart
// ❌ Missing setState or incorrect value handling
FlutstrapCheckbox(
  value: _isChecked,
  onChanged: (value) => _isChecked = value!, // Missing setState
)

// ✅ Correct state management
FlutstrapCheckbox(
  value: _isChecked,
  onChanged: (value) => setState(() => _isChecked = value!),
)
```

**Tri-state Not Working**

```dart
// ❌ Incorrect value type for tri-state
bool _value = false; // Should be bool? for tri-state

FlutstrapCheckbox(
  value: _value,
  onChanged: (value) => setState(() => _value = value!),
  tristate: true,
)

// ✅ Correct tri-state implementation
bool? _value = null; // Can be true, false, or null

FlutstrapCheckbox(
  value: _value,
  onChanged: (value) => setState(() => _value = value),
  tristate: true,
)
```

**Accessibility Issues**

```dart
// ❌ Missing semantic information
FlutstrapCheckbox(
  value: _isChecked,
  onChanged: (value) => setState(() => _isChecked = value!),
  // No label or semanticLabel
)

// ✅ Accessible implementation
FlutstrapCheckbox(
  value: _isChecked,
  onChanged: (value) => setState(() => _isChecked = value!),
  label: 'Enable feature',
  semanticLabel: 'Toggle experimental feature activation',
)
```

### Debugging Tips

1. **Check Value Types**: Ensure `bool?` for tri-state, `bool` for standard
2. **Verify State Management**: Use `setState` for local state changes
3. **Test Accessibility**: Use screen readers to verify semantic labels
4. **Check Focus Management**: Ensure proper keyboard navigation
5. **Monitor Performance**: Use Flutter DevTools for performance monitoring

---

**This comprehensive guide covers all aspects of using the Flutstrap Checkbox component. The checkbox system is designed to be highly flexible, performant, and accessible while providing a robust solution for selection controls across various interaction patterns, validation requirements, and design contexts. With features like tri-state support, smooth animations, and comprehensive accessibility, Flutstrap Checkbox offers enterprise-grade selection control capabilities for modern Flutter applications.**
