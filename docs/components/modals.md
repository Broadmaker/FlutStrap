# Flutstrap Modal Component Guide

## Introduction

The **FlutstrapModal** is a customizable modal dialog with Bootstrap-inspired styling, multiple variants, sizes, and built-in service methods for common modal patterns. It provides a comprehensive modal solution with proper accessibility, focus management, and flexible content organization.

### What the Component Does

FlutstrapModal offers:

- Multiple visual variants (8 color options)
- Four size options (sm, md, lg, xl)
- Built-in service methods for common patterns
- Proper header, content, and action sections
- Accessibility and keyboard navigation support
- Dismissible and non-dismissible modes
- Customizable styling and layout

### When and Why to Use It

Use FlutstrapModal when you need:

- Confirmation dialogs for user actions
- Alert messages and notifications
- Form inputs in modal dialogs
- Detailed information displays
- User settings or preferences
- Any content that requires user attention

### Prerequisites

- Flutter 3.0 or higher
- Flutstrap theme package
- Material Design Icons

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

### Basic Modal with Custom Content

```dart
void _showBasicModal(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => FlutstrapModal(
      title: Text('User Profile'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage('https://picsum.photos/200'),
          ),
          SizedBox(height: 16),
          Text('John Doe', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text('john.doe@example.com', style: TextStyle(color: Colors.grey)),
          SizedBox(height: 8),
          Text('Software Developer', style: TextStyle(color: Colors.blue)),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Close'),
        ),
      ],
    ),
  );
}
```

### Using Modal Service

```dart
void _showConfirmationModal(BuildContext context) {
  FlutstrapModalService.showConfirmModal(
    context: context,
    title: 'Delete Item',
    content: 'This action cannot be undone. Are you sure you want to delete this item?',
    confirmText: 'Delete',
    cancelText: 'Cancel',
    variant: FSModalVariant.danger,
  ).then((confirmed) {
    if (confirmed) {
      // Perform deletion
      _deleteItem();
    }
  });
}
```

## Component Variants

FlutstrapModal offers 8 visual variants that affect the header color:

### Primary

```dart
FlutstrapModal(
  title: Text('Primary Modal'),
  content: Text('This is a primary modal.'),
  variant: FSModalVariant.primary,
)
```

### Secondary

```dart
FlutstrapModal(
  title: Text('Secondary Modal'),
  content: Text('This is a secondary modal.'),
  variant: FSModalVariant.secondary,
)
```

### Success

```dart
FlutstrapModal(
  title: Text('Success Modal'),
  content: Text('This is a success modal.'),
  variant: FSModalVariant.success,
)
```

### Danger

```dart
FlutstrapModal(
  title: Text('Danger Modal'),
  content: Text('This is a danger modal.'),
  variant: FSModalVariant.danger,
)
```

### Warning

```dart
FlutstrapModal(
  title: Text('Warning Modal'),
  content: Text('This is a warning modal.'),
  variant: FSModalVariant.warning,
)
```

### Info

```dart
FlutstrapModal(
  title: Text('Info Modal'),
  content: Text('This is an info modal.'),
  variant: FSModalVariant.info,
)
```

### Light

```dart
FlutstrapModal(
  title: Text('Light Modal'),
  content: Text('This is a light modal.'),
  variant: FSModalVariant.light,
)
```

### Dark

```dart
FlutstrapModal(
  title: Text('Dark Modal'),
  content: Text('This is a dark modal.'),
  variant: FSModalVariant.dark,
)
```

## Modal Sizes

### Small (sm) - 300px

```dart
FlutstrapModal(
  title: Text('Small Modal'),
  content: Text('This is a small modal. Perfect for simple confirmations.'),
  size: FSModalSize.sm,
)
```

### Medium (md) - 500px (Default)

```dart
FlutstrapModal(
  title: Text('Medium Modal'),
  content: Text('This is a medium modal. Good for most use cases.'),
  size: FSModalSize.md,
)
```

### Large (lg) - 800px

```dart
FlutstrapModal(
  title: Text('Large Modal'),
  content: Text('This is a large modal. Use for complex content.'),
  size: FSModalSize.lg,
)
```

### Extra Large (xl) - 1140px

```dart
FlutstrapModal(
  title: Text('Extra Large Modal'),
  content: Text('This is an extra large modal. Use for very complex content.'),
  size: FSModalSize.xl,
)
```

## Properties & Parameters

### Parameter Reference Table

| Parameter         | Type                    | Default   | Description                      |
| ----------------- | ----------------------- | --------- | -------------------------------- |
| `title`           | `Widget?`               | `null`    | Modal title widget               |
| `content`         | `Widget?`               | `null`    | Modal content widget             |
| `actions`         | `List<Widget>?`         | `null`    | Action buttons in footer         |
| `dismissible`     | `bool`                  | `true`    | Whether modal can be dismissed   |
| `showCloseButton` | `bool`                  | `true`    | Whether to show close button     |
| `onDismiss`       | `VoidCallback?`         | `null`    | Callback when modal is dismissed |
| `variant`         | `FSModalVariant`        | `primary` | Visual style variant             |
| `size`            | `FSModalSize`           | `md`      | Modal size (sm, md, lg, xl)      |
| `backgroundColor` | `Color?`                | `null`    | Custom background color          |
| `elevation`       | `double?`               | `null`    | Custom elevation                 |
| `borderRadius`    | `BorderRadiusGeometry?` | `null`    | Custom border radius             |
| `padding`         | `EdgeInsetsGeometry?`   | `null`    | Custom content padding           |

### FSModalVariant Enum

```dart
enum FSModalVariant {
  primary, secondary, success, danger, warning, info, light, dark
}
```

### FSModalSize Enum

```dart
enum FSModalSize {
  sm,  // 300px width
  md,  // 500px width
  lg,  // 800px width
  xl   // 1140px width
}
```

## Modal Service Methods

### Show Basic Modal

```dart
FlutstrapModalService.showModal(
  context: context,
  title: 'Information',
  content: 'This is a basic modal with default actions.',
  variant: FSModalVariant.info,
  size: FSModalSize.md,
)
```

### Show Confirmation Modal

```dart
FlutstrapModalService.showConfirmModal(
  context: context,
  title: 'Confirm Action',
  content: 'Are you sure you want to proceed?',
  confirmText: 'Yes, Proceed',
  cancelText: 'No, Cancel',
  variant: FSModalVariant.warning,
).then((confirmed) {
  if (confirmed) {
    print('User confirmed');
  } else {
    print('User cancelled');
  }
});
```

### Show Alert Modal

```dart
FlutstrapModalService.showAlert(
  context: context,
  title: 'Important Notice',
  content: 'Please review the changes before proceeding.',
  variant: FSModalVariant.warning,
)
```

### Show Success Modal

```dart
FlutstrapModalService.showSuccess(
  context: context,
  title: 'Success!',
  content: 'Your changes have been saved successfully.',
)
```

### Show Error Modal

```dart
FlutstrapModalService.showError(
  context: context,
  title: 'Error Occurred',
  content: 'There was a problem saving your changes. Please try again.',
)
```

### Show Custom Modal

```dart
FlutstrapModalService.showCustomModal(
  context: context,
  title: Text('Custom Modal'),
  content: Column(
    children: [
      Text('This is a custom modal with complex content.'),
      SizedBox(height: 16),
      TextField(decoration: InputDecoration(labelText: 'Name')),
      TextField(decoration: InputDecoration(labelText: 'Email')),
    ],
  ),
  actions: [
    TextButton(
      onPressed: () => Navigator.pop(context),
      child: Text('Cancel'),
    ),
    FilledButton(
      onPressed: () => Navigator.pop(context),
      child: Text('Save'),
    ),
  ],
  variant: FSModalVariant.primary,
  size: FSModalSize.lg,
)
```

## Advanced Usage

### Form in Modal

```dart
void _showFormModal(BuildContext context) {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) => FlutstrapModal(
      title: Text('Contact Form'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Full Name',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'Email Address',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            maxLines: 3,
            decoration: InputDecoration(
              labelText: 'Message',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            // Handle form submission
            _submitForm(nameController.text, emailController.text);
            Navigator.pop(context);
          },
          child: Text('Submit'),
        ),
      ],
      size: FSModalSize.md,
    ),
  );
}
```

### List Content in Modal

```dart
void _showListModal(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => FlutstrapModal(
      title: Text('Select Item'),
      content: Container(
        height: 200,
        child: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) => ListTile(
            leading: CircleAvatar(child: Text('${index + 1}')),
            title: Text('Item ${index + 1}'),
            subtitle: Text('Description for item ${index + 1}'),
            onTap: () {
              Navigator.pop(context, index);
            },
          ),
        ),
      ),
      size: FSModalSize.sm,
    ),
  ).then((selectedIndex) {
    if (selectedIndex != null) {
      print('Selected item: $selectedIndex');
    }
  });
}
```

### Non-dismissible Modal

```dart
void _showRequiredActionModal(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevent closing by tapping outside
    builder: (context) => FlutstrapModal(
      title: Text('Required Action'),
      content: Text('You must complete this action to continue.'),
      actions: [
        FilledButton(
          onPressed: () {
            // Perform required action
            _completeAction();
            Navigator.pop(context);
          },
          child: Text('I Understand'),
        ),
      ],
      dismissible: false, // Also prevent close button
      showCloseButton: false, // Hide close button
    ),
  );
}
```

## Customization

### Custom Styling

```dart
FlutstrapModal(
  title: Text('Custom Styled Modal'),
  content: Text('This modal has custom styling.'),
  backgroundColor: Colors.grey[50],
  elevation: 16.0,
  borderRadius: BorderRadius.circular(20),
  padding: EdgeInsets.all(32),
)
```

### Using copyWith for Modifications

```dart
// Base modal
final baseModal = FlutstrapModal(
  title: Text('Base Modal'),
  content: Text('This is the base content.'),
);

// Modified versions
final successModal = baseModal.success();
final largeModal = baseModal.large();
final dangerModal = baseModal.danger();
final customModal = baseModal.copyWith(
  title: Text('Custom Title'),
  content: Text('Custom content'),
  variant: FSModalVariant.info,
);
```

### Modal Trigger Widget

```dart
FlutstrapModalTrigger(
  modalTitle: Text('Profile Information'),
  modalContent: Column(
    children: [
      CircleAvatar(radius: 40),
      Text('John Doe'),
      Text('Software Developer'),
    ],
  ),
  modalActions: [
    TextButton(
      onPressed: () => Navigator.pop(context),
      child: Text('Close'),
    ),
  ],
  child: ListTile(
    leading: Icon(Icons.person),
    title: Text('View Profile'),
    trailing: Icon(Icons.arrow_forward),
  ),
)
```

## Integration Examples

### Settings Modal

```dart
void _showSettingsModal(BuildContext context) {
  bool notificationsEnabled = true;
  bool darkModeEnabled = false;

  showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) => FlutstrapModal(
        title: Text('Settings'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Push Notifications'),
              trailing: Switch(
                value: notificationsEnabled,
                onChanged: (value) => setState(() => notificationsEnabled = value),
              ),
            ),
            ListTile(
              leading: Icon(Icons.dark_mode),
              title: Text('Dark Mode'),
              trailing: Switch(
                value: darkModeEnabled,
                onChanged: (value) => setState(() => darkModeEnabled = value),
              ),
            ),
            ListTile(
              leading: Icon(Icons.language),
              title: Text('Language'),
              trailing: Text('English'),
              onTap: () => _showLanguageModal(context),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              _saveSettings(notificationsEnabled, darkModeEnabled);
              Navigator.pop(context);
            },
            child: Text('Save'),
          ),
        ],
        size: FSModalSize.md,
      ),
    ),
  );
}
```

### Product Selection Modal

```dart
void _showProductModal(BuildContext context) {
  int selectedProduct = 0;

  showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) => FlutstrapModal(
        title: Text('Choose a Plan'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildPlanCard(
              context: context,
              title: 'Basic',
              price: '\$9/month',
              features: ['10 Projects', '5GB Storage', 'Basic Support'],
              isSelected: selectedProduct == 0,
              onTap: () => setState(() => selectedProduct = 0),
            ),
            SizedBox(height: 12),
            _buildPlanCard(
              context: context,
              title: 'Pro',
              price: '\$29/month',
              features: ['50 Projects', '50GB Storage', 'Priority Support'],
              isSelected: selectedProduct == 1,
              onTap: () => setState(() => selectedProduct = 1),
            ),
            SizedBox(height: 12),
            _buildPlanCard(
              context: context,
              title: 'Enterprise',
              price: 'Custom',
              features: ['Unlimited Projects', '1TB Storage', '24/7 Support'],
              isSelected: selectedProduct == 2,
              onTap: () => setState(() => selectedProduct = 2),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              _selectPlan(selectedProduct);
              Navigator.pop(context);
            },
            child: Text('Select Plan'),
          ),
        ],
        size: FSModalSize.lg,
      ),
    ),
  );
}

Widget _buildPlanCard({
  required BuildContext context,
  required String title,
  required String price,
  required List<String> features,
  required bool isSelected,
  required VoidCallback onTap,
}) {
  return Card(
    color: isSelected ? Theme.of(context).primaryColor.withOpacity(0.1) : null,
    child: ListTile(
      contentPadding: EdgeInsets.all(16),
      leading: Icon(
        isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
        color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
      ),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(price, style: TextStyle(fontSize: 16)),
          SizedBox(height: 8),
          ...features.map((feature) => Text('• $feature')),
        ],
      ),
      onTap: onTap,
    ),
  );
}
```

## Accessibility Notes

FlutstrapModal includes comprehensive accessibility features:

- **Screen Reader Support**: Uses proper semantic labels and route naming
- **Keyboard Navigation**: Full support for Tab, Enter, Escape keys
- **Focus Management**: Proper focus trapping within modal
- **Close Button**: Proper semantic label for close button
- **ARIA Attributes**: Announces modal state to screen readers

```dart
FlutstrapModal(
  title: Text('Accessible Modal'), // Used for semantic label
  content: Text('This modal is fully accessible.'),
  // Automatically handles focus management and keyboard navigation
)
```

## Best Practices

### Modal Content Guidelines

- **Keep it Focused**: Modals should have a single primary purpose
- **Clear Actions**: Use clear, action-oriented button text
- **Appropriate Size**: Choose modal size based on content complexity
- **Consistent Variants**: Use variant colors consistently (success for positive, danger for destructive, etc.)

### User Experience

```dart
// ✅ Good - Clear purpose and actions
FlutstrapModalService.showConfirmModal(
  title: 'Delete Project',
  content: 'This will permanently delete the project and all its data.',
  confirmText: 'Delete', // Clear destructive action
  cancelText: 'Keep', // Clear safe action
  variant: FSModalVariant.danger, // Appropriate color for destructive action
)

// ❌ Avoid - Vague purpose
FlutstrapModalService.showModal(
  title: 'Action Required',
  content: 'Please make a selection.', // Too vague
)
```

### Performance Considerations

- **Avoid Heavy Content**: Keep modal content reasonably lightweight
- **Use Appropriate Size**: Don't use xl size for simple confirmations
- **Dispose Controllers**: Properly dispose controllers in stateful modals

## Troubleshooting

### Common Issues and Solutions

**Modal Not Closing**

```dart
// Ensure you're using the correct context
showDialog(
  context: context, // Must be BuildContext from widget tree
  builder: (context) => FlutstrapModal(
    actions: [
      TextButton(
        onPressed: () => Navigator.of(context).pop(), // Use same context
        child: Text('Close'),
      ),
    ],
  ),
)
```

**Modal Too Large for Screen**

```dart
// Use appropriate size for screen
FlutstrapModal(
  content: yourContent,
  size: MediaQuery.of(context).size.width < 600
      ? FSModalSize.sm
      : FSModalSize.md,
)
```

**Actions Not Aligning Properly**

```dart
// Ensure actions are properly structured
FlutstrapModal(
  actions: [
    TextButton(...), // First action
    SizedBox(width: 8), // Proper spacing
    FilledButton(...), // Second action
  ],
)
```

**Accessibility Issues**

```dart
// Provide proper titles for screen readers
FlutstrapModal(
  title: Text('User Settings'), // Used as semantic label
  content: yourContent,
)
```

This comprehensive guide covers all aspects of using the FlutstrapModal component. The modal system is designed to be highly flexible, accessible, and consistent while providing a robust solution for dialog interactions in your Flutter applications.
