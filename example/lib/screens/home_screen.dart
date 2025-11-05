/// Flutstrap Components Demo - Home Screen
///
/// Main navigation hub for exploring all Flutstrap components.
///
/// Features:
/// - 🔍 Searchable component library with real-time filtering
/// - 🎨 Modern Material Design 3 interface
/// - 📱 Responsive layout with adaptive design
/// - ⚡ Performance optimized with constants and efficient rebuilding
/// - ♿ Accessibility compliant with proper semantics
/// - 🌙 Dark theme support
///
/// {@category Demo}
/// {@category Screens}
import 'package:flutter/material.dart';
import 'package:flutstrap/flutstrap.dart';

// Import all screen files
import 'theme_screen.dart';
import 'utilities_screen.dart';
import 'typography_screen.dart';
// import 'code_viewer_demo.dart'; // Commented out as per your example_app.dart
import 'animation_screen.dart';
import 'buttons_screen.dart';
import 'cards_screen.dart';
import 'forms_screen.dart';
import 'layout_screen.dart';
import 'alerts_screen.dart';
import 'modals_screen.dart';
import 'dropdowns_screen.dart';
import 'navbars_screen.dart';
import 'progress_screen.dart';
import 'spinners_screen.dart';
import 'tooltips_screen.dart';
import 'tables_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  /// Route name for navigation
  static const String routeName = '/';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  final List<ComponentItem> _filteredItems = [];

  // ✅ CONSTANTS FOR BETTER PERFORMANCE AND MAINTAINABILITY
  static const EdgeInsets _contentPadding = EdgeInsets.all(16.0);
  static const EdgeInsets _cardMargin = EdgeInsets.only(bottom: 12.0);
  static const EdgeInsets _iconPadding = EdgeInsets.all(8.0);
  static const EdgeInsets _listTilePadding = EdgeInsets.symmetric(
    horizontal: 16.0,
    vertical: 12.0,
  );
  static const double _iconSize = 20.0;
  static const double _trailingIconSize = 16.0;
  static const double _cardBorderRadius = 12.0;
  static const double _iconBackgroundBorderRadius = 8.0;
  static const double _searchBorderRadius = 12.0;
  static const double _emptyStateIconSize = 64.0;

  static const List<ComponentItem> _componentItems = [
    ComponentItem(
      title: 'Theme System',
      description: 'Typography, colors, and design tokens',
      icon: Icons.palette,
      route: ThemeScreen.routeName,
    ),
    ComponentItem(
      title: 'Utilities & Responsive',
      description: 'Spacing, breakpoints, validation, and utilities',
      icon: Icons.build,
      route: UtilitiesScreen.routeName,
    ),
    ComponentItem(
      title: 'Typography & Icons',
      description: 'Text styles and icon usage patterns',
      icon: Icons.text_fields,
      route: TypographyScreen.routeName,
    ),
    // ComponentItem(
    //   title: 'Code Viewer Demo',
    //   description: 'Test the code viewer component',
    //   icon: Icons.code,
    //   route: CodeViewerDemoScreen.routeName,
    // ),
    ComponentItem(
      title: 'Animations',
      description: 'Fade-in, slide transitions, and animation effects',
      icon: Icons.animation,
      route: AnimationsScreen.routeName,
    ),
    ComponentItem(
      title: 'Buttons',
      description: 'All button variants, sizes, and states',
      icon: Icons.touch_app,
      route: ButtonsScreen.routeName,
    ),
    ComponentItem(
      title: 'Cards',
      description: 'Card components with headers and content',
      icon: Icons.dashboard,
      route: CardsScreen.routeName,
    ),
    ComponentItem(
      title: 'Forms',
      description: 'Input fields, checkboxes, and radios',
      icon: Icons.text_fields,
      route: FormsScreen.routeName,
    ),
    ComponentItem(
      title: 'Layout',
      description: 'Grid system and responsive layouts',
      icon: Icons.grid_view,
      route: LayoutScreen.routeName,
    ),
    ComponentItem(
      title: 'Alerts & Badges',
      description: 'Contextual feedback and indicators',
      icon: Icons.notifications,
      route: AlertsScreen.routeName,
    ),
    ComponentItem(
      title: 'Modals',
      description: 'Dialog windows and modal services',
      icon: Icons.layers,
      route: ModalsScreen.routeName,
    ),
    ComponentItem(
      title: 'Dropdowns',
      description: 'Selection menus and dropdown variants',
      icon: Icons.arrow_drop_down_circle,
      route: DropdownsScreen.routeName,
    ),
    ComponentItem(
      title: 'Navbars',
      description: 'Navigation bars and responsive menus',
      icon: Icons.menu,
      route: NavbarsScreen.routeName,
    ),
    ComponentItem(
      title: 'Progress Bars',
      description: 'Loading indicators and progress tracking',
      icon: Icons.timeline,
      route: ProgressScreen.routeName,
    ),
    ComponentItem(
      title: 'Spinners',
      description: 'Loading indicators and animated spinners',
      icon: Icons.autorenew,
      route: SpinnersScreen.routeName,
    ),
    ComponentItem(
      title: 'Tooltips',
      description: 'Contextual hints and information popovers',
      icon: Icons.tips_and_updates,
      route: TooltipsScreen.routeName,
    ),
    ComponentItem(
      title: 'Tables',
      description: 'Data tables with sorting and responsive layouts',
      icon: Icons.table_chart,
      route: TablesScreen.routeName,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _initializeData();
    _searchController.addListener(_filterComponents);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  /// Initialize component data and set up initial state
  void _initializeData() {
    _filteredItems.addAll(_componentItems);
  }

  /// Filter components based on search query
  void _filterComponents() {
    final query = _searchController.text.trim().toLowerCase();

    setState(() {
      _filteredItems.clear();

      if (query.isEmpty) {
        _filteredItems.addAll(_componentItems);
      } else {
        _filteredItems.addAll(
          _componentItems.where((item) =>
              item.title.toLowerCase().contains(query) ||
              item.description.toLowerCase().contains(query)),
        );
      }
    });
  }

  /// Clear search query and reset filtering
  void _clearSearch() {
    _searchController.clear();
    _searchFocusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutstrap Examples'),
        backgroundColor: colorScheme.inversePrimary,
        elevation: 0,
        scrolledUnderElevation: 4.0, // ✅ ADD: Scroll effect
      ),
      body: Padding(
        padding: _contentPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ ENHANCED: Search bar with better UX
            _buildSearchBar(context),
            const SizedBox(height: 24.0),

            // ✅ ENHANCED: Header with count and better typography
            _buildHeader(context),
            const SizedBox(height: 16.0),

            // ✅ ENHANCED: Component list with empty state
            Expanded(
              child: _filteredItems.isEmpty
                  ? _buildEmptyState(context)
                  : _buildComponentList(context),
            ),
          ],
        ),
      ),
    );
  }

  /// Build search bar with clear functionality
  Widget _buildSearchBar(BuildContext context) {
    final theme = Theme.of(context);

    return TextField(
      controller: _searchController,
      focusNode: _searchFocusNode,
      decoration: InputDecoration(
        hintText: 'Search ${_componentItems.length} components...',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: _searchController.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: _clearSearch,
                tooltip: 'Clear search', // ✅ ADD: Accessibility
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_searchBorderRadius),
          borderSide: BorderSide(color: theme.colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_searchBorderRadius),
          borderSide: BorderSide(
            color: theme.colorScheme.primary,
            width: 2.0,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 12.0,
        ),
      ),
      textInputAction: TextInputAction.search,
      onSubmitted: (_) => _searchFocusNode.unfocus(),
    );
  }

  /// Build header section with title and count
  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Flutstrap Components',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w700,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          _buildResultsText(),
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
      ],
    );
  }

  /// Build results text with proper pluralization
  String _buildResultsText() {
    final count = _filteredItems.length;
    final total = _componentItems.length;

    if (_searchController.text.isEmpty) {
      return '$count components available';
    } else {
      return '$count of $total components found';
    }
  }

  /// Build empty state for no results
  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: _emptyStateIconSize,
              color: colorScheme.onSurface.withOpacity(0.3),
            ),
            const SizedBox(height: 24.0),
            Text(
              'No components found',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8.0),
            Text(
              _searchController.text.isEmpty
                  ? 'Components will appear here'
                  : 'Try adjusting your search terms',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface.withOpacity(0.6),
              ),
              textAlign: TextAlign.center,
            ),
            if (_searchController.text.isNotEmpty) ...[
              const SizedBox(height: 16.0),
              FilledButton.tonal(
                onPressed: _clearSearch,
                child: const Text('Clear search'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// Build component list with performance optimization
  Widget _buildComponentList(BuildContext context) {
    return ListView.builder(
      itemCount: _filteredItems.length,
      itemBuilder: (context, index) {
        final item = _filteredItems[index];
        return _buildComponentCard(
          context: context,
          item: item,
          isLast: index == _filteredItems.length - 1,
        );
      },
      // ✅ ADD: Performance optimizations
      cacheExtent: 1000.0,
      addAutomaticKeepAlives: true,
    );
  }

  /// Build individual component card
  Widget _buildComponentCard({
    required BuildContext context,
    required ComponentItem item,
    required bool isLast,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      margin: isLast
          ? _cardMargin.copyWith(
              bottom: 0.0) // Remove bottom margin for last item
          : _cardMargin,
      child: Card(
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_cardBorderRadius),
        ),
        child: ListTile(
          leading: Container(
            padding: _iconPadding,
            decoration: BoxDecoration(
              color: colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(_iconBackgroundBorderRadius),
            ),
            child: Icon(
              item.icon,
              color: colorScheme.primary,
              size: _iconSize,
            ),
          ),
          title: Text(
            item.title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
          subtitle: Text(
            item.description,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface.withOpacity(0.6),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Icon(
            Icons.arrow_forward_ios_rounded,
            size: _trailingIconSize,
            color: colorScheme.onSurface.withOpacity(0.6),
          ),
          contentPadding: _listTilePadding,
          onTap: () => item.navigate(context),
          // ✅ ADD: Accessibility
          mouseCursor: SystemMouseCursors.click,
        ),
      ),
    );
  }
}

/// Data model representing a component demo item
class ComponentItem {
  final String title;
  final String description;
  final IconData icon;
  final String route;

  const ComponentItem({
    required this.title,
    required this.description,
    required this.icon,
    required this.route,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ComponentItem &&
        other.title == title &&
        other.description == description &&
        other.icon == icon &&
        other.route == route;
  }

  @override
  int get hashCode {
    return Object.hash(title, description, icon, route);
  }

  @override
  String toString() {
    return 'ComponentItem(title: $title, route: $route)';
  }
}

/// Extension methods for ComponentItem
extension ComponentItemExtension on ComponentItem {
  /// Navigate to the component's demo screen
  void navigate(BuildContext context) {
    // ✅ ADD: Error handling for navigation
    try {
      Navigator.pushNamed(context, route);
    } catch (e) {
      // Fallback to generic error handling
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Cannot open $title: Route not configured'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }

  /// Check if item matches search query
  bool matchesQuery(String query) {
    if (query.isEmpty) return true;
    final lowerQuery = query.toLowerCase();
    return title.toLowerCase().contains(lowerQuery) ||
        description.toLowerCase().contains(lowerQuery);
  }
}
