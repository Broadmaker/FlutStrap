# Flutstrap Grid System Guide

## Introduction

Flutstrap Grid System is a comprehensive grid system container that combines container, rows, and columns for easy responsive layout creation inspired by Bootstrap's grid system. It provides a robust solution for creating complex, responsive layouts in Flutter applications with enterprise-grade performance and flexibility.

**This comprehensive guide covers all aspects of using the Flutstrap Grid System. The grid system is designed to be highly flexible, responsive, and intuitive while providing a robust solution for complex layouts across various screen sizes, content types, and design requirements.**

### What It Does

- Creates responsive grid layouts with flexible row and column management
- Provides multiple grid creation patterns (single row, multiple rows, responsive, cards, auto-fit)
- Implements Bootstrap-inspired 12-column grid system
- Offers utility functions for optimal grid calculations

### When to Use

- Complex dashboard layouts with multiple sections
- Card grids and product listings
- Responsive form layouts with multiple columns
- Image galleries and content grids
- Any scenario requiring structured, responsive layouts

### Prerequisites

- Flutter 3.0 or higher
- Flutstrap Container, Row, and Column components
- Flutstrap spacing system (`FSSpacing`)

## Installation & Setup

### Required Dependencies

```dart
import 'package:flutstrap/flutstrap.dart';
```

### Basic Project Setup

Ensure your app has access to Flutstrap components and spacing:

```dart
void main() {
  runApp(MyApp()); // Flutstrap components available globally
}
```

## Basic Usage

### Simple Grid with Single Row

```dart
FlutstrapGrid(
  children: [
    FlutstrapRow(
      children: [
        FlutstrapCol(
          size: FSColSize(xs: 12, md: 6),
          child: Container(
            height: 100,
            color: Colors.blue,
            child: Center(child: Text('Column 1')),
          ),
        ),
        FlutstrapCol(
          size: FSColSize(xs: 12, md: 6),
          child: Container(
            height: 100,
            color: Colors.red,
            child: Center(child: Text('Column 2')),
          ),
        ),
      ],
    ),
  ],
)
```

### Using Factory Methods for Quick Grid Creation

```dart
// Single row grid
FlutstrapGrid.singleRow(
  columns: [
    FlutstrapCol(size: FSColSize.all(6), child: Text('Left')),
    FlutstrapCol(size: FSColSize.all(6), child: Text('Right')),
  ],
  gap: 16.0,
)

// Multiple rows grid
FlutstrapGrid.multipleRows(
  rows: [
    [Text('Row 1, Col 1'), Text('Row 1, Col 2')],
    [Text('Row 2, Col 1'), Text('Row 2, Col 2')],
  ],
  rowGap: 24.0,
  columnGap: 16.0,
)
```

## Component Variants

### Grid Types

Flutstrap Grid provides multiple specialized grid types through factory methods:

```dart
// Single Row Grid - Simple horizontal layouts
FlutstrapGrid.singleRow(
  columns: [/* column widgets */],
  gap: 16.0,
)

// Multiple Rows Grid - Complex multi-row layouts
FlutstrapGrid.multipleRows(
  rows: [
    [/* row 1 columns */],
    [/* row 2 columns */],
  ],
  rowGap: 24.0,
  columnGap: 16.0,
)

// Responsive Grid - Breakpoint-based column changes
FlutstrapGrid.responsive(
  children: [/* child widgets */],
  xsColumns: 1,  // Mobile: 1 column
  smColumns: 2,  // Small: 2 columns
  mdColumns: 3,  // Medium: 3 columns
  lgColumns: 4,  // Large: 4 columns
)

// Cards Grid - Optimized for card layouts
FlutstrapGrid.cards(
  cards: [/* card widgets */],
  columns: 3,  // 3 columns on all screens
  gap: 16.0,
  equalHeight: true,  // Cards have equal height
)

// Auto-fit Grid - Dynamic columns based on available width
FlutstrapGrid.autoFit(
  children: [/* child widgets */],
  minColumnWidth: 200.0,  // Minimum column width
  gap: 16.0,
)
```

### Container Variants

```dart
// Fluid grid (full width)
FlutstrapGrid(
  fluid: true,
  children: [/* ... */],
)

// Fixed grid (with max width constraints)
FlutstrapGrid(
  fluid: false,
  children: [/* ... */],
)

// Styled grid with background
FlutstrapGrid(
  color: Colors.grey[50],
  padding: EdgeInsets.all(24),
  margin: EdgeInsets.all(16),
  decoration: BoxDecoration(
    border: Border.all(color: Colors.grey[300]),
    borderRadius: BorderRadius.circular(8),
  ),
  children: [/* ... */],
)
```

## Properties & Parameters

### Parameter Reference Table

| Parameter    | Type                  | Default      | Description                                  |
| ------------ | --------------------- | ------------ | -------------------------------------------- |
| `children`   | `List<Widget>`        | **required** | Grid children (usually FlutstrapRow widgets) |
| `fluid`      | `bool`                | `false`      | Full-width container vs constrained          |
| `padding`    | `EdgeInsetsGeometry?` | `null`       | Internal padding                             |
| `margin`     | `EdgeInsetsGeometry?` | `null`       | External margin                              |
| `color`      | `Color?`              | `null`       | Background color                             |
| `decoration` | `Decoration?`         | `null`       | Background decoration                        |
| `alignment`  | `AlignmentGeometry?`  | `null`       | Content alignment                            |
| `rowGap`     | `double?`             | `16.0`       | Space between rows                           |

### Factory Method Parameters

#### singleRow()

| Parameter            | Type                  | Default      | Description           |
| -------------------- | --------------------- | ------------ | --------------------- |
| `columns`            | `List<Widget>`        | **required** | Column widgets        |
| `gap`                | `double?`             | `16.0`       | Space between columns |
| `mainAxisAlignment`  | `MainAxisAlignment`   | `start`      | Row alignment         |
| `crossAxisAlignment` | `CrossAxisAlignment`  | `start`      | Column alignment      |
| `fluid`              | `bool`                | `false`      | Container behavior    |
| `padding`            | `EdgeInsetsGeometry?` | `null`       | Grid padding          |
| `margin`             | `EdgeInsetsGeometry?` | `null`       | Grid margin           |

#### multipleRows()

| Parameter            | Type                  | Default      | Description             |
| -------------------- | --------------------- | ------------ | ----------------------- |
| `rows`               | `List<List<Widget>>`  | **required** | 2D array of row columns |
| `rowGap`             | `double?`             | `16.0`       | Space between rows      |
| `columnGap`          | `double?`             | `16.0`       | Space between columns   |
| `mainAxisAlignment`  | `MainAxisAlignment`   | `start`      | Row alignment           |
| `crossAxisAlignment` | `CrossAxisAlignment`  | `start`      | Column alignment        |
| `fluid`              | `bool`                | `false`      | Container behavior      |
| `padding`            | `EdgeInsetsGeometry?` | `null`       | Grid padding            |
| `margin`             | `EdgeInsetsGeometry?` | `null`       | Grid margin             |

#### responsive()

| Parameter    | Type                  | Default      | Description           |
| ------------ | --------------------- | ------------ | --------------------- |
| `children`   | `List<Widget>`        | **required** | Child widgets         |
| `xsColumns`  | `int`                 | `1`          | Mobile columns        |
| `smColumns`  | `int?`                | `null`       | Small screen columns  |
| `mdColumns`  | `int?`                | `null`       | Medium screen columns |
| `lgColumns`  | `int?`                | `null`       | Large screen columns  |
| `xlColumns`  | `int?`                | `null`       | XL screen columns     |
| `xxlColumns` | `int?`                | `null`       | XXL screen columns    |
| `gap`        | `double?`             | `16.0`       | Space between columns |
| `fluid`      | `bool`                | `false`      | Container behavior    |
| `padding`    | `EdgeInsetsGeometry?` | `null`       | Grid padding          |
| `margin`     | `EdgeInsetsGeometry?` | `null`       | Grid margin           |

## Customization

### Advanced Grid Configuration

```dart
FlutstrapGrid(
  fluid: true,
  padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
  margin: EdgeInsets.all(8),
  decoration: BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.blue.shade50, Colors.white],
    ),
  ),
  rowGap: 20.0,
  children: [
    // Header row
    FlutstrapRow(
      children: [
        FlutstrapCol(
          size: FSColSize(xs: 12, md: 8),
          child: Text(
            'Dashboard',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        FlutstrapCol(
          size: FSColSize(xs: 12, md: 4),
          child: FlutstrapButton(
            text: 'Refresh Data',
            variant: FSButtonVariant.primary,
            expanded: true,
          ),
        ),
      ],
    ),

    // Stats row
    FlutstrapRow(
      children: [
        FlutstrapCol(
          size: FSColSize(xs: 6, md: 3),
          child: _buildStatCard('Users', '1,234', Icons.people, Colors.blue),
        ),
        FlutstrapCol(
          size: FSColSize(xs: 6, md: 3),
          child: _buildStatCard('Revenue', '\$12.5K', Icons.attach_money, Colors.green),
        ),
        FlutstrapCol(
          size: FSColSize(xs: 6, md: 3),
          child: _buildStatCard('Orders', '456', Icons.shopping_cart, Colors.orange),
        ),
        FlutstrapCol(
          size: FSColSize(xs: 6, md: 3),
          child: _buildStatCard('Growth', '+12%', Icons.trending_up, Colors.purple),
        ),
      ],
    ),
  ],
)
```

### Complex Multi-Section Layout

```dart
FlutstrapGrid(
  padding: EdgeInsets.all(24),
  margin: EdgeInsets.symmetric(vertical: 16),
  color: Colors.white,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 8,
        offset: Offset(0, 2),
      ),
    ],
  ),
  children: [
    // Section 1: Header
    FlutstrapRow(
      children: [
        FlutstrapCol(
          size: FSColSize.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Project Overview', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('Manage your project settings and team members'),
            ],
          ),
        ),
      ],
    ),

    SizedBox(height: 24), // Custom gap

    // Section 2: Form
    FlutstrapRow(
      children: [
        FlutstrapCol(
          size: FSColSize(xs: 12, lg: 6),
          child: FlutstrapInput(labelText: 'Project Name', placeholder: 'Enter project name'),
        ),
        FlutstrapCol(
          size: FSColSize(xs: 12, lg: 6),
          child: FlutstrapInput(labelText: 'Project Lead', placeholder: 'Select team lead'),
        ),
      ],
    ),

    SizedBox(height: 16),

    // Section 3: Multi-column content
    FlutstrapRow(
      children: [
        FlutstrapCol(
          size: FSColSize(xs: 12, md: 8),
          child: FlutstrapTextArea(
            label: 'Project Description',
            placeholder: 'Describe your project...',
            rows: 4,
          ),
        ),
        FlutstrapCol(
          size: FSColSize(xs: 12, md: 4),
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Text('Team Members', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 12),
                  // Team member list...
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  ],
)
```

## Interactivity & Behavior

### Dynamic Grid with Filtering

```dart
class FilterableGrid extends StatefulWidget {
  @override
  _FilterableGridState createState() => _FilterableGridState();
}

class _FilterableGridState extends State<FilterableGrid> {
  List<Map<String, dynamic>> _items = [
    {'id': 1, 'name': 'Product A', 'category': 'Electronics', 'price': 299},
    {'id': 2, 'name': 'Product B', 'category': 'Books', 'price': 25},
    {'id': 3, 'name': 'Product C', 'category': 'Electronics', 'price': 599},
    {'id': 4, 'name': 'Product D', 'category': 'Clothing', 'price': 49},
    {'id': 5, 'name': 'Product E', 'category': 'Books', 'price': 35},
    {'id': 6, 'name': 'Product F', 'category': 'Electronics', 'price': 799},
  ];

  String _selectedCategory = 'All';
  int _columns = 3;

  List<Map<String, dynamic>> get _filteredItems {
    if (_selectedCategory == 'All') return _items;
    return _items.where((item) => item['category'] == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Controls
        FlutstrapGrid(
          children: [
            FlutstrapRow(
              children: [
                FlutstrapCol(
                  size: FSColSize(xs: 12, md: 6),
                  child: DropdownButtonFormField<String>(
                    value: _selectedCategory,
                    items: ['All', 'Electronics', 'Books', 'Clothing'].map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (value) => setState(() => _selectedCategory = value!),
                    decoration: InputDecoration(labelText: 'Category'),
                  ),
                ),
                FlutstrapCol(
                  size: FSColSize(xs: 12, md: 6),
                  child: DropdownButtonFormField<int>(
                    value: _columns,
                    items: [2, 3, 4].map((cols) {
                      return DropdownMenuItem(
                        value: cols,
                        child: Text('$cols Columns'),
                      );
                    }).toList(),
                    onChanged: (value) => setState(() => _columns = value!),
                    decoration: InputDecoration(labelText: 'Layout'),
                  ),
                ),
              ],
            ),
          ],
        ),

        SizedBox(height: 24),

        // Products grid
        FlutstrapGrid.responsive(
          children: _filteredItems.map((item) {
            return Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(child: Icon(Icons.shopping_bag, size: 48, color: Colors.grey[600])),
                    ),
                    SizedBox(height: 12),
                    Text(item['name'], style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text(item['category'], style: TextStyle(color: Colors.grey[600])),
                    SizedBox(height: 8),
                    Text('\$${item['price']}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
                    SizedBox(height: 12),
                    FlutstrapButton(
                      onPressed: () {},
                      text: 'Add to Cart',
                      size: FSButtonSize.sm,
                      expanded: true,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
          xsColumns: 1,
          smColumns: 2,
          mdColumns: _columns,
          lgColumns: _columns,
          gap: 16.0,
        ),
      ],
    );
  }
}
```

### Auto-fit Grid with Dynamic Content

```dart
class DynamicContentGrid extends StatefulWidget {
  @override
  _DynamicContentGridState createState() => _DynamicContentGridState();
}

class _DynamicContentGridState extends State<DynamicContentGrid> {
  List<Widget> _contentItems = [];

  @override
  void initState() {
    super.initState();
    _loadInitialContent();
  }

  void _loadInitialContent() {
    // Simulate loading content
    setState(() {
      _contentItems = List.generate(12, (index) {
        return Card(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  height: 100,
                  color: Colors.primaries[index % Colors.primaries.length].withOpacity(0.2),
                  child: Center(
                    child: Text(
                      'Item ${index + 1}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Text('Description for item ${index + 1}'),
              ],
            ),
          ),
        );
      });
    });
  }

  void _loadMoreContent() {
    // Simulate loading more content
    setState(() {
      final startIndex = _contentItems.length;
      final newItems = List.generate(6, (index) {
        return Card(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  height: 100,
                  color: Colors.primaries[(startIndex + index) % Colors.primaries.length].withOpacity(0.2),
                  child: Center(
                    child: Text(
                      'Item ${startIndex + index + 1}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Text('New item loaded dynamically'),
              ],
            ),
          ),
        );
      });
      _contentItems.addAll(newItems);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FlutstrapGrid.autoFit(
          children: _contentItems,
          minColumnWidth: 250.0,
          gap: 16.0,
          padding: EdgeInsets.all(16),
        ),

        SizedBox(height: 24),

        FlutstrapButton(
          onPressed: _loadMoreContent,
          text: 'Load More Items',
          variant: FSButtonVariant.outlinePrimary,
        ),
      ],
    );
  }
}
```

## Integration Examples

### Complete E-commerce Product Grid

```dart
class ProductGrid extends StatelessWidget {
  final List<Map<String, dynamic>> products = [
    {
      'id': 1,
      'name': 'Wireless Headphones',
      'price': 199.99,
      'rating': 4.5,
      'image': 'headphones',
      'category': 'Electronics'
    },
    {
      'id': 2,
      'name': 'Smart Watch',
      'price': 299.99,
      'rating': 4.2,
      'image': 'watch',
      'category': 'Electronics'
    },
    // ... more products
  ];

  @override
  Widget build(BuildContext context) {
    return FlutstrapGrid.cards(
      cards: products.map((product) {
        return Card(
          elevation: 2,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product image
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Icon(Icons.shopping_bag, size: 64, color: Colors.grey[600]),
                  ),
                ),

                SizedBox(height: 12),

                // Product name
                Text(
                  product['name'],
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                SizedBox(height: 8),

                // Rating
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    SizedBox(width: 4),
                    Text(product['rating'].toString()),
                    SizedBox(width: 8),
                    Text(product['category'], style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                  ],
                ),

                SizedBox(height: 12),

                // Price and action
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${product['price']}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                    FlutstrapButton(
                      onPressed: () {},
                      text: 'Add to Cart',
                      size: FSButtonSize.sm,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList(),
      columns: 4,
      gap: 16.0,
      equalHeight: true,
      fluid: true,
      padding: EdgeInsets.all(16),
    );
  }
}
```

### Dashboard with Multiple Grid Sections

```dart
class DashboardGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Quick Stats Section
          FlutstrapGrid(
            margin: EdgeInsets.all(16),
            children: [
              FlutstrapRow(
                children: [
                  FlutstrapCol(
                    size: FSColSize(xs: 6, md: 3),
                    child: _buildStatCard('Total Revenue', '\$12,456', Icons.attach_money, Colors.green),
                  ),
                  FlutstrapCol(
                    size: FSColSize(xs: 6, md: 3),
                    child: _buildStatCard('New Users', '1,234', Icons.people, Colors.blue),
                  ),
                  FlutstrapCol(
                    size: FSColSize(xs: 6, md: 3),
                    child: _buildStatCard('Orders', '456', Icons.shopping_cart, Colors.orange),
                  ),
                  FlutstrapCol(
                    size: FSColSize(xs: 6, md: 3),
                    child: _buildStatCard('Conversion', '12.5%', Icons.trending_up, Colors.purple),
                  ),
                ],
              ),
            ],
          ),

          // Charts Section
          FlutstrapGrid(
            margin: EdgeInsets.symmetric(horizontal: 16),
            children: [
              FlutstrapRow(
                children: [
                  FlutstrapCol(
                    size: FSColSize(xs: 12, lg: 8),
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Revenue Overview', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            SizedBox(height: 16),
                            Container(
                              height: 200,
                              color: Colors.grey[100],
                              child: Center(child: Text('Revenue Chart')),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  FlutstrapCol(
                    size: FSColSize(xs: 12, lg: 4),
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Top Products', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            SizedBox(height: 16),
                            _buildProductItem('Wireless Headphones', '\$199'),
                            _buildProductItem('Smart Watch', '\$299'),
                            _buildProductItem('Laptop Stand', '\$89'),
                            _buildProductItem('Phone Case', '\$25'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Recent Activity Section
          FlutstrapGrid(
            margin: EdgeInsets.all(16),
            children: [
              FlutstrapRow(
                children: [
                  FlutstrapCol(
                    size: FSColSize.all(12),
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Recent Activity', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            SizedBox(height: 16),
                            FlutstrapGrid.multipleRows(
                              rows: [
                                ['New order #1234', 'John Doe', '\$199.99', '2 hours ago'],
                                ['User registration', 'Jane Smith', '-', '5 hours ago'],
                                ['Product review', 'Bob Johnson', '5 stars', '1 day ago'],
                                ['Payment received', 'Alice Brown', '\$299.99', '2 days ago'],
                              ],
                              columnGap: 16.0,
                              rowGap: 12.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, size: 20, color: color),
                ),
                Icon(Icons.more_vert, color: Colors.grey[400]),
              ],
            ),
            SizedBox(height: 16),
            Text(title, style: TextStyle(color: Colors.grey[600])),
            SizedBox(height: 4),
            Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildProductItem(String name, String price) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.shopping_bag, size: 20, color: Colors.grey[600]),
          ),
          SizedBox(width: 12),
          Expanded(child: Text(name)),
          Text(price, style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
```

## Performance Optimization

### Efficient Grid Usage Patterns

```dart
// ✅ GOOD: Using appropriate grid type for content
FlutstrapGrid.responsive(
  children: products,
  xsColumns: 1,
  mdColumns: 3,
  lgColumns: 4,
)

// ✅ BETTER: Using auto-fit for dynamic content
FlutstrapGrid.autoFit(
  children: items,
  minColumnWidth: 200.0, // Optimal for content
)

// ❌ AVOID: Overusing complex grids for simple layouts
// Use FlutstrapRow directly for simple horizontal layouts
```

### Memory Management

```dart
// ✅ GOOD: Using const children when possible
FlutstrapGrid(
  children: const [
    FlutstrapRow(children: [/* const children */]),
  ],
)

// ✅ BETTER: Lazy loading for large grids
ListView.builder(
  itemCount: largeList.length,
  itemBuilder: (context, index) {
    return FlutstrapGrid.singleRow(
      columns: [/* build only visible rows */],
    );
  },
)
```

## Best Practices

### Grid Type Selection

```dart
// ✅ SINGLE ROW: Simple horizontal layouts
FlutstrapGrid.singleRow(
  columns: [Header(), Content(), Actions()],
)

// ✅ MULTIPLE ROWS: Tabular data or forms
FlutstrapGrid.multipleRows(
  rows: [
    [Label1(), Input1()],
    [Label2(), Input2()],
    [Label3(), Input3()],
  ],
)

// ✅ RESPONSIVE: Content that changes layout
FlutstrapGrid.responsive(
  children: products,
  xsColumns: 1,  // Mobile: list
  mdColumns: 2,  // Tablet: grid
  lgColumns: 4,  // Desktop: dense grid
)

// ✅ CARDS: Product grids, dashboards
FlutstrapGrid.cards(
  cards: productCards,
  columns: 3,
  equalHeight: true,  // Consistent card heights
)

// ✅ AUTO-FIT: Dynamic content, galleries
FlutstrapGrid.autoFit(
  children: galleryItems,
  minColumnWidth: 150.0,  // Minimum item size
)
```

### Gap Strategy

```dart
// ✅ CONSISTENT: Using Flutstrap spacing
gap: FSSpacing.md,  // 16px
rowGap: FSSpacing.lg, // 24px

// ✅ RESPONSIVE: Different gaps for different screens
LayoutBuilder(
  builder: (context, constraints) {
    final isMobile = constraints.maxWidth < 768;
    return FlutstrapGrid(
      rowGap: isMobile ? FSSpacing.sm : FSSpacing.lg,
      children: [/* ... */],
    );
  },
)
```

## Troubleshooting

### Common Issues and Solutions

**Grid Not Rendering Properly**

```dart
// ❌ Missing container constraints
FlutstrapGrid(
  children: [/* ... */],
  fluid: false, // But parent doesn't provide constraints
)

// ✅ Ensure parent provides constraints or use fluid grid
Container(
  constraints: BoxConstraints(maxWidth: 1200),
  child: FlutstrapGrid(
    children: [/* ... */],
    fluid: false,
  ),
)

// OR use fluid grid
FlutstrapGrid(
  children: [/* ... */],
  fluid: true, // Full width
)
```

**Columns Not Aligning**

```dart
// ❌ Mixed content heights without proper alignment
FlutstrapRow(
  children: [
    FlutstrapCol(child: ShortContent()),
    FlutstrapCol(child: LongContent()), // Misalignment
  ],
)

// ✅ Use stretch alignment for equal heights
FlutstrapRow(
  crossAxisAlignment: CrossAxisAlignment.stretch,
  children: [
    FlutstrapCol(child: Container(child: ShortContent())),
    FlutstrapCol(child: Container(child: LongContent())),
  ],
)
```

**Performance Issues with Large Grids**

```dart
// ❌ Loading all items at once
FlutstrapGrid(
  children: List.generate(1000, (i) => HeavyWidget()), // Performance hit
)

// ✅ Use ListView.builder with grid for large datasets
ListView.builder(
  itemCount: (1000 / columns).ceil(),
  itemBuilder: (context, rowIndex) {
    return FlutstrapRow(
      children: List.generate(columns, (colIndex) {
        final itemIndex = rowIndex * columns + colIndex;
        if (itemIndex >= 1000) return SizedBox.shrink();
        return FlutstrapCol(
          size: FSColSize.all(12 ~/ columns),
          child: HeavyWidget(itemIndex),
        );
      }),
    );
  },
)
```

### Debugging Tips

1. **Check Container Constraints**: Verify parent provides adequate constraints
2. **Test Responsive Behavior**: Check grid on different screen sizes
3. **Inspect Column Sums**: Ensure columns per row don't exceed 12
4. **Monitor Performance**: Use DevTools to check grid rendering performance
5. **Verify Content Sizing**: Ensure content fits within column constraints

---

**This comprehensive guide covers all aspects of using the Flutstrap Grid System. The grid system is designed to be highly flexible, responsive, and intuitive while providing a robust solution for complex layouts across various screen sizes, content types, and design requirements. With features like multiple grid patterns, responsive behavior, and performance optimizations, Flutstrap Grid offers enterprise-grade layout capabilities for modern Flutter applications.**
