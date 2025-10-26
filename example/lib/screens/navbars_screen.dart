import 'package:flutter/material.dart';
import 'package:master_flutstrap/flutstrap.dart';

class NavbarsScreen extends StatefulWidget {
  const NavbarsScreen({super.key});

  @override
  State<NavbarsScreen> createState() => _NavbarsScreenState();
}

class _NavbarsScreenState extends State<NavbarsScreen> {
  int _currentSection = 0;
  String _searchQuery = '';

  late List<FSNavbarItem> _basicNavbarItems;
  late List<FSNavbarItem> _dropdownNavbarItems;
  late List<FSNavbarItem> _activeNavbarItems;
  late List<FSNavbarItem> _disabledNavbarItems;

  @override
  void initState() {
    super.initState();
    _initializeNavbarItems();
  }

  void _initializeNavbarItems() {
    _basicNavbarItems = [
      FSNavbarItem.simple(
        label: 'Home',
        onTap: () => _showSnackBar('Home clicked'),
      ),
      FSNavbarItem.simple(
        label: 'Features',
        onTap: () => _showSnackBar('Features clicked'),
      ),
      FSNavbarItem.simple(
        label: 'Pricing',
        onTap: () => _showSnackBar('Pricing clicked'),
      ),
      FSNavbarItem.simple(
        label: 'About',
        onTap: () => _showSnackBar('About clicked'),
      ),
    ];

    _dropdownNavbarItems = [
      FSNavbarItem.simple(
        label: 'Home',
        onTap: () => _showSnackBar('Home clicked'),
      ),
      FSNavbarItem.dropdown(
        label: 'Products',
        children: [
          FSNavbarItem.simple(
            label: 'Web App',
            onTap: () => _showSnackBar('Web App clicked'),
          ),
          FSNavbarItem.simple(
            label: 'Mobile App',
            onTap: () => _showSnackBar('Mobile App clicked'),
          ),
          FSNavbarItem.simple(
            label: 'Desktop App',
            onTap: () => _showSnackBar('Desktop App clicked'),
          ),
        ],
      ),
      FSNavbarItem.dropdown(
        label: 'Services',
        children: [
          FSNavbarItem.simple(
            label: 'Consulting',
            onTap: () => _showSnackBar('Consulting clicked'),
          ),
          FSNavbarItem.simple(
            label: 'Development',
            onTap: () => _showSnackBar('Development clicked'),
          ),
          FSNavbarItem.simple(
            label: 'Support',
            onTap: () => _showSnackBar('Support clicked'),
          ),
        ],
      ),
      FSNavbarItem.simple(
        label: 'Contact',
        onTap: () => _showSnackBar('Contact clicked'),
      ),
    ];

    _activeNavbarItems = [
      FSNavbarItem(
        label: 'Dashboard',
        onTap: () => _showSnackBar('Dashboard clicked'),
        isActive: true,
      ),
      FSNavbarItem.simple(
        label: 'Projects',
        onTap: () => _showSnackBar('Projects clicked'),
      ),
      FSNavbarItem.simple(
        label: 'Team',
        onTap: () => _showSnackBar('Team clicked'),
      ),
      FSNavbarItem.simple(
        label: 'Calendar',
        onTap: () => _showSnackBar('Calendar clicked'),
      ),
    ];

    _disabledNavbarItems = [
      FSNavbarItem.simple(
        label: 'Home',
        onTap: () => _showSnackBar('Home clicked'),
      ),
      FSNavbarItem(
        label: 'Disabled Item',
        onTap: () => _showSnackBar('This should not fire'),
        enabled: false,
      ),
      FSNavbarItem.simple(
        label: 'Services',
        onTap: () => _showSnackBar('Services clicked'),
      ),
    ];
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(milliseconds: 800),
      ),
    );
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
    _showSnackBar('Searching for: $query');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nav Bars'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isSmallScreen = constraints.maxWidth < 600;

          return CustomScrollView(
            slivers: [
              // Example 1: Basic Light Navbar
              SliverToBoxAdapter(
                child: _buildNavbarExample(
                  context,
                  'Basic Light Navbar',
                  'Simple navbar with brand and navigation items',
                  FlutstrapNavbar(
                    brandText: 'Flutstrap',
                    items: _basicNavbarItems,
                    variant: FSNavbarVariant.light,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                  ),
                ),
              ),

              // Example 2: Dark Variant
              SliverToBoxAdapter(
                child: _buildNavbarExample(
                  context,
                  'Dark Variant',
                  'Navbar with dark background theme',
                  FlutstrapNavbar(
                    brandText: 'Flutstrap',
                    items: _basicNavbarItems,
                    variant: FSNavbarVariant.dark,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                  ),
                ),
              ),

              // Example 3: Primary Color Variant
              SliverToBoxAdapter(
                child: _buildNavbarExample(
                  context,
                  'Primary Color Variant',
                  'Navbar with primary color theme',
                  FlutstrapNavbar(
                    brandText: 'Flutstrap',
                    items: _basicNavbarItems,
                    variant: FSNavbarVariant.primary,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                  ),
                ),
              ),

              // Example 4: With Search
              SliverToBoxAdapter(
                child: _buildNavbarExample(
                  context,
                  'With Search Box',
                  'Navbar with integrated search functionality',
                  FlutstrapNavbar(
                    brandText: 'Flutstrap',
                    items: _basicNavbarItems,
                    variant: FSNavbarVariant.light,
                    showSearch: true,
                    searchPlaceholder: 'Search...',
                    onSearch: _onSearchChanged,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                  ),
                ),
              ),

              // Example 5: With Dropdown Menus
              SliverToBoxAdapter(
                child: _buildNavbarExample(
                  context,
                  'With Dropdown Menus',
                  'Navbar with dropdown navigation items',
                  FlutstrapNavbar(
                    brandText: 'Flutstrap',
                    items: _dropdownNavbarItems,
                    variant: FSNavbarVariant.light,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                  ),
                ),
              ),

              // Example 6: With Active State
              SliverToBoxAdapter(
                child: _buildNavbarExample(
                  context,
                  'With Active State',
                  'Navbar showing active navigation item',
                  FlutstrapNavbar(
                    brandText: 'Flutstrap',
                    items: _activeNavbarItems,
                    variant: FSNavbarVariant.light,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                  ),
                ),
              ),

              // Example 7: With Disabled Items
              SliverToBoxAdapter(
                child: _buildNavbarExample(
                  context,
                  'With Disabled Items',
                  'Navbar with disabled navigation items',
                  FlutstrapNavbar(
                    brandText: 'Flutstrap',
                    items: _disabledNavbarItems,
                    variant: FSNavbarVariant.light,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                  ),
                ),
              ),

              // Example 8: With Icons
              SliverToBoxAdapter(
                child: _buildNavbarExample(
                  context,
                  'With Icons',
                  'Navbar items with icons',
                  FlutstrapNavbar(
                    brandText: 'Flutstrap',
                    items: [
                      FSNavbarItem(
                        label: 'Home',
                        icon: const Icon(Icons.home, size: 18),
                        onTap: () => _showSnackBar('Home clicked'),
                      ),
                      FSNavbarItem(
                        label: 'Favorites',
                        icon: const Icon(Icons.favorite, size: 18),
                        onTap: () => _showSnackBar('Favorites clicked'),
                      ),
                      FSNavbarItem(
                        label: 'Profile',
                        icon: const Icon(Icons.person, size: 18),
                        onTap: () => _showSnackBar('Profile clicked'),
                      ),
                      FSNavbarItem(
                        label: 'Settings',
                        icon: const Icon(Icons.settings, size: 18),
                        onTap: () => _showSnackBar('Settings clicked'),
                      ),
                    ],
                    variant: FSNavbarVariant.light,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                  ),
                ),
              ),

              // Example 9: All Color Variants
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'All Color Variants',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Different color variants available for navbars',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withOpacity(0.7),
                            ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),

              // Color Variants Grid - RESPONSIVE FIX
              if (isSmallScreen)
                // Single column for small screens
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final variants = FSNavbarVariant.values;
                      final variant = variants[index];

                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context)
                                .colorScheme
                                .outline
                                .withOpacity(0.2),
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: FlutstrapNavbar(
                          brandText: _getVariantName(variant),
                          items: [
                            FSNavbarItem.simple(
                              label: 'Item 1',
                              onTap: () => _showSnackBar(
                                  '${_getVariantName(variant)} - Item 1'),
                            ),
                            FSNavbarItem.simple(
                              label: 'Item 2',
                              onTap: () => _showSnackBar(
                                  '${_getVariantName(variant)} - Item 2'),
                            ),
                          ],
                          variant: variant,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                        ),
                      );
                    },
                    childCount: FSNavbarVariant.values.length,
                  ),
                )
              else
                // Grid for larger screens
                SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 3,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final variants = FSNavbarVariant.values;
                      final variant = variants[index];

                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context)
                                .colorScheme
                                .outline
                                .withOpacity(0.2),
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: FlutstrapNavbar(
                          brandText: _getVariantName(variant),
                          items: [
                            FSNavbarItem.simple(
                              label: 'Item 1',
                              onTap: () => _showSnackBar(
                                  '${_getVariantName(variant)} - Item 1'),
                            ),
                            FSNavbarItem.simple(
                              label: 'Item 2',
                              onTap: () => _showSnackBar(
                                  '${_getVariantName(variant)} - Item 2'),
                            ),
                          ],
                          variant: variant,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                        ),
                      );
                    },
                    childCount: FSNavbarVariant.values.length,
                  ),
                ),

              // Spacer at the end
              const SliverToBoxAdapter(
                child: SizedBox(height: 32),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildNavbarExample(
    BuildContext context,
    String title,
    String description,
    FlutstrapNavbar navbar,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                ),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: navbar,
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  String _getVariantName(FSNavbarVariant variant) {
    switch (variant) {
      case FSNavbarVariant.light:
        return 'Light';
      case FSNavbarVariant.dark:
        return 'Dark';
      case FSNavbarVariant.primary:
        return 'Primary';
      case FSNavbarVariant.secondary:
        return 'Secondary';
      case FSNavbarVariant.success:
        return 'Success';
      case FSNavbarVariant.danger:
        return 'Danger';
      case FSNavbarVariant.warning:
        return 'Warning';
      case FSNavbarVariant.info:
        return 'Info';
    }
  }
}
