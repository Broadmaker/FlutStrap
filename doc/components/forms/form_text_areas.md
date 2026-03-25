# Flutstrap TextArea Component Guide

## Introduction

Flutstrap TextArea is a high-performance, accessible multi-line text input field with comprehensive validation, auto-resize, and optimized rendering patterns. It provides a robust solution for long-form text input in Flutter applications with enterprise-grade performance and accessibility features.

**This comprehensive guide covers all aspects of using the Flutstrap TextArea component. The textarea system is designed to be highly flexible, performant, and accessible while providing a robust solution for multi-line text input across various content types, validation requirements, and design contexts.**

### What It Does

- Provides customizable multi-line text input with auto-resize capabilities
- Supports character counting, validation states, and helper text
- Offers multiple size variants and visual styling options
- Includes accessibility features and performance optimizations

### When to Use

- Long-form text input (descriptions, comments, notes, bios)
- Content editing with character limits
- Forms requiring multi-line user input
- Applications needing auto-resizing text areas

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

### Simple TextArea

```dart
FlutstrapTextArea(
  label: 'Description',
  placeholder: 'Enter your description...',
  rows: 4,
)
```

### TextArea with Character Counter

```dart
FlutstrapTextArea(
  label: 'Bio',
  maxLength: 500,
  showCharacterCounter: true,
  rows: 3,
  placeholder: 'Tell us about yourself...',
)
```

### Auto-Resizing TextArea

```dart
FlutstrapTextArea(
  label: 'Notes',
  autoResize: true,
  placeholder: 'Start typing... your textarea will grow automatically',
)
```

### Programmatic Control

```dart
final textareaKey = GlobalKey<FlutstrapTextAreaState>();

FlutstrapTextArea(
  key: textareaKey,
  label: 'Controlled textarea',
)

// Later in your code...
void _handleAction() {
  textareaKey.currentState?.clear();
  textareaKey.currentState?.focus();
  textareaKey.currentState?.value = 'New content';
}
```

## Component Variants

### Visual Variants

Flutstrap TextArea provides 6 visual variants to convey different states and meanings:

```dart
// Primary (default) - standard textarea
FlutstrapTextArea(
  variant: FSTextAreaVariant.primary,
  label: 'Primary TextArea',
)

// Success - for valid/approved content
FlutstrapTextArea(
  variant: FSTextAreaVariant.success,
  label: 'Success TextArea',
)

// Danger - for error states (auto-applied when validation fails)
FlutstrapTextArea(
  variant: FSTextAreaVariant.danger,
  label: 'Error TextArea',
)

// Warning - for cautionary content
FlutstrapTextArea(
  variant: FSTextAreaVariant.warning,
  label: 'Warning TextArea',
)

// Info - for informational content
FlutstrapTextArea(
  variant: FSTextAreaVariant.info,
  label: 'Info TextArea',
)

// Secondary - alternative styling
FlutstrapTextArea(
  variant: FSTextAreaVariant.secondary,
  label: 'Secondary TextArea',
)
```

### Size Variants

```dart
// Small - compact for dense interfaces
FlutstrapTextArea(
  size: FSTextAreaSize.sm,
  label: 'Small TextArea',
  rows: 2,
)

// Medium - standard size (default)
FlutstrapTextArea(
  size: FSTextAreaSize.md,
  label: 'Medium TextArea',
  rows: 4,
)

// Large - for better readability
FlutstrapTextArea(
  size: FSTextAreaSize.lg,
  label: 'Large TextArea',
  rows: 6,
)
```

## Properties & Parameters

### Parameter Reference Table

| Parameter              | Type                     | Default   | Description                         |
| ---------------------- | ------------------------ | --------- | ----------------------------------- |
| `controller`           | `TextEditingController?` | `null`    | Controls the textarea's content     |
| `initialValue`         | `String?`                | `null`    | Initial text content                |
| `label`                | `String?`                | `null`    | Textarea label                      |
| `placeholder`          | `String?`                | `null`    | Placeholder text                    |
| `helperText`           | `String?`                | `null`    | Helper text below textarea          |
| `disabled`             | `bool`                   | `false`   | Disable the textarea                |
| `readonly`             | `bool`                   | `false`   | Make textarea read-only             |
| `required`             | `bool`                   | `false`   | Mark field as required              |
| `showValidation`       | `bool`                   | `false`   | Show validation state               |
| `isValid`              | `bool`                   | `true`    | Validation state                    |
| `validationMessage`    | `String?`                | `null`    | Validation error message            |
| `maxLength`            | `int?`                   | `null`    | Maximum character limit             |
| `showCharacterCounter` | `bool`                   | `false`   | Show character counter              |
| `rows`                 | `int`                    | `3`       | Initial number of rows              |
| `autoResize`           | `bool`                   | `false`   | Auto-adjust height based on content |
| `size`                 | `FSTextAreaSize`         | `md`      | Textarea size (sm, md, lg)          |
| `variant`              | `FSTextAreaVariant`      | `primary` | Visual style variant                |
| `onChanged`            | `ValueChanged<String>?`  | `null`    | Text change callback                |
| `onSubmitted`          | `ValueChanged<String>?`  | `null`    | Submit callback                     |
| `focusNode`            | `FocusNode?`             | `null`    | Focus management                    |
| `textInputAction`      | `TextInputAction?`       | `null`    | Keyboard action button              |
| `padding`              | `EdgeInsetsGeometry?`    | `null`    | Custom padding                      |
| `showLabel`            | `bool`                   | `true`    | Show/hide label                     |
| `semanticLabel`        | `String?`                | `null`    | Accessibility label                 |
| `resizeDelay`          | `Duration`               | `100ms`   | Auto-resize debounce delay          |

### FSTextAreaVariant Enum

```dart
enum FSTextAreaVariant {
  primary,    // Blue theme - standard input
  secondary,  // Gray theme - alternative styling
  success,    // Green theme - positive/valid states
  danger,     // Red theme - error states
  warning,    // Yellow theme - cautionary states
  info,       // Blue theme - informational states
}
```

### FSTextAreaSize Enum

```dart
enum FSTextAreaSize {
  sm,  // Compact - smaller padding and font
  md,  // Medium - standard padding and font
  lg,  // Large - larger padding and font for better readability
}
```

## Customization

### Styling and Appearance

```dart
FlutstrapTextArea(
  label: 'Custom Styled TextArea',
  placeholder: 'Enter your content here...',
  variant: FSTextAreaVariant.primary,
  size: FSTextAreaSize.lg,
  rows: 5,
  helperText: 'This is a custom styled text area',
  padding: EdgeInsets.all(16),
)
```

### Validation and Character Limits

```dart
FlutstrapTextArea(
  label: 'Product Description',
  placeholder: 'Describe your product...',
  maxLength: 1000,
  showCharacterCounter: true,
  showValidation: true,
  isValid: _isDescriptionValid,
  validationMessage: 'Description must be between 50 and 1000 characters',
  helperText: 'Provide a detailed description of your product',
)
```

### Auto-Resize Configuration

```dart
FlutstrapTextArea(
  label: 'Dynamic Notes',
  placeholder: 'Type here... the textarea will grow with your content',
  autoResize: true,
  resizeDelay: Duration(milliseconds: 200), // Custom debounce delay
  // rows parameter is ignored when autoResize is true
)
```

## Interactivity & Behavior

### Form Integration with Validation

```dart
class TextAreaFormExample extends StatefulWidget {
  @override
  _TextAreaFormExampleState createState() => _TextAreaFormExampleState();
}

class _TextAreaFormExampleState extends State<TextAreaFormExample> {
  final GlobalKey<FlutstrapTextAreaState> _descriptionKey = GlobalKey();
  final GlobalKey<FlutstrapTextAreaState> _notesKey = GlobalKey();
  bool _showValidation = false;

  void _validateForm() {
    setState(() {
      _showValidation = true;
    });

    final descriptionValid = _descriptionKey.currentState?.isValid ?? false;
    final notesValid = _notesKey.currentState?.isValid ?? false;

    if (descriptionValid && notesValid) {
      _submitForm();
    }
  }

  void _submitForm() {
    final description = _descriptionKey.currentState?.value ?? '';
    final notes = _notesKey.currentState?.value ?? '';

    print('Description: $description');
    print('Notes: $notes');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FlutstrapTextArea(
          key: _descriptionKey,
          label: 'Product Description',
          required: true,
          maxLength: 500,
          showCharacterCounter: true,
          showValidation: _showValidation,
          isValid: _descriptionKey.currentState?.value.length ?? 0 > 10,
          validationMessage: 'Description must be at least 10 characters',
          helperText: 'Describe your product in detail',
          rows: 4,
        ),

        SizedBox(height: 24),

        FlutstrapTextArea(
          key: _notesKey,
          label: 'Additional Notes',
          autoResize: true,
          placeholder: 'Any additional information...',
          helperText: 'Optional notes about your product',
        ),

        SizedBox(height: 24),

        FlutstrapButton(
          onPressed: _validateForm,
          child: Text('Submit'),
          size: FSSize.lg,
        ),
      ],
    );
  }
}
```

### Dynamic Content Management

```dart
class DynamicTextArea extends StatefulWidget {
  @override
  _DynamicTextAreaState createState() => _DynamicTextAreaState();
}

class _DynamicTextAreaState extends State<DynamicTextArea> {
  final GlobalKey<FlutstrapTextAreaState> _textareaKey = GlobalKey();
  bool _isLoading = false;

  void _loadTemplate() async {
    setState(() => _isLoading = true);

    // Simulate API call
    await Future.delayed(Duration(seconds: 1));

    if (_textareaKey.currentState != null) {
      _textareaKey.currentState!.value = '''
Thank you for your inquiry about our services.

We specialize in:
- Custom Flutter development
- UI/UX design
- Performance optimization
- Enterprise solutions

Please let us know your specific requirements and we'll be happy to assist you.
''';
    }

    setState(() => _isLoading = false);
  }

  void _clearContent() {
    _textareaKey.currentState?.clear();
  }

  void _analyzeContent() {
    final content = _textareaKey.currentState?.value ?? '';
    final charCount = _textareaKey.currentState?.characterCount ?? 0;
    final usage = _textareaKey.currentState?.characterUsage ?? 0;

    print('Content length: $charCount characters');
    print('Usage percentage: ${(usage * 100).toStringAsFixed(1)}%');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FlutstrapTextArea(
          key: _textareaKey,
          label: 'Email Template',
          autoResize: true,
          maxLength: 2000,
          showCharacterCounter: true,
          placeholder: 'Start typing or load a template...',
          helperText: 'Create your email template here',
        ),

        SizedBox(height: 16),

        Row(
          children: [
            FlutstrapButton(
              onPressed: _isLoading ? null : _loadTemplate,
              child: _isLoading
                  ? SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text('Load Template'),
              variant: FSButtonVariant.outline,
            ),

            SizedBox(width: 8),

            FlutstrapButton(
              onPressed: _clearContent,
              child: Text('Clear'),
              variant: FSButtonVariant.secondary,
            ),

            Spacer(),

            FlutstrapButton(
              onPressed: _analyzeContent,
              child: Text('Analyze'),
              variant: FSButtonVariant.info,
            ),
          ],
        ),
      ],
    );
  }
}
```

## Accessibility Notes

Flutstrap TextArea includes comprehensive accessibility features:

- **Screen Reader Support**: Full semantic labels for textarea content and states
- **Keyboard Navigation**: Proper focus management and keyboard interaction
- **Character Counter Announcements**: Screen readers announce character count changes
- **Validation State Announcements**: Proper announcements for validation errors
- **High Contrast Support**: Meets WCAG contrast guidelines for all states

```dart
FlutstrapTextArea(
  label: 'Product Description',
  semanticLabel: 'Product description field for detailed product information',
  helperText: 'Describe the product features and benefits',
  maxLength: 500,
  showCharacterCounter: true,
  showValidation: true,
  validationMessage: 'Description must be between 50 and 500 characters',
)
```

## Integration Examples

### Complete Contact Form with TextArea

```dart
class ContactForm extends StatefulWidget {
  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final GlobalKey<FlutstrapTextAreaState> _messageKey = GlobalKey();
  final GlobalKey<FlutstrapInputState> _nameKey = GlobalKey();
  final GlobalKey<FlutstrapInputState> _emailKey = GlobalKey();
  bool _isSubmitting = false;

  void _submitForm() async {
    final messageValid = _messageKey.currentState?.isValid ?? false;
    final nameValid = _nameKey.currentState?.isValid ?? false;
    final emailValid = _emailKey.currentState?.isValid ?? false;

    if (!messageValid || !nameValid || !emailValid) {
      // Show validation errors
      return;
    }

    setState(() => _isSubmitting = true);

    // Simulate form submission
    await Future.delayed(Duration(seconds: 2));

    setState(() => _isSubmitting = false);
    // Show success message
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contact Us',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),

          SizedBox(height: 8),

          Text(
            'Have questions? We\'d love to hear from you.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
          ),

          SizedBox(height: 24),

          FlutstrapFormGroup(
            label: 'Your Information',
            layout: FSFormGroupLayout.horizontal,
            children: [
              Expanded(
                child: FlutstrapInput(
                  key: _nameKey,
                  labelText: 'Full Name',
                  required: true,
                  validator: (value) {
                    if (value!.isEmpty) return 'Name is required';
                    return null;
                  },
                ),
              ),

              SizedBox(width: 16),

              Expanded(
                child: FlutstrapInput(
                  key: _emailKey,
                  labelText: 'Email Address',
                  required: true,
                  validator: (value) {
                    if (value!.isEmpty) return 'Email is required';
                    if (!value.contains('@')) return 'Invalid email format';
                    return null;
                  },
                ),
              ),
            ],
          ),

          SizedBox(height: 24),

          FlutstrapTextArea(
            key: _messageKey,
            label: 'Your Message',
            required: true,
            maxLength: 1000,
            showCharacterCounter: true,
            rows: 6,
            placeholder: 'How can we help you?',
            helperText: 'Please provide detailed information about your inquiry',
            validator: (value) {
              if (value!.isEmpty) return 'Message is required';
              if (value.length < 20) return 'Message is too short';
              return null;
            },
          ),

          SizedBox(height: 32),

          FlutstrapButton(
            onPressed: _isSubmitting ? null : _submitForm,
            child: _isSubmitting
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text('Send Message'),
            size: FSSize.lg,
          ),
        ],
      ),
    );
  }
}
```

### Rich Text Editor Simulation

```dart
class RichTextEditor extends StatefulWidget {
  @override
  _RichTextEditorState createState() => _RichTextEditorState();
}

class _RichTextEditorState extends State<RichTextEditor> {
  final GlobalKey<FlutstrapTextAreaState> _editorKey = GlobalKey();
  final List<String> _templates = [
    'Meeting Notes Template',
    'Project Update Template',
    'Client Report Template',
  ];
  String _selectedTemplate = 'Meeting Notes Template';

  void _loadTemplate() {
    final templateContent = _getTemplateContent(_selectedTemplate);
    _editorKey.currentState?.value = templateContent;
  }

  String _getTemplateContent(String template) {
    switch (template) {
      case 'Meeting Notes Template':
        return '''Meeting Notes

Date: ${DateTime.now().toString().split(' ')[0]}
Attendees:
-
-

Agenda:
1.
2.
3.

Action Items:
-
-

Next Meeting:''';

      case 'Project Update Template':
        return '''Project Update

Project: [Project Name]
Date: ${DateTime.now().toString().split(' ')[0]}

This Week's Progress:
-
-

Next Week's Plan:
-
-

Blockers/Issues:
-
- ''';

      case 'Client Report Template':
        return '''Client Report

Client: [Client Name]
Period: [Date Range]

Summary:
[Brief summary of work completed]

Key Accomplishments:
-
-

Next Steps:
-
-

Questions/Feedback:''';

      default:
        return '';
    }
  }

  void _exportContent() {
    final content = _editorKey.currentState?.value ?? '';
    if (content.isNotEmpty) {
      // Simulate export functionality
      print('Exporting content: ${content.length} characters');
      // In a real app, this might save to a file or share
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: FlutstrapDropdown(
                labelText: 'Template',
                items: _templates,
                value: _selectedTemplate,
                onChanged: (value) => setState(() => _selectedTemplate = value!),
              ),
            ),

            SizedBox(width: 12),

            FlutstrapButton(
              onPressed: _loadTemplate,
              child: Text('Load Template'),
              variant: FSButtonVariant.outline,
            ),

            SizedBox(width: 8),

            FlutstrapButton(
              onPressed: _exportContent,
              child: Text('Export'),
              variant: FSButtonVariant.primary,
            ),
          ],
        ),

        SizedBox(height: 16),

        FlutstrapTextArea(
          key: _editorKey,
          label: 'Editor',
          autoResize: true,
          placeholder: 'Start writing or load a template...',
          helperText: 'Use templates for consistent formatting',
          size: FSTextAreaSize.lg,
        ),

        SizedBox(height: 16),

        Row(
          children: [
            Text(
              'Word Count: ${_editorKey.currentState?.value.split(RegExp(r'\s+')).where((word) => word.isNotEmpty).length ?? 0}',
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),

            Spacer(),

            Text(
              'Character Count: ${_editorKey.currentState?.characterCount ?? 0}',
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }
}
```

## Performance Optimization

### Auto-Resize Best Practices

```dart
// ✅ GOOD: Appropriate resize delay for typing performance
FlutstrapTextArea(
  autoResize: true,
  resizeDelay: Duration(milliseconds: 150), // Balanced performance
  // ...
)

// ✅ BETTER: Longer delay for better performance during rapid typing
FlutstrapTextArea(
  autoResize: true,
  resizeDelay: Duration(milliseconds: 300), // Better performance
  // ...
)

// ❌ AVOID: Very short delays that may cause performance issues
FlutstrapTextArea(
  autoResize: true,
  resizeDelay: Duration.zero, // May cause jank during typing
  // ...
)
```

### Efficient State Management

```dart
// ✅ GOOD: Using keys for programmatic control
final _editorKey = GlobalKey<FlutstrapTextAreaState>();

FlutstrapTextArea(
  key: _editorKey,
  // ...
)

// Efficient operations
void _performOperations() {
  _editorKey.currentState?.clear();
  _editorKey.currentState?.focus();
  final content = _editorKey.currentState?.value;
}

// ✅ GOOD: Using controllers for complex scenarios
final _textController = TextEditingController();

FlutstrapTextArea(
  controller: _textController,
  // ...
)
```

## Best Practices

### Character Limit Guidelines

```dart
// ✅ GOOD: Appropriate character limits with helpful messaging
FlutstrapTextArea(
  label: 'Product Description',
  maxLength: 500,
  showCharacterCounter: true,
  helperText: 'Ideal length: 50-500 characters',
  validator: (value) {
    if (value!.isEmpty) return 'Description is required';
    if (value.length < 50) return 'Please provide more details (minimum 50 characters)';
    if (value.length > 500) return 'Description is too long (maximum 500 characters)';
    return null;
  },
)

// ✅ GOOD: Color-coded character counter for better UX
FlutstrapTextArea(
  maxLength: 280,
  showCharacterCounter: true,
  // Counter automatically changes color based on usage
)
```

### Auto-Resize Usage Patterns

```dart
// ✅ VERTICAL SCROLL: For fixed-size content areas
FlutstrapTextArea(
  rows: 6,
  autoResize: false, // Fixed height with scroll
  // Good for forms with limited space
)

// ✅ AUTO-RESIZE: For dynamic content that should be fully visible
FlutstrapTextArea(
  autoResize: true, // Grows with content
  // Good for notes, comments, content editors
)

// ✅ COMBINATION: Auto-resize with maximum rows
Container(
  constraints: BoxConstraints(maxHeight: 300),
  child: FlutstrapTextArea(
    autoResize: true,
    // Will auto-resize up to container constraint
  ),
)
```

## Troubleshooting

### Common Issues and Solutions

**Auto-Resize Not Working**

```dart
// ❌ Conflicting constraints
Container(
  height: 200, // Fixed height conflicts with auto-resize
  child: FlutstrapTextArea(
    autoResize: true,
  ),
)

// ✅ Correct: Allow container to size naturally
Container(
  constraints: BoxConstraints(maxHeight: 400), // Maximum but not fixed
  child: FlutstrapTextArea(
    autoResize: true,
  ),
)

// OR use without container constraints
FlutstrapTextArea(
  autoResize: true,
)
```

**Performance Issues with Large Content**

```dart
// ❌ Very large content without optimization
FlutstrapTextArea(
  autoResize: true,
  // With thousands of lines, may cause performance issues
)

// ✅ Better: Use fixed height with scroll for very large content
FlutstrapTextArea(
  rows: 10,
  autoResize: false, // Fixed height with scroll
  // Better performance for large documents
)

// OR implement virtualized scrolling for extremely large content
```

**Character Counter Not Updating**

```dart
// ❌ Missing state management for dynamic updates
FlutstrapTextArea(
  showCharacterCounter: true,
  maxLength: 100,
  // Counter updates automatically - no extra code needed
)

// ✅ Correct: The component handles counter updates automatically
// No additional state management required
```

### Debugging Tips

1. **Check Auto-Resize Constraints**: Ensure parent widgets don't impose fixed heights
2. **Monitor Performance**: Use Flutter DevTools to check resize performance
3. **Test Accessibility**: Use screen readers to verify semantic announcements
4. **Verify Character Counting**: Test with various content lengths and unicode characters
5. **Check Focus Management**: Ensure proper keyboard navigation and focus indicators

---

**This comprehensive guide covers all aspects of using the Flutstrap TextArea component. The textarea system is designed to be highly flexible, performant, and accessible while providing a robust solution for multi-line text input across various content types, validation requirements, and design contexts. With features like auto-resize, character counting, and comprehensive accessibility, Flutstrap TextArea offers enterprise-grade text input capabilities for modern Flutter applications.**
