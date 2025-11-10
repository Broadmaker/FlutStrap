/// Flutstrap Navbar Demo Screen
///
/// Comprehensive demonstration of Flutstrap navbar components including:
/// - 🎨 All navbar variants (primary, success, danger, warning, info, light, dark)
/// - 📏 Multiple positions (static, fixedTop, fixedBottom, stickyTop)
/// - 🔧 Advanced features (search, dropdowns, custom branding, fluid layout)
/// - 📱 Responsive behavior (mobile menu, breakpoints)
/// - ⚡ Interactive states (active items, disabled items, hover effects)
///
/// Features:
/// - Live interactive navbar demonstrations
/// - Code examples for each navbar type
/// - State management for dynamic examples
/// - Mobile/desktop responsive testing
///
/// {@category Demo}
/// {@category Screens}
/// {@category Navigation}

import 'package:flutter/material.dart';
import 'package:flutstrap/flutstrap.dart';

class NavbarsScreen extends StatefulWidget {
  const NavbarsScreen({super.key});

  /// Route name for navigation
  static const String routeName = '/navbars';

  @override
  State<NavbarsScreen> createState() => _NavbarsScreenState();
}

class _NavbarsScreenState extends State<NavbarsScreen> {
  // ✅ STATE FOR INTERACTIVE EXAMPLES
  int _currentPage = 0;
  String _searchQuery = '';
  bool _showFixedDemo = false;
  double _scrollOffset = 0;
  final ScrollController _scrollController = ScrollController();

  // ✅ LAZY-INITIALIZED NAVBAR ITEMS (Fixed the initialization error)
  late final List<FSNavbarItem> _basicItems;
  late final List<FSNavbarItem> _dropdownItems;
  late final List<FSNavbarItem> _complexItems;
  late final List<FSNavbarItem> _disabledItems;

  // ✅ CONSTANTS FOR PERFORMANCE
  static const EdgeInsets _screenPadding = EdgeInsets.all(16.0);
  static const EdgeInsets _sectionPadding = EdgeInsets.only(bottom: 32.0);
  static const EdgeInsets _demoPadding = EdgeInsets.all(16.0);
  static const double _sectionSpacing = 24.0;
  static const double _itemSpacing = 16.0;

  @override
  void initState() {
    super.initState();
    _initializeNavbarItems(); // ✅ INITIALIZE ITEMS IN INITSTATE
    _scrollController.addListener(_updateScrollOffset);
  }

  // ✅ FIXED: Initialize items after widget is mounted
  void _initializeNavbarItems() {
    _basicItems = [
      FSNavbarItem(
        label: 'Home',
        onTap: () => _showSnackbar('Home clicked'),
        icon: const Icon(Icons.home, size: 18),
      ),
      FSNavbarItem(
        label: 'About',
        onTap: () => _showSnackbar('About clicked'),
        icon: const Icon(Icons.info, size: 18),
      ),
      FSNavbarItem(
        label: 'Services',
        onTap: () => _showSnackbar('Services clicked'),
        icon: const Icon(Icons.build, size: 18),
      ),
      FSNavbarItem(
        label: 'Contact',
        onTap: () => _showSnackbar('Contact clicked'),
        icon: const Icon(Icons.contact_mail, size: 18),
      ),
    ];

    _dropdownItems = [
      FSNavbarItem.simple(
        label: 'Home',
        onTap: () => _showSnackbar('Home clicked'),
      ),
      FSNavbarItem.dropdown(
        label: 'Products',
        children: [
          FSNavbarItem(
            label: 'Web Applications',
            onTap: () => _showSnackbar('Web Apps clicked'),
            icon: const Icon(Icons.web, size: 16),
          ),
          FSNavbarItem(
            label: 'Mobile Apps',
            onTap: () => _showSnackbar('Mobile Apps clicked'),
            icon: const Icon(Icons.phone_iphone, size: 16),
          ),
          FSNavbarItem(
            label: 'Desktop Software',
            onTap: () => _showSnackbar('Desktop Software clicked'),
            icon: const Icon(Icons.desktop_windows, size: 16),
          ),
        ],
      ),
      FSNavbarItem.dropdown(
        label: 'Services',
        children: [
          FSNavbarItem(
            label: 'UI/UX Design',
            onTap: () => _showSnackbar('UI/UX Design clicked'),
          ),
          FSNavbarItem(
            label: 'Development',
            onTap: () => _showSnackbar('Development clicked'),
          ),
          FSNavbarItem(
            label: 'Consulting',
            onTap: () => _showSnackbar('Consulting clicked'),
          ),
        ],
      ),
      FSNavbarItem.simple(
        label: 'Pricing',
        onTap: () => _showSnackbar('Pricing clicked'),
      ),
      FSNavbarItem.simple(
        label: 'Blog',
        onTap: () => _showSnackbar('Blog clicked'),
      ),
    ];

    _complexItems = [
      FSNavbarItem(
        label: 'Dashboard',
        onTap: () => _setActivePage(0),
        icon: const Icon(Icons.dashboard, size: 18),
        isActive: true,
      ),
      FSNavbarItem(
        label: 'Projects',
        onTap: () => _setActivePage(1),
        icon: const Icon(Icons.work, size: 18),
      ),
      FSNavbarItem.dropdown(
        label: 'Team',
        icon: const Icon(Icons.people, size: 18),
        children: [
          FSNavbarItem(
            label: 'Development Team',
            onTap: () => _setActivePage(2),
            icon: const Icon(Icons.code, size: 16),
          ),
          FSNavbarItem(
            label: 'Design Team',
            onTap: () => _setActivePage(3),
            icon: const Icon(Icons.design_services, size: 16),
          ),
          FSNavbarItem(
            label: 'Marketing',
            onTap: () => _setActivePage(4),
            icon: const Icon(Icons.analytics, size: 16),
          ),
        ],
      ),
      FSNavbarItem(
        label: 'Calendar',
        onTap: () => _setActivePage(5),
        icon: const Icon(Icons.calendar_today, size: 18),
      ),
      FSNavbarItem(
        label: 'Documents',
        onTap: () => _setActivePage(6),
        icon: const Icon(Icons.folder, size: 18),
      ),
      FSNavbarItem(
        label: 'Reports',
        onTap: () => _setActivePage(7),
        icon: const Icon(Icons.assessment, size: 18),
      ),
    ];

    _disabledItems = [
      FSNavbarItem(
        label: 'Active Item',
        onTap: () => _showSnackbar('Active item clicked'),
        isActive: true,
      ),
      FSNavbarItem(
        label: 'Normal Item',
        onTap: () => _showSnackbar('Normal item clicked'),
      ),
      FSNavbarItem(
        label: 'Disabled Item',
        onTap: () => _showSnackbar('This should not appear'),
        enabled: false,
      ),
      FSNavbarItem(
        label: 'Another Active',
        onTap: () => _showSnackbar('Another active item clicked'),
      ),
    ];
  }

  void _updateScrollOffset() {
    setState(() {
      _scrollOffset = _scrollController.offset;
    });
  }

  void _setActivePage(int page) {
    setState(() {
      _currentPage = page;
    });
    _showSnackbar('Navigated to page $page');
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Narbar Components'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // ✅ FIXED NAVBAR DEMO (Conditional)
          if (_showFixedDemo) ..._buildFixedNavbarDemo(),

          // ✅ MAIN CONTENT
          SliverToBoxAdapter(
            child: Padding(
              padding: _screenPadding,
              child: Column(
                children: [
                  // ✅ INTRODUCTION SECTION
                  _buildIntroductionSection(context),
                  const SizedBox(height: _sectionSpacing),

                  // ✅ BASIC NAVBARS
                  _buildBasicNavbarsSection(context),
                  const SizedBox(height: _sectionSpacing),

                  // ✅ NAVBAR VARIANTS
                  _buildNavbarVariantsSection(context),
                  const SizedBox(height: _sectionSpacing),

                  // ✅ NAVBAR POSITIONS
                  _buildNavbarPositionsSection(context),
                  const SizedBox(height: _sectionSpacing),

                  // ✅ NAVBAR WITH DROPDOWNS
                  _buildNavbarWithDropdownsSection(context),
                  const SizedBox(height: _sectionSpacing),

                  // ✅ NAVBAR WITH SEARCH
                  _buildNavbarWithSearchSection(context),
                  const SizedBox(height: _sectionSpacing),

                  // ✅ COMPLEX NAVBAR EXAMPLE
                  _buildComplexNavbarSection(context),
                  const SizedBox(height: _sectionSpacing),

                  // ✅ INTERACTIVE DEMO
                  _buildInteractiveDemoSection(context),
                  const SizedBox(height: 100), // Bottom padding
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build fixed navbar demo section
  List<Widget> _buildFixedNavbarDemo() {
    return [
      SliverAppBar(
        pinned: true,
        expandedHeight: 0,
        toolbarHeight: 0,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      SliverToBoxAdapter(
        child: Column(
          children: [
            // Fixed navbar for demo
            FlutstrapNavbar(
              brandText: 'Fixed Demo',
              items: _basicItems,
              variant: FSNavbarVariant.primary,
              position: FSNavbarPosition.fixedTop,
              customItems: [
                FlutstrapButton(
                  onPressed: () => setState(() => _showFixedDemo = false),
                  text: 'Close Demo',
                  size: FSButtonSize.sm,
                  variant: FSButtonVariant.outlineLight,
                ),
              ],
            ),
            // Spacer to push content down
            SizedBox(
              height: 200,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Fixed Navbar Demo',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Scroll down to see the fixed navbar in action',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Scroll Offset: ${_scrollOffset.toStringAsFixed(1)}',
                      style: const TextStyle(fontFamily: 'monospace'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ];
  }

  /// Build introduction section
  Widget _buildIntroductionSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Flutstrap Navbars',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: _itemSpacing),
          Text(
            'High-performance, responsive navigation bars with Bootstrap-inspired styling. '
            'Navbars support dropdown menus, search functionality, custom branding, '
            'multiple positions, and comprehensive responsive behavior.',
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

  /// Build basic navbars section
  Widget _buildBasicNavbarsSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Basic Navbars',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Simple navigation bars with basic items and branding',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: _itemSpacing),
          Card(
            child: Padding(
              padding: _demoPadding,
              child: Column(
                children: [
                  _buildNavbarWithCode(
                    context,
                    FlutstrapNavbar(
                      brandText: 'MyApp',
                      items: _basicItems,
                      variant: FSNavbarVariant.light,
                    ),
                    'Basic navbar with text brand',
                  ),
                  const SizedBox(height: 16),
                  _buildNavbarWithCode(
                    context,
                    FlutstrapNavbar(
                      brand: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.rocket_launch,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Flutstrap',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                          ),
                        ],
                      ),
                      items: _basicItems,
                      variant: FSNavbarVariant.light,
                    ),
                    'Custom brand widget with icon',
                  ),
                  const SizedBox(height: 16),
                  _buildNavbarWithCode(
                    context,
                    FlutstrapNavbar(
                      brandText: 'Fluid Navbar',
                      items: _basicItems,
                      variant: FSNavbarVariant.secondary,
                      fluid: true,
                    ),
                    'Fluid layout (full width)',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build navbar variants section
  Widget _buildNavbarVariantsSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Navbar Variants',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Different color variants for various design contexts',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: _itemSpacing),
          Card(
            child: Padding(
              padding: _demoPadding,
              child: Column(
                children: [
                  _buildVariantNavbar('Light Variant', FSNavbarVariant.light),
                  const SizedBox(height: 16),
                  _buildVariantNavbar('Dark Variant', FSNavbarVariant.dark),
                  const SizedBox(height: 16),
                  _buildVariantNavbar(
                      'Primary Variant', FSNavbarVariant.primary),
                  const SizedBox(height: 16),
                  _buildVariantNavbar(
                      'Success Variant', FSNavbarVariant.success),
                  const SizedBox(height: 16),
                  _buildVariantNavbar('Danger Variant', FSNavbarVariant.danger),
                  const SizedBox(height: 16),
                  _buildVariantNavbar(
                      'Warning Variant', FSNavbarVariant.warning),
                  const SizedBox(height: 16),
                  _buildVariantNavbar('Info Variant', FSNavbarVariant.info),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build navbar positions section
  Widget _buildNavbarPositionsSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Navbar Positions',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Different positioning behaviors for various layout needs',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: _itemSpacing),
          Card(
            child: Padding(
              padding: _demoPadding,
              child: Column(
                children: [
                  _buildPositionNavbar(
                      'Static (Default)', FSNavbarPosition.static),
                  const SizedBox(height: 16),
                  _buildPositionNavbar(
                      'Sticky Top', FSNavbarPosition.stickyTop),
                  const SizedBox(height: 16),
                  _buildPositionNavbarWithAction(
                    'Fixed Top',
                    FSNavbarPosition.fixedTop,
                    'Test Fixed Position',
                    () => setState(() => _showFixedDemo = true),
                  ),
                  const SizedBox(height: 16),
                  _buildPositionNavbar(
                      'Fixed Bottom', FSNavbarPosition.fixedBottom),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build navbar with dropdowns section
  Widget _buildNavbarWithDropdownsSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Navbar with Dropdowns',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Advanced navigation with dropdown menus and hierarchical items',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: _itemSpacing),
          Card(
            child: Padding(
              padding: _demoPadding,
              child: Column(
                children: [
                  _buildNavbarWithCode(
                    context,
                    FlutstrapNavbar(
                      brandText: 'Company',
                      items: _dropdownItems,
                      variant: FSNavbarVariant.primary,
                    ),
                    'Dropdown menus with nested items',
                  ),
                  const SizedBox(height: 16),
                  _buildNavbarWithCode(
                    context,
                    FlutstrapNavbar(
                      brandText: 'Portal',
                      items: _complexItems,
                      variant: FSNavbarVariant.dark,
                      expand: true,
                    ),
                    'Complex navbar with active states and spacing',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build navbar with search section
  Widget _buildNavbarWithSearchSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Navbar with Search',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Navigation bars with integrated search functionality',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: _itemSpacing),
          Card(
            child: Padding(
              padding: _demoPadding,
              child: Column(
                children: [
                  _buildNavbarWithCode(
                    context,
                    FlutstrapNavbar(
                      brandText: 'Search Demo',
                      items: _basicItems,
                      showSearch: true,
                      onSearch: (query) {
                        setState(() => _searchQuery = query);
                        _showSnackbar('Searching: $query');
                      },
                      searchPlaceholder: 'Search...',
                      variant: FSNavbarVariant.light,
                    ),
                    'Basic search functionality',
                  ),
                  const SizedBox(height: 16),
                  _buildNavbarWithCode(
                    context,
                    FlutstrapNavbar(
                      brandText: 'Advanced',
                      items: _basicItems,
                      showSearch: true,
                      onSearch: (query) =>
                          _showSnackbar('Advanced search: $query'),
                      searchPlaceholder: 'Type to search...',
                      variant: FSNavbarVariant.dark,
                      customItems: [
                        FlutstrapButton(
                          onPressed: () => _showSnackbar('Custom action'),
                          text: 'Action',
                          size: FSButtonSize.sm,
                          variant: FSButtonVariant.outlineLight,
                        ),
                      ],
                    ),
                    'Search with custom items',
                  ),
                  if (_searchQuery.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceVariant,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Current search: "$_searchQuery"',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build complex navbar section
  Widget _buildComplexNavbarSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Complex Navbar Example',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Real-world example with active states, icons, and multiple features',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: _itemSpacing),
          Card(
            child: Padding(
              padding: _demoPadding,
              child: Column(
                children: [
                  FlutstrapNavbar(
                    brand: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.rocket_launch,
                              color: Colors.white, size: 20),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Flutstrap Admin',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                        ),
                      ],
                    ),
                    items: _complexItems,
                    variant: FSNavbarVariant.light,
                    showSearch: true,
                    onSearch: (query) => _showSnackbar('Admin search: $query'),
                    searchPlaceholder: 'Search admin...',
                    customItems: [
                      const IconButton(
                        onPressed: null,
                        icon: Icon(Icons.notifications),
                        tooltip: 'Notifications',
                      ),
                      const SizedBox(width: 8),
                      const CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.blue,
                        child: Text('A', style: TextStyle(color: Colors.white)),
                      ),
                    ],
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
                        const Text(
                          'Current Page:',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        Text(
                            'Page $_currentPage: ${_getPageName(_currentPage)}'),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          children: [
                            FlutstrapButton(
                              onPressed: () => _setActivePage(0),
                              text: 'Dashboard',
                              size: FSButtonSize.sm,
                              variant: _currentPage == 0
                                  ? FSButtonVariant.primary
                                  : FSButtonVariant.outlinePrimary,
                            ),
                            FlutstrapButton(
                              onPressed: () => _setActivePage(1),
                              text: 'Projects',
                              size: FSButtonSize.sm,
                              variant: _currentPage == 1
                                  ? FSButtonVariant.primary
                                  : FSButtonVariant.outlinePrimary,
                            ),
                            FlutstrapButton(
                              onPressed: () => _setActivePage(2),
                              text: 'Team',
                              size: FSButtonSize.sm,
                              variant: _currentPage == 2
                                  ? FSButtonVariant.primary
                                  : FSButtonVariant.outlinePrimary,
                            ),
                          ],
                        ),
                      ],
                    ),
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
            'Test navbar features with different states and configurations',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: _itemSpacing),
          Card(
            child: Padding(
              padding: _demoPadding,
              child: Column(
                children: [
                  _buildNavbarWithCode(
                    context,
                    FlutstrapNavbar(
                      brandText: 'Interactive Demo',
                      items: _disabledItems,
                      variant: FSNavbarVariant.info,
                      showSearch: true,
                      onSearch: (query) => _showSnackbar('Demo search: $query'),
                    ),
                    'Mixed states (active, normal, disabled)',
                  ),

                  const SizedBox(height: 16),

                  // Demo controls
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
                          'Demo Controls:',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            FlutstrapButton(
                              onPressed: () => _showSnackbar('Home clicked'),
                              text: 'Trigger Home',
                              size: FSButtonSize.sm,
                            ),
                            FlutstrapButton(
                              onPressed: () => _showSnackbar('About clicked'),
                              text: 'Trigger About',
                              size: FSButtonSize.sm,
                            ),
                            FlutstrapButton(
                              onPressed: () =>
                                  _showSnackbar('Services clicked'),
                              text: 'Trigger Services',
                              size: FSButtonSize.sm,
                            ),
                            FlutstrapButton(
                              onPressed: () => _showSnackbar('Contact clicked'),
                              text: 'Trigger Contact',
                              size: FSButtonSize.sm,
                            ),
                          ],
                        ),
                      ],
                    ),
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

  /// Build navbar with code example
  Widget _buildNavbarWithCode(
      BuildContext context, Widget navbar, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        navbar,
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

  /// Build variant navbar
  Widget _buildVariantNavbar(String label, FSNavbarVariant variant) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        FlutstrapNavbar(
          brandText: label,
          items: _basicItems,
          variant: variant,
        ),
      ],
    );
  }

  /// Build position navbar
  Widget _buildPositionNavbar(String label, FSNavbarPosition position) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        FlutstrapNavbar(
          brandText: label,
          items: _basicItems,
          position: position,
          variant: FSNavbarVariant.primary,
        ),
      ],
    );
  }

  /// Build position navbar with action button
  Widget _buildPositionNavbarWithAction(
    String label,
    FSNavbarPosition position,
    String buttonText,
    VoidCallback onPressed,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        FlutstrapNavbar(
          brandText: label,
          items: _basicItems,
          position: position,
          variant: FSNavbarVariant.primary,
          customItems: [
            FlutstrapButton(
              onPressed: onPressed,
              text: buttonText,
              size: FSButtonSize.sm,
              variant: FSButtonVariant.outlineLight,
            ),
          ],
        ),
      ],
    );
  }

  /// Get page name for display
  String _getPageName(int page) {
    switch (page) {
      case 0:
        return 'Dashboard';
      case 1:
        return 'Projects';
      case 2:
        return 'Development Team';
      case 3:
        return 'Design Team';
      case 4:
        return 'Marketing';
      case 5:
        return 'Calendar';
      case 6:
        return 'Documents';
      case 7:
        return 'Reports';
      default:
        return 'Unknown Page';
    }
  }
}
