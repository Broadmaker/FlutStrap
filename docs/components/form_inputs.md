# Flutstrap Input Component Guide

## Introduction

Flutstrap Input is a high-performance, accessible text input field with comprehensive validation, multiple variants, and optimized rendering patterns. It provides a robust form input solution for Flutter applications with enterprise-grade performance and accessibility features.

**This comprehensive guide covers all aspects of using the Flutstrap Input component. The input system is designed to be highly flexible, performant, and accessible while providing a robust solution for form inputs across various validation requirements, interaction patterns, and design contexts.**

### What It Does

- Provides customizable text input fields with comprehensive validation
- Supports multiple visual variants and size options
- Offers real-time validation with debouncing for performance
- Includes accessibility features and error handling

### When to Use

- Form inputs in login screens, registration forms, and data entry
- Applications requiring real-time validation with visual feedback
- Projects needing consistent input styling across the application
- Accessible forms with screen reader support

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

### Simple Input Field

```dart
FlutstrapInput(
  labelText: 'Email',
  hintText: 'Enter your email',
  validator: (value) {
    if (value?.isEmpty ?? true) return 'Email is required';
    if (!value!.contains('@')) return 'Enter a valid email';
    return null;
  },
)
```

### Input with Icons and Validation

```dart
FlutstrapInput(
  labelText: 'Password',
  obscureText: true,
  prefixIcon: Icon(Icons.lock),
  suffixIcon: Icon(Icons.visibility),
  variant: FSInputVariant.success,
  validator: (value) {
    if (value!.length < 8) return 'Password must be at least 8 characters';
    return null;
  },
)
```

### Programmatic Control

```dart
final inputKey = GlobalKey<FlutstrapInputState>();

FlutstrapInput(
  key: inputKey,
  labelText: 'Controlled input',
  validator: (value) => value!.isEmpty ? 'Required' : null,
)

// Later in your code...
void _handleSubmit() {
  inputKey.currentState?.clear();
  inputKey.currentState?.focus();
  inputKey.currentState?.setError('Custom error message');
}
```

## Component Variants

### Visual Variants

Flutstrap Input provides 6 visual variants to convey different input states:

```dart
// Primary (default) - standard input
FlutstrapInput(
  variant: FSInputVariant.primary,
  labelText: 'Primary Input',
)

// Success - for valid inputs
FlutstrapInput(
  variant: FSInputVariant.success,
  labelText: 'Success Input',
)

// Danger - for error states (auto-applied when validation fails)
FlutstrapInput(
  variant: FSInputVariant.danger,
  labelText: 'Error Input',
)

// Warning - for cautionary inputs
FlutstrapInput(
  variant: FSInputVariant.warning,
  labelText: 'Warning Input',
)

// Info - for informational inputs
FlutstrapInput(
  variant: FSInputVariant.info,
  labelText: 'Info Input',
)

// Secondary - alternative styling
FlutstrapInput(
  variant: FSInputVariant.secondary,
  labelText: 'Secondary Input',
)
```

### Size Variants

```dart
// Small - compact for dense interfaces
FlutstrapInput(
  size: FSInputSize.sm,
  labelText: 'Small Input',
)

// Medium - standard size (default)
FlutstrapInput(
  size: FSInputSize.md,
  labelText: 'Medium Input',
)

// Large - for better readability and touch targets
FlutstrapInput(
  size: FSInputSize.lg,
  labelText: 'Large Input',
)
```

## Properties & Parameters

### Parameter Reference Table

| Parameter         | Type                         | Default   | Description                         |
| ----------------- | ---------------------------- | --------- | ----------------------------------- |
| `controller`      | `TextEditingController?`     | `null`    | Controls the input's text           |
| `initialValue`    | `String?`                    | `null`    | Initial text value                  |
| `focusNode`       | `FocusNode?`                 | `null`    | Controls input focus                |
| `keyboardType`    | `TextInputType?`             | `null`    | Keyboard type (email, number, etc.) |
| `textInputAction` | `TextInputAction?`           | `null`    | Keyboard action button              |
| `obscureText`     | `bool`                       | `false`   | Hide text (for passwords)           |
| `enabled`         | `bool`                       | `true`    | Enable/disable input                |
| `maxLines`        | `int?`                       | `1`       | Maximum lines for text              |
| `validator`       | `String? Function(String?)?` | `null`    | Validation function                 |
| `onChanged`       | `void Function(String)?`     | `null`    | Text change callback                |
| `prefixIcon`      | `Widget?`                    | `null`    | Icon before the input               |
| `suffixIcon`      | `Widget?`                    | `null`    | Icon after the input                |
| `labelText`       | `String?`                    | `null`    | Input label                         |
| `hintText`        | `String?`                    | `null`    | Placeholder text                    |
| `errorText`       | `String?`                    | `null`    | Manual error message                |
| `helperText`      | `String?`                    | `null`    | Helper text below input             |
| `variant`         | `FSInputVariant`             | `primary` | Visual style variant                |
| `size`            | `FSInputSize`                | `md`      | Input size (sm, md, lg)             |
| `filled`          | `bool`                       | `false`   | Whether to show filled background   |
| `validationDelay` | `Duration`                   | `300ms`   | Delay for validation debouncing     |

### FSInputVariant Enum

```dart
enum FSInputVariant {
  primary,    // Standard input styling
  secondary,  // Alternative styling
  success,    // Green theme for valid inputs
  danger,     // Red theme for errors
  warning,    // Yellow theme for warnings
  info,       // Blue theme for information
}
```

### FSInputSize Enum

```dart
enum FSInputSize {
  sm,  // Compact - less padding
  md,  // Medium - standard padding
  lg,  // Large - more padding for better touch targets
}
```

## Customization

### Styling and Appearance

```dart
FlutstrapInput(
  labelText: 'Custom Styled Input',
  hintText: 'Enter your text',
  filled: true,
  fillColor: Colors.grey[50],
  variant: FSInputVariant.primary,
  size: FSInputSize.lg,
  prefixIcon: Icon(Icons.person, color: Colors.blue),
  suffixIcon: Icon(Icons.check_circle, color: Colors.green),
)
```

### Custom Validation

```dart
FlutstrapInput(
  labelText: 'Username',
  hintText: 'Enter your username',
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }
    if (value.length < 3) {
      return 'Username must be at least 3 characters';
    }
    if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
      return 'Username can only contain letters, numbers, and underscores';
    }
    return null;
  },
)
```

### Conditional Styling

```dart
FlutstrapInput(
  labelText: 'Email',
  hintText: 'Enter your email',
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!value.contains('@')) {
      return 'Please enter a valid email address';
    }
    return null;
  },
  // Variant will automatically change to danger on validation error
)
```

## Validation & Behavior

### Real-time Validation

```dart
FlutstrapInput(
  labelText: 'Search',
  hintText: 'Type to search...',
  validator: (value) {
    if (value != null && value.length > 0 && value.length < 3) {
      return 'Search term must be at least 3 characters';
    }
    return null;
  },
  validationDelay: Duration(milliseconds: 500), // Debounce validation
  onChanged: (value) {
    // Only triggered after validation delay
    print('Search value: $value');
  },
)
```

### Programmatic Validation Control

```dart
class FormExample extends StatefulWidget {
  @override
  _FormExampleState createState() => _FormExampleState();
}

class _FormExampleState extends State<FormExample> {
  final GlobalKey<FlutstrapInputState> _emailKey = GlobalKey();
  final GlobalKey<FlutstrapInputState> _passwordKey = GlobalKey();

  void _validateForm() {
    final emailValid = _emailKey.currentState?.isValid ?? false;
    final passwordValid = _passwordKey.currentState?.isValid ?? false;

    if (emailValid && passwordValid) {
      _submitForm();
    } else {
      // Manually trigger validation
      _emailKey.currentState?.focus();
    }
  }

  void _clearForm() {
    _emailKey.currentState?.clear();
    _passwordKey.currentState?.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FlutstrapInput(
          key: _emailKey,
          labelText: 'Email',
          validator: (value) => value!.contains('@') ? null : 'Invalid email',
        ),
        SizedBox(height: 16),
        FlutstrapInput(
          key: _passwordKey,
          labelText: 'Password',
          obscureText: true,
          validator: (value) => value!.length >= 6 ? null : 'Too short',
        ),
        SizedBox(height: 16),
        Row(
          children: [
            FlutstrapButton(
              onPressed: _validateForm,
              child: Text('Submit'),
            ),
            SizedBox(width: 8),
            FlutstrapButton(
              onPressed: _clearForm,
              variant: FSButtonVariant.secondary,
              child: Text('Clear'),
            ),
          ],
        ),
      ],
    );
  }
}
```

## Accessibility Notes

Flutstrap Input includes comprehensive accessibility features:

- **Screen Reader Support**: Full semantic labels for inputs, labels, and errors
- **Keyboard Navigation**: Proper focus management and keyboard interaction
- **Error Announcements**: Screen readers announce validation errors
- **High Contrast Support**: Meets WCAG contrast guidelines
- **Focus Indicators**: Clear visual focus indicators

```dart
FlutstrapInput(
  labelText: 'Email Address',
  hintText: 'Enter your email',
  semanticLabel: 'Email address for account creation',
  validator: (value) {
    if (value!.isEmpty) return 'Email address is required';
    return null;
  },
)
```

## Integration Examples

### Complete Login Form

```dart
class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FlutstrapInputState> _emailKey = GlobalKey();
  final GlobalKey<FlutstrapInputState> _passwordKey = GlobalKey();
  final _formKey = GlobalKey<FormState>();

  void _handleLogin() {
    final emailValid = _emailKey.currentState?.isValid ?? false;
    final passwordValid = _passwordKey.currentState?.isValid ?? false;

    if (emailValid && passwordValid) {
      // Perform login
      _performLogin(
        _emailKey.currentState!.value,
        _passwordKey.currentState!.value,
      );
    } else {
      // Show validation errors
      _emailKey.currentState?.focus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          FlutstrapInput(
            key: _emailKey,
            labelText: 'Email Address',
            hintText: 'you@example.com',
            prefixIcon: Icon(Icons.email),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Email is required';
              }
              if (!value.contains('@')) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          FlutstrapInput(
            key: _passwordKey,
            labelText: 'Password',
            hintText: 'Enter your password',
            prefixIcon: Icon(Icons.lock),
            obscureText: true,
            textInputAction: TextInputAction.done,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Password is required';
              }
              if (value.length < 8) {
                return 'Password must be at least 8 characters';
              }
              return null;
            },
            onFieldSubmitted: (_) => _handleLogin(),
          ),
          SizedBox(height: 24),
          FlutstrapButton(
            onPressed: _handleLogin,
            child: Text('Sign In'),
            size: FSSize.lg,
          ),
        ],
      ),
    );
  }
}
```

### Registration Form with Multiple Input Types

```dart
class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final Map<String, GlobalKey<FlutstrapInputState>> _inputKeys = {};

  @override
  void initState() {
    super.initState();
    // Initialize keys for each field
    _inputKeys['firstName'] = GlobalKey();
    _inputKeys['lastName'] = GlobalKey();
    _inputKeys['email'] = GlobalKey();
    _inputKeys['phone'] = GlobalKey();
    _inputKeys['password'] = GlobalKey();
    _inputKeys['confirmPassword'] = GlobalKey();
  }

  void _validateForm() {
    bool allValid = true;

    for (final key in _inputKeys.values) {
      if (!(key.currentState?.isValid ?? false)) {
        key.currentState?.focus();
        allValid = false;
        break;
      }
    }

    if (allValid) {
      _submitRegistration();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: FlutstrapInput(
                  key: _inputKeys['firstName'],
                  labelText: 'First Name',
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: FlutstrapInput(
                  key: _inputKeys['lastName'],
                  labelText: 'Last Name',
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          FlutstrapInput(
            key: _inputKeys['email'],
            labelText: 'Email Address',
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Icon(Icons.email),
            validator: (value) {
              if (value!.isEmpty) return 'Email is required';
              if (!value.contains('@')) return 'Invalid email format';
              return null;
            },
          ),
          SizedBox(height: 16),
          FlutstrapInput(
            key: _inputKeys['phone'],
            labelText: 'Phone Number',
            keyboardType: TextInputType.phone,
            prefixIcon: Icon(Icons.phone),
            validator: (value) {
              if (value!.isEmpty) return 'Phone number is required';
              if (value.length < 10) return 'Invalid phone number';
              return null;
            },
          ),
          SizedBox(height: 16),
          FlutstrapInput(
            key: _inputKeys['password'],
            labelText: 'Password',
            obscureText: true,
            prefixIcon: Icon(Icons.lock),
            helperText: 'Must be at least 8 characters',
            validator: (value) {
              if (value!.isEmpty) return 'Password is required';
              if (value.length < 8) return 'Must be at least 8 characters';
              return null;
            },
          ),
          SizedBox(height: 16),
          FlutstrapInput(
            key: _inputKeys['confirmPassword'],
            labelText: 'Confirm Password',
            obscureText: true,
            prefixIcon: Icon(Icons.lock),
            validator: (value) {
              final password = _inputKeys['password']!.currentState?.value;
              if (value != password) return 'Passwords do not match';
              return null;
            },
          ),
          SizedBox(height: 24),
          FlutstrapButton(
            onPressed: _validateForm,
            child: Text('Create Account'),
            size: FSSize.lg,
          ),
        ],
      ),
    );
  }
}
```

## Performance Optimization

### Validation Debouncing

```dart
// ✅ GOOD: Debounced validation for better performance
FlutstrapInput(
  labelText: 'Search',
  validator: (value) {
    // Expensive validation logic
    return _performExpensiveValidation(value);
  },
  validationDelay: Duration(milliseconds: 500), // Wait for user to stop typing
)

// ❌ AVOID: Immediate validation on every keystroke
FlutstrapInput(
  labelText: 'Search',
  validator: (value) {
    // This runs on every keystroke without debouncing
    return _performExpensiveValidation(value);
  },
  validationDelay: Duration.zero, // Not recommended for expensive operations
)
```

### Efficient State Management

```dart
// ✅ GOOD: Using keys for programmatic control
final _emailKey = GlobalKey<FlutstrapInputState>();

FlutstrapInput(
  key: _emailKey,
  labelText: 'Email',
)

// Later access state without rebuilding
void _clearEmail() {
  _emailKey.currentState?.clear();
}

// ✅ GOOD: Using controllers for complex scenarios
final _emailController = TextEditingController();

FlutstrapInput(
  controller: _emailController,
  labelText: 'Email',
)
```

## Best Practices

### Validation Patterns

```dart
// ✅ GOOD: Clear, specific error messages
FlutstrapInput(
  labelText: 'Username',
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }
    if (value.length < 3) {
      return 'Username must be at least 3 characters';
    }
    if (value.length > 20) {
      return 'Username cannot exceed 20 characters';
    }
    if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
      return 'Username can only contain letters, numbers, and underscores';
    }
    return null;
  },
)

// ❌ AVOID: Vague error messages
FlutstrapInput(
  labelText: 'Username',
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Error'; // Too vague
    }
    return null;
  },
)
```

### Keyboard and UX Patterns

```dart
FlutstrapInput(
  labelText: 'Email',
  keyboardType: TextInputType.emailAddress,
  textInputAction: TextInputAction.next, // Moves to next field
  onFieldSubmitted: (_) => _nextField(), // Handle submission
)

FlutstrapInput(
  labelText: 'Password',
  obscureText: true,
  textInputAction: TextInputAction.done, // Submits form
  onFieldSubmitted: (_) => _submitForm(), // Handle form submission
)
```

## Troubleshooting

### Common Issues and Solutions

**Validation Not Triggering**

```dart
// ❌ Validation only on form submit
FlutstrapInput(
  labelText: 'Email',
  validator: (value) => value!.isEmpty ? 'Required' : null,
)

// ✅ Real-time validation with proper setup
FlutstrapInput(
  labelText: 'Email',
  validator: (value) => value!.isEmpty ? 'Required' : null,
  // Validation happens automatically on change and focus loss
)
```

**Programmatic Control Not Working**

```dart
// ❌ Missing key or incorrect key type
FlutstrapInput(
  labelText: 'Email', // No key assigned
)

// ✅ Proper key usage
final _emailKey = GlobalKey<FlutstrapInputState>();

FlutstrapInput(
  key: _emailKey,
  labelText: 'Email',
)

// Access methods correctly
_emailKey.currentState?.clear();
_emailKey.currentState?.focus();
```

**Performance Issues with Large Forms**

```dart
// ❌ Expensive operations in validator
FlutstrapInput(
  labelText: 'Search',
  validator: (value) {
    // Network call in validator - BAD!
    return _checkServerAvailability(value);
  },
)

// ✅ Optimized validation with debouncing
FlutstrapInput(
  labelText: 'Search',
  validator: (value) {
    // Local validation only
    if (value != null && value.length > 0 && value.length < 3) {
      return 'Too short';
    }
    return null;
  },
  validationDelay: Duration(milliseconds: 500),
)
```

### Debugging Tips

1. **Check Key References**: Ensure you're using `GlobalKey<FlutstrapInputState>`
2. **Verify Validation Logic**: Test validator functions independently
3. **Monitor Performance**: Use validation delays for expensive operations
4. **Test Accessibility**: Use screen readers to verify semantic labels
5. **Check Focus Management**: Ensure proper textInputAction settings

---

**This comprehensive guide covers all aspects of using the Flutstrap Input component. The input system is designed to be highly flexible, performant, and accessible while providing a robust solution for form inputs across various validation requirements, interaction patterns, and design contexts. With features like debounced validation, programmatic control, and comprehensive accessibility support, Flutstrap Input offers enterprise-grade form handling capabilities for modern Flutter applications.**
