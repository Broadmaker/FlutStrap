# Flutstrap Alert Component Guide

## Introduction

Flutstrap Alert is a high-performance, flexible alert component for displaying contextual feedback messages with comprehensive theming and animation support. It provides a robust way to communicate important information to users in your Flutter applications.

### What It Does

- Displays contextual feedback messages with various visual styles
- Supports automatic dismissal and manual dismissal
- Provides smooth animations and accessibility features
- Offers multiple variants for different message types (success, error, warning, etc.)

### When to Use

- Display success messages after user actions
- Show error notifications when operations fail
- Provide warnings about potential issues
- Display informational messages
- Give users feedback about system status

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

### Simple Alert

```dart
FlutstrapAlert(
  message: 'This is a basic alert message',
  variant: FSAlertVariant.primary,
)
```

### Using Convenience Methods

```dart
// Success alert with auto-dismiss
FlutstrapAlert.success(
  message: 'Operation completed successfully!',
  autoDismissDuration: Duration(seconds: 5),
)

// Error alert with custom title
FlutstrapAlert.error(
  title: 'Upload Failed',
  message: 'Please check your connection and try again.',
  dismissible: true,
)
```

## Component Variants

Flutstrap Alert provides 8 visual variants to convey different types of messages:

### Primary

```dart
FlutstrapAlert.primary(
  message: 'Primary information message',
)
```

### Success

```dart
FlutstrapAlert.success(
  message: 'Operation completed successfully!',
)
```

### Danger (Error)

```dart
FlutstrapAlert.error(
  message: 'Something went wrong!',
)
```

### Warning

```dart
FlutstrapAlert.warning(
  message: 'Your session will expire soon.',
)
```

### Info

```dart
FlutstrapAlert.info(
  message: 'New features are available.',
)
```

### Secondary

```dart
FlutstrapAlert(
  message: 'Secondary information',
  variant: FSAlertVariant.secondary,
)
```

### Light & Dark

```dart
FlutstrapAlert(
  message: 'Light variant message',
  variant: FSAlertVariant.light,
)

FlutstrapAlert(
  message: 'Dark variant message',
  variant: FSAlertVariant.dark,
)
```

## Properties & Parameters

### Parameter Reference Table

| Parameter             | Type             | Default      | Description                             |
| --------------------- | ---------------- | ------------ | --------------------------------------- |
| `title`               | `String?`        | `null`       | Optional title text for the alert       |
| `message`             | `String`         | **required** | Main alert message content              |
| `variant`             | `FSAlertVariant` | `primary`    | Visual style variant                    |
| `dismissible`         | `bool`           | `false`      | Whether alert can be manually dismissed |
| `onDismiss`           | `VoidCallback?`  | `null`       | Callback when alert is dismissed        |
| `leading`             | `Widget?`        | `null`       | Custom leading widget (replaces icon)   |
| `trailing`            | `Widget?`        | `null`       | Custom trailing widget                  |
| `autoDismissDuration` | `Duration?`      | `null`       | Duration before auto-dismissal          |
| `showIcon`            | `bool`           | `true`       | Whether to show variant icon            |
| `borderRadius`        | `double`         | `8.0`        | Border radius for alert container       |
| `animateEntrance`     | `bool`           | `true`       | Whether to animate alert appearance     |

### FSAlertVariant Enum

```dart
enum FSAlertVariant {
  primary,    // Blue theme - general information
  secondary,  // Gray theme - secondary information
  success,    // Green theme - success messages
  danger,     // Red theme - error messages
  warning,    // Yellow theme - warnings
  info,       // Light blue theme - informational
  light,      // Light background
  dark,       // Dark background
}
```

## Customization

### Custom Colors and Styling

```dart
FlutstrapAlert(
  message: 'Custom styled alert',
  variant: FSAlertVariant.primary,
  borderRadius: 12.0, // Rounded corners
  showIcon: false, // Hide default icon
)
```

### Custom Leading Icon

```dart
FlutstrapAlert(
  message: 'Alert with custom icon',
  leading: Icon(Icons.star, color: Colors.amber),
  showIcon: false, // Important: disable default icon
)
```

### Custom Action Button

```dart
FlutstrapAlert(
  variant: FSAlertVariant.warning,
  message: 'Your session will expire soon.',
  trailing: FlutstrapButton(
    onPressed: extendSession,
    child: Text('Extend Session'),
    size: FSSize.sm,
  ),
)
```

### Custom Animation

```dart
FlutstrapAlert(
  message: 'Alert without animation',
  animateEntrance: false,
  autoDismissDuration: Duration(seconds: 3),
)
```

## Interactivity & Behavior

### Manual Dismissal

```dart
FlutstrapAlert(
  message: 'This alert can be dismissed',
  dismissible: true,
  onDismiss: () {
    print('Alert was dismissed!');
  },
)
```

### Auto-Dismissal

```dart
FlutstrapAlert.success(
  message: 'This alert will auto-dismiss in 5 seconds',
  autoDismissDuration: Duration(seconds: 5),
  onDismiss: () {
    // Perform cleanup or state updates
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Alert dismissed')),
    );
  },
)
```

### Programmatic Dismissal

```dart
class AlertExample extends StatefulWidget {
  @override
  _AlertExampleState createState() => _AlertExampleState();
}

class _AlertExampleState extends State<AlertExample> {
  final GlobalKey<_FlutstrapAlertState> _alertKey = GlobalKey();

  void _dismissAlert() {
    _alertKey.currentState?.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FlutstrapAlert(
          key: _alertKey, // Attach the key
          message: 'Programmatically dismissible alert',
          variant: FSAlertVariant.info,
        ),
        FlutstrapButton(
          onPressed: _dismissAlert,
          child: Text('Dismiss Alert'),
        ),
      ],
    );
  }
}
```

## Accessibility Notes

Flutstrap Alert includes comprehensive accessibility features:

- **Screen Reader Support**: Uses `Semantics` widget with `liveRegion` for automatic announcements
- **Semantic Labels**: Provides descriptive labels including alert type and content
- **Keyboard Navigation**: Supports keyboard interaction where applicable
- **WCAG Compliance**: Follows contrast guidelines for text and background colors
- **Dismissible Actions**: Proper semantic labels for dismiss buttons

```dart
// Screen readers will announce: "Success, Operation completed, success alert, Dismissible"
FlutstrapAlert.success(
  title: 'Success',
  message: 'Operation completed',
  dismissible: true,
)
```

## Integration Examples

### In a Form Validation Context

```dart
class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _showError = false;

  void _submitForm() {
    if (_isValid) {
      // Show success
      setState(() {
        _showError = false;
      });
      // Process login...
    } else {
      // Show error
      setState(() {
        _showError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_showError)
          FlutstrapAlert.error(
            message: 'Please check your email and password',
            autoDismissDuration: Duration(seconds: 5),
          ),

        FlutstrapTextField(
          label: 'Email',
          // ... field properties
        ),

        FlutstrapTextField(
          label: 'Password',
          obscureText: true,
          // ... field properties
        ),

        FlutstrapButton(
          onPressed: _submitForm,
          child: Text('Login'),
        ),
      ],
    );
  }
}
```

### With Multiple Alerts

```dart
Column(
  children: [
    FlutstrapAlert.success(
      message: 'Profile updated successfully',
      autoDismissDuration: Duration(seconds: 3),
    ),
    FlutstrapAlert.info(
      message: 'New messages available',
      trailing: FlutstrapButton(
        onPressed: () => _loadMessages(),
        child: Text('View'),
        variant: FSButtonVariant.outline,
      ),
    ),
  ],
)
```

### In App Layout

```dart
Scaffold(
  appBar: FlutstrapAppBar(
    title: Text('My App'),
  ),
  body: Padding(
    padding: EdgeInsets.all(FSSpacing.md),
    child: Column(
      children: [
        FlutstrapAlert.warning(
          message: 'Maintenance scheduled for tonight at 2 AM',
        ),
        SizedBox(height: FSSpacing.lg),
        // Rest of your content...
        Expanded(
          child: YourMainContent(),
        ),
      ],
    ),
  ),
)
```

## Best Practices

### Performance Recommendations

- **Style Caching**: The component automatically caches styles for better performance
- **Efficient Rebuilds**: Uses `const` constructors and immutable data where possible
- **Animation Optimization**: Leverages Flutter's optimized animation widgets

### UX Design Tips

```dart
// GOOD: Clear, concise messages
FlutstrapAlert.success(
  message: 'Changes saved',
  autoDismissDuration: Duration(seconds: 3),
)

// AVOID: Overly long messages
FlutstrapAlert(
  message: 'Your request has been processed successfully and all the changes you made have been saved to the database and will be reflected in the next update cycle which runs every 15 minutes.',
)

// GOOD: Use titles for important alerts
FlutstrapAlert.error(
  title: 'Connection Lost',
  message: 'Please check your internet connection',
  dismissible: true,
)

// GOOD: Provide actions when needed
FlutstrapAlert(
  variant: FSAlertVariant.warning,
  message: 'Storage almost full',
  trailing: FlutstrapButton(
    onPressed: _clearStorage,
    child: Text('Manage Storage'),
  ),
)
```

### Auto-Dismiss Guidelines

- **Success messages**: 3-5 seconds
- **Info messages**: 5-7 seconds
- **Warnings**: Keep visible until action taken or manually dismissed
- **Errors**: Keep visible until resolved or manually dismissed

## Troubleshooting

### Common Issues and Solutions

**Alert not appearing**

```dart
// ❌ Wrong: Alert might be outside visible area
FlutstrapAlert(message: 'Hello')

// ✅ Correct: Ensure proper layout constraints
SingleChildScrollView(
  child: Column(
    children: [
      FlutstrapAlert(message: 'Hello'),
      // other content...
    ],
  ),
)
```

**Auto-dismiss not working**

```dart
// ❌ Timer might be cancelled if widget rebuilds
// ✅ Ensure stable widget tree and proper state management
```

**Theme colors not applying**

```dart
// ❌ Missing FSTheme wrapper
// ✅ Ensure your app is wrapped with FSTheme
MaterialApp(
  home: FSTheme(
    data: FSThemeData.light(),
    child: YourPage(),
  ),
)
```

**Custom leading/trailing not showing**

```dart
// ❌ Forgetting to disable default icon
FlutstrapAlert(
  leading: MyCustomIcon(),
  message: 'Alert',
)

// ✅ Correct approach
FlutstrapAlert(
  leading: MyCustomIcon(),
  showIcon: false, // Disable default icon
  message: 'Alert',
)
```

**Animation issues**

```dart
// If animations are janky, try:
FlutstrapAlert(
  message: 'Alert',
  animateEntrance: false, // Disable animations
)
```

This comprehensive guide covers all aspects of using the FlutstrapAlert component. The alert system is designed to be flexible, performant, and accessible while providing a great user experience for displaying contextual feedback and notifications.
