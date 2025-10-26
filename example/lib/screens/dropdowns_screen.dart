import 'package:flutter/material.dart';
import 'package:master_flutstrap/flutstrap.dart';

class DropdownsScreen extends StatefulWidget {
  const DropdownsScreen({super.key});

  @override
  State<DropdownsScreen> createState() => _DropdownsScreenState();
}

class _DropdownsScreenState extends State<DropdownsScreen> {
  String? _selectedFruit;
  String? _selectedCountry;

  // Separate state variables for each size dropdown
  String? _selectedSmallSize;
  String? _selectedMediumSize;
  String? _selectedLargeSize;

  // Separate state variables for each variant dropdown
  String? _selectedPrimaryVariant;
  String? _selectedSuccessVariant;
  String? _selectedDangerVariant;
  String? _selectedWarningVariant;
  String? _selectedInfoVariant;
  String? _selectedSecondaryVariant;

  // Separate state variables for advanced features section
  String? _selectedPrefixIcon;
  String? _selectedErrorExample;
  String? _selectedMixedItems;

  List<String> _selectedMultiple = [];
  String? _selectedSearch;

  final List<FSDropdownItem<String>> _fruitItems = [
    const FSDropdownItem(value: 'apple', label: 'Apple'),
    const FSDropdownItem(value: 'banana', label: 'Banana'),
    const FSDropdownItem(value: 'orange', label: 'Orange'),
    const FSDropdownItem(value: 'grape', label: 'Grape'),
    const FSDropdownItem(value: 'strawberry', label: 'Strawberry'),
  ];

  final List<FSDropdownItem<String>> _countryItems = [
    const FSDropdownItem(
      value: 'us',
      label: 'United States',
      leading: Icon(Icons.flag, size: 20),
    ),
    const FSDropdownItem(
      value: 'ca',
      label: 'Canada',
      leading: Icon(Icons.flag, size: 20),
    ),
    const FSDropdownItem(
      value: 'uk',
      label: 'United Kingdom',
      leading: Icon(Icons.flag, size: 20),
    ),
    const FSDropdownItem(
      value: 'au',
      label: 'Australia',
      leading: Icon(Icons.flag, size: 20),
    ),
    const FSDropdownItem(
      value: 'jp',
      label: 'Japan',
      leading: Icon(Icons.flag, size: 20),
    ),
  ];

  final List<FSDropdownItem<String>> _sizeItems = [
    const FSDropdownItem(value: 'sm', label: 'Small'),
    const FSDropdownItem(value: 'md', label: 'Medium'),
    const FSDropdownItem(value: 'lg', label: 'Large'),
    const FSDropdownItem(value: 'xl', label: 'Extra Large'),
  ];

  final List<FSDropdownItem<String>> _variantItems = [
    const FSDropdownItem(value: 'primary', label: 'Primary'),
    const FSDropdownItem(value: 'secondary', label: 'Secondary'),
    const FSDropdownItem(value: 'success', label: 'Success'),
    const FSDropdownItem(value: 'danger', label: 'Danger'),
    const FSDropdownItem(value: 'warning', label: 'Warning'),
    const FSDropdownItem(value: 'info', label: 'Info'),
  ];

  final List<FSDropdownItem<String>> _searchItems = [
    const FSDropdownItem(value: 'flutter', label: 'Flutter'),
    const FSDropdownItem(value: 'dart', label: 'Dart'),
    const FSDropdownItem(value: 'android', label: 'Android'),
    const FSDropdownItem(value: 'ios', label: 'iOS'),
    const FSDropdownItem(value: 'web', label: 'Web'),
    const FSDropdownItem(value: 'desktop', label: 'Desktop'),
    const FSDropdownItem(value: 'mobile', label: 'Mobile'),
    const FSDropdownItem(value: 'framework', label: 'Framework'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dropdowns'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(context, 'Basic Dropdown'),
            _buildBasicDropdownSection(context),
            const SizedBox(height: 32),
            _buildSectionTitle(context, 'Dropdown Variants'),
            _buildVariantDropdownsSection(context),
            const SizedBox(height: 32),
            _buildSectionTitle(context, 'Dropdown Sizes'),
            _buildSizeDropdownsSection(context),
            const SizedBox(height: 32),
            _buildSectionTitle(context, 'Advanced Features'),
            _buildAdvancedFeaturesSection(context),
            const SizedBox(height: 32),
            _buildSectionTitle(context, 'With Icons & Custom Items'),
            _buildIconDropdownsSection(context),
            const SizedBox(height: 32),
            _buildSectionTitle(context, 'Searchable Dropdown'),
            _buildSearchableDropdownSection(context),
            const SizedBox(height: 32),
            _buildSectionTitle(context, 'State Display'),
            _buildStateDisplaySection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }

  Widget _buildBasicDropdownSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FlutstrapDropdown<String>(
          items: _fruitItems,
          value: _selectedFruit,
          onChanged: (value) {
            setState(() {
              _selectedFruit = value;
            });
          },
          placeholder: 'Select a fruit',
          labelText: 'Favorite Fruit',
          helperText: 'Choose your favorite fruit from the list',
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'Selected: ${_selectedFruit ?? 'None'}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }

  Widget _buildVariantDropdownsSection(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        SizedBox(
          width: 200,
          child: FlutstrapDropdown<String>(
            items: _variantItems,
            value: _selectedPrimaryVariant,
            onChanged: (value) {
              setState(() {
                _selectedPrimaryVariant = value;
              });
            },
            placeholder: 'Select variant',
            variant: FSDropdownVariant.primary,
          ),
        ),
        SizedBox(
          width: 200,
          child: FlutstrapDropdown<String>(
            items: _variantItems,
            value: _selectedSuccessVariant,
            onChanged: (value) {
              setState(() {
                _selectedSuccessVariant = value;
              });
            },
            placeholder: 'Select variant',
            variant: FSDropdownVariant.success,
          ),
        ),
        SizedBox(
          width: 200,
          child: FlutstrapDropdown<String>(
            items: _variantItems,
            value: _selectedDangerVariant,
            onChanged: (value) {
              setState(() {
                _selectedDangerVariant = value;
              });
            },
            placeholder: 'Select variant',
            variant: FSDropdownVariant.danger,
          ),
        ),
        SizedBox(
          width: 200,
          child: FlutstrapDropdown<String>(
            items: _variantItems,
            value: _selectedWarningVariant,
            onChanged: (value) {
              setState(() {
                _selectedWarningVariant = value;
              });
            },
            placeholder: 'Select variant',
            variant: FSDropdownVariant.warning,
          ),
        ),
        SizedBox(
          width: 200,
          child: FlutstrapDropdown<String>(
            items: _variantItems,
            value: _selectedInfoVariant,
            onChanged: (value) {
              setState(() {
                _selectedInfoVariant = value;
              });
            },
            placeholder: 'Select variant',
            variant: FSDropdownVariant.info,
          ),
        ),
        SizedBox(
          width: 200,
          child: FlutstrapDropdown<String>(
            items: _variantItems,
            value: _selectedSecondaryVariant,
            onChanged: (value) {
              setState(() {
                _selectedSecondaryVariant = value;
              });
            },
            placeholder: 'Select variant',
            variant: FSDropdownVariant.secondary,
          ),
        ),
      ],
    );
  }

  Widget _buildSizeDropdownsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FlutstrapDropdown<String>(
          items: _sizeItems,
          value: _selectedSmallSize,
          onChanged: (value) {
            setState(() {
              _selectedSmallSize = value;
            });
          },
          placeholder: 'Select size',
          labelText: 'Small Size',
          size: FSDropdownSize.sm,
        ),
        const SizedBox(height: 16),
        FlutstrapDropdown<String>(
          items: _sizeItems,
          value: _selectedMediumSize,
          onChanged: (value) {
            setState(() {
              _selectedMediumSize = value;
            });
          },
          placeholder: 'Select size',
          labelText: 'Medium Size (Default)',
          size: FSDropdownSize.md,
        ),
        const SizedBox(height: 16),
        FlutstrapDropdown<String>(
          items: _sizeItems,
          value: _selectedLargeSize,
          onChanged: (value) {
            setState(() {
              _selectedLargeSize = value;
            });
          },
          placeholder: 'Select size',
          labelText: 'Large Size',
          size: FSDropdownSize.lg,
        ),
      ],
    );
  }

  Widget _buildAdvancedFeaturesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FlutstrapDropdown<String>(
          items: _fruitItems,
          value: _selectedPrefixIcon,
          onChanged: (value) {
            setState(() {
              _selectedPrefixIcon = value;
            });
          },
          placeholder: 'Select with prefix icon',
          labelText: 'With Prefix Icon',
          prefixIcon: const Icon(Icons.food_bank),
        ),
        const SizedBox(height: 16),
        FlutstrapDropdown<String>(
          items: _fruitItems,
          value: _selectedErrorExample,
          onChanged: (value) {
            setState(() {
              _selectedErrorExample = value;
            });
          },
          placeholder: 'Select with error state',
          labelText: 'Error State Example',
          errorText:
              _selectedErrorExample == null ? 'This field is required' : null,
        ),
        const SizedBox(height: 16),
        FlutstrapDropdown<String>(
          items: _fruitItems,
          value: _selectedFruit,
          onChanged: null, // Disabled
          placeholder: 'Disabled dropdown',
          labelText: 'Disabled State',
          enabled: false,
        ),
        const SizedBox(height: 16),
        FlutstrapDropdown<String>(
          items: [
            const FSDropdownItem(value: 'enabled', label: 'Enabled Option'),
            const FSDropdownItem(
                value: 'disabled', label: 'Disabled Option', enabled: false),
            const FSDropdownItem(value: 'enabled2', label: 'Another Enabled'),
          ],
          value: _selectedMixedItems,
          onChanged: (value) {
            setState(() {
              _selectedMixedItems = value;
            });
          },
          placeholder: 'Mixed enabled/disabled',
          labelText: 'Mixed Items',
        ),
      ],
    );
  }

  Widget _buildIconDropdownsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FlutstrapDropdown<String>(
          items: _countryItems,
          value: _selectedCountry,
          onChanged: (value) {
            setState(() {
              _selectedCountry = value;
            });
          },
          placeholder: 'Select a country',
          labelText: 'Country with Flags',
        ),
        const SizedBox(height: 16),
        FlutstrapDropdown<String>(
          items: [
            const FSDropdownItem(
              value: 'profile',
              label: 'Profile Settings',
              leading: Icon(Icons.person),
              trailing: Icon(Icons.chevron_right),
            ),
            const FSDropdownItem(
              value: 'security',
              label: 'Security',
              leading: Icon(Icons.security),
              trailing: Icon(Icons.chevron_right),
            ),
            const FSDropdownItem(
              value: 'notifications',
              label: 'Notifications',
              leading: Icon(Icons.notifications),
              trailing: Icon(Icons.chevron_right),
            ),
            const FSDropdownItem(
              value: 'help',
              label: 'Help & Support',
              leading: Icon(Icons.help),
              trailing: Icon(Icons.chevron_right),
            ),
          ],
          value: _selectedCountry,
          onChanged: (value) {
            setState(() {
              _selectedCountry = value;
            });
          },
          placeholder: 'Select menu option',
          labelText: 'Settings Menu Style',
        ),
      ],
    );
  }

  Widget _buildSearchableDropdownSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FlutstrapDropdown<String>(
          items: _searchItems,
          value: _selectedSearch,
          onChanged: (value) {
            setState(() {
              _selectedSearch = value;
            });
          },
          placeholder: 'Search for a term...',
          labelText: 'Searchable Dropdown',
          showSearch: true,
          searchHint: 'Type to search...',
          menuMaxHeight: 300,
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Selected: ${_selectedSearch ?? 'None'}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 4),
              Text(
                'Try typing "mobile" or "web" in the search box',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStateDisplaySection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Current Selections:',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 12),
          _buildStateItem('Favorite Fruit', _selectedFruit),
          _buildStateItem('Country', _selectedCountry),
          _buildStateItem('Small Size', _selectedSmallSize),
          _buildStateItem('Medium Size', _selectedMediumSize),
          _buildStateItem('Large Size', _selectedLargeSize),
          _buildStateItem('Primary Variant', _selectedPrimaryVariant),
          _buildStateItem('Success Variant', _selectedSuccessVariant),
          _buildStateItem('Danger Variant', _selectedDangerVariant),
          _buildStateItem('Warning Variant', _selectedWarningVariant),
          _buildStateItem('Info Variant', _selectedInfoVariant),
          _buildStateItem('Secondary Variant', _selectedSecondaryVariant),
          _buildStateItem('Prefix Icon Example', _selectedPrefixIcon),
          _buildStateItem('Error Example', _selectedErrorExample),
          _buildStateItem('Mixed Items', _selectedMixedItems),
          _buildStateItem('Search Term', _selectedSearch),
        ],
      ),
    );
  }

  Widget _buildStateItem(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          Text(value ?? 'Not selected'),
        ],
      ),
    );
  }
}
