# Flutstrap Dropdown Component Guide

## Introduction

The **FlutstrapDropdown** is a high-performance, customizable dropdown menu with Bootstrap-inspired styling, search functionality, and comprehensive accessibility support. It provides a robust dropdown solution that works with any data type and includes advanced features like search, custom items, and proper focus management.

### What the Component Does

FlutstrapDropdown offers:

- Type-safe dropdowns for any data type
- Search functionality with debouncing
- Custom item rendering with leading/trailing widgets
- Multiple visual variants (8 color options)
- Three size options (sm, md, lg)
- Comprehensive accessibility support
- Proper overlay management and focus handling
- Error states and helper text
- Disabled state support

### When and Why to Use It

Use FlutstrapDropdown when you need:

- Form selection with custom options
- Searchable dropdowns for large datasets
- Consistent dropdown styling across your app
- Accessible dropdown menus
- Custom item layouts (avatars, icons, etc.)
- Type-safe selection handling

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

### Simple String Dropdown

```dart
String? selectedValue;

FlutstrapDropdown<String>(
  items: [
    FSDropdownItem(value: 'option1', label: 'Option 1'),
    FSDropdownItem(value: 'option2', label: 'Option 2'),
    FSDropdownItem(value: 'option3', label: 'Option 3'),
  ],
  value: selectedValue,
  onChanged: (value) {
    setState(() {
      selectedValue = value;
    });
  },
  placeholder: 'Select an option',
)
```

### Dropdown with Custom Objects

```dart
class User {
  final String id;
  final String name;
  final String avatarUrl;

  User({required this.id, required this.name, required this.avatarUrl});
}

User? selectedUser;

FlutstrapDropdown<User>(
  items: [
    FSDropdownItem(
      value: User(id: '1', name: 'John Doe', avatarUrl: '...'),
      label: 'John Doe',
      leading: CircleAvatar(
        backgroundImage: NetworkImage('...'),
      ),
    ),
    FSDropdownItem(
      value: User(id: '2', name: 'Jane Smith', avatarUrl: '...'),
      label: 'Jane Smith',
      leading: CircleAvatar(
        backgroundImage: NetworkImage('...'),
      ),
    ),
  ],
  value: selectedUser,
  onChanged: (user) {
    setState(() {
      selectedUser = user;
    });
  },
)
```

## Component Variants

FlutstrapDropdown offers 8 visual variants that affect the border and focus colors:

### Primary

```dart
FlutstrapDropdown<String>(
  items: items,
  value: selectedValue,
  onChanged: onChanged,
  variant: FSDropdownVariant.primary,
)
```

### Secondary

```dart
FlutstrapDropdown<String>(
  items: items,
  value: selectedValue,
  onChanged: onChanged,
  variant: FSDropdownVariant.secondary,
)
```

### Success

```dart
FlutstrapDropdown<String>(
  items: items,
  value: selectedValue,
  onChanged: onChanged,
  variant: FSDropdownVariant.success,
)
```

### Danger

```dart
FlutstrapDropdown<String>(
  items: items,
  value: selectedValue,
  onChanged: onChanged,
  variant: FSDropdownVariant.danger,
)
```

### Warning

```dart
FlutstrapDropdown<String>(
  items: items,
  value: selectedValue,
  onChanged: onChanged,
  variant: FSDropdownVariant.warning,
)
```

### Info

```dart
FlutstrapDropdown<String>(
  items: items,
  value: selectedValue,
  onChanged: onChanged,
  variant: FSDropdownVariant.info,
)
```

### Light

```dart
FlutstrapDropdown<String>(
  items: items,
  value: selectedValue,
  onChanged: onChanged,
  variant: FSDropdownVariant.light,
)
```

### Dark

```dart
FlutstrapDropdown<String>(
  items: items,
  value: selectedValue,
  onChanged: onChanged,
  variant: FSDropdownVariant.dark,
)
```

## Dropdown Sizes

### Small (sm)

```dart
FlutstrapDropdown<String>(
  items: items,
  value: selectedValue,
  onChanged: onChanged,
  size: FSDropdownSize.sm,
  labelText: 'Small Dropdown',
)
```

### Medium (md) - Default

```dart
FlutstrapDropdown<String>(
  items: items,
  value: selectedValue,
  onChanged: onChanged,
  size: FSDropdownSize.md,
  labelText: 'Medium Dropdown',
)
```

### Large (lg)

```dart
FlutstrapDropdown<String>(
  items: items,
  value: selectedValue,
  onChanged: onChanged,
  size: FSDropdownSize.lg,
  labelText: 'Large Dropdown',
)
```

## Properties & Parameters

### Parameter Reference Table

| Parameter             | Type                      | Default      | Description                             |
| --------------------- | ------------------------- | ------------ | --------------------------------------- |
| `items`               | `List<FSDropdownItem<T>>` | **Required** | List of dropdown items                  |
| `value`               | `T?`                      | `null`       | Currently selected value                |
| `onChanged`           | `ValueChanged<T?>?`       | `null`       | Callback when selection changes         |
| `placeholder`         | `String?`                 | `null`       | Placeholder text when no value selected |
| `labelText`           | `String?`                 | `null`       | Label text above dropdown               |
| `errorText`           | `String?`                 | `null`       | Error message text                      |
| `helperText`          | `String?`                 | `null`       | Helper text below dropdown              |
| `enabled`             | `bool`                    | `true`       | Whether dropdown is enabled             |
| `isExpanded`          | `bool`                    | `false`      | Whether dropdown expands to fill width  |
| `variant`             | `FSDropdownVariant`       | `primary`    | Visual style variant                    |
| `size`                | `FSDropdownSize`          | `md`         | Dropdown size (sm, md, lg)              |
| `prefixIcon`          | `Widget?`                 | `null`       | Icon displayed before dropdown content  |
| `suffixIcon`          | `Widget?`                 | `null`       | Icon displayed after dropdown content   |
| `showSearch`          | `bool`                    | `false`      | Whether to show search field            |
| `searchHint`          | `String?`                 | `null`       | Hint text for search field              |
| `decoration`          | `InputDecoration?`        | `null`       | Custom input decoration                 |
| `menuMaxHeight`       | `double`                  | `200.0`      | Maximum height of dropdown menu         |
| `borderRadius`        | `BorderRadiusGeometry?`   | `null`       | Custom border radius                    |
| `searchDebounceDelay` | `Duration`                | `300ms`      | Delay for search debouncing             |

### FSDropdownVariant Enum

```dart
enum FSDropdownVariant {
  primary, secondary, success, danger, warning, info, light, dark
}
```

### FSDropdownSize Enum

```dart
enum FSDropdownSize {
  sm,  // Small: compact padding, smaller icons
  md,  // Medium: standard padding, normal icons
  lg   // Large: generous padding, larger icons
}
```

### FSDropdownItem Class

```dart
FSDropdownItem<T>(
  value: T,           // The value of this item
  label: String,      // Display text for this item
  leading: Widget?,   // Optional leading widget (icon, avatar, etc.)
  trailing: Widget?,  // Optional trailing widget
  enabled: bool,      // Whether this item is selectable (default: true)
)
```

## Advanced Features

### Search Functionality

```dart
FlutstrapDropdown<String>(
  items: List.generate(50, (i) =>
    FSDropdownItem(value: 'item$i', label: 'Item ${i + 1}')
  ),
  value: selectedValue,
  onChanged: onChanged,
  showSearch: true,
  searchHint: 'Search items...',
  searchDebounceDelay: Duration(milliseconds: 500),
)
```

### Custom Item Rendering

```dart
FlutstrapDropdown<String>(
  items: [
    FSDropdownItem(
      value: 'pro',
      label: 'Pro Plan',
      leading: Icon(Icons.star, color: Colors.amber),
      trailing: Text('\$29/month', style: TextStyle(color: Colors.green)),
    ),
    FSDropdownItem(
      value: 'team',
      label: 'Team Plan',
      leading: Icon(Icons.group, color: Colors.blue),
      trailing: Text('\$99/month', style: TextStyle(color: Colors.green)),
    ),
    FSDropdownItem(
      value: 'enterprise',
      label: 'Enterprise Plan',
      leading: Icon(Icons.business, color: Colors.purple),
      trailing: Text('Contact Sales', style: TextStyle(color: Colors.grey)),
    ),
  ],
  value: selectedPlan,
  onChanged: onChanged,
)
```

### Form Integration with Validation

```dart
class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  String? selectedCategory;
  String? errorText;

  void _validateForm() {
    setState(() {
      errorText = selectedCategory == null ? 'Please select a category' : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FlutstrapDropdown<String>(
          items: [
            FSDropdownItem(value: 'tech', label: 'Technology'),
            FSDropdownItem(value: 'design', label: 'Design'),
            FSDropdownItem(value: 'business', label: 'Business'),
          ],
          value: selectedCategory,
          onChanged: (value) {
            setState(() {
              selectedCategory = value;
              errorText = null; // Clear error when user selects something
            });
          },
          labelText: 'Category',
          errorText: errorText,
          helperText: 'Select the most relevant category',
        ),
        SizedBox(height: 20),
        FlutstrapButton(
          onPressed: _validateForm,
          text: 'Submit',
        ),
      ],
    );
  }
}
```

## Customization

### Icons and Custom Styling

```dart
FlutstrapDropdown<String>(
  items: items,
  value: selectedValue,
  onChanged: onChanged,
  prefixIcon: Icon(Icons.category),
  suffixIcon: Icon(Icons.arrow_drop_down),
  borderRadius: BorderRadius.circular(12),
)

FlutstrapDropdown<String>(
  items: items,
  value: selectedValue,
  onChanged: onChanged,
  decoration: InputDecoration(
    filled: true,
    fillColor: Colors.grey[100],
  ),
)
```

### Disabled State

```dart
FlutstrapDropdown<String>(
  items: items,
  value: selectedValue,
  onChanged: null, // Disables the dropdown
  helperText: 'This field is currently disabled',
)

// Or explicitly disabled
FlutstrapDropdown<String>(
  items: items,
  value: selectedValue,
  onChanged: onChanged,
  enabled: false,
  helperText: 'This field is currently disabled',
)
```

### Menu Customization

```dart
FlutstrapDropdown<String>(
  items: items,
  value: selectedValue,
  onChanged: onChanged,
  menuMaxHeight: 300, // Larger menu
  showSearch: true, // Include search for large lists
)
```

## Integration Examples

### Settings Form

```dart
Column(
  children: [
    FlutstrapDropdown<String>(
      items: [
        FSDropdownItem(value: 'en', label: 'English'),
        FSDropdownItem(value: 'es', label: 'Spanish'),
        FSDropdownItem(value: 'fr', label: 'French'),
        FSDropdownItem(value: 'de', label: 'German'),
      ],
      value: language,
      onChanged: (value) => setState(() => language = value),
      labelText: 'Language',
      prefixIcon: Icon(Icons.language),
    ),
    SizedBox(height: 16),
    FlutstrapDropdown<String>(
      items: [
        FSDropdownItem(value: 'light', label: 'Light'),
        FSDropdownItem(value: 'dark', label: 'Dark'),
        FSDropdownItem(value: 'system', label: 'System'),
      ],
      value: theme,
      onChanged: (value) => setState(() => theme = value),
      labelText: 'Theme',
      prefixIcon: Icon(Icons.brightness_medium),
    ),
    SizedBox(height: 16),
    FlutstrapDropdown<String>(
      items: List.generate(10, (i) =>
        FSDropdownItem(value: 'region$i', label: 'Region ${i + 1}')
      ),
      value: region,
      onChanged: (value) => setState(() => region = value),
      labelText: 'Region',
      showSearch: true,
      searchHint: 'Search regions...',
    ),
  ],
)
```

### User Selection with Avatars

```dart
FlutstrapDropdown<User>(
  items: users.map((user) => FSDropdownItem(
    value: user,
    label: user.name,
    leading: CircleAvatar(
      backgroundImage: NetworkImage(user.avatarUrl),
      radius: 12,
    ),
    trailing: Text(user.role, style: TextStyle(color: Colors.grey)),
  )).toList(),
  value: selectedUser,
  onChanged: (user) => setState(() => selectedUser = user),
  placeholder: 'Select a user',
  showSearch: true,
  searchHint: 'Search users by name...',
)
```

### Product Selection with Icons

```dart
FlutstrapDropdown<String>(
  items: [
    FSDropdownItem(
      value: 'mobile',
      label: 'Mobile App',
      leading: Icon(Icons.phone_iphone, color: Colors.blue),
    ),
    FSDropdownItem(
      value: 'web',
      label: 'Web Application',
      leading: Icon(Icons.computer, color: Colors.green),
    ),
    FSDropdownItem(
      value: 'desktop',
      label: 'Desktop Software',
      leading: Icon(Icons.desktop_windows, color: Colors.orange),
    ),
    FSDropdownItem(
      value: 'api',
      label: 'API Development',
      leading: Icon(Icons.code, color: Colors.purple),
    ),
  ],
  value: projectType,
  onChanged: (value) => setState(() => projectType = value),
  labelText: 'Project Type',
)
```

## Accessibility Notes

FlutstrapDropdown includes comprehensive accessibility features:

- **Screen Reader Support**: Uses `Semantics` widget with proper labels
- **Keyboard Navigation**: Full support for Tab, Enter, Escape keys
- **Focus Management**: Proper focus handling for dropdown and search
- **ARIA Attributes**: Announces expanded state to screen readers
- **Search Accessibility**: Search field is properly accessible
- **Item States**: Disabled items are properly announced

```dart
FlutstrapDropdown<String>(
  items: items,
  value: selectedValue,
  onChanged: onChanged,
  labelText: 'Category', // Used as semantic label
  placeholder: 'Select an option', // Used when no value selected
)
```

## Performance Features

### Search Debouncing

```dart
FlutstrapDropdown<String>(
  items: largeList,
  value: selectedValue,
  onChanged: onChanged,
  showSearch: true,
  searchDebounceDelay: Duration(milliseconds: 500), // Custom debounce delay
)
```

### Efficient Rendering

- **Virtual Scrolling**: Large lists are efficiently rendered
- **Search Filtering**: Search uses efficient filtering with debouncing
- **Overlay Management**: Proper overlay lifecycle management

## Best Practices

### Data Handling

```dart
// ✅ Good - Use meaningful values
FSDropdownItem(value: user.id, label: user.name)

// ✅ Good - Handle null values properly
onChanged: (value) {
  setState(() {
    selectedValue = value; // Can be null
  });
}

// ❌ Avoid - Using display text as values
FSDropdownItem(value: 'Display Text', label: 'Display Text')
```

### Search Implementation

```dart
// ✅ Good - Use search for large lists
FlutstrapDropdown<String>(
  items: largeList,
  showSearch: largeList.length > 10,
)

// ✅ Good - Provide helpful search hints
FlutstrapDropdown<String>(
  items: users,
  showSearch: true,
  searchHint: 'Search by name or email...',
)
```

### Error Handling

```dart
FlutstrapDropdown<String>(
  items: items,
  value: selectedValue,
  onChanged: onChanged,
  errorText: _hasError ? 'Please select a valid option' : null,
  helperText: _hasError ? null : 'Choose from available options',
)
```

## Troubleshooting

### Common Issues and Solutions

**Dropdown Not Opening**

```dart
// Ensure dropdown is enabled and has items
FlutstrapDropdown<String>(
  items: items, // Must not be empty
  enabled: true, // Must be true
  onChanged: (value) {}, // Must not be null when enabled
)
```

**Value Not Displaying**

```dart
// Ensure value exists in items list
FlutstrapDropdown<String>(
  items: [
    FSDropdownItem(value: '1', label: 'One'),
    FSDropdownItem(value: '2', label: 'Two'),
  ],
  value: '1', // Must match one of the item values
  onChanged: onChanged,
)
```

**Search Not Working**

```dart
// Enable search and ensure items have proper labels
FlutstrapDropdown<String>(
  items: items,
  showSearch: true, // Must be true
  // Items must have labels that can be searched
)
```

**Overlay Positioning Issues**

```dart
// Ensure dropdown has enough space below
// Use menuMaxHeight to control menu size
FlutstrapDropdown<String>(
  items: items,
  menuMaxHeight: 150, // Smaller menu for constrained spaces
)
```

This comprehensive guide covers all aspects of using the FlutstrapDropdown component. The dropdown system is designed to be highly flexible, performant, and accessible while providing a consistent selection interface for various data types and use cases.
