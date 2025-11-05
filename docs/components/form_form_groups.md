# Flutstrap Form Group Component Guide

## Introduction

Flutstrap Form Group is a high-performance, accessible form group component for grouping related form fields with consistent spacing, validation states, and layout options. It provides a robust solution for organizing form elements in Flutter applications with enterprise-grade performance and accessibility features.

**This comprehensive guide covers all aspects of using the Flutstrap Form Group component. The form group system is designed to be highly flexible, performant, and accessible while providing a robust solution for organizing form fields across various layout requirements, validation states, and design contexts.**

### What It Does

- Groups related form fields with consistent spacing and styling
- Provides multiple layout options (vertical, horizontal, inline)
- Supports collective validation states and error messaging
- Offers accessibility features and performance optimizations

### When to Use

- Grouping related form fields (name fields, contact information, address)
- Showing collective validation states for multiple fields
- Creating consistent form layouts with proper spacing
- Building complex forms with multiple logical sections
- Organizing filter controls and search interfaces

### Prerequisites

- Flutter 3.0 or higher
- Flutstrap theme system (`FSTheme`)
- Flutstrap form components (Input, Checkbox, Radio, etc.)

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

### Vertical Form Group (Default)

```dart
FlutstrapFormGroup(
  label: 'Personal Information',
  children: [
    FlutstrapInput(labelText: 'First Name'),
    FlutstrapInput(labelText: 'Last Name'),
    FlutstrapInput(labelText: 'Email'),
  ],
)
```

### Horizontal Form Group

```dart
FlutstrapFormGroup(
  label: 'Contact Details',
  layout: FSFormGroupLayout.horizontal,
  children: [
    FlutstrapInput(labelText: 'Phone'),
    FlutstrapInput(labelText: 'Email'),
  ],
)
```

### Form Group with Validation

```dart
FlutstrapFormGroup(
  label: 'Account Details',
  showValidation: true,
  isValid: false,
  validationMessage: 'Please fill all required fields',
  children: [
    FlutstrapInput(labelText: 'Username'),
    FlutstrapInput(labelText: 'Password', obscureText: true),
  ],
)
```

### Inline Form Group for Filters

```dart
FlutstrapFormGroup(
  label: 'Filters',
  layout: FSFormGroupLayout.inline,
  spacing: 12.0,
  children: [
    FlutstrapInput(labelText: 'Search'),
    FlutstrapDropdown(
      items: ['Option 1', 'Option 2', 'Option 3'],
      onChanged: (value) {},
    ),
    FlutstrapButton(child: Text('Apply')),
  ],
)
```

## Component Variants

### Layout Variants

Flutstrap Form Group provides 3 layout variants for different use cases:

```dart
// Vertical - stacked fields (default)
FlutstrapFormGroup(
  layout: FSFormGroupLayout.vertical,
  children: [
    FlutstrapInput(labelText: 'Field 1'),
    FlutstrapInput(labelText: 'Field 2'),
  ],
)

// Horizontal - side-by-side fields
FlutstrapFormGroup(
  layout: FSFormGroupLayout.horizontal,
  children: [
    FlutstrapInput(labelText: 'First Name'),
    FlutstrapInput(labelText: 'Last Name'),
  ],
)

// Inline - wrap-based layout for dynamic content
FlutstrapFormGroup(
  layout: FSFormGroupLayout.inline,
  children: [
    FlutstrapInput(labelText: 'Search'),
    FlutstrapDropdown(items: [...]),
    FlutstrapButton(child: Text('Filter')),
  ],
)
```

### Size Variants

```dart
// Small - compact spacing
FlutstrapFormGroup(
  size: FSFormGroupSize.sm,
  children: [/* ... */],
)

// Medium - standard spacing (default)
FlutstrapFormGroup(
  size: FSFormGroupSize.md,
  children: [/* ... */],
)

// Large - generous spacing
FlutstrapFormGroup(
  size: FSFormGroupSize.lg,
  children: [/* ... */],
)
```

### State Variants

```dart
// Valid - normal state
FlutstrapFormGroup(
  state: FSFormGroupState.valid,
  children: [/* ... */],
)

// Invalid - validation error state
FlutstrapFormGroup(
  state: FSFormGroupState.invalid,
  showValidation: true,
  validationMessage: 'Fix the errors below',
  children: [/* ... */],
)

// Loading - processing state
FlutstrapFormGroup(
  state: FSFormGroupState.loading,
  children: [/* ... */],
)

// Disabled - non-interactive state
FlutstrapFormGroup(
  state: FSFormGroupState.disabled,
  children: [/* ... */],
)
```

## Properties & Parameters

### Parameter Reference Table

| Parameter            | Type                 | Default      | Description              |
| -------------------- | -------------------- | ------------ | ------------------------ |
| `children`           | `List<Widget>`       | **required** | Form fields to group     |
| `label`              | `String?`            | `null`       | Group label text         |
| `helperText`         | `String?`            | `null`       | Helper text below fields |
| `validationMessage`  | `String?`            | `null`       | Validation error message |
| `showValidation`     | `bool`               | `false`      | Show validation state    |
| `isValid`            | `bool`               | `true`       | Validation state         |
| `required`           | `bool`               | `false`      | Mark group as required   |
| `layout`             | `FSFormGroupLayout`  | `vertical`   | Layout type              |
| `size`               | `FSFormGroupSize`    | `md`         | Size variant             |
| `crossAxisAlignment` | `CrossAxisAlignment` | `start`      | Cross-axis alignment     |
| `mainAxisAlignment`  | `MainAxisAlignment`  | `start`      | Main-axis alignment      |
| `spacing`            | `double`             | `16.0`       | Space between children   |
| `showLabel`          | `bool`               | `true`       | Show/hide label          |
| `customLabel`        | `Widget?`            | `null`       | Custom label widget      |
| `state`              | `FSFormGroupState`   | `valid`      | Group state              |

### FSFormGroupLayout Enum

```dart
enum FSFormGroupLayout {
  vertical,   // Stacked vertically
  horizontal, // Side by side horizontally
  inline,     // Wrap-based layout
}
```

### FSFormGroupSize Enum

```dart
enum FSFormGroupSize {
  sm,  // Compact spacing (8px default)
  md,  // Medium spacing (16px default)
  lg,  // Large spacing (24px default)
}
```

### FSFormGroupState Enum

```dart
enum FSFormGroupState {
  valid,     // Normal state
  invalid,   // Validation error state
  loading,   // Processing state
  disabled,  // Non-interactive state
}
```

## Customization

### Custom Label Widget

```dart
FlutstrapFormGroup(
  customLabel: Row(
    children: [
      Icon(Icons.person, size: 16),
      SizedBox(width: 8),
      Text('Personal Information'),
      Spacer(),
      FlutstrapBadge(
        text: 'Required',
        variant: FSBadgeVariant.danger,
        size: FSBadgeSize.sm,
      ),
    ],
  ),
  children: [
    FlutstrapInput(labelText: 'First Name'),
    FlutstrapInput(labelText: 'Last Name'),
  ],
)
```

### Custom Spacing and Alignment

```dart
FlutstrapFormGroup(
  label: 'Address Information',
  layout: FSFormGroupLayout.horizontal,
  spacing: 20.0,
  crossAxisAlignment: CrossAxisAlignment.center,
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Expanded(child: FlutstrapInput(labelText: 'Street')),
    SizedBox(width: 16),
    Expanded(flex: 2, child: FlutstrapInput(labelText: 'City')),
    SizedBox(width: 16),
    Expanded(child: FlutstrapInput(labelText: 'ZIP Code')),
  ],
)
```

### Advanced Validation States

```dart
FlutstrapFormGroup(
  label: 'Payment Information',
  showValidation: true,
  isValid: _isPaymentValid,
  validationMessage: _getPaymentValidationMessage(),
  state: _isProcessing ? FSFormGroupState.loading : FSFormGroupState.valid,
  children: [
    FlutstrapInput(labelText: 'Card Number'),
    FlutstrapInput(labelText: 'Expiration Date'),
    FlutstrapInput(labelText: 'CVV'),
  ],
)
```

## Interactivity & Behavior

### Dynamic Form Groups

```dart
class DynamicFormGroup extends StatefulWidget {
  @override
  _DynamicFormGroupState createState() => _DynamicFormGroupState();
}

class _DynamicFormGroupState extends State<DynamicFormGroup> {
  bool _isFormValid = false;
  bool _isLoading = false;
  List<String> _dynamicFields = ['Field 1'];

  void _validateForm() {
    setState(() {
      _isFormValid = _checkFormValidity();
    });
  }

  void _addField() {
    setState(() {
      _dynamicFields.add('Field ${_dynamicFields.length + 1}');
    });
  }

  void _submitForm() async {
    setState(() => _isLoading = true);

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return FlutstrapFormGroup(
      label: 'Dynamic Fields',
      showValidation: true,
      isValid: _isFormValid,
      validationMessage: 'Please fill all fields',
      state: _isLoading ? FSFormGroupState.loading : FSFormGroupState.valid,
      children: [
        ..._dynamicFields.map((field) => FlutstrapInput(
          labelText: field,
          onChanged: (_) => _validateForm(),
        )).toList(),

        FlutstrapButton(
          onPressed: _addField,
          child: Text('Add Field'),
          variant: FSButtonVariant.outline,
        ),

        SizedBox(height: 16),

        FlutstrapButton(
          onPressed: _isFormValid && !_isLoading ? _submitForm : null,
          child: Text('Submit'),
        ),
      ],
    );
  }
}
```

### Form Group with Mixed Components

```dart
FlutstrapFormGroup(
  label: 'Preferences',
  children: [
    FlutstrapInput(
      labelText: 'Display Name',
      helperText: 'This will be shown to other users',
    ),

    FlutstrapFormGroup(
      label: 'Notification Settings',
      layout: FSFormGroupLayout.vertical,
      showLabel: false,
      children: [
        FlutstrapCheckbox(
          value: _emailNotifications,
          onChanged: (value) => setState(() => _emailNotifications = value!),
          label: 'Email Notifications',
        ),
        FlutstrapCheckbox(
          value: _pushNotifications,
          onChanged: (value) => setState(() => _pushNotifications = value!),
          label: 'Push Notifications',
        ),
      ],
    ),

    FlutstrapFormGroup(
      label: 'Theme Preference',
      layout: FSFormGroupLayout.vertical,
      showLabel: false,
      children: [
        FlutstrapRadio<String>(
          value: 'light',
          groupValue: _theme,
          onChanged: (value) => setState(() => _theme = value!),
          label: 'Light Theme',
        ),
        FlutstrapRadio<String>(
          value: 'dark',
          groupValue: _theme,
          onChanged: (value) => setState(() => _theme = value!),
          label: 'Dark Theme',
        ),
        FlutstrapRadio<String>(
          value: 'system',
          groupValue: _theme,
          onChanged: (value) => setState(() => _theme = value!),
          label: 'System Default',
        ),
      ],
    ),
  ],
)
```

## Accessibility Notes

Flutstrap Form Group includes comprehensive accessibility features:

- **Screen Reader Support**: Full semantic labels for form groups and states
- **Focus Management**: Proper focus traversal within form groups
- **State Announcements**: Screen readers announce validation states and loading states
- **Group Semantics**: Proper grouping for related form fields
- **High Contrast Support**: Meets WCAG contrast guidelines for all states

```dart
FlutstrapFormGroup(
  label: 'Contact Information',
  semanticLabel: 'Contact information form section including phone and email',
  showValidation: true,
  isValid: _isContactValid,
  validationMessage: 'Please provide valid contact information',
  children: [
    FlutstrapInput(labelText: 'Phone Number'),
    FlutstrapInput(labelText: 'Email Address'),
  ],
)
```

## Integration Examples

### Complete Registration Form

```dart
class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isSubmitting = false;
  bool _acceptTerms = false;

  void _submitForm() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_acceptTerms) return;

    setState(() => _isSubmitting = true);

    // Simulate registration
    await Future.delayed(Duration(seconds: 2));

    setState(() => _isSubmitting = false);
    // Handle registration success
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          FlutstrapFormGroup(
            label: 'Account Information',
            required: true,
            children: [
              FlutstrapInput(
                labelText: 'Username',
                validator: (value) {
                  if (value!.isEmpty) return 'Username is required';
                  if (value.length < 3) return 'Too short';
                  return null;
                },
              ),
              FlutstrapInput(
                labelText: 'Email',
                validator: (value) {
                  if (value!.isEmpty) return 'Email is required';
                  if (!value.contains('@')) return 'Invalid email';
                  return null;
                },
              ),
              FlutstrapInput(
                labelText: 'Password',
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) return 'Password is required';
                  if (value.length < 8) return 'Must be 8+ characters';
                  return null;
                },
              ),
            ],
          ),

          FlutstrapFormGroup(
            label: 'Personal Information',
            children: [
              FlutstrapFormGroup(
                label: 'Name',
                layout: FSFormGroupLayout.horizontal,
                showLabel: false,
                children: [
                  Expanded(child: FlutstrapInput(labelText: 'First Name')),
                  SizedBox(width: 16),
                  Expanded(child: FlutstrapInput(labelText: 'Last Name')),
                ],
              ),
              FlutstrapInput(labelText: 'Phone Number'),
            ],
          ),

          FlutstrapFormGroup(
            label: 'Agreements',
            showValidation: true,
            isValid: _acceptTerms,
            validationMessage: 'You must accept the terms to continue',
            children: [
              FlutstrapCheckbox(
                value: _acceptTerms,
                onChanged: (value) => setState(() => _acceptTerms = value!),
                label: 'I accept the Terms of Service and Privacy Policy',
              ),
            ],
          ),

          SizedBox(height: 24),

          FlutstrapButton(
            onPressed: _isSubmitting ? null : _submitForm,
            child: _isSubmitting
                ? SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text('Create Account'),
            size: FSSize.lg,
          ),
        ],
      ),
    );
  }
}
```

### Advanced Filter Panel

```dart
class FilterPanel extends StatefulWidget {
  @override
  _FilterPanelState createState() => _FilterPanelState();
}

class _FilterPanelState extends State<FilterPanel> {
  String _searchQuery = '';
  String _category = '';
  String _status = '';
  DateTime? _startDate;
  DateTime? _endDate;

  void _applyFilters() {
    // Apply filter logic
    print('Applying filters: $_searchQuery, $_category, $_status');
  }

  void _resetFilters() {
    setState(() {
      _searchQuery = '';
      _category = '';
      _status = '';
      _startDate = null;
      _endDate = null;
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
      child: FlutstrapFormGroup(
        label: 'Advanced Filters',
        layout: FSFormGroupLayout.inline,
        spacing: 12,
        children: [
          SizedBox(
            width: 200,
            child: FlutstrapInput(
              labelText: 'Search',
              value: _searchQuery,
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
          ),

          SizedBox(
            width: 150,
            child: FlutstrapDropdown(
              labelText: 'Category',
              items: ['All', 'Electronics', 'Clothing', 'Books'],
              value: _category.isEmpty ? 'All' : _category,
              onChanged: (value) => setState(() => _category = value!),
            ),
          ),

          SizedBox(
            width: 150,
            child: FlutstrapDropdown(
              labelText: 'Status',
              items: ['All', 'Active', 'Inactive', 'Pending'],
              value: _status.isEmpty ? 'All' : _status,
              onChanged: (value) => setState(() => _status = value!),
            ),
          ),

          FlutstrapButton(
            onPressed: _applyFilters,
            child: Text('Apply'),
            variant: FSButtonVariant.primary,
          ),

          FlutstrapButton(
            onPressed: _resetFilters,
            child: Text('Reset'),
            variant: FSButtonVariant.outline,
          ),
        ],
      ),
    );
  }
}
```

## Performance Optimization

### Efficient Children Management

```dart
// ✅ GOOD: Using const children when possible
FlutstrapFormGroup(
  label: 'Static Options',
  children: const [
    FlutstrapCheckbox(value: true, onChanged: null, label: 'Option 1'),
    FlutstrapCheckbox(value: false, onChanged: null, label: 'Option 2'),
  ],
)

// ✅ GOOD: Pre-allocating lists for dynamic content
FlutstrapFormGroup(
  label: 'Dynamic Fields',
  children: List<Widget>.generate(
    _fieldCount,
    (index) => FlutstrapInput(labelText: 'Field ${index + 1}'),
    growable: false, // Fixed-size for better performance
  ),
)
```

### Using Convenience Methods

```dart
// ✅ GOOD: Method chaining for quick customization
FlutstrapFormGroup(
  children: [/* ... */],
)
.withLabel('Contact Information')
.horizontal()
.withSpacing(20)
.asRequired()
```

### Static Factory Methods

```dart
// ✅ GOOD: Using static methods for common patterns
FlutstrapFormGroup.verticalGroup(
  label: 'User Details',
  required: true,
  children: [
    FlutstrapInput(labelText: 'Name'),
    FlutstrapInput(labelText: 'Email'),
  ],
)

FlutstrapFormGroup.horizontalGroup(
  label: 'Address',
  spacing: 16.0,
  children: [
    FlutstrapInput(labelText: 'Street'),
    FlutstrapInput(labelText: 'City'),
  ],
)

FlutstrapFormGroup.inlineGroup(
  label: 'Filters',
  spacing: 12.0,
  children: [
    FlutstrapInput(labelText: 'Search'),
    FlutstrapDropdown(items: [...]),
    FlutstrapButton(child: Text('Apply')),
  ],
)
```

## Best Practices

### Layout Selection Guidelines

```dart
// ✅ VERTICAL: For sequential, related fields
FlutstrapFormGroup(
  layout: FSFormGroupLayout.vertical,
  children: [
    FlutstrapInput(labelText: 'Username'),
    FlutstrapInput(labelText: 'Email'),
    FlutstrapInput(labelText: 'Password'),
  ],
)

// ✅ HORIZONTAL: For parallel, complementary fields
FlutstrapFormGroup(
  layout: FSFormGroupLayout.horizontal,
  children: [
    FlutstrapInput(labelText: 'First Name'),
    FlutstrapInput(labelText: 'Last Name'),
  ],
)

// ✅ INLINE: For filters, search bars, and toolbars
FlutstrapFormGroup(
  layout: FSFormGroupLayout.inline,
  children: [
    FlutstrapInput(labelText: 'Search'),
    FlutstrapDropdown(items: [...]),
    FlutstrapButton(child: Text('Search')),
  ],
)
```

### Validation Patterns

```dart
// ✅ GOOD: Clear validation with helpful messages
FlutstrapFormGroup(
  label: 'Payment Details',
  showValidation: true,
  isValid: _isPaymentValid,
  validationMessage: _getPaymentErrors().join(', '),
  children: [
    FlutstrapInput(labelText: 'Card Number'),
    FlutstrapInput(labelText: 'Expiry Date'),
    FlutstrapInput(labelText: 'CVV'),
  ],
)

// ✅ GOOD: Group-level validation for related fields
FlutstrapFormGroup(
  label: 'Date Range',
  showValidation: true,
  isValid: _isDateRangeValid,
  validationMessage: 'End date must be after start date',
  children: [
    FlutstrapInput(labelText: 'Start Date'),
    FlutstrapInput(labelText: 'End Date'),
  ],
)
```

## Troubleshooting

### Common Issues and Solutions

**Layout Not Working as Expected**

```dart
// ❌ Incorrect layout for content type
FlutstrapFormGroup(
  layout: FSFormGroupLayout.horizontal,
  children: [
    FlutstrapInput(labelText: 'Long field name that takes lots of space'),
    FlutstrapInput(labelText: 'Another long field name'),
    // May overflow on small screens
  ],
)

// ✅ Better: Use vertical or wrap with constraints
FlutstrapFormGroup(
  layout: FSFormGroupLayout.vertical,
  children: [/* ... */],
)

// OR use horizontal with constraints
FlutstrapFormGroup(
  layout: FSFormGroupLayout.horizontal,
  children: [
    Expanded(child: FlutstrapInput(labelText: 'Field 1')),
    SizedBox(width: 16),
    Expanded(child: FlutstrapInput(labelText: 'Field 2')),
  ],
)
```

**Validation State Not Updating**

```dart
// ❌ Missing state management
FlutstrapFormGroup(
  showValidation: true,
  isValid: _isValid, // Not updating
  children: [/* ... */],
)

// ✅ Correct: Use setState to update validation
FlutstrapFormGroup(
  showValidation: true,
  isValid: _isValid,
  onValidityChange: (isValid) => setState(() => _isValid = isValid),
  children: [
    FlutstrapInput(
      onChanged: (value) => setState(() => _validateForm()),
    ),
  ],
)
```

**Performance Issues with Many Children**

```dart
// ❌ Too many children or complex widgets
FlutstrapFormGroup(
  children: List.generate(50, (i) => ComplexFormField()),
  // May cause performance issues
)

// ✅ Better: Virtualize or paginate large lists
FlutstrapFormGroup(
  children: [
    ..._visibleFields.map((field) => SimpleFormField(field)),
    if (_hasMore) LoadMoreButton(),
  ],
)
```

### Debugging Tips

1. **Check Child Count**: Ensure you don't exceed the maximum child count (20)
2. **Verify Layout Constraints**: Ensure parent provides adequate constraints
3. **Test Accessibility**: Use screen readers to verify semantic grouping
4. **Monitor Performance**: Use Flutter DevTools for performance monitoring
5. **Validate State Management**: Ensure proper state updates for dynamic content

---

**This comprehensive guide covers all aspects of using the Flutstrap Form Group component. The form group system is designed to be highly flexible, performant, and accessible while providing a robust solution for organizing form fields across various layout requirements, validation states, and design contexts. With features like multiple layout options, collective validation, and comprehensive accessibility, Flutstrap Form Group offers enterprise-grade form organization capabilities for modern Flutter applications.**
