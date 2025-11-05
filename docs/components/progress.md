# Flutstrap Progress Bar Component Guide

## Introduction

The **FlutstrapProgress** is a customizable progress bar with Bootstrap-inspired styling, featuring animations, striped patterns, and comprehensive accessibility support. It provides a robust solution for displaying progress indicators in various contexts.

### What the Component Does

FlutstrapProgress offers:

- Multiple visual variants (8 color options)
- Three size options (sm, md, lg)
- Smooth animations with custom curves
- Striped pattern effects
- Indeterminate progress mode
- Value labels and custom labels
- Progress groups for multiple bars
- Comprehensive validation and error handling

### When and Why to Use It

Use FlutstrapProgress when you need:

- File upload progress indicators
- Form completion progress
- Loading states with progress
- Multi-step process indicators
- Resource loading progress
- Any scenario requiring visual progress feedback

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

### Basic Progress Bar

```dart
FlutstrapProgress(
  value: 75,
  variant: FSProgressVariant.primary,
)

FlutstrapProgress(
  value: 50,
  label: 'Upload Progress',
  variant: FSProgressVariant.success,
)
```

### Animated Progress Bar

```dart
FlutstrapProgress(
  value: currentProgress,
  animated: true,
  animationDuration: Duration(seconds: 2),
  animationCurve: Curves.easeInOut,
  variant: FSProgressVariant.info,
)
```

### Custom Styled Progress Bar

```dart
FlutstrapProgress(
  value: 65,
  progressColor: Colors.purple,
  backgroundColor: Colors.purple.withOpacity(0.2),
  height: 12,
  borderRadius: BorderRadius.circular(10),
)
```

## Component Variants

FlutstrapProgress offers 8 visual variants:

### Primary

```dart
FlutstrapProgress(
  value: 75,
  variant: FSProgressVariant.primary,
)
```

### Secondary

```dart
FlutstrapProgress(
  value: 75,
  variant: FSProgressVariant.secondary,
)
```

### Success

```dart
FlutstrapProgress(
  value: 75,
  variant: FSProgressVariant.success,
)
```

### Danger

```dart
FlutstrapProgress(
  value: 75,
  variant: FSProgressVariant.danger,
)
```

### Warning

```dart
FlutstrapProgress(
  value: 75,
  variant: FSProgressVariant.warning,
)
```

### Info

```dart
FlutstrapProgress(
  value: 75,
  variant: FSProgressVariant.info,
)
```

### Light

```dart
FlutstrapProgress(
  value: 75,
  variant: FSProgressVariant.light,
)
```

### Dark

```dart
FlutstrapProgress(
  value: 75,
  variant: FSProgressVariant.dark,
)
```

## Progress Sizes

### Small (sm) - 4px height

```dart
FlutstrapProgress(
  value: 75,
  size: FSProgressSize.sm,
  variant: FSProgressVariant.primary,
)
```

### Medium (md) - 8px height (Default)

```dart
FlutstrapProgress(
  value: 75,
  size: FSProgressSize.md,
  variant: FSProgressVariant.primary,
)
```

### Large (lg) - 12px height

```dart
FlutstrapProgress(
  value: 75,
  size: FSProgressSize.lg,
  variant: FSProgressVariant.primary,
)
```

## Properties & Parameters

### Parameter Reference Table

| Parameter           | Type                    | Default            | Description                               |
| ------------------- | ----------------------- | ------------------ | ----------------------------------------- |
| `value`             | `double`                | **Required**       | Current progress value (0-100)            |
| `minValue`          | `double`                | `0.0`              | Minimum progress value                    |
| `maxValue`          | `double`                | `100.0`            | Maximum progress value                    |
| `variant`           | `FSProgressVariant`     | `primary`          | Visual style variant                      |
| `size`              | `FSProgressSize`        | `md`               | Progress bar size                         |
| `animated`          | `bool`                  | `false`            | Whether to animate progress changes       |
| `striped`           | `bool`                  | `false`            | Whether to show striped pattern           |
| `label`             | `String?`               | `null`             | Text label above progress bar             |
| `customLabel`       | `Widget?`               | `null`             | Custom label widget                       |
| `backgroundColor`   | `Color?`                | `null`             | Custom background color                   |
| `progressColor`     | `Color?`                | `null`             | Custom progress color                     |
| `height`            | `double?`               | `null`             | Custom height (overrides size)            |
| `fixedWidth`        | `double?`               | `null`             | Fixed width for progress bar              |
| `expandToFill`      | `bool`                  | `true`             | Whether to expand to fill available width |
| `borderRadius`      | `BorderRadiusGeometry?` | `null`             | Custom border radius                      |
| `animationDuration` | `Duration`              | `500ms`            | Animation duration                        |
| `animationCurve`    | `Curve`                 | `Curves.easeInOut` | Animation curve                           |
| `validator`         | `Function?`             | `null`             | Custom value validator                    |

### FSProgressVariant Enum

```dart
enum FSProgressVariant {
  primary, secondary, success, danger, warning, info, light, dark
}
```

### FSProgressSize Enum

```dart
enum FSProgressSize {
  sm,  // 4px height
  md,  // 8px height
  lg   // 12px height
}
```

## Advanced Features

### Indeterminate Progress

```dart
FlutstrapProgress.indeterminate(
  variant: FSProgressVariant.primary,
  label: 'Processing...',
  striped: true,
  animated: true,
)
```

### Striped Pattern

```dart
FlutstrapProgress(
  value: 75,
  striped: true,
  variant: FSProgressVariant.warning,
  animated: true, // Stripes work best with animation
)
```

### Custom Value Ranges

```dart
FlutstrapProgress(
  value: 250,
  minValue: 0,
  maxValue: 500, // Custom range: 0-500
  label: 'Points: 250/500',
  variant: FSProgressVariant.success,
)
```

### Custom Labels

```dart
FlutstrapProgress(
  value: 85,
  customLabel: Row(
    children: [
      Icon(Icons.cloud_upload, size: 16),
      SizedBox(width: 8),
      Text('Uploading: 85%'),
      Spacer(),
      Text('4.2 MB/s'),
    ],
  ),
)
```

### Fixed Width Progress

```dart
FlutstrapProgress(
  value: 60,
  fixedWidth: 200,
  expandToFill: false, // Use fixed width instead of expanding
  variant: FSProgressVariant.info,
)
```

## Progress Groups

### Multiple Progress Bars

```dart
FlutstrapProgressGroup(
  children: [
    FlutstrapProgress(
      value: 25,
      label: 'Storage',
      variant: FSProgressVariant.primary,
    ),
    FlutstrapProgress(
      value: 50,
      label: 'Memory',
      variant: FSProgressVariant.success,
    ),
    FlutstrapProgress(
      value: 75,
      label: 'CPU',
      variant: FSProgressVariant.warning,
    ),
  ],
  spacing: 12,
)
```

### Compact Progress Group

```dart
FlutstrapProgressGroup(
  children: [
    FlutstrapProgress(value: 30, variant: FSProgressVariant.danger),
    FlutstrapProgress(value: 60, variant: FSProgressVariant.warning),
    FlutstrapProgress(value: 90, variant: FSProgressVariant.success),
  ],
  spacing: 4,
  expandToFill: false,
)
```

## Integration Examples

### File Upload Progress

```dart
class FileUploadProgress extends StatefulWidget {
  @override
  _FileUploadProgressState createState() => _FileUploadProgressState();
}

class _FileUploadProgressState extends State<FileUploadProgress> {
  double _uploadProgress = 0.0;
  bool _isUploading = false;

  void _simulateUpload() async {
    setState(() {
      _isUploading = true;
      _uploadProgress = 0.0;
    });

    for (int i = 0; i <= 100; i += 10) {
      await Future.delayed(Duration(milliseconds: 300));
      setState(() {
        _uploadProgress = i.toDouble();
      });
    }

    setState(() => _isUploading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FlutstrapProgress(
          value: _uploadProgress,
          label: _isUploading ? 'Uploading file...' : 'Upload complete',
          variant: _isUploading ? FSProgressVariant.primary : FSProgressVariant.success,
          animated: true,
          striped: _isUploading,
          customLabel: _isUploading
              ? Row(
                  children: [
                    Text('Uploading...'),
                    Spacer(),
                    Text('${_uploadProgress.toStringAsFixed(0)}%'),
                  ],
                )
              : Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green, size: 16),
                    SizedBox(width: 8),
                    Text('Upload complete'),
                  ],
                ),
        ),
        SizedBox(height: 16),
        FlutstrapButton(
          onPressed: _isUploading ? null : _simulateUpload,
          text: _isUploading ? 'Uploading...' : 'Start Upload',
          variant: FSButtonVariant.primary,
        ),
      ],
    );
  }
}
```

### Multi-Step Form Progress

```dart
class MultiStepForm extends StatefulWidget {
  @override
  _MultiStepFormState createState() => _MultiStepFormState();
}

class _MultiStepFormState extends State<MultiStepForm> {
  int _currentStep = 1;
  final int _totalSteps = 4;

  double get _progressPercentage {
    return (_currentStep / _totalSteps) * 100;
  }

  String get _stepLabel {
    switch (_currentStep) {
      case 1: return 'Personal Information';
      case 2: return 'Contact Details';
      case 3: return 'Preferences';
      case 4: return 'Confirmation';
      default: return 'Step $_currentStep';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FlutstrapProgress(
          value: _progressPercentage,
          label: _stepLabel,
          customLabel: Row(
            children: [
              Text('Step $_currentStep of $_totalSteps'),
              Spacer(),
              Text('${_progressPercentage.toStringAsFixed(0)}%'),
            ],
          ),
          variant: FSProgressVariant.info,
          animated: true,
          size: FSProgressSize.lg,
        ),
        SizedBox(height: 32),
        // Form steps would go here
        Text('Step $_currentStep Content'),
        SizedBox(height: 16),
        Row(
          children: [
            if (_currentStep > 1)
              FlutstrapButton(
                onPressed: () => setState(() => _currentStep--),
                text: 'Previous',
                variant: FSButtonVariant.outlineSecondary,
              ),
            Spacer(),
            if (_currentStep < _totalSteps)
              FlutstrapButton(
                onPressed: () => setState(() => _currentStep++),
                text: 'Next',
                variant: FSButtonVariant.primary,
              )
            else
              FlutstrapButton(
                onPressed: () => print('Form submitted'),
                text: 'Submit',
                variant: FSButtonVariant.success,
              ),
          ],
        ),
      ],
    );
  }
}
```

### System Resource Monitor

```dart
class SystemMonitor extends StatefulWidget {
  @override
  _SystemMonitorState createState() => _SystemMonitorState();
}

class _SystemMonitorState extends State<SystemMonitor> {
  double _cpuUsage = 45.0;
  double _memoryUsage = 72.0;
  double _diskUsage = 88.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('System Resources', style: Theme.of(context).textTheme.titleMedium),
        SizedBox(height: 16),
        FlutstrapProgressGroup(
          children: [
            FlutstrapProgress(
              value: _cpuUsage,
              label: 'CPU Usage',
              customLabel: _buildResourceLabel('CPU', _cpuUsage),
              variant: _getResourceVariant(_cpuUsage),
              animated: true,
            ),
            SizedBox(height: 12),
            FlutstrapProgress(
              value: _memoryUsage,
              label: 'Memory Usage',
              customLabel: _buildResourceLabel('Memory', _memoryUsage),
              variant: _getResourceVariant(_memoryUsage),
              animated: true,
            ),
            SizedBox(height: 12),
            FlutstrapProgress(
              value: _diskUsage,
              label: 'Disk Usage',
              customLabel: _buildResourceLabel('Disk', _diskUsage),
              variant: _getResourceVariant(_diskUsage),
              animated: true,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildResourceLabel(String resource, double usage) {
    return Row(
      children: [
        Text(resource),
        Spacer(),
        Text('${usage.toStringAsFixed(1)}%'),
      ],
    );
  }

  FSProgressVariant _getResourceVariant(double usage) {
    if (usage < 50) return FSProgressVariant.success;
    if (usage < 80) return FSProgressVariant.warning;
    return FSProgressVariant.danger;
  }
}
```

### Using copyWith for Dynamic Updates

```dart
class DynamicProgressExample extends StatefulWidget {
  @override
  _DynamicProgressExampleState createState() => _DynamicProgressExampleState();
}

class _DynamicProgressExampleState extends State<DynamicProgressExample> {
  double _progress = 0.0;
  FSProgressVariant _variant = FSProgressVariant.primary;

  // Base progress configuration
  FlutstrapProgress get _baseProgress => FlutstrapProgress(
    value: _progress,
    animated: true,
    label: 'Processing',
  );

  void _updateProgress(double newProgress) {
    setState(() {
      _progress = newProgress;

      // Automatically update variant based on progress
      if (_progress < 30) _variant = FSProgressVariant.danger;
      else if (_progress < 70) _variant = FSProgressVariant.warning;
      else _variant = FSProgressVariant.success;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _baseProgress.copyWith(
          variant: _variant,
          customLabel: Row(
            children: [
              Text('Progress: ${_progress.toStringAsFixed(0)}%'),
              Spacer(),
              if (_progress < 100)
                FlutstrapSpinner(size: FSSpinnerSize.sm)
              else
                Icon(Icons.check_circle, color: Colors.green, size: 16),
            ],
          ),
        ),
        SizedBox(height: 16),
        Slider(
          value: _progress,
          onChanged: _updateProgress,
          min: 0,
          max: 100,
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutstrapButton(
              onPressed: () => _updateProgress(0),
              text: 'Reset',
              variant: FSButtonVariant.outlineSecondary,
            ),
            SizedBox(width: 8),
            FlutstrapButton(
              onPressed: () => _updateProgress(100),
              text: 'Complete',
              variant: FSButtonVariant.primary,
            ),
          ],
        ),
      ],
    );
  }
}
```

## Accessibility Notes

FlutstrapProgress includes comprehensive accessibility features:

- **Screen Reader Support**: Uses live region for dynamic updates
- **Semantic Labels**: Properly announces progress percentage
- **High Contrast**: All variants support high contrast modes
- **Value Indicators**: Clear visual indicators for progress states
- **ARIA Compliance**: Proper attributes for screen readers

```dart
FlutstrapProgress(
  value: 75,
  label: 'Upload Progress', // Used for semantic context
  // Automatically announces "75% complete" to screen readers
)
```

## Performance Guidelines

### Animation Optimization

```dart
// ✅ Good - Disable animation for static progress
FlutstrapProgress(
  value: 50,
  animated: false, // No unnecessary animations
)

// ✅ Good - Use longer duration for smooth animations
FlutstrapProgress(
  value: currentProgress,
  animated: true,
  animationDuration: Duration(milliseconds: 1000), // Smooth transition
)

// ❌ Avoid - Multiple striped animations simultaneously
Column(
  children: [
    FlutstrapProgress(value: 25, striped: true, animated: true),
    FlutstrapProgress(value: 50, striped: true, animated: true), // Heavy
    FlutstrapProgress(value: 75, striped: true, animated: true), // Heavy
  ],
)
```

### Layout Optimization

```dart
// ✅ Good - Use fixed width in constrained layouts
FlutstrapProgress(
  value: 60,
  fixedWidth: 200,
  expandToFill: false, // Better performance
)

// ✅ Good - Avoid expansion in lists
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) => FlutstrapProgress(
    value: items[index].progress,
    expandToFill: false, // Preents layout conflicts
  ),
)
```

## Troubleshooting

### Common Issues and Solutions

**Animation Not Working**

```dart
// Ensure animated is true and value is changing
FlutstrapProgress(
  value: _currentProgress, // Must change over time
  animated: true, // Must be true
  animationDuration: Duration(milliseconds: 500), // Reasonable duration
)

// Check if value updates trigger rebuild
setState(() {
  _currentProgress = newValue; // Must call setState
});
```

**Progress Bar Not Visible**

```dart
// Check value range and colors
FlutstrapProgress(
  value: 50, // Must be between minValue and maxValue
  minValue: 0,
  maxValue: 100,
  progressColor: Colors.blue, // Ensure sufficient contrast
  backgroundColor: Colors.grey[200],
)

// Ensure container has sufficient width
Container(
  width: double.infinity, // Or specific width
  child: FlutstrapProgress(value: 75),
)
```

**Performance Issues with Multiple Progress Bars**

```dart
// Disable animations for multiple bars
FlutstrapProgressGroup(
  children: [
    FlutstrapProgress(value: 25, animated: false),
    FlutstrapProgress(value: 50, animated: false),
    FlutstrapProgress(value: 75, animated: false),
  ],
)

// Use fixed widths
FlutstrapProgress(
  value: 60,
  fixedWidth: 300,
  expandToFill: false,
)
```

**Validation Errors**

```dart
// Use custom validator for complex ranges
FlutstrapProgress(
  value: _customValue,
  minValue: -100,
  maxValue: 100,
  validator: (value, min, max) {
    return value >= min && value <= max && !value.isNaN;
  },
)
```

This comprehensive guide covers all aspects of using the FlutstrapProgress component. The progress bar system is designed to be highly flexible, performant, and accessible while providing a robust solution for displaying progress indicators in various application contexts.
