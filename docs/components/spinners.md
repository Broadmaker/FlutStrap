# Flutstrap Spinner Component Guide

## Introduction

The **FlutstrapSpinner** is a customizable loading spinner with Bootstrap-inspired styling, featuring multiple animation types, variants, and comprehensive accessibility support. It provides a robust solution for displaying loading states in various contexts.

### What the Component Does

FlutstrapSpinner offers:

- Three animation types (border, growing, dots)
- Multiple visual variants (8 color options)
- Three size options (sm, md, lg)
- Smooth animations with custom durations
- Accessibility features for screen readers
- Error handling and fallback options
- Spinner button integration

### When and Why to Use It

Use FlutstrapSpinner when you need:

- Loading indicators for async operations
- Form submission states
- Content loading feedback
- Processing indicators
- Any scenario requiring visual loading feedback

### Prerequisites

- Flutter 3.0 or higher
- Flutstrap theme package

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

### Basic Spinner

```dart
FlutstrapSpinner(
  variant: FSSpinnerVariant.primary,
)

FlutstrapSpinner(
  variant: FSSpinnerVariant.success,
  label: 'Loading...',
)
```

### Custom Styled Spinner

```dart
FlutstrapSpinner(
  variant: FSSpinnerVariant.primary,
  color: Colors.purple,
  strokeWidth: 3.0,
  animationDuration: Duration(milliseconds: 800),
)
```

### Centered Spinner with Label

```dart
FlutstrapSpinner(
  variant: FSSpinnerVariant.info,
  label: 'Processing your request...',
  centered: true,
)
```

## Component Variants

FlutstrapSpinner offers 8 visual variants:

### Primary

```dart
FlutstrapSpinner(
  variant: FSSpinnerVariant.primary,
)
```

### Secondary

```dart
FlutstrapSpinner(
  variant: FSSpinnerVariant.secondary,
)
```

### Success

```dart
FlutstrapSpinner(
  variant: FSSpinnerVariant.success,
)
```

### Danger

```dart
FlutstrapSpinner(
  variant: FSSpinnerVariant.danger,
)
```

### Warning

```dart
FlutstrapSpinner(
  variant: FSSpinnerVariant.warning,
)
```

### Info

```dart
FlutstrapSpinner(
  variant: FSSpinnerVariant.info,
)
```

### Light

```dart
FlutstrapSpinner(
  variant: FSSpinnerVariant.light,
)
```

### Dark

```dart
FlutstrapSpinner(
  variant: FSSpinnerVariant.dark,
)
```

## Spinner Sizes

### Small (sm) - 16px

```dart
FlutstrapSpinner(
  size: FSSpinnerSize.sm,
  variant: FSSpinnerVariant.primary,
)
```

### Medium (md) - 24px (Default)

```dart
FlutstrapSpinner(
  size: FSSpinnerSize.md,
  variant: FSSpinnerVariant.primary,
)
```

### Large (lg) - 32px

```dart
FlutstrapSpinner(
  size: FSSpinnerSize.lg,
  variant: FSSpinnerVariant.primary,
)
```

## Spinner Types

### Border Spinner (Classic rotating border)

```dart
FlutstrapSpinner(
  type: FSSpinnerType.border,
  variant: FSSpinnerVariant.primary,
  strokeWidth: 3.0,
)
```

### Growing Spinner (Pulsing circle)

```dart
FlutstrapSpinner(
  type: FSSpinnerType.growing,
  variant: FSSpinnerVariant.success,
)
```

### Dots Spinner (Bouncing dots)

```dart
FlutstrapSpinner(
  type: FSSpinnerType.dots,
  variant: FSSpinnerVariant.warning,
)
```

## Properties & Parameters

### Parameter Reference Table

| Parameter           | Type               | Default   | Description                            |
| ------------------- | ------------------ | --------- | -------------------------------------- |
| `variant`           | `FSSpinnerVariant` | `primary` | Visual style variant                   |
| `size`              | `FSSpinnerSize`    | `md`      | Spinner size                           |
| `type`              | `FSSpinnerType`    | `border`  | Animation type                         |
| `label`             | `String?`          | `null`    | Text label below spinner               |
| `customLabel`       | `Widget?`          | `null`    | Custom label widget                    |
| `color`             | `Color?`           | `null`    | Custom spinner color                   |
| `strokeWidth`       | `double?`          | `null`    | Border stroke width (border type only) |
| `animationDuration` | `Duration`         | `1000ms`  | Animation duration                     |
| `centered`          | `bool`             | `false`   | Whether to center the spinner          |
| `onAnimationError`  | `Function?`        | `null`    | Animation error callback               |
| `fallbackWidget`    | `Widget?`          | `null`    | Fallback widget for animation errors   |

### FSSpinnerVariant Enum

```dart
enum FSSpinnerVariant {
  primary, secondary, success, danger, warning, info, light, dark
}
```

### FSSpinnerSize Enum

```dart
enum FSSpinnerSize {
  sm,  // 16px
  md,  // 24px
  lg   // 32px
}
```

### FSSpinnerType Enum

```dart
enum FSSpinnerType {
  border,  // Rotating border
  growing, // Pulsing circle
  dots     // Bouncing dots
}
```

## Advanced Features

### Custom Labels

```dart
FlutstrapSpinner(
  variant: FSSpinnerVariant.primary,
  customLabel: Column(
    children: [
      Text('Processing', style: TextStyle(fontWeight: FontWeight.bold)),
      Text('This may take a few seconds...', style: TextStyle(fontSize: 12)),
    ],
  ),
)
```

### Error Handling

```dart
FlutstrapSpinner(
  variant: FSSpinnerVariant.primary,
  onAnimationError: (error) {
    print('Spinner animation error: $error');
    // Log to analytics or show fallback
  },
  fallbackWidget: Icon(Icons.refresh, color: Colors.grey),
)
```

### Custom Animation Duration

```dart
FlutstrapSpinner(
  variant: FSSpinnerVariant.warning,
  animationDuration: Duration(milliseconds: 500), // Faster animation
)

FlutstrapSpinner(
  variant: FSSpinnerVariant.info,
  animationDuration: Duration(milliseconds: 2000), // Slower animation
)
```

### Using copyWith for Dynamic Updates

```dart
class DynamicSpinner extends StatefulWidget {
  @override
  _DynamicSpinnerState createState() => _DynamicSpinnerState();
}

class _DynamicSpinnerState extends State<DynamicSpinner> {
  FSSpinnerVariant _currentVariant = FSSpinnerVariant.primary;
  FSSpinnerType _currentType = FSSpinnerType.border;

  // Base spinner configuration
  FlutstrapSpinner get _baseSpinner => FlutstrapSpinner(
    variant: _currentVariant,
    type: _currentType,
    label: 'Processing',
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _baseSpinner.copyWith(
          customLabel: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Loading: '),
              Text(_getTypeName(_currentType),
                   style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        SizedBox(height: 20),
        Wrap(
          spacing: 8,
          children: [
            FlutstrapButton(
              onPressed: () => setState(() => _currentType = FSSpinnerType.border),
              text: 'Border',
              size: FSButtonSize.sm,
            ),
            FlutstrapButton(
              onPressed: () => setState(() => _currentType = FSSpinnerType.growing),
              text: 'Growing',
              size: FSButtonSize.sm,
            ),
            FlutstrapButton(
              onPressed: () => setState(() => _currentType = FSSpinnerType.dots),
              text: 'Dots',
              size: FSButtonSize.sm,
            ),
          ],
        ),
      ],
    );
  }

  String _getTypeName(FSSpinnerType type) {
    return type.toString().split('.').last;
  }
}
```

## Spinner Button

### Loading Button State

```dart
FlutstrapSpinnerButton(
  isLoading: _isLoading,
  onPressed: _submitForm,
  child: Text('Save Changes'),
  spinner: FlutstrapSpinner(
    variant: FSSpinnerVariant.light,
    size: FSSpinnerSize.sm,
  ),
  loadingLabel: 'Saving...',
)
```

### Custom Button Styling

```dart
FlutstrapSpinnerButton(
  isLoading: _isUploading,
  onPressed: _uploadFile,
  child: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.cloud_upload),
      SizedBox(width: 8),
      Text('Upload File'),
    ],
  ),
  spinner: FlutstrapSpinner(
    variant: FSSpinnerVariant.dark,
    type: FSSpinnerType.growing,
  ),
  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
  minimumSize: Size(120, 48),
)
```

## Integration Examples

### Form Submission with Spinner

```dart
class SubmitForm extends StatefulWidget {
  @override
  _SubmitFormState createState() => _SubmitFormState();
}

class _SubmitFormState extends State<SubmitForm> {
  bool _isSubmitting = false;

  Future<void> _handleSubmit() async {
    setState(() => _isSubmitting = true);

    try {
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));
      // Handle successful submission
      print('Form submitted successfully');
    } catch (e) {
      // Handle error
      print('Submission error: $e');
    } finally {
      setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Form fields would go here
        TextField(decoration: InputDecoration(labelText: 'Name')),
        TextField(decoration: InputDecoration(labelText: 'Email')),

        SizedBox(height: 20),

        FlutstrapSpinnerButton(
          isLoading: _isSubmitting,
          onPressed: _handleSubmit,
          child: Text('Submit Form'),
          spinner: FlutstrapSpinner(
            variant: FSSpinnerVariant.light,
            size: FSSpinnerSize.sm,
          ),
          loadingLabel: 'Submitting form...',
        ),
      ],
    );
  }
}
```

### Content Loading State

```dart
class ContentLoader extends StatefulWidget {
  @override
  _ContentLoaderState createState() => _ContentLoaderState();
}

class _ContentLoaderState extends State<ContentLoader> {
  bool _isLoading = true;
  List<String> _items = [];

  @override
  void initState() {
    super.initState();
    _loadContent();
  }

  Future<void> _loadContent() async {
    // Simulate network request
    await Future.delayed(Duration(seconds: 3));

    setState(() {
      _items = List.generate(10, (index) => 'Item ${index + 1}');
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: FlutstrapSpinner(
              variant: FSSpinnerVariant.primary,
              type: FSSpinnerType.growing,
              label: 'Loading content...',
              centered: true,
            ),
          )
        : ListView.builder(
            itemCount: _items.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(_items[index]),
            ),
          );
  }
}
```

### Multiple Spinner Types Demo

```dart
class SpinnerDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Spinner Types', style: Theme.of(context).textTheme.headlineSmall),
        SizedBox(height: 20),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                FlutstrapSpinner(
                  type: FSSpinnerType.border,
                  variant: FSSpinnerVariant.primary,
                ),
                SizedBox(height: 8),
                Text('Border'),
              ],
            ),
            Column(
              children: [
                FlutstrapSpinner(
                  type: FSSpinnerType.growing,
                  variant: FSSpinnerVariant.success,
                ),
                SizedBox(height: 8),
                Text('Growing'),
              ],
            ),
            Column(
              children: [
                FlutstrapSpinner(
                  type: FSSpinnerType.dots,
                  variant: FSSpinnerVariant.warning,
                ),
                SizedBox(height: 8),
                Text('Dots'),
              ],
            ),
          ],
        ),

        SizedBox(height: 30),

        Text('Spinner Sizes', style: Theme.of(context).textTheme.headlineSmall),
        SizedBox(height: 20),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                FlutstrapSpinner(
                  size: FSSpinnerSize.sm,
                  variant: FSSpinnerVariant.info,
                ),
                SizedBox(height: 8),
                Text('Small'),
              ],
            ),
            Column(
              children: [
                FlutstrapSpinner(
                  size: FSSpinnerSize.md,
                  variant: FSSpinnerVariant.info,
                ),
                SizedBox(height: 8),
                Text('Medium'),
              ],
            ),
            Column(
              children: [
                FlutstrapSpinner(
                  size: FSSpinnerSize.lg,
                  variant: FSSpinnerVariant.info,
                ),
                SizedBox(height: 8),
                Text('Large'),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
```

### API Request with Error Handling

```dart
class ApiLoader extends StatefulWidget {
  @override
  _ApiLoaderState createState() => _ApiLoaderState();
}

class _ApiLoaderState extends State<ApiLoader> {
  bool _isLoading = false;
  String? _error;

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      // Simulate API call that might fail
      await Future.delayed(Duration(seconds: 2));

      // Randomly simulate success or failure
      if (Random().nextBool()) {
        throw Exception('Network error');
      }

      // Success case
      print('Data fetched successfully');

    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_isLoading)
          FlutstrapSpinner(
            variant: FSSpinnerVariant.primary,
            label: 'Fetching data from API...',
            centered: true,
            onAnimationError: (error) {
              print('Spinner animation failed: $error');
            },
            fallbackWidget: Icon(Icons.hourglass_empty, size: 48, color: Colors.grey),
          )
        else if (_error != null)
          Column(
            children: [
              Icon(Icons.error_outline, color: Colors.red, size: 48),
              SizedBox(height: 8),
              Text('Error: $_error', style: TextStyle(color: Colors.red)),
              SizedBox(height: 16),
              FlutstrapButton(
                onPressed: _fetchData,
                text: 'Retry',
                variant: FSButtonVariant.danger,
              ),
            ],
          )
        else
          FlutstrapButton(
            onPressed: _fetchData,
            text: 'Fetch Data',
            variant: FSButtonVariant.primary,
          ),
      ],
    );
  }
}
```

## Accessibility Notes

FlutstrapSpinner includes comprehensive accessibility features:

- **Screen Reader Support**: Uses live region for dynamic updates
- **Semantic Labels**: Properly announces loading states
- **High Contrast**: All variants support high contrast modes
- **Clear Indicators**: Different spinner types have distinct announcements
- **ARIA Compliance**: Proper attributes for screen readers

```dart
FlutstrapSpinner(
  variant: FSSpinnerVariant.primary,
  label: 'Loading user data', // Provides context for screen readers
  // Automatically announces appropriate loading indicator type
)
```

## Performance Guidelines

### Animation Optimization

```dart
// ✅ Good - Use appropriate animation duration
FlutstrapSpinner(
  animationDuration: Duration(milliseconds: 1000), // Reasonable duration
)

// ✅ Good - Use simpler spinner types for better performance
FlutstrapSpinner(
  type: FSSpinnerType.border, // Best performance
)

// ❌ Avoid - Multiple complex spinners simultaneously
Column(
  children: [
    FlutstrapSpinner(type: FSSpinnerType.dots), // More complex
    FlutstrapSpinner(type: FSSpinnerType.dots), // More complex
    FlutstrapSpinner(type: FSSpinnerType.dots), // More complex
  ],
)
```

### Error Handling Best Practices

```dart
// ✅ Good - Provide fallback for animation errors
FlutstrapSpinner(
  onAnimationError: (error) {
    // Log error for debugging
    debugPrint('Spinner animation error: $error');
  },
  fallbackWidget: CircularProgressIndicator(), // Graceful fallback
)

// ✅ Good - Handle errors in production
FlutstrapSpinner(
  onAnimationError: (error) {
    if (!kDebugMode) {
      // In production, use a simple fallback
      // Consider logging to analytics
    }
  },
)
```

## Troubleshooting

### Common Issues and Solutions

**Animation Not Working**

```dart
// Ensure animation duration is greater than zero
FlutstrapSpinner(
  animationDuration: Duration(milliseconds: 500), // Must be > 0
)

// Check if widget is visible and has sufficient space
Container(
  width: 100,
  height: 100,
  child: FlutstrapSpinner(), // Ensure container is large enough
)
```

**Performance Issues**

```dart
// Reduce number of simultaneous animated spinners
// Use border type for best performance
FlutstrapSpinner(
  type: FSSpinnerType.border, // Most performant
  size: FSSpinnerSize.sm,     // Smaller = better performance
)

// Consider static indicators for multiple items
_isLoading
  ? FlutstrapSpinner(type: FSSpinnerType.border)
  : YourContentWidget()
```

**Accessibility Concerns**

```dart
// Always provide meaningful labels
FlutstrapSpinner(
  label: 'Loading user profile', // Context-specific label
)

// Use custom labels for complex scenarios
FlutstrapSpinner(
  customLabel: Semantics(
    label: 'Uploading file: 50% complete',
    child: Text('Uploading...'),
  ),
)
```

This comprehensive guide covers all aspects of using the FlutstrapSpinner component. The spinner system is designed to be highly flexible, performant, and accessible while providing a robust solution for loading indicators in various application contexts.
