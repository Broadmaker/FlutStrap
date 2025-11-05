# Flutstrap Table Component Guide

## Introduction

Flutstrap Table is a high-performance, customizable table component with Bootstrap-inspired styling, sorting, responsive behavior, and virtualization for large datasets. It provides a robust data display solution for Flutter applications with enterprise-grade performance features.

**This comprehensive guide covers all aspects of using the Flutstrap Table component. The table system is designed to be highly flexible, performant, and accessible while providing a robust solution for data presentation across various screen sizes, interaction patterns, and dataset complexities.**

### What It Does

- Displays tabular data with customizable columns and styling
- Supports sorting, virtualization, and responsive layouts
- Provides multiple visual variants and size options
- Handles large datasets efficiently with smart rendering

### When to Use

- Displaying user lists, product catalogs, or any structured data
- Applications requiring sortable data tables
- Projects needing responsive table behavior across devices
- Handling large datasets (1,000+ items) with smooth performance

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

### Simple Table with Map Data

```dart
FlutstrapTable<Map<String, dynamic>>(
  columns: [
    FSTableColumn(
      header: 'Name',
      accessor: 'name',
      sortable: true,
    ),
    FSTableColumn(
      header: 'Age',
      accessor: 'age',
      sortable: true,
    ),
    FSTableColumn(
      header: 'Email',
      accessor: 'email',
    ),
  ],
  data: [
    {'name': 'John Doe', 'age': 30, 'email': 'john@example.com'},
    {'name': 'Jane Smith', 'age': 25, 'email': 'jane@example.com'},
    {'name': 'Bob Johnson', 'age': 35, 'email': 'bob@example.com'},
  ],
  variant: FSTableVariant.primary,
  striped: true,
  hover: true,
)
```

### Table with Custom Objects

```dart
class User {
  final String name;
  final int age;
  final bool isActive;

  User({required this.name, required this.age, required this.isActive});
}

FlutstrapTable<User>(
  columns: [
    FSTableColumn(
      header: 'User',
      cellBuilder: (user) => Text(user.name),
      sortable: true,
    ),
    FSTableColumn(
      header: 'Age',
      cellBuilder: (user) => Text(user.age.toString()),
      sortable: true,
    ),
    FSTableColumn(
      header: 'Status',
      cellBuilder: (user) => FlutstrapBadge(
        text: user.isActive ? 'Active' : 'Inactive',
        variant: user.isActive ? FSBadgeVariant.success : FSBadgeVariant.secondary,
      ),
    ),
  ],
  data: [
    User(name: 'John Doe', age: 30, isActive: true),
    User(name: 'Jane Smith', age: 25, isActive: false),
  ],
  onRowTap: (user) => _showUserDetails(user),
)
```

## Component Variants

### Visual Variants

Flutstrap Table provides 8 visual variants to match different design contexts:

```dart
// Primary (default)
FlutstrapTable(
  variant: FSTableVariant.primary,
  // ...
)

// Success - for positive data
FlutstrapTable(
  variant: FSTableVariant.success,
  // ...
)

// Danger - for error or warning data
FlutstrapTable(
  variant: FSTableVariant.danger,
  // ...
)

// Warning - for cautionary data
FlutstrapTable(
  variant: FSTableVariant.warning,
  // ...
)

// Info - for informational data
FlutstrapTable(
  variant: FSTableVariant.info,
  // ...
)

// Light & Dark - for specific themes
FlutstrapTable(
  variant: FSTableVariant.light,
  // ...
)

FlutstrapTable(
  variant: FSTableVariant.dark,
  // ...
)
```

### Size Variants

```dart
// Small - compact for dense data
FlutstrapTable(
  size: FSTableSize.sm,
  // ...
)

// Medium - standard size (default)
FlutstrapTable(
  size: FSTableSize.md,
  // ...
)

// Large - for better readability
FlutstrapTable(
  size: FSTableSize.lg,
  // ...
)
```

## Properties & Parameters

### Parameter Reference Table

| Parameter         | Type                          | Default      | Description                   |
| ----------------- | ----------------------------- | ------------ | ----------------------------- |
| `columns`         | `List<FSTableColumn<T>>`      | **required** | Column definitions            |
| `data`            | `List<T>`                     | **required** | Data to display               |
| `variant`         | `FSTableVariant`              | `primary`    | Visual style variant          |
| `size`            | `FSTableSize`                 | `md`         | Table size (sm, md, lg)       |
| `responsive`      | `FSTableResponsive`           | `scroll`     | Responsive behavior           |
| `striped`         | `bool`                        | `false`      | Alternate row colors          |
| `bordered`        | `bool`                        | `false`      | Show borders                  |
| `hover`           | `bool`                        | `true`       | Highlight rows on hover       |
| `condensed`       | `bool`                        | `false`      | Reduce padding                |
| `emptyMessage`    | `String?`                     | `null`       | Custom empty state message    |
| `emptyWidget`     | `Widget?`                     | `null`       | Custom empty state widget     |
| `onRowTap`        | `Function(T)?`                | `null`       | Row tap callback              |
| `onRowDoubleTap`  | `Function(T)?`                | `null`       | Row double-tap callback       |
| `columnWidths`    | `Map<int, TableColumnWidth>?` | `null`       | Custom column widths          |
| `borderRadius`    | `BorderRadiusGeometry?`       | `null`       | Table border radius           |
| `showHeader`      | `bool`                        | `true`       | Show/hide table header        |
| `backgroundColor` | `Color?`                      | `null`       | Custom background color       |
| `borderColor`     | `Color?`                      | `null`       | Custom border color           |
| `virtualized`     | `bool`                        | `true`       | Enable virtualization         |
| `rowHeight`       | `double`                      | `48.0`       | Row height for virtualization |

### FSTableColumn Parameters

| Parameter     | Type                  | Default      | Description                |
| ------------- | --------------------- | ------------ | -------------------------- |
| `header`      | `String`              | **required** | Column header text         |
| `accessor`    | `String?`             | `null`       | Field name for data access |
| `cellBuilder` | `Widget Function(T)?` | `null`       | Custom cell renderer       |
| `sortable`    | `bool`                | `false`      | Enable column sorting      |
| `width`       | `double?`             | `null`       | Fixed column width         |
| `headerAlign` | `TextAlign`           | `left`       | Header text alignment      |
| `cellAlign`   | `TextAlign`           | `left`       | Cell text alignment        |
| `visible`     | `bool`                | `true`       | Show/hide column           |
| `priority`    | `int?`                | `null`       | Responsive priority (1-5)  |

## Customization

### Custom Column Rendering

```dart
FSTableColumn<User>(
  header: 'Actions',
  cellBuilder: (user) => Row(
    children: [
      FlutstrapButton(
        onPressed: () => _editUser(user),
        child: Icon(Icons.edit, size: 16),
        size: FSSize.sm,
        variant: FSButtonVariant.outline,
      ),
      SizedBox(width: 8),
      FlutstrapButton(
        onPressed: () => _deleteUser(user),
        child: Icon(Icons.delete, size: 16),
        size: FSSize.sm,
        variant: FSButtonVariant.danger,
      ),
    ],
  ),
)
```

### Custom Styling

```dart
FlutstrapTable<User>(
  columns: userColumns,
  data: users,
  backgroundColor: Colors.grey[50],
  borderColor: Colors.blue.shade200,
  borderRadius: BorderRadius.circular(12),
  columnWidths: {
    0: FixedColumnWidth(200), // Name column fixed width
    1: FlexColumnWidth(),     // Age column flexible
    2: IntrinsicColumnWidth(), // Status column intrinsic
  },
)
```

### Conditional Row Styling

```dart
FSTableColumn<User>(
  header: 'Status',
  cellBuilder: (user) => Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    decoration: BoxDecoration(
      color: user.isActive ? Colors.green.shade100 : Colors.red.shade100,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(
      user.isActive ? 'Active' : 'Inactive',
      style: TextStyle(
        color: user.isActive ? Colors.green.shade800 : Colors.red.shade800,
        fontWeight: FontWeight.w500,
      ),
    ),
  ),
)
```

## Interactivity & Behavior

### Sorting

```dart
FlutstrapTable<Product>(
  columns: [
    FSTableColumn(
      header: 'Product Name',
      accessor: 'name',
      sortable: true, // Enable sorting
    ),
    FSTableColumn(
      header: 'Price',
      accessor: 'price',
      sortable: true,
    ),
    FSTableColumn(
      header: 'Category',
      accessor: 'category',
      sortable: true,
    ),
  ],
  data: products,
)
```

### Row Interactions

```dart
FlutstrapTable<Order>(
  columns: orderColumns,
  data: orders,
  onRowTap: (order) {
    // Single tap - view details
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OrderDetailsPage(order: order)),
    );
  },
  onRowDoubleTap: (order) {
    // Double tap - quick edit
    _showQuickEditDialog(order);
  },
  hover: true, // Visual feedback on hover
)
```

### Virtualization for Large Datasets

```dart
FlutstrapTable<LogEntry>(
  columns: logColumns,
  data: largeLogList, // 10,000+ items
  virtualized: true, // Enable virtualization
  rowHeight: 40, // Custom row height for dense data
  // Virtualization is automatic for datasets > 50 items
)
```

## Responsive Behavior

### Responsive Modes

```dart
// Scroll - Horizontal scrolling on small screens (default)
FlutstrapTable(
  responsive: FSTableResponsive.scroll,
  // ...
)

// Collapse - Transforms to card layout on mobile
FlutstrapTable(
  responsive: FSTableResponsive.collapse,
  // ...
)

// Stacked - Stacks columns vertically on tablet
FlutstrapTable(
  responsive: FSTableResponsive.stacked,
  // ...
)

// None - No responsive adaptation
FlutstrapTable(
  responsive: FSTableResponsive.none,
  // ...
)
```

### Column Priority for Responsive Behavior

```dart
FlutstrapTable<User>(
  columns: [
    FSTableColumn(
      header: 'ID',
      accessor: 'id',
      priority: 1, // Always visible
      width: 80,
    ),
    FSTableColumn(
      header: 'Name',
      accessor: 'name',
      priority: 1, // Always visible
    ),
    FSTableColumn(
      header: 'Email',
      accessor: 'email',
      priority: 2, // Hidden on very small screens
    ),
    FSTableColumn(
      header: 'Phone',
      accessor: 'phone',
      priority: 3, // Hidden on mobile
    ),
    FSTableColumn(
      header: 'Department',
      accessor: 'department',
      priority: 4, // Hidden on tablet
    ),
  ],
  data: users,
  responsive: FSTableResponsive.collapse,
)
```

## Performance Optimization

### Virtualization Best Practices

```dart
// ✅ GOOD: Virtualization enabled for large datasets
FlutstrapTable<DataPoint>(
  columns: dataColumns,
  data: largeDataset, // 1,000+ items
  virtualized: true,
  rowHeight: 48.0,
)

// ✅ BETTER: Adjust row height for dense data
FlutstrapTable<LogEntry>(
  columns: logColumns,
  data: logEntries, // 50,000+ items
  virtualized: true,
  rowHeight: 32.0, // Smaller height for more rows visible
)

// ❌ AVOID: Disabling virtualization for large datasets
FlutstrapTable<DataPoint>(
  columns: dataColumns,
  data: largeDataset, // 10,000 items
  virtualized: false, // Will cause performance issues
)
```

### Efficient Cell Builders

```dart
// ✅ GOOD: Simple cell builders with const widgets
FSTableColumn<User>(
  header: 'Status',
  cellBuilder: (user) => const FlutstrapBadge(
    text: 'Active',
    variant: FSBadgeVariant.success,
  ),
)

// ✅ GOOD: Efficient value extraction with accessor
FSTableColumn<User>(
  header: 'Name',
  accessor: 'name', // More efficient than cellBuilder for simple text
  sortable: true,
)

// ❌ AVOID: Expensive operations in cell builders
FSTableColumn<User>(
  header: 'Profile',
  cellBuilder: (user) {
    // Expensive network call in builder - BAD!
    return FutureBuilder<String>(
      future: _fetchUserProfile(user.id),
      builder: (context, snapshot) {
        return Text(snapshot.data ?? 'Loading...');
      },
    );
  },
)
```

## Accessibility Notes

Flutstrap Table includes comprehensive accessibility features:

- **Screen Reader Support**: Full semantic labels for headers, cells, and sort buttons
- **Keyboard Navigation**: Support for keyboard interaction and focus management
- **Sorting Accessibility**: Proper announcements for sort state changes
- **Responsive Semantics**: Adaptive labels for different responsive modes

```dart
// Screen readers will announce sort state and cell content
FlutstrapTable(
  columns: [
    FSTableColumn(
      header: 'Name',
      accessor: 'name',
      sortable: true, // Announces "Name. Tap to sort ascending"
    ),
  ],
  // ...
)
```

## Integration Examples

### Complete User Management Table

```dart
class UserManagementTable extends StatelessWidget {
  final List<User> users;
  final Function(User) onEdit;
  final Function(User) onDelete;

  const UserManagementTable({
    super.key,
    required this.users,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return FlutstrapTable<User>(
      columns: [
        FSTableColumn(
          header: 'Avatar',
          cellBuilder: (user) => CircleAvatar(
            backgroundImage: NetworkImage(user.avatarUrl),
            radius: 16,
          ),
          width: 60,
        ),
        FSTableColumn(
          header: 'Name',
          accessor: 'fullName',
          sortable: true,
          priority: 1,
        ),
        FSTableColumn(
          header: 'Email',
          accessor: 'email',
          sortable: true,
          priority: 2,
        ),
        FSTableColumn(
          header: 'Role',
          cellBuilder: (user) => FlutstrapBadge(
            text: user.role.toUpperCase(),
            variant: _getRoleVariant(user.role),
          ),
          sortable: true,
        ),
        FSTableColumn(
          header: 'Last Active',
          cellBuilder: (user) => Text(
            _formatDate(user.lastActive),
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
            ),
          ),
          sortable: true,
        ),
        FSTableColumn(
          header: 'Actions',
          cellBuilder: (user) => Row(
            children: [
              FlutstrapButton(
                onPressed: () => onEdit(user),
                child: Icon(Icons.edit, size: 16),
                size: FSSize.sm,
                variant: FSButtonVariant.outline,
              ),
              SizedBox(width: 8),
              FlutstrapButton(
                onPressed: () => onDelete(user),
                child: Icon(Icons.delete, size: 16),
                size: FSSize.sm,
                variant: FSButtonVariant.danger,
              ),
            ],
          ),
          width: 120,
        ),
      ],
      data: users,
      variant: FSTableVariant.light,
      striped: true,
      hover: true,
      responsive: FSTableResponsive.collapse,
      onRowTap: (user) => _showUserProfile(context, user),
    );
  }

  FSBadgeVariant _getRoleVariant(String role) {
    switch (role) {
      case 'admin': return FSBadgeVariant.danger;
      case 'manager': return FSTableVariant.warning;
      case 'user': return FSTableVariant.primary;
      default: return FSTableVariant.secondary;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
```

### Data Table with Search and Pagination

```dart
class DataTableWithControls extends StatefulWidget {
  @override
  _DataTableWithControlsState createState() => _DataTableWithControlsState();
}

class _DataTableWithControlsState extends State<DataTableWithControls> {
  final List<User> _allUsers = []; // Your full dataset
  List<User> _filteredUsers = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _filteredUsers = _allUsers;
  }

  void _onSearch(String query) {
    setState(() {
      _searchQuery = query;
      _filteredUsers = _allUsers.where((user) =>
        user.name.toLowerCase().contains(query.toLowerCase()) ||
        user.email.toLowerCase().contains(query.toLowerCase())
      ).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search bar
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: FlutstrapTextField(
            prefixIcon: Icon(Icons.search),
            placeholder: 'Search users...',
            onChanged: _onSearch,
          ),
        ),

        // Table
        Expanded(
          child: FlutstrapTable<User>(
            columns: [
              FSTableColumn(header: 'Name', accessor: 'name', sortable: true),
              FSTableColumn(header: 'Email', accessor: 'email', sortable: true),
              FSTableColumn(header: 'Role', accessor: 'role', sortable: true),
            ],
            data: _filteredUsers,
            emptyWidget: _buildEmptyState(),
          ),
        ),

        // Pagination controls would go here
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
          SizedBox(height: 16),
          Text(
            _searchQuery.isEmpty
                ? 'No users found'
                : 'No users matching "$_searchQuery"',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
```

## Best Practices

### Performance Recommendations

**Use Virtualization for Large Datasets**

```dart
// ✅ Automatic virtualization for > 50 items
FlutstrapTable<DataPoint>(
  data: largeDataset, // 1,000+ items
  virtualized: true, // Enabled by default
  rowHeight: 48.0, // Match your content height
)

// ✅ Optimize row height for dense data
FlutstrapTable<LogEntry>(
  data: logs,
  rowHeight: 32.0, // Smaller for better performance
)
```

**Efficient Column Definitions**

```dart
// ✅ Use accessor for simple text fields
FSTableColumn<User>(
  header: 'Name',
  accessor: 'name', // More efficient
  sortable: true,
)

// ✅ Use cellBuilder for complex widgets
FSTableColumn<User>(
  header: 'Status',
  cellBuilder: (user) => FlutstrapBadge(
    text: user.status,
    variant: _getStatusVariant(user.status),
  ),
)

// ❌ Avoid expensive operations in builders
FSTableColumn<User>(
  header: 'Data',
  cellBuilder: (user) {
    // Don't do this!
    return FutureBuilder<List<String>>(
      future: _fetchUserData(user.id),
      builder: (context, snapshot) => Text(snapshot.data?.join(', ') ?? ''),
    );
  },
)
```

### UX Design Tips

**Responsive Column Priorities**

```dart
FlutstrapTable<Product>(
  columns: [
    FSTableColumn(header: 'ID', priority: 1, width: 80), // Always show
    FSTableColumn(header: 'Name', priority: 1), // Always show
    FSTableColumn(header: 'Category', priority: 2), // Hide on mobile
    FSTableColumn(header: 'Supplier', priority: 3), // Hide on tablet
    FSTableColumn(header: 'Warehouse', priority: 4), // Hide on small desktop
  ],
  responsive: FSTableResponsive.collapse,
)
```

**Appropriate Empty States**

```dart
FlutstrapTable<Order>(
  columns: orderColumns,
  data: orders,
  emptyWidget: Column(
    children: [
      Icon(Icons.receipt_long, size: 64, color: Colors.grey[400]),
      SizedBox(height: 16),
      Text('No orders found'),
      SizedBox(height: 8),
      FlutstrapButton(
        onPressed: _createFirstOrder,
        child: Text('Create First Order'),
      ),
    ],
  ),
)
```

## Troubleshooting

### Common Issues and Solutions

**Table Not Rendering**

```dart
// ❌ Missing constraints
FlutstrapTable(data: myData, columns: myColumns)

// ✅ Provide proper constraints
Container(
  height: 400, // Fixed height
  child: FlutstrapTable(data: myData, columns: myColumns),
)

// OR use Expanded
Column(
  children: [
    Expanded(
      child: FlutstrapTable(data: myData, columns: myColumns),
    ),
  ],
)
```

**Sorting Not Working**

```dart
// ❌ Missing accessor or sortable flag
FSTableColumn(header: 'Name') // No sorting

// ✅ Enable sorting with accessor
FSTableColumn(
  header: 'Name',
  accessor: 'name',
  sortable: true, // Required for sorting
)

// ✅ For custom objects, use accessor with Map or implement sorting
FSTableColumn<User>(
  header: 'Name',
  cellBuilder: (user) => Text(user.name),
  sortable: true, // Will use cellBuilder content for sorting
)
```

**Performance Issues with Large Datasets**

```dart
// ❌ Disabled virtualization
FlutstrapTable(
  data: largeDataset, // 10,000 items
  virtualized: false, // Causes performance issues
)

// ✅ Enable virtualization (default)
FlutstrapTable(
  data: largeDataset,
  virtualized: true, // Enabled by default
  rowHeight: 40.0, // Optimize for your content
)

// ✅ Use efficient cell builders
FSTableColumn<User>(
  header: 'Name',
  accessor: 'name', // More efficient than cellBuilder for text
)
```

**Responsive Behavior Not Working**

```dart
// ❌ Missing LayoutBuilder parent
FlutstrapTable(responsive: FSTableResponsive.collapse)

// ✅ Ensure table has width constraints
Container(
  width: double.infinity, // Or specific width
  child: FlutstrapTable(responsive: FSTableResponsive.collapse),
)

// ✅ Use in responsive parent
LayoutBuilder(
  builder: (context, constraints) {
    return FlutstrapTable(
      responsive: FSTableResponsive.collapse,
      // ...
    );
  },
)
```

### Debugging Tips

1. **Check Data Types**: Ensure your data matches the generic type `T`
2. **Verify Column Definitions**: All columns must have either `accessor` or `cellBuilder`
3. **Monitor Performance**: Use Flutter DevTools to identify slow cell builders
4. **Test Responsive Behavior**: Use different screen sizes in the simulator
5. **Check Error Boundaries**: The table includes error handling for faulty cell builders

---

**This comprehensive guide covers all aspects of using the Flutstrap Table component. The table system is designed to be highly flexible, performant, and accessible while providing a robust solution for data presentation across various screen sizes, interaction patterns, and dataset complexities. With features like automatic virtualization, responsive layouts, and comprehensive accessibility support, Flutstrap Table offers enterprise-grade data display capabilities for modern Flutter applications.**
