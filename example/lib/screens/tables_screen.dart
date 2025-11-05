/// Flutstrap Tables Demo Screen
///
/// Comprehensive demonstration of Flutstrap table components including:
/// - 🎨 All table variants (primary, success, danger, warning, info, light, dark)
/// - 📏 Multiple sizes (small, medium, large)
/// - ⚡ Advanced features (sorting, virtualization, responsive behavior)
/// - 📊 Real-world examples (user tables, product catalogs, data grids)
/// - 🎯 Interactive demonstrations with live data
///
/// Features:
/// - Live interactive table demonstrations
/// - Code examples for each table configuration
/// - State management for dynamic examples
/// - Real-time sorting and filtering
///
/// {@category Demo}
/// {@category Screens}
/// {@category Data Display}

import 'package:flutter/material.dart';
import 'package:flutstrap/flutstrap.dart';

// Sample data models
class User {
  final int id;
  final String name;
  final String email;
  final String role;
  final bool isActive;
  final DateTime joinDate;
  final double balance;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.isActive,
    required this.joinDate,
    required this.balance,
  });
}

class Product {
  final String id;
  final String name;
  final String category;
  final double price;
  final int stock;
  final double rating;
  final bool featured;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.stock,
    required this.rating,
    required this.featured,
  });
}

class Transaction {
  final String id;
  final DateTime date;
  final String description;
  final double amount;
  final String status;
  final String category;

  const Transaction({
    required this.id,
    required this.date,
    required this.description,
    required this.amount,
    required this.status,
    required this.category,
  });
}

class TablesScreen extends StatefulWidget {
  const TablesScreen({super.key});

  /// Route name for navigation
  static const String routeName = '/tables';

  @override
  State<TablesScreen> createState() => _TablesScreenState();
}

class _TablesScreenState extends State<TablesScreen> {
  // ✅ STATE FOR INTERACTIVE EXAMPLES
  FSTableVariant _selectedVariant = FSTableVariant.primary;
  FSTableSize _selectedSize = FSTableSize.md;
  FSTableResponsive _selectedResponsive = FSTableResponsive.scroll;
  bool _striped = true;
  bool _bordered = false;
  bool _hover = true;
  bool _showHeader = true;
  bool _virtualized = true;
  int _currentDataset = 0;

  // ✅ SAMPLE DATA
  final List<User> _users = [
    User(
      id: 1,
      name: 'John Smith',
      email: 'john.smith@example.com',
      role: 'Admin',
      isActive: true,
      joinDate: DateTime(2023, 1, 15),
      balance: 1250.75,
    ),
    User(
      id: 2,
      name: 'Sarah Johnson',
      email: 'sarah.j@example.com',
      role: 'User',
      isActive: true,
      joinDate: DateTime(2023, 3, 22),
      balance: 850.50,
    ),
    User(
      id: 3,
      name: 'Michael Brown',
      email: 'm.brown@example.com',
      role: 'Moderator',
      isActive: false,
      joinDate: DateTime(2022, 11, 5),
      balance: 2100.00,
    ),
    User(
      id: 4,
      name: 'Emily Davis',
      email: 'emily.davis@example.com',
      role: 'User',
      isActive: true,
      joinDate: DateTime(2023, 6, 18),
      balance: 450.25,
    ),
    User(
      id: 5,
      name: 'David Wilson',
      email: 'd.wilson@example.com',
      role: 'Admin',
      isActive: true,
      joinDate: DateTime(2022, 8, 30),
      balance: 3200.80,
    ),
  ];

  final List<Product> _products = [
    Product(
      id: 'P001',
      name: 'Wireless Headphones',
      category: 'Electronics',
      price: 199.99,
      stock: 45,
      rating: 4.5,
      featured: true,
    ),
    Product(
      id: 'P002',
      name: 'Smart Watch',
      category: 'Electronics',
      price: 299.99,
      stock: 23,
      rating: 4.2,
      featured: true,
    ),
    Product(
      id: 'P003',
      name: 'Coffee Maker',
      category: 'Home Appliances',
      price: 89.99,
      stock: 67,
      rating: 4.7,
      featured: false,
    ),
    Product(
      id: 'P004',
      name: 'Desk Lamp',
      category: 'Home Decor',
      price: 45.50,
      stock: 12,
      rating: 4.0,
      featured: true,
    ),
    Product(
      id: 'P005',
      name: 'Yoga Mat',
      category: 'Fitness',
      price: 29.99,
      stock: 89,
      rating: 4.8,
      featured: false,
    ),
  ];

  final List<Transaction> _transactions = [
    Transaction(
      id: 'T001',
      date: DateTime(2024, 1, 15),
      description: 'Online Purchase - Electronics',
      amount: -199.99,
      status: 'Completed',
      category: 'Shopping',
    ),
    Transaction(
      id: 'T002',
      date: DateTime(2024, 1, 14),
      description: 'Salary Deposit',
      amount: 2500.00,
      status: 'Completed',
      category: 'Income',
    ),
    Transaction(
      id: 'T003',
      date: DateTime(2024, 1, 13),
      description: 'Utility Bill Payment',
      amount: -120.50,
      status: 'Pending',
      category: 'Bills',
    ),
    Transaction(
      id: 'T004',
      date: DateTime(2024, 1, 12),
      description: 'Restaurant Dinner',
      amount: -75.25,
      status: 'Completed',
      category: 'Dining',
    ),
    Transaction(
      id: 'T005',
      date: DateTime(2024, 1, 11),
      description: 'Stock Dividend',
      amount: 45.75,
      status: 'Completed',
      category: 'Investment',
    ),
  ];

  // ✅ TABLE COLUMNS
  final List<FSTableColumn<User>> _userColumns = [
    FSTableColumn<User>(
      header: 'ID',
      accessor: 'id',
      sortable: true,
      width: 80,
      headerAlign: TextAlign.center,
      cellAlign: TextAlign.center,
      priority: 1,
    ),
    FSTableColumn<User>(
      header: 'Name',
      accessor: 'name',
      sortable: true,
      priority: 1,
    ),
    FSTableColumn<User>(
      header: 'Email',
      accessor: 'email',
      sortable: true,
      priority: 2,
    ),
    FSTableColumn<User>(
      header: 'Role',
      accessor: 'role',
      sortable: true,
      width: 120,
      priority: 2,
    ),
    FSTableColumn<User>(
      header: 'Status',
      cellBuilder: (user) => FlutstrapBadge(
        text: user.isActive ? 'Active' : 'Inactive',
        variant:
            user.isActive ? FSBadgeVariant.success : FSBadgeVariant.secondary,
        size: FSBadgeSize.sm,
      ),
      sortable: false,
      width: 100,
      priority: 3,
    ),
    FSTableColumn<User>(
      header: 'Join Date',
      cellBuilder: (user) => Text(
        '${user.joinDate.month}/${user.joinDate.day}/${user.joinDate.year}',
      ),
      sortable: true,
      width: 120,
      priority: 3,
    ),
    FSTableColumn<User>(
      header: 'Balance',
      cellBuilder: (user) => Text(
        '\$${user.balance.toStringAsFixed(2)}',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: user.balance >= 1000 ? Colors.green : Colors.orange,
        ),
      ),
      sortable: true,
      width: 120,
      headerAlign: TextAlign.right,
      cellAlign: TextAlign.right,
      priority: 4,
    ),
  ];

  final List<FSTableColumn<Product>> _productColumns = [
    FSTableColumn<Product>(
      header: 'ID',
      accessor: 'id',
      sortable: true,
      width: 100,
      priority: 1,
    ),
    FSTableColumn<Product>(
      header: 'Name',
      accessor: 'name',
      sortable: true,
      priority: 1,
    ),
    FSTableColumn<Product>(
      header: 'Category',
      accessor: 'category',
      sortable: true,
      width: 150,
      priority: 2,
    ),
    FSTableColumn<Product>(
      header: 'Price',
      cellBuilder: (product) => Text(
        '\$${product.price.toStringAsFixed(2)}',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      sortable: true,
      width: 100,
      headerAlign: TextAlign.right,
      cellAlign: TextAlign.right,
      priority: 2,
    ),
    FSTableColumn<Product>(
      header: 'Stock',
      accessor: 'stock',
      sortable: true,
      width: 80,
      headerAlign: TextAlign.center,
      cellAlign: TextAlign.center,
      priority: 3,
    ),
    FSTableColumn<Product>(
      header: 'Rating',
      cellBuilder: (product) => Row(
        children: [
          Icon(Icons.star, color: Colors.amber, size: 16),
          SizedBox(width: 4),
          Text(product.rating.toStringAsFixed(1)),
        ],
      ),
      sortable: true,
      width: 100,
      priority: 3,
    ),
    FSTableColumn<Product>(
      header: 'Featured',
      cellBuilder: (product) => product.featured
          ? Icon(Icons.check_circle, color: Colors.green, size: 20)
          : Icon(Icons.circle_outlined, color: Colors.grey, size: 20),
      sortable: true,
      width: 100,
      headerAlign: TextAlign.center,
      cellAlign: TextAlign.center,
      priority: 4,
    ),
  ];

  final List<FSTableColumn<Transaction>> _transactionColumns = [
    FSTableColumn<Transaction>(
      header: 'ID',
      accessor: 'id',
      sortable: true,
      width: 100,
      priority: 1,
    ),
    FSTableColumn<Transaction>(
      header: 'Date',
      cellBuilder: (transaction) => Text(
        '${transaction.date.month}/${transaction.date.day}/${transaction.date.year}',
      ),
      sortable: true,
      width: 120,
      priority: 1,
    ),
    FSTableColumn<Transaction>(
      header: 'Description',
      accessor: 'description',
      sortable: true,
      priority: 1,
    ),
    FSTableColumn<Transaction>(
      header: 'Amount',
      cellBuilder: (transaction) => Text(
        '\$${transaction.amount.abs().toStringAsFixed(2)}',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: transaction.amount >= 0 ? Colors.green : Colors.red,
        ),
      ),
      sortable: true,
      width: 120,
      headerAlign: TextAlign.right,
      cellAlign: TextAlign.right,
      priority: 2,
    ),
    FSTableColumn<Transaction>(
      header: 'Status',
      cellBuilder: (transaction) => FlutstrapBadge(
        text: transaction.status,
        variant: transaction.status == 'Completed'
            ? FSBadgeVariant.success
            : transaction.status == 'Pending'
                ? FSBadgeVariant.warning
                : FSBadgeVariant.secondary,
        size: FSBadgeSize.sm,
      ),
      sortable: true,
      width: 120,
      priority: 2,
    ),
    FSTableColumn<Transaction>(
      header: 'Category',
      accessor: 'category',
      sortable: true,
      width: 120,
      priority: 3,
    ),
  ];

  // ✅ CONSTANTS
  static const EdgeInsets _screenPadding = EdgeInsets.all(16.0);
  static const EdgeInsets _sectionPadding = EdgeInsets.only(bottom: 32.0);
  static const EdgeInsets _demoPadding = EdgeInsets.all(16.0);
  static const double _sectionSpacing = 24.0;

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _onUserRowTap(User user) {
    _showSnackbar('Selected user: ${user.name}');
  }

  void _onProductRowTap(Product product) {
    _showSnackbar('Selected product: ${product.name}');
  }

  void _onTransactionRowTap(Transaction transaction) {
    _showSnackbar('Selected transaction: ${transaction.description}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Table Components'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      body: Padding(
        padding: _screenPadding,
        child: ListView(
          children: [
            // ✅ INTRODUCTION SECTION
            _buildIntroductionSection(context),
            const SizedBox(height: _sectionSpacing),

            // ✅ BASIC TABLES
            _buildBasicTablesSection(context),
            const SizedBox(height: _sectionSpacing),

            // ✅ TABLE VARIANTS
            _buildTableVariantsSection(context),
            const SizedBox(height: _sectionSpacing),

            // ✅ ADVANCED FEATURES
            _buildAdvancedFeaturesSection(context),
            const SizedBox(height: _sectionSpacing),

            // ✅ INTERACTIVE DEMO
            _buildInteractiveDemoSection(context),
          ],
        ),
      ),
    );
  }

  /// Build introduction section
  Widget _buildIntroductionSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Flutstrap Tables',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            'High-performance, customizable tables with Bootstrap-inspired styling. '
            'Tables support sorting, virtualization, responsive behavior, and comprehensive '
            'accessibility features for displaying large datasets efficiently.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  height: 1.5,
                ),
          ),
        ],
      ),
    );
  }

  /// Build basic tables section
  Widget _buildBasicTablesSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Basic Tables',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Simple table configurations with different data types',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: _demoPadding,
              child: Column(
                children: [
                  _buildTableWithCode(
                    context,
                    FlutstrapTable<User>(
                      columns: _userColumns,
                      data: _users,
                      striped: true,
                      hover: true,
                      onRowTap: _onUserRowTap,
                    ),
                    'User table with sorting and row actions',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build table variants section
  Widget _buildTableVariantsSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Table Variants',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Different visual styles for various design contexts',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: _demoPadding,
              child: Column(
                children: [
                  _buildVariantTable('Primary Variant', FSTableVariant.primary),
                  const SizedBox(height: 16),
                  _buildVariantTable('Success Variant', FSTableVariant.success),
                  const SizedBox(height: 16),
                  _buildVariantTable('Danger Variant', FSTableVariant.danger),
                  const SizedBox(height: 16),
                  _buildVariantTable('Light Variant', FSTableVariant.light),
                  const SizedBox(height: 16),
                  _buildVariantTable('Dark Variant', FSTableVariant.dark),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build advanced features section
  Widget _buildAdvancedFeaturesSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Advanced Features',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Virtualization, responsive behavior, and custom configurations',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: _demoPadding,
              child: Column(
                children: [
                  _buildTableWithCode(
                    context,
                    FlutstrapTable<Product>(
                      columns: _productColumns,
                      data: _products,
                      variant: FSTableVariant.primary,
                      striped: true,
                      hover: true,
                      bordered: true,
                      onRowTap: _onProductRowTap,
                    ),
                    'Product table with borders and custom cell rendering',
                  ),
                  const SizedBox(height: 16),
                  _buildTableWithCode(
                    context,
                    FlutstrapTable<Transaction>(
                      columns: _transactionColumns,
                      data: _transactions,
                      variant: FSTableVariant.info,
                      size: FSTableSize.sm,
                      condensed: true,
                      onRowTap: _onTransactionRowTap,
                    ),
                    'Condensed transaction table with small size',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build interactive demo section
  Widget _buildInteractiveDemoSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Interactive Demo',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Customize table features and see real-time changes',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: _demoPadding,
              child: Column(
                children: [
                  // Current configuration
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Current Configuration:',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        Text('Variant: ${_selectedVariant.name}'),
                        Text('Size: ${_selectedSize.name}'),
                        Text('Responsive: ${_selectedResponsive.name}'),
                        Text('Striped: $_striped'),
                        Text('Bordered: $_bordered'),
                        Text('Hover: $_hover'),
                        Text('Virtualized: $_virtualized'),
                        Text('Dataset: ${_getDatasetName(_currentDataset)}'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Live table preview
                  _buildTableWithCode(
                    context,
                    _buildLiveDemoTable(),
                    'Live table preview with current settings',
                  ),

                  const SizedBox(height: 16),

                  // Configuration controls
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Table Configuration:',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 16),

                      // Variant selection
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Variant:'),
                          Wrap(
                            spacing: 8,
                            children: [
                              _buildVariantButton(
                                  'Primary', FSTableVariant.primary),
                              _buildVariantButton(
                                  'Success', FSTableVariant.success),
                              _buildVariantButton(
                                  'Danger', FSTableVariant.danger),
                              _buildVariantButton(
                                  'Warning', FSTableVariant.warning),
                              _buildVariantButton('Info', FSTableVariant.info),
                              _buildVariantButton(
                                  'Light', FSTableVariant.light),
                              _buildVariantButton('Dark', FSTableVariant.dark),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Size selection
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Size:'),
                          Wrap(
                            spacing: 8,
                            children: [
                              _buildSizeButton('Small', FSTableSize.sm),
                              _buildSizeButton('Medium', FSTableSize.md),
                              _buildSizeButton('Large', FSTableSize.lg),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Responsive selection
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Responsive Behavior:'),
                          Wrap(
                            spacing: 8,
                            children: [
                              _buildResponsiveButton(
                                  'None', FSTableResponsive.none),
                              _buildResponsiveButton(
                                  'Scroll', FSTableResponsive.scroll),
                              _buildResponsiveButton(
                                  'Collapse', FSTableResponsive.collapse),
                              _buildResponsiveButton(
                                  'Stacked', FSTableResponsive.stacked),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Toggle options
                      Wrap(
                        spacing: 16,
                        runSpacing: 8,
                        children: [
                          _buildToggleOption('Striped', _striped,
                              (value) => setState(() => _striped = value)),
                          _buildToggleOption('Bordered', _bordered,
                              (value) => setState(() => _bordered = value)),
                          _buildToggleOption('Hover', _hover,
                              (value) => setState(() => _hover = value)),
                          _buildToggleOption('Show Header', _showHeader,
                              (value) => setState(() => _showHeader = value)),
                          _buildToggleOption('Virtualized', _virtualized,
                              (value) => setState(() => _virtualized = value)),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Dataset selection
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Dataset:'),
                          Wrap(
                            spacing: 8,
                            children: [
                              _buildDatasetButton('Users', 0),
                              _buildDatasetButton('Products', 1),
                              _buildDatasetButton('Transactions', 2),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ✅ HELPER METHODS

  /// Build table with code example
  Widget _buildTableWithCode(
      BuildContext context, Widget table, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        table,
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            description,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
        ),
      ],
    );
  }

  /// Build variant table
  Widget _buildVariantTable(String label, FSTableVariant variant) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        FlutstrapTable<User>(
          columns: _userColumns.take(4).toList(),
          data: _users.take(3).toList(),
          variant: variant,
          striped: true,
          hover: true,
          showHeader: true,
        ),
      ],
    );
  }

  /// Build live demo table
  Widget _buildLiveDemoTable() {
    switch (_currentDataset) {
      case 0:
        return FlutstrapTable<User>(
          columns: _userColumns,
          data: _users,
          variant: _selectedVariant,
          size: _selectedSize,
          responsive: _selectedResponsive,
          striped: _striped,
          bordered: _bordered,
          hover: _hover,
          showHeader: _showHeader,
          virtualized: _virtualized,
          onRowTap: _onUserRowTap,
        );
      case 1:
        return FlutstrapTable<Product>(
          columns: _productColumns,
          data: _products,
          variant: _selectedVariant,
          size: _selectedSize,
          responsive: _selectedResponsive,
          striped: _striped,
          bordered: _bordered,
          hover: _hover,
          showHeader: _showHeader,
          virtualized: _virtualized,
          onRowTap: _onProductRowTap,
        );
      case 2:
        return FlutstrapTable<Transaction>(
          columns: _transactionColumns,
          data: _transactions,
          variant: _selectedVariant,
          size: _selectedSize,
          responsive: _selectedResponsive,
          striped: _striped,
          bordered: _bordered,
          hover: _hover,
          showHeader: _showHeader,
          virtualized: _virtualized,
          onRowTap: _onTransactionRowTap,
        );
      default:
        return const SizedBox.shrink();
    }
  }

  /// Build variant button
  Widget _buildVariantButton(String label, FSTableVariant variant) {
    return FlutstrapButton(
      onPressed: () => setState(() => _selectedVariant = variant),
      text: label,
      size: FSButtonSize.sm,
      variant: _selectedVariant == variant
          ? FSButtonVariant.primary
          : FSButtonVariant.outlinePrimary,
    );
  }

  /// Build size button
  Widget _buildSizeButton(String label, FSTableSize size) {
    return FlutstrapButton(
      onPressed: () => setState(() => _selectedSize = size),
      text: label,
      size: FSButtonSize.sm,
      variant: _selectedSize == size
          ? FSButtonVariant.success
          : FSButtonVariant.outlineSuccess,
    );
  }

  /// Build responsive button
  Widget _buildResponsiveButton(String label, FSTableResponsive responsive) {
    return FlutstrapButton(
      onPressed: () => setState(() => _selectedResponsive = responsive),
      text: label,
      size: FSButtonSize.sm,
      variant: _selectedResponsive == responsive
          ? FSButtonVariant.info
          : FSButtonVariant.outlineInfo,
    );
  }

  /// Build dataset button
  Widget _buildDatasetButton(String label, int datasetIndex) {
    return FlutstrapButton(
      onPressed: () => setState(() => _currentDataset = datasetIndex),
      text: label,
      size: FSButtonSize.sm,
      variant: _currentDataset == datasetIndex
          ? FSButtonVariant.warning
          : FSButtonVariant.outlineWarning,
    );
  }

  /// Build toggle option
  Widget _buildToggleOption(
      String label, bool value, ValueChanged<bool> onChanged) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Switch(
          value: value,
          onChanged: onChanged,
        ),
        const SizedBox(width: 4),
        Text(label),
      ],
    );
  }

  /// Get dataset name
  String _getDatasetName(int index) {
    switch (index) {
      case 0:
        return 'Users';
      case 1:
        return 'Products';
      case 2:
        return 'Transactions';
      default:
        return 'Unknown';
    }
  }
}
