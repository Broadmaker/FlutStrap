/// Flutstrap Dropdowns Demo Screen
///
/// Comprehensive demonstration of Flutstrap dropdown components including:
/// - 🎨 All dropdown variants (primary, success, danger, warning, info, etc.)
/// - 📏 Multiple sizes (small, medium, large)
/// - 🔍 Advanced features (search, custom items, icons, grouping)
/// - ⚡ Interactive states (enabled, disabled, loading, error)
/// - 🎯 Custom content (images, complex items, actions)
///
/// Features:
/// - Live interactive dropdown demonstrations
/// - Code examples for each dropdown type
/// - State management for dynamic examples
/// - Search and filtering demonstrations
///
/// {@category Demo}
/// {@category Screens}
/// {@category Forms}

import 'package:flutter/material.dart';
import 'package:master_flutstrap/flutstrap.dart';

class DropdownsScreen extends StatefulWidget {
  const DropdownsScreen({super.key});

  /// Route name for navigation
  static const String routeName = '/dropdowns';

  @override
  State<DropdownsScreen> createState() => _DropdownsScreenState();
}

class _DropdownsScreenState extends State<DropdownsScreen> {
  // ✅ STATE FOR INTERACTIVE EXAMPLES
  String? _selectedBasicValue;
  String? _selectedVariantValue;
  String? _selectedSizeValue;
  String? _selectedSearchValue;
  String? _selectedCustomValue;
  User? _selectedUser;
  bool _dropdownEnabled = true;

  // ✅ SAMPLE DATA
  final List<FSDropdownItem<String>> _basicItems = [
    const FSDropdownItem(value: '1', label: 'Option 1'),
    const FSDropdownItem(value: '2', label: 'Option 2'),
    const FSDropdownItem(value: '3', label: 'Option 3'),
    const FSDropdownItem(value: '4', label: 'Option 4'),
    const FSDropdownItem(value: '5', label: 'Option 5'),
  ];

  final List<FSDropdownItem<String>> _searchItems = [
    const FSDropdownItem(value: 'apple', label: 'Apple'),
    const FSDropdownItem(value: 'banana', label: 'Banana'),
    const FSDropdownItem(value: 'cherry', label: 'Cherry'),
    const FSDropdownItem(value: 'date', label: 'Date'),
    const FSDropdownItem(value: 'elderberry', label: 'Elderberry'),
    const FSDropdownItem(value: 'fig', label: 'Fig'),
    const FSDropdownItem(value: 'grape', label: 'Grape'),
    const FSDropdownItem(value: 'honeydew', label: 'Honeydew'),
  ];

  final List<FSDropdownItem<User>> _userItems = [
    FSDropdownItem(
      value: User(
          id: '1',
          name: 'Alice Johnson',
          email: 'alice@example.com',
          role: 'Admin'),
      label: 'Alice Johnson',
      leading: const CircleAvatar(
        backgroundColor: Colors.blue,
        child: Text('AJ', style: TextStyle(color: Colors.white)),
      ),
      trailing: const Icon(Icons.verified, color: Colors.green, size: 16),
    ),
    FSDropdownItem(
      value: User(
          id: '2', name: 'Bob Smith', email: 'bob@example.com', role: 'User'),
      label: 'Bob Smith',
      leading: const CircleAvatar(
        backgroundColor: Colors.green,
        child: Text('BS', style: TextStyle(color: Colors.white)),
      ),
    ),
    FSDropdownItem(
      value: User(
          id: '3',
          name: 'Carol Davis',
          email: 'carol@example.com',
          role: 'Editor'),
      label: 'Carol Davis',
      leading: const CircleAvatar(
        backgroundColor: Colors.orange,
        child: Text('CD', style: TextStyle(color: Colors.white)),
      ),
      trailing: const Icon(Icons.verified, color: Colors.green, size: 16),
    ),
    FSDropdownItem(
      value: User(
          id: '4',
          name: 'David Wilson',
          email: 'david@example.com',
          role: 'User'),
      label: 'David Wilson',
      leading: const CircleAvatar(
        backgroundColor: Colors.purple,
        child: Text('DW', style: TextStyle(color: Colors.white)),
      ),
    ),
  ];

  final List<FSDropdownItem<String>> _customItems = [
    const FSDropdownItem(
      value: 'premium',
      label: 'Premium Plan',
      leading: Icon(Icons.star, color: Colors.amber, size: 20),
      trailing: Text('\$29.99', style: TextStyle(fontWeight: FontWeight.bold)),
    ),
    const FSDropdownItem(
      value: 'pro',
      label: 'Pro Plan',
      leading: Icon(Icons.workspace_premium, color: Colors.blue, size: 20),
      trailing: Text('\$19.99', style: TextStyle(fontWeight: FontWeight.bold)),
    ),
    const FSDropdownItem(
      value: 'basic',
      label: 'Basic Plan',
      leading: Icon(Icons.check_circle, color: Colors.green, size: 20),
      trailing: Text('\$9.99', style: TextStyle(fontWeight: FontWeight.bold)),
    ),
    const FSDropdownItem(
      value: 'free',
      label: 'Free Plan',
      leading: Icon(Icons.free_breakfast, color: Colors.grey, size: 20),
      trailing: Text('Free', style: TextStyle(color: Colors.grey)),
    ),
  ];

  // ✅ CONSTANTS FOR PERFORMANCE
  static const EdgeInsets _screenPadding = EdgeInsets.all(16.0);
  static const EdgeInsets _sectionPadding = EdgeInsets.only(bottom: 32.0);
  static const EdgeInsets _cardPadding = EdgeInsets.all(16.0);
  static const double _sectionSpacing = 24.0;
  static const double _itemSpacing = 16.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dropdown Components'),
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

            // ✅ BASIC DROPDOWNS
            _buildBasicDropdownsSection(context),
            const SizedBox(height: _sectionSpacing),

            // ✅ DROPDOWN VARIANTS
            _buildDropdownVariantsSection(context),
            const SizedBox(height: _sectionSpacing),

            // ✅ DROPDOWN SIZES
            _buildDropdownSizesSection(context),
            const SizedBox(height: _sectionSpacing),

            // ✅ SEARCH DROPDOWNS
            _buildSearchDropdownsSection(context),
            const SizedBox(height: _sectionSpacing),

            // ✅ CUSTOM CONTENT DROPDOWNS
            _buildCustomContentDropdownsSection(context),
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
            'Flutstrap Dropdowns',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: _itemSpacing),
          Text(
            'High-performance, customizable dropdown menus with Bootstrap-inspired styling. '
            'Dropdowns support search functionality, custom items, icons, and comprehensive accessibility.',
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

  /// Build basic dropdowns section
  Widget _buildBasicDropdownsSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Basic Dropdowns',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Simple dropdowns with text options and basic functionality',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: _itemSpacing),
          Card(
            child: Padding(
              padding: _cardPadding,
              child: Column(
                children: [
                  _buildDropdownWithCode(
                    context,
                    FlutstrapDropdown<String>(
                      items: _basicItems,
                      value: _selectedBasicValue,
                      onChanged: _dropdownEnabled
                          ? (value) {
                              setState(() => _selectedBasicValue = value);
                              _showSnackbar('Selected: $value');
                            }
                          : null,
                      placeholder: 'Select an option',
                      labelText: 'Basic Dropdown',
                    ),
                    'Basic dropdown with label and placeholder',
                  ),
                  const SizedBox(height: 16),
                  _buildDropdownWithCode(
                    context,
                    FlutstrapDropdown<String>(
                      items: _basicItems,
                      value: _selectedBasicValue,
                      onChanged: _dropdownEnabled
                          ? (value) {
                              setState(() => _selectedBasicValue = value);
                            }
                          : null,
                      helperText: 'This is helper text for the dropdown',
                    ),
                    'With helper text',
                  ),
                  const SizedBox(height: 16),
                  _buildDropdownWithCode(
                    context,
                    FlutstrapDropdown<String>(
                      items: _basicItems,
                      value: _selectedBasicValue,
                      onChanged: null, // Disabled
                      placeholder: 'Disabled dropdown',
                      errorText: 'This field is currently disabled',
                    ),
                    'Disabled state (onChanged: null)',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build dropdown variants section
  Widget _buildDropdownVariantsSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dropdown Variants',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Different visual styles for various contexts and semantic meanings',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: _itemSpacing),
          Card(
            child: Padding(
              padding: _cardPadding,
              child: Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  _buildVariantDropdown('Primary', FSDropdownVariant.primary),
                  _buildVariantDropdown('Success', FSDropdownVariant.success),
                  _buildVariantDropdown('Danger', FSDropdownVariant.danger),
                  _buildVariantDropdown('Warning', FSDropdownVariant.warning),
                  _buildVariantDropdown('Info', FSDropdownVariant.info),
                  _buildVariantDropdown('Light', FSDropdownVariant.light),
                  _buildVariantDropdown('Dark', FSDropdownVariant.dark),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build dropdown sizes section
  Widget _buildDropdownSizesSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dropdown Sizes',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Different sizes for various UI contexts and content density',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: _itemSpacing),
          Card(
            child: Padding(
              padding: _cardPadding,
              child: Column(
                children: [
                  _buildSizeDropdown('Small Dropdown', FSDropdownSize.sm),
                  const SizedBox(height: 16),
                  _buildSizeDropdown('Medium Dropdown', FSDropdownSize.md),
                  const SizedBox(height: 16),
                  _buildSizeDropdown('Large Dropdown', FSDropdownSize.lg),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build search dropdowns section
  Widget _buildSearchDropdownsSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Search Dropdowns',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Dropdowns with built-in search functionality for large option sets',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: _itemSpacing),
          Card(
            child: Padding(
              padding: _cardPadding,
              child: Column(
                children: [
                  _buildDropdownWithCode(
                    context,
                    FlutstrapDropdown<String>(
                      items: _searchItems,
                      value: _selectedSearchValue,
                      onChanged: (value) {
                        setState(() => _selectedSearchValue = value);
                        _showSnackbar('Selected: $value');
                      },
                      placeholder: 'Search fruits...',
                      showSearch: true,
                      searchHint: 'Type to filter fruits',
                      labelText: 'Fruit Search Dropdown',
                    ),
                    'showSearch: true',
                  ),
                  const SizedBox(height: 16),
                  _buildDropdownWithCode(
                    context,
                    FlutstrapDropdown<String>(
                      items: _searchItems,
                      value: _selectedSearchValue,
                      onChanged: (value) =>
                          setState(() => _selectedSearchValue = value),
                      placeholder: 'Search with prefix icon',
                      showSearch: true,
                      prefixIcon: const Icon(Icons.search),
                    ),
                    'With custom prefix icon',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build custom content dropdowns section
  Widget _buildCustomContentDropdownsSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Custom Content Dropdowns',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Dropdowns with custom items, icons, images, and complex content',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: _itemSpacing),
          Card(
            child: Padding(
              padding: _cardPadding,
              child: Column(
                children: [
                  // User dropdown with avatars
                  _buildDropdownWithCode(
                    context,
                    FlutstrapDropdown<User>(
                      items: _userItems,
                      value: _selectedUser,
                      onChanged: (user) {
                        setState(() => _selectedUser = user);
                        if (user != null) {
                          _showSnackbar('Selected: ${user.name}');
                        }
                      },
                      placeholder: 'Select a user',
                      labelText: 'User Dropdown',
                    ),
                    'Custom objects with avatars and icons',
                  ),
                  const SizedBox(height: 16),

                  // Custom content dropdown
                  _buildDropdownWithCode(
                    context,
                    FlutstrapDropdown<String>(
                      items: _customItems,
                      value: _selectedCustomValue,
                      onChanged: (value) {
                        setState(() => _selectedCustomValue = value);
                        _showSnackbar('Selected plan: $value');
                      },
                      placeholder: 'Choose a plan',
                      labelText: 'Pricing Plans',
                    ),
                    'Complex items with leading/trailing widgets',
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
            'Dynamic dropdown demonstrations with state management',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: _itemSpacing),
          Card(
            child: Padding(
              padding: _cardPadding,
              child: Column(
                children: [
                  // Current selections display
                  _buildSelectionsDisplay(),
                  const SizedBox(height: 16),

                  // Control buttons
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      FlutstrapButton(
                        onPressed: _toggleDropdownState,
                        text: _dropdownEnabled ? 'Disable All' : 'Enable All',
                        variant: _dropdownEnabled
                            ? FSButtonVariant.warning
                            : FSButtonVariant.success,
                        size: FSButtonSize.sm,
                      ),
                      FlutstrapButton(
                        onPressed: _clearAllSelections,
                        text: 'Clear All',
                        variant: FSButtonVariant.outlineDanger,
                        size: FSButtonSize.sm,
                      ),
                      FlutstrapButton(
                        onPressed: _setRandomSelections,
                        text: 'Randomize',
                        variant: FSButtonVariant.outlinePrimary,
                        size: FSButtonSize.sm,
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Demo dropdown
                  _buildDropdownWithCode(
                    context,
                    FlutstrapDropdown<String>(
                      items: _basicItems,
                      value: _selectedBasicValue,
                      onChanged: _dropdownEnabled
                          ? (value) {
                              setState(() => _selectedBasicValue = value);
                              _showSnackbar('Demo selection: $value');
                            }
                          : null,
                      placeholder: 'Interactive demo dropdown',
                      helperText: _dropdownEnabled
                          ? 'This dropdown is enabled'
                          : 'This dropdown is disabled',
                      errorText: !_dropdownEnabled
                          ? 'Dropdown functionality is currently disabled'
                          : null,
                    ),
                    'Interactive state demonstration',
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

  /// Build dropdown with code example
  Widget _buildDropdownWithCode(
      BuildContext context, Widget dropdown, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        dropdown,
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

  /// Build variant dropdown
  Widget _buildVariantDropdown(String label, FSDropdownVariant variant) {
    return SizedBox(
      width: 200,
      child: FlutstrapDropdown<String>(
        items: _basicItems,
        value: _selectedVariantValue,
        onChanged: (value) => setState(() => _selectedVariantValue = value),
        placeholder: label,
        variant: variant,
      ),
    );
  }

  /// Build size dropdown
  Widget _buildSizeDropdown(String label, FSDropdownSize size) {
    return Row(
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
          child: FlutstrapDropdown<String>(
            items: _basicItems,
            value: _selectedSizeValue,
            onChanged: (value) => setState(() => _selectedSizeValue = value),
            placeholder: 'Select option',
            size: size,
          ),
        ),
      ],
    );
  }

  /// Build selections display
  Widget _buildSelectionsDisplay() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Current Selections:',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text('Basic: ${_selectedBasicValue ?? 'None'}'),
          Text('Variant: ${_selectedVariantValue ?? 'None'}'),
          Text('Size: ${_selectedSizeValue ?? 'None'}'),
          Text('Search: ${_selectedSearchValue ?? 'None'}'),
          Text('Custom: ${_selectedCustomValue ?? 'None'}'),
          Text('User: ${_selectedUser?.name ?? 'None'}'),
          Text('Status: ${_dropdownEnabled ? 'Enabled' : 'Disabled'}'),
        ],
      ),
    );
  }

  // ✅ INTERACTION HANDLERS

  void _toggleDropdownState() {
    setState(() {
      _dropdownEnabled = !_dropdownEnabled;
    });
    _showSnackbar(
        _dropdownEnabled ? 'Dropdowns enabled' : 'Dropdowns disabled');
  }

  void _clearAllSelections() {
    setState(() {
      _selectedBasicValue = null;
      _selectedVariantValue = null;
      _selectedSizeValue = null;
      _selectedSearchValue = null;
      _selectedCustomValue = null;
      _selectedUser = null;
    });
    _showSnackbar('All selections cleared');
  }

  void _setRandomSelections() {
    setState(() {
      _selectedBasicValue =
          _basicItems[DateTime.now().millisecond % _basicItems.length].value;
      _selectedVariantValue =
          _basicItems[DateTime.now().second % _basicItems.length].value;
      _selectedSizeValue =
          _basicItems[DateTime.now().millisecond % _basicItems.length].value;
      _selectedSearchValue =
          _searchItems[DateTime.now().second % _searchItems.length].value;
      _selectedCustomValue =
          _customItems[DateTime.now().millisecond % _customItems.length].value;
      _selectedUser =
          _userItems[DateTime.now().second % _userItems.length].value;
    });
    _showSnackbar('Random selections applied');
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

// ✅ DATA MODELS

class User {
  final String id;
  final String name;
  final String email;
  final String role;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => name;
}
