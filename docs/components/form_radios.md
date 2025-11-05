# Flutstrap Radio Component Guide

## Introduction

Flutstrap Radio is a high-performance, accessible radio button component with comprehensive theming, smooth animations, and Bootstrap-inspired variants. It provides a robust single-selection control solution for Flutter applications with enterprise-grade performance and accessibility features.

**This comprehensive guide covers all aspects of using the Flutstrap Radio component. The radio system is designed to be highly flexible, performant, and accessible while providing a robust solution for single-selection controls across various interaction patterns, validation requirements, and design contexts.**

### What It Does

- Provides customizable radio button controls with multiple visual variants
- Supports single selection within grouped options
- Offers smooth animations and comprehensive validation support
- Includes accessibility features and performance optimizations

### When to Use

- Single selection in forms, settings, and preference panels
- Mutually exclusive options where only one choice is allowed
- Survey questions with predefined answer options
- Configuration settings with limited choices

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

### Simple Radio Group

```dart
String _selectedOption = 'option1';

Column(
  children: [
    FlutstrapRadio<String>(
      value: 'option1',
      groupValue: _selectedOption,
      onChanged: (value) => setState(() => _selectedOption = value!),
      label: 'Option 1',
    ),
    FlutstrapRadio<String>(
      value: 'option2',
      groupValue: _selectedOption,
      onChanged: (value) => setState(() => _selectedOption = value!),
      label: 'Option 2',
    ),
    FlutstrapRadio<String>(
      value: 'option3',
      groupValue: _selectedOption,
      onChanged: (value) => setState(() => _selectedOption = value!),
      label: 'Option 3',
    ),
  ],
)
```

### Radio with Variant

```dart
String _status = 'pending';

FlutstrapRadio<String>(
  value: 'success',
  groupValue: _status,
  onChanged: (value) => setState(() => _status = value!),
  variant: FSRadioVariant.success,
  label: 'Success Status',
)
```

### Disabled Radio

```dart
FlutstrapRadio<String>(
  value: 'disabled',
  groupValue: 'enabled', // Different from value to show unselected state
  onChanged: null,
  label: 'Disabled radio option',
  disabled: true,
)
```

## Component Variants

### Visual Variants

Flutstrap Radio provides 6 visual variants to convey different states and meanings:

```dart
// Primary (default) - standard selection
FlutstrapRadio<String>(
  value: 'primary',
  groupValue: _selected,
  onChanged: (value) => setState(() => _selected = value!),
  variant: FSRadioVariant.primary,
  label: 'Primary radio',
)

// Success - for positive/approved states
FlutstrapRadio<String>(
  value: 'success',
  groupValue: _selected,
  onChanged: (value) => setState(() => _selected = value!),
  variant: FSRadioVariant.success,
  label: 'Success radio',
)

// Danger - for critical/warning states
FlutstrapRadio<String>(
  value: 'danger',
  groupValue: _selected,
  onChanged: (value) => setState(() => _selected = value!),
  variant: FSRadioVariant.danger,
  label: 'Danger radio',
)

// Warning - for cautionary states
FlutstrapRadio<String>(
  value: 'warning',
  groupValue: _selected,
  onChanged: (value) => setState(() => _selected = value!),
  variant: FSRadioVariant.warning,
  label: 'Warning radio',
)

// Info - for informational states
FlutstrapRadio<String>(
  value: 'info',
  groupValue: _selected,
  onChanged: (value) => setState(() => _selected = value!),
  variant: FSRadioVariant.info,
  label: 'Info radio',
)

// Secondary - alternative styling
FlutstrapRadio<String>(
  value: 'secondary',
  groupValue: _selected,
  onChanged: (value) => setState(() => _selected = value!),
  variant: FSRadioVariant.secondary,
  label: 'Secondary radio',
)
```

### Size Variants

```dart
// Small - compact for dense interfaces
FlutstrapRadio<String>(
  value: 'small',
  groupValue: _selected,
  onChanged: (value) => setState(() => _selected = value!),
  size: FSRadioSize.sm,
  label: 'Small radio',
)

// Medium - standard size (default)
FlutstrapRadio<String>(
  value: 'medium',
  groupValue: _selected,
  onChanged: (value) => setState(() => _selected = value!),
  size: FSRadioSize.md,
  label: 'Medium radio',
)

// Large - for better visibility and touch targets
FlutstrapRadio<String>(
  value: 'large',
  groupValue: _selected,
  onChanged: (value) => setState(() => _selected = value!),
  size: FSRadioSize.lg,
  label: 'Large radio',
)
```

## Properties & Parameters

### Parameter Reference Table

| Parameter           | Type                  | Default      | Description                       |
| ------------------- | --------------------- | ------------ | --------------------------------- |
| `value`             | `T`                   | **required** | Radio button value                |
| `groupValue`        | `T?`                  | **required** | Currently selected value in group |
| `onChanged`         | `ValueChanged<T?>?`   | `null`       | Selection change callback         |
| `variant`           | `FSRadioVariant`      | `primary`    | Visual style variant              |
| `size`              | `FSRadioSize`         | `md`         | Radio size (sm, md, lg)           |
| `label`             | `String?`             | `null`       | Text label for radio              |
| `customLabel`       | `Widget?`             | `null`       | Custom label widget               |
| `disabled`          | `bool`                | `false`      | Disable the radio button          |
| `inline`            | `bool`                | `false`      | Inline layout with label          |
| `semanticLabel`     | `String?`             | `null`       | Accessibility label               |
| `showValidation`    | `bool`                | `false`      | Show validation state             |
| `isValid`           | `bool`                | `true`       | Validation state                  |
| `validationMessage` | `String?`             | `null`       | Validation error message          |
| `activeColor`       | `Color?`              | `null`       | Custom active color               |
| `dotColor`          | `Color?`              | `null`       | Custom dot color                  |
| `visualDensity`     | `VisualDensity?`      | `null`       | Visual density                    |
| `padding`           | `EdgeInsetsGeometry?` | `null`       | Custom padding                    |

### FSRadioVariant Enum

```dart
enum FSRadioVariant {
  primary,    // Blue theme - standard selection
  secondary,  // Gray theme - alternative styling
  success,    // Green theme - positive/approved states
  danger,     // Red theme - error/critical states
  warning,    // Yellow theme - cautionary states
  info,       // Blue theme - informational states
}
```

### FSRadioSize Enum

```dart
enum FSRadioSize {
  sm,  // 16px - compact size
  md,  // 20px - standard size
  lg,  // 24px - large size for better touch targets
}
```

## Customization

### Custom Styling

```dart
FlutstrapRadio<String>(
  value: 'custom',
  groupValue: _selected,
  onChanged: (value) => setState(() => _selected = value!),
  label: 'Custom styled radio',
  activeColor: Colors.purple,
  dotColor: Colors.white,
  size: FSRadioSize.lg,
  padding: EdgeInsets.all(8),
)
```

### Custom Label Widget

```dart
FlutstrapRadio<String>(
  value: 'premium',
  groupValue: _selectedPlan,
  onChanged: (value) => setState(() => _selectedPlan = value!),
  customLabel: Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.blue),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('Premium Plan', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(width: 8),
            FlutstrapBadge(
              text: 'Recommended',
              variant: FSBadgeVariant.success,
              size: FSBadgeSize.sm,
            ),
          ],
        ),
        SizedBox(height: 4),
        Text('\$29/month', style: TextStyle(color: Colors.green)),
        SizedBox(height: 4),
        Text('All features included', style: TextStyle(fontSize: 12)),
      ],
    ),
  ),
)
```

### Validation Styling

```dart
FlutstrapRadio<String>(
  value: 'agree',
  groupValue: _agreement,
  onChanged: (value) => setState(() => _agreement = value!),
  label: 'I agree to the terms and conditions',
  showValidation: true,
  isValid: _agreement != null,
  validationMessage: 'You must select an option to continue',
)
```

## Interactivity & Behavior

### Radio Group Patterns

```dart
class RadioGroupExample extends StatefulWidget {
  @override
  _RadioGroupExampleState createState() => _RadioGroupExampleState();
}

class _RadioGroupExampleState extends State<RadioGroupExample> {
  String? _selectedCategory;
  String? _selectedPriority;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SizedBox(height: 12),
        FlutstrapRadio<String>(
          value: 'feature',
          groupValue: _selectedCategory,
          onChanged: (value) => setState(() => _selectedCategory = value!),
          label: 'Feature Request',
          variant: FSRadioVariant.primary,
        ),
        SizedBox(height: 8),
        FlutstrapRadio<String>(
          value: 'bug',
          groupValue: _selectedCategory,
          onChanged: (value) => setState(() => _selectedCategory = value!),
          label: 'Bug Report',
          variant: FSRadioVariant.danger,
        ),
        SizedBox(height: 8),
        FlutstrapRadio<String>(
          value: 'improvement',
          groupValue: _selectedCategory,
          onChanged: (value) => setState(() => _selectedCategory = value!),
          label: 'Improvement',
          variant: FSRadioVariant.info,
        ),

        SizedBox(height: 24),

        Text(
          'Priority',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SizedBox(height: 12),
        FlutstrapRadio<String>(
          value: 'low',
          groupValue: _selectedPriority,
          onChanged: (value) => setState(() => _selectedPriority = value!),
          label: 'Low',
          variant: FSRadioVariant.success,
        ),
        SizedBox(height: 8),
        FlutstrapRadio<String>(
          value: 'medium',
          groupValue: _selectedPriority,
          onChanged: (value) => setState(() => _selectedPriority = value!),
          label: 'Medium',
          variant: FSRadioVariant.warning,
        ),
        SizedBox(height: 8),
        FlutstrapRadio<String>(
          value: 'high',
          groupValue: _selectedPriority,
          onChanged: (value) => setState(() => _selectedPriority = value!),
          label: 'High',
          variant: FSRadioVariant.danger,
        ),
      ],
    );
  }
}
```

### Form Integration with Validation

```dart
class RadioFormExample extends StatefulWidget {
  @override
  _RadioFormExampleState createState() => _RadioFormExampleState();
}

class _RadioFormExampleState extends State<RadioFormExample> {
  String? _selectedOption;
  bool _showValidation = false;

  void _submitForm() {
    setState(() {
      _showValidation = true;
    });

    if (_selectedOption == null) {
      return; // Don't submit if no option selected
    }

    // Process form submission
    _processFormData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Please select your preferred contact method:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),

        FlutstrapRadio<String>(
          value: 'email',
          groupValue: _selectedOption,
          onChanged: (value) => setState(() => _selectedOption = value!),
          label: 'Email',
          showValidation: _showValidation,
          isValid: _selectedOption != null,
        ),
        SizedBox(height: 8),

        FlutstrapRadio<String>(
          value: 'phone',
          groupValue: _selectedOption,
          onChanged: (value) => setState(() => _selectedOption = value!),
          label: 'Phone',
          showValidation: _showValidation,
          isValid: _selectedOption != null,
        ),
        SizedBox(height: 8),

        FlutstrapRadio<String>(
          value: 'sms',
          groupValue: _selectedOption,
          onChanged: (value) => setState(() => _selectedOption = value!),
          label: 'SMS',
          showValidation: _showValidation,
          isValid: _selectedOption != null,
        ),

        if (_showValidation && _selectedOption == null)
          Padding(
            padding: EdgeInsets.only(top: 8),
            child: Text(
              'Please select a contact method',
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),

        SizedBox(height: 24),
        FlutstrapButton(
          onPressed: _submitForm,
          child: Text('Submit'),
        ),
      ],
    );
  }
}
```

## Accessibility Notes

Flutstrap Radio includes comprehensive accessibility features:

- **Screen Reader Support**: Full semantic labels for radio states and groups
- **Keyboard Navigation**: Support for keyboard interaction and focus management
- **Group Semantics**: Proper grouping for screen reader announcements
- **State Announcements**: Screen readers announce selected/unselected states
- **Focus Indicators**: Clear visual focus indicators for keyboard users
- **High Contrast Support**: Meets WCAG contrast guidelines

```dart
// Screen readers will properly announce the radio group
Column(
  children: [
    FlutstrapRadio<String>(
      value: 'email',
      groupValue: _contactMethod,
      onChanged: (value) => setState(() => _contactMethod = value!),
      label: 'Email',
      semanticLabel: 'Contact via email address',
    ),
    FlutstrapRadio<String>(
      value: 'phone',
      groupValue: _contactMethod,
      onChanged: (value) => setState(() => _contactMethod = value!),
      label: 'Phone',
      semanticLabel: 'Contact via phone call',
    ),
  ],
)
```

## Integration Examples

### Survey Form with Radio Groups

```dart
class SurveyForm extends StatefulWidget {
  @override
  _SurveyFormState createState() => _SurveyFormState();
}

class _SurveyFormState extends State<SurveyForm> {
  String? _satisfactionLevel;
  String? _recommendation;
  String? _usageFrequency;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Customer Satisfaction Survey',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: 24),

          _buildQuestion(
            'How satisfied are you with our product?',
            [
              _buildRadio('very_satisfied', 'Very Satisfied', FSRadioVariant.success),
              _buildRadio('satisfied', 'Satisfied', FSRadioVariant.info),
              _buildRadio('neutral', 'Neutral', FSRadioVariant.secondary),
              _buildRadio('dissatisfied', 'Dissatisfied', FSRadioVariant.warning),
              _buildRadio('very_dissatisfied', 'Very Dissatisfied', FSRadioVariant.danger),
            ],
            _satisfactionLevel,
            (value) => setState(() => _satisfactionLevel = value!),
          ),

          SizedBox(height: 32),

          _buildQuestion(
            'How likely are you to recommend us to others?',
            [
              _buildRadio('very_likely', 'Very Likely', FSRadioVariant.success),
              _buildRadio('likely', 'Likely', FSRadioVariant.info),
              _buildRadio('neutral', 'Neutral', FSRadioVariant.secondary),
              _buildRadio('unlikely', 'Unlikely', FSRadioVariant.warning),
              _buildRadio('very_unlikely', 'Very Unlikely', FSRadioVariant.danger),
            ],
            _recommendation,
            (value) => setState(() => _recommendation = value!),
          ),

          SizedBox(height: 32),

          _buildQuestion(
            'How often do you use our product?',
            [
              _buildRadio('daily', 'Daily', FSRadioVariant.primary),
              _buildRadio('weekly', 'Weekly', FSRadioVariant.primary),
              _buildRadio('monthly', 'Monthly', FSRadioVariant.primary),
              _buildRadio('rarely', 'Rarely', FSRadioVariant.primary),
              _buildRadio('first_time', 'First Time', FSRadioVariant.primary),
            ],
            _usageFrequency,
            (value) => setState(() => _usageFrequency = value!),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestion(String question, List<Widget> options, String? groupValue, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SizedBox(height: 16),
        ...options,
      ],
    );
  }

  Widget _buildRadio(String value, String label, FSRadioVariant variant) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: FlutstrapRadio<String>(
        value: value,
        groupValue: _satisfactionLevel,
        onChanged: (value) => setState(() => _satisfactionLevel = value!),
        label: label,
        variant: variant,
      ),
    );
  }
}
```

### Settings Panel with Radio Options

```dart
class ThemeSettings extends StatefulWidget {
  @override
  _ThemeSettingsState createState() => _ThemeSettingsState();
}

class _ThemeSettingsState extends State<ThemeSettings> {
  String? _themePreference = 'system';
  String? _fontSize = 'medium';
  String? _language = 'english';

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
            'Appearance Settings',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 16),

          Text('Theme', style: TextStyle(fontWeight: FontWeight.w600)),
          SizedBox(height: 12),
          FlutstrapRadio<String>(
            value: 'light',
            groupValue: _themePreference,
            onChanged: (value) => setState(() => _themePreference = value!),
            label: 'Light Theme',
            inline: true,
          ),
          SizedBox(height: 8),
          FlutstrapRadio<String>(
            value: 'dark',
            groupValue: _themePreference,
            onChanged: (value) => setState(() => _themePreference = value!),
            label: 'Dark Theme',
            inline: true,
          ),
          SizedBox(height: 8),
          FlutstrapRadio<String>(
            value: 'system',
            groupValue: _themePreference,
            onChanged: (value) => setState(() => _themePreference = value!),
            label: 'System Default',
            inline: true,
          ),

          SizedBox(height: 24),

          Text('Font Size', style: TextStyle(fontWeight: FontWeight.w600)),
          SizedBox(height: 12),
          FlutstrapRadio<String>(
            value: 'small',
            groupValue: _fontSize,
            onChanged: (value) => setState(() => _fontSize = value!),
            label: 'Small',
            inline: true,
            size: FSRadioSize.sm,
          ),
          SizedBox(height: 8),
          FlutstrapRadio<String>(
            value: 'medium',
            groupValue: _fontSize,
            onChanged: (value) => setState(() => _fontSize = value!),
            label: 'Medium',
            inline: true,
            size: FSRadioSize.md,
          ),
          SizedBox(height: 8),
          FlutstrapRadio<String>(
            value: 'large',
            groupValue: _fontSize,
            onChanged: (value) => setState(() => _fontSize = value!),
            label: 'Large',
            inline: true,
            size: FSRadioSize.lg,
          ),
        ],
      ),
    );
  }
}
```

## Performance Optimization

### Efficient State Management

```dart
// ✅ GOOD: Using stateful widget for local state management
class EfficientRadioGroup extends StatefulWidget {
  @override
  _EfficientRadioGroupState createState() => _EfficientRadioGroupState();
}

class _EfficientRadioGroupState extends State<EfficientRadioGroup> {
  String? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FlutstrapRadio<String>(
          value: 'option1',
          groupValue: _selectedValue,
          onChanged: (value) => setState(() => _selectedValue = value!),
          label: 'Option 1',
        ),
        FlutstrapRadio<String>(
          value: 'option2',
          groupValue: _selectedValue,
          onChanged: (value) => setState(() => _selectedValue = value!),
          label: 'Option 2',
        ),
      ],
    );
  }
}
```

### Using Convenience Methods

```dart
// ✅ GOOD: Method chaining for quick customization
FlutstrapRadio<String>(
  value: 'success',
  groupValue: _status,
  onChanged: (value) => setState(() => _status = value!),
)
.success()           // Change variant to success
.large()             // Change size to large
.withLabel('Completed') // Set label
```

## Best Practices

### Grouping and Semantics

```dart
// ✅ GOOD: Clear grouping with semantic labels
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Semantics(
      label: 'Shipping method selection',
      child: Column(
        children: [
          FlutstrapRadio<String>(
            value: 'standard',
            groupValue: _shippingMethod,
            onChanged: (value) => setState(() => _shippingMethod = value!),
            label: 'Standard Shipping (5-7 days)',
            semanticLabel: 'Standard shipping delivery method',
          ),
          FlutstrapRadio<String>(
            value: 'express',
            groupValue: _shippingMethod,
            onChanged: (value) => setState(() => _shippingMethod = value!),
            label: 'Express Shipping (2-3 days)',
            semanticLabel: 'Express shipping delivery method',
          ),
          FlutstrapRadio<String>(
            value: 'overnight',
            groupValue: _shippingMethod,
            onChanged: (value) => setState(() => _shippingMethod = value!),
            label: 'Overnight Shipping',
            semanticLabel: 'Overnight shipping delivery method',
          ),
        ],
      ),
    ),
  ],
)
```

### Validation Patterns

```dart
// ✅ GOOD: Clear validation with helpful messages
Column(
  children: [
    FlutstrapRadio<String>(
      value: 'agree',
      groupValue: _agreement,
      onChanged: (value) => setState(() => _agreement = value!),
      label: 'I agree to the terms and conditions',
      showValidation: _showValidation,
      isValid: _agreement != null,
    ),
    if (_showValidation && _agreement == null)
      Padding(
        padding: EdgeInsets.only(left: 32, top: 4),
        child: Text(
          'You must agree to the terms to continue',
          style: TextStyle(color: Colors.red, fontSize: 12),
        ),
      ),
  ],
)
```

## Troubleshooting

### Common Issues and Solutions

**Radio Not Selecting**

```dart
// ❌ Missing setState or incorrect value handling
FlutstrapRadio<String>(
  value: 'option1',
  groupValue: _selected,
  onChanged: (value) => _selected = value!, // Missing setState
)

// ✅ Correct state management
FlutstrapRadio<String>(
  value: 'option1',
  groupValue: _selected,
  onChanged: (value) => setState(() => _selected = value!),
)
```

**Multiple Radios Selecting Simultaneously**

```dart
// ❌ Different groupValue variables for each radio
String _option1 = 'option1';
String _option2 = 'option2';

FlutstrapRadio<String>(
  value: 'option1',
  groupValue: _option1, // Should be shared variable
  onChanged: (value) => setState(() => _option1 = value!),
)
FlutstrapRadio<String>(
  value: 'option2',
  groupValue: _option2, // Should be shared variable
  onChanged: (value) => setState(() => _option2 = value!),
)

// ✅ Correct group implementation
String? _selectedOption;

FlutstrapRadio<String>(
  value: 'option1',
  groupValue: _selectedOption,
  onChanged: (value) => setState(() => _selectedOption = value!),
)
FlutstrapRadio<String>(
  value: 'option2',
  groupValue: _selectedOption,
  onChanged: (value) => setState(() => _selectedOption = value!),
)
```

**Accessibility Issues**

```dart
// ❌ Missing semantic grouping
Column(
  children: [
    FlutstrapRadio<String>(...),
    FlutstrapRadio<String>(...),
    // No semantic grouping
  ],
)

// ✅ Accessible implementation
Semantics(
  label: 'Payment method selection',
  child: Column(
    children: [
      FlutstrapRadio<String>(
        value: 'credit',
        groupValue: _paymentMethod,
        onChanged: (value) => setState(() => _paymentMethod = value!),
        label: 'Credit Card',
        semanticLabel: 'Pay with credit card',
      ),
      FlutstrapRadio<String>(
        value: 'paypal',
        groupValue: _paymentMethod,
        onChanged: (value) => setState(() => _paymentMethod = value!),
        label: 'PayPal',
        semanticLabel: 'Pay with PayPal',
      ),
    ],
  ),
)
```

### Debugging Tips

1. **Check Group Values**: Ensure all radios in a group share the same `groupValue` variable
2. **Verify State Management**: Use `setState` for local state changes
3. **Test Value Types**: Ensure `value` and `groupValue` are the same type
4. **Check Accessibility**: Use screen readers to verify semantic grouping
5. **Monitor Performance**: Use Flutter DevTools for performance monitoring

---

**This comprehensive guide covers all aspects of using the Flutstrap Radio component. The radio system is designed to be highly flexible, performant, and accessible while providing a robust solution for single-selection controls across various interaction patterns, validation requirements, and design contexts. With features like smooth animations, comprehensive validation, and proper semantic grouping, Flutstrap Radio offers enterprise-grade selection control capabilities for modern Flutter applications.**
