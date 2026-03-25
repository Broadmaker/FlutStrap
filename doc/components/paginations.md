# Flutstrap Pagination Component Guide

## Introduction

The **FlutstrapPagination** is a high-performance, customizable pagination component with Bootstrap-inspired styling, optimized for large datasets and smooth user interactions. It provides a comprehensive pagination solution with accessibility features and flexible configuration options.

### What the Component Does

FlutstrapPagination offers:

- Multiple visual variants (8 color options)
- Three size options (sm, md, lg)
- Flexible alignment (start, center, end)
- Items count display
- First/last page navigation
- Previous/next page controls
- Smart page number generation with ellipsis
- Scrollable pagination for large page counts
- Comprehensive accessibility support

### When and Why to Use It

Use FlutstrapPagination when you need:

- Data tables with paginated results
- Content lists with multiple pages
- Search results pagination
- Any scenario where data needs to be split across multiple pages
- Accessible navigation through large datasets

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

### Basic Pagination

```dart
class PaginatedView extends StatefulWidget {
  @override
  _PaginatedViewState createState() => _PaginatedViewState();
}

class _PaginatedViewState extends State<PaginatedView> {
  int _currentPage = 1;
  final int _totalPages = 15;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Your content here
        Expanded(
          child: ListView.builder(
            itemCount: 25, // Example items per page
            itemBuilder: (context, index) => ListTile(
              title: Text('Item ${(_currentPage - 1) * 25 + index + 1}'),
            ),
          ),
        ),
        // Pagination controls
        FlutstrapPagination(
          currentPage: _currentPage,
          totalPages: _totalPages,
          onPageChanged: (page) {
            setState(() {
              _currentPage = page;
            });
          },
        ),
      ],
    );
  }
}
```

### Advanced Pagination with Items Count

```dart
FlutstrapPagination(
  currentPage: _currentPage,
  totalPages: 42,
  totalItems: 420,
  itemsPerPage: 10,
  showItemsCount: true,
  showFirstLast: true,
  variant: FSPaginationVariant.primary,
  onPageChanged: (page) {
    // Fetch data for the new page
    _fetchPageData(page);
  },
)
```

## Component Variants

FlutstrapPagination offers 8 visual variants:

### Primary

```dart
FlutstrapPagination(
  currentPage: currentPage,
  totalPages: totalPages,
  onPageChanged: onPageChanged,
  variant: FSPaginationVariant.primary,
)
```

### Secondary

```dart
FlutstrapPagination(
  currentPage: currentPage,
  totalPages: totalPages,
  onPageChanged: onPageChanged,
  variant: FSPaginationVariant.secondary,
)
```

### Success

```dart
FlutstrapPagination(
  currentPage: currentPage,
  totalPages: totalPages,
  onPageChanged: onPageChanged,
  variant: FSPaginationVariant.success,
)
```

### Danger

```dart
FlutstrapPagination(
  currentPage: currentPage,
  totalPages: totalPages,
  onPageChanged: onPageChanged,
  variant: FSPaginationVariant.danger,
)
```

### Warning

```dart
FlutstrapPagination(
  currentPage: currentPage,
  totalPages: totalPages,
  onPageChanged: onPageChanged,
  variant: FSPaginationVariant.warning,
)
```

### Info

```dart
FlutstrapPagination(
  currentPage: currentPage,
  totalPages: totalPages,
  onPageChanged: onPageChanged,
  variant: FSPaginationVariant.info,
)
```

### Light

```dart
FlutstrapPagination(
  currentPage: currentPage,
  totalPages: totalPages,
  onPageChanged: onPageChanged,
  variant: FSPaginationVariant.light,
)
```

### Dark

```dart
FlutstrapPagination(
  currentPage: currentPage,
  totalPages: totalPages,
  onPageChanged: onPageChanged,
  variant: FSPaginationVariant.dark,
)
```

## Pagination Sizes

### Small (sm)

```dart
FlutstrapPagination(
  currentPage: currentPage,
  totalPages: totalPages,
  onPageChanged: onPageChanged,
  size: FSPaginationSize.sm,
)
```

### Medium (md) - Default

```dart
FlutstrapPagination(
  currentPage: currentPage,
  totalPages: totalPages,
  onPageChanged: onPageChanged,
  size: FSPaginationSize.md,
)
```

### Large (lg)

```dart
FlutstrapPagination(
  currentPage: currentPage,
  totalPages: totalPages,
  onPageChanged: onPageChanged,
  size: FSPaginationSize.lg,
)
```

## Alignment Options

### Start Aligned

```dart
FlutstrapPagination(
  currentPage: currentPage,
  totalPages: totalPages,
  onPageChanged: onPageChanged,
  alignment: FSPaginationAlignment.start,
)
```

### Center Aligned (Default)

```dart
FlutstrapPagination(
  currentPage: currentPage,
  totalPages: totalPages,
  onPageChanged: onPageChanged,
  alignment: FSPaginationAlignment.center,
)
```

### End Aligned

```dart
FlutstrapPagination(
  currentPage: currentPage,
  totalPages: totalPages,
  onPageChanged: onPageChanged,
  alignment: FSPaginationAlignment.end,
)
```

## Properties & Parameters

### Parameter Reference Table

| Parameter          | Type                    | Default                                       | Description                             |
| ------------------ | ----------------------- | --------------------------------------------- | --------------------------------------- |
| `currentPage`      | `int`                   | **Required**                                  | Current active page (1-based)           |
| `totalPages`       | `int`                   | **Required**                                  | Total number of pages                   |
| `onPageChanged`    | `ValueChanged<int>`     | **Required**                                  | Callback when page changes              |
| `totalItems`       | `int`                   | `0`                                           | Total number of items for count display |
| `itemsPerPage`     | `int`                   | `10`                                          | Items per page for count calculation    |
| `variant`          | `FSPaginationVariant`   | `primary`                                     | Visual style variant                    |
| `size`             | `FSPaginationSize`      | `md`                                          | Pagination size                         |
| `alignment`        | `FSPaginationAlignment` | `center`                                      | Pagination alignment                    |
| `showNumbers`      | `bool`                  | `true`                                        | Whether to show page numbers            |
| `showPreviousNext` | `bool`                  | `true`                                        | Whether to show prev/next buttons       |
| `showFirstLast`    | `bool`                  | `false`                                       | Whether to show first/last buttons      |
| `showItemsCount`   | `bool`                  | `false`                                       | Whether to show items count             |
| `previousText`     | `String`                | `'Previous'`                                  | Previous button text                    |
| `nextText`         | `String`                | `'Next'`                                      | Next button text                        |
| `firstText`        | `String`                | `'First'`                                     | First button text                       |
| `lastText`         | `String`                | `'Last'`                                      | Last button text                        |
| `itemsCountText`   | `String`                | `'Showing {start} to {end} of {total} items'` | Items count template                    |
| `maxVisiblePages`  | `int`                   | `7`                                           | Maximum visible page numbers            |
| `disabled`         | `bool`                  | `false`                                       | Whether pagination is disabled          |
| `margin`           | `EdgeInsetsGeometry?`   | `null`                                        | Custom margin                           |

### FSPaginationVariant Enum

```dart
enum FSPaginationVariant {
  primary, secondary, success, danger, warning, info, light, dark
}
```

### FSPaginationSize Enum

```dart
enum FSPaginationSize {
  sm,  // Small: compact buttons, smaller text
  md,  // Medium: standard buttons, normal text
  lg   // Large: larger buttons, bigger text
}
```

### FSPaginationAlignment Enum

```dart
enum FSPaginationAlignment {
  start,  // Left-aligned
  center, // Center-aligned
  end     // Right-aligned
}
```

## Advanced Features

### Items Count Display

```dart
FlutstrapPagination(
  currentPage: currentPage,
  totalPages: totalPages,
  totalItems: 1250,
  itemsPerPage: 25,
  showItemsCount: true,
  itemsCountText: 'Displaying {start}-{end} of {total} records',
  onPageChanged: onPageChanged,
)
```

### Custom Button Texts

```dart
FlutstrapPagination(
  currentPage: currentPage,
  totalPages: totalPages,
  previousText: '← Prev',
  nextText: 'Next →',
  firstText: '« First',
  lastText: 'Last »',
  onPageChanged: onPageChanged,
)
```

### Compact Pagination for Mobile

```dart
FlutstrapPagination(
  currentPage: currentPage,
  totalPages: totalPages,
  size: FSPaginationSize.sm,
  maxVisiblePages: 5,
  showFirstLast: false,
  onPageChanged: onPageChanged,
)
```

### Disabled State

```dart
FlutstrapPagination(
  currentPage: currentPage,
  totalPages: totalPages,
  onPageChanged: onPageChanged,
  disabled: isLoading, // Disable during loading
)
```

## Smart Page Number Generation

The pagination component automatically generates optimal page numbers with ellipsis for large page counts:

### Example Page Number Patterns

- **Pages 1-7**: `[1, 2, 3, 4, 5, 6, 7]`
- **Pages 1-15 (current page 8)**: `[1, ..., 6, 7, 8, 9, 10, ..., 15]`
- **Pages 1-20 (current page 1)**: `[1, 2, 3, 4, 5, 6, 7, ..., 20]`
- **Pages 1-20 (current page 20)**: `[1, ..., 14, 15, 16, 17, 18, 19, 20]`

```dart
FlutstrapPagination(
  currentPage: 8,
  totalPages: 15,
  maxVisiblePages: 7, // Controls how many numbers to show
  onPageChanged: onPageChanged,
)
// Renders: [1, ..., 6, 7, 8, 9, 10, ..., 15]
```

## Integration Examples

### Data Table with Pagination

```dart
class DataTableWithPagination extends StatefulWidget {
  @override
  _DataTableWithPaginationState createState() => _DataTableWithPaginationState();
}

class _DataTableWithPaginationState extends State<DataTableWithPagination> {
  int _currentPage = 1;
  final int _itemsPerPage = 10;
  List<Map<String, dynamic>> _allData = [];
  List<Map<String, dynamic>> _currentPageData = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);

    // Simulate API call
    await Future.delayed(Duration(seconds: 1));

    // Generate sample data
    _allData = List.generate(125, (index) => {
      'id': index + 1,
      'name': 'Item ${index + 1}',
      'value': (index + 1) * 10,
    });

    _updateCurrentPageData();
    setState(() => _isLoading = false);
  }

  void _updateCurrentPageData() {
    final startIndex = (_currentPage - 1) * _itemsPerPage;
    final endIndex = startIndex + _itemsPerPage;
    _currentPageData = _allData.sublist(
      startIndex,
      endIndex < _allData.length ? endIndex : _allData.length,
    );
  }

  void _handlePageChange(int page) {
    setState(() {
      _currentPage = page;
      _updateCurrentPageData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Data Table
        Expanded(
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: DataTable(
                    columns: [
                      DataColumn(label: Text('ID')),
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Value')),
                    ],
                    rows: _currentPageData.map((item) => DataRow(
                      cells: [
                        DataCell(Text(item['id'].toString())),
                        DataCell(Text(item['name'])),
                        DataCell(Text(item['value'].toString())),
                      ],
                    )).toList(),
                  ),
                ),
        ),

        // Pagination
        FlutstrapPagination(
          currentPage: _currentPage,
          totalPages: (_allData.length / _itemsPerPage).ceil(),
          totalItems: _allData.length,
          itemsPerPage: _itemsPerPage,
          showItemsCount: true,
          showFirstLast: true,
          variant: FSPaginationVariant.primary,
          onPageChanged: _handlePageChange,
          disabled: _isLoading,
        ),
      ],
    );
  }
}
```

### Search Results Pagination

```dart
class SearchResults extends StatefulWidget {
  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  int _currentPage = 1;
  final int _totalPages = 23;
  final String _searchQuery = 'flutter';
  final int _totalResults = 225;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Search header
        Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Search results for "$_searchQuery"',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),

        // Results list
        Expanded(
          child: ListView.builder(
            itemCount: 10, // Items per page
            itemBuilder: (context, index) => ListTile(
              title: Text('Result ${(_currentPage - 1) * 10 + index + 1}'),
              subtitle: Text('Description of result...'),
            ),
          ),
        ),

        // Pagination with custom alignment
        FlutstrapPagination(
          currentPage: _currentPage,
          totalPages: _totalPages,
          totalItems: _totalResults,
          itemsPerPage: 10,
          showItemsCount: true,
          alignment: FSPaginationAlignment.start,
          itemsCountText: '{total} results found • Page {start}-{end}',
          onPageChanged: (page) {
            setState(() => _currentPage = page);
            // In real app, you'd fetch new page data here
          },
        ),
      ],
    );
  }
}
```

### Using copyWith for State Management

```dart
class PaginationExample extends StatefulWidget {
  @override
  _PaginationExampleState createState() => _PaginationExampleState();
}

class _PaginationExampleState extends State<PaginationExample> {
  int _currentPage = 1;
  final int _totalPages = 15;

  // Base pagination configuration
  FlutstrapPagination get _basePagination => FlutstrapPagination(
    currentPage: _currentPage,
    totalPages: _totalPages,
    onPageChanged: (page) => setState(() => _currentPage = page),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Different pagination styles
        _basePagination.primary(),
        SizedBox(height: 16),
        _basePagination.success().withItemsCount(),
        SizedBox(height: 16),
        _basePagination.dark().withFirstLast().large(),
        SizedBox(height: 16),
        _basePagination.copyWith(
          showItemsCount: true,
          totalItems: 150,
          itemsPerPage: 10,
          alignment: FSPaginationAlignment.start,
        ),
      ],
    );
  }
}
```

## Accessibility Notes

FlutstrapPagination includes comprehensive accessibility features:

- **Screen Reader Support**: Uses proper semantic labels for all buttons
- **Keyboard Navigation**: Full support for keyboard interaction
- **Clear Indicators**: Current page is clearly announced as "Current page"
- **Descriptive Labels**: Buttons have descriptive labels like "Go to next page"
- **Focus Management**: Proper focus handling during page changes

```dart
FlutstrapPagination(
  currentPage: currentPage,
  totalPages: totalPages,
  onPageChanged: onPageChanged,
  // Automatically provides:
  // - "Current page X" announcements
  // - "Go to previous/next page" labels
  // - "Go to page X" for number buttons
)
```

## Performance Features

### Page Number Caching

```dart
// Page numbers are automatically cached for performance
// Multiple paginations with same configuration reuse computed page numbers
FlutstrapPagination(
  currentPage: 5,
  totalPages: 15,
  maxVisiblePages: 7,
  onPageChanged: onPageChanged,
)
```

### Scroll Optimization

```dart
// For large page counts (>15), pagination becomes scrollable
FlutstrapPagination(
  currentPage: currentPage,
  totalPages: 50, // Automatically becomes horizontally scrollable
  onPageChanged: onPageChanged,
)
```

## Best Practices

### Page Number Limits

```dart
// ✅ Good - Reasonable page count with ellipsis
FlutstrapPagination(
  currentPage: 8,
  totalPages: 23,
  maxVisiblePages: 7, // Shows ellipsis for better UX
  onPageChanged: onPageChanged,
)

// ❌ Avoid - Too many visible pages
FlutstrapPagination(
  currentPage: 8,
  totalPages: 23,
  maxVisiblePages: 23, // Shows all pages - can be overwhelming
  onPageChanged: onPageChanged,
)
```

### Items Count Usage

```dart
// ✅ Good - Useful for data-heavy applications
FlutstrapPagination(
  currentPage: currentPage,
  totalPages: totalPages,
  totalItems: 1250,
  itemsPerPage: 25,
  showItemsCount: true,
  onPageChanged: onPageChanged,
)

// ❌ Avoid - Unnecessary for simple navigation
FlutstrapPagination(
  currentPage: currentPage,
  totalPages: 5, // Too few pages for items count
  showItemsCount: true, // Adds clutter
  onPageChanged: onPageChanged,
)
```

## Troubleshooting

### Common Issues and Solutions

**Current Page Out of Range**

```dart
// Ensure currentPage is within valid range
FlutstrapPagination(
  currentPage: _clamp(_currentPage, 1, totalPages), // Clamp to valid range
  totalPages: totalPages,
  onPageChanged: onPageChanged,
)

int _clamp(int value, int min, int max) {
  return value < min ? min : (value > max ? max : value);
}
```

**Pagination Not Updating**

```dart
// Ensure you're calling setState when page changes
FlutstrapPagination(
  currentPage: _currentPage,
  totalPages: _totalPages,
  onPageChanged: (page) {
    setState(() { // Must call setState to trigger rebuild
      _currentPage = page;
    });
  },
)
```

**Items Count Not Showing**

```dart
// Ensure totalItems is provided and showItemsCount is true
FlutstrapPagination(
  currentPage: currentPage,
  totalPages: totalPages,
  totalItems: 150, // Must be > 0
  showItemsCount: true, // Must be true
  onPageChanged: onPageChanged,
)
```

**Too Many Pages Error**

```dart
// Pagination supports up to 10,000 pages
FlutstrapPagination(
  currentPage: currentPage,
  totalPages: 500, // ✅ Valid
  onPageChanged: onPageChanged,
)

FlutstrapPagination(
  currentPage: currentPage,
  totalPages: 15000, // ❌ Throws assertion error
  onPageChanged: onPageChanged,
)
```

This comprehensive guide covers all aspects of using the FlutstrapPagination component. The pagination system is designed to be highly flexible, performant, and accessible while providing a robust solution for navigating through paginated content in your Flutter applications.
