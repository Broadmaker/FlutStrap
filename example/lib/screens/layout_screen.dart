/// Flutstrap Layout Components Demo Screen - COMPLETELY FIXED OVERFLOW VERSION
///
/// Comprehensive demonstration of Flutstrap layout components with:
/// 🏗️ Interactive container system with live constraints
/// 📱 Dynamic grid system with real-time breakpoint display
/// 📐 Row & Column layouts with constraint visualization
/// 👁️ Responsive visibility with live screen size detection
/// 🎯 Advanced layout patterns with interactive playground
/// 🔧 Error-free implementation with proper constraint handling
///
/// {@category Demo}
/// {@category Screens}
/// {@category Layout}

import 'package:flutter/material.dart';
import 'package:flutstrap/flutstrap.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  /// Route name for navigation
  static const String routeName = '/layout';

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen>
    with WidgetsBindingObserver {
  // ✅ ENHANCED STATE MANAGEMENT
  int _containerPressCount = 0;
  bool _showMobileOnlyContent = true;
  bool _showDesktopOnlyContent = false;
  int _gridColumnCount = 3;
  double _containerMaxWidth = 300;
  bool _containerFluid = false;
  double _rowGap = 12.0;
  double _columnGap = 12.0;
  String _currentBreakpoint = 'XS';
  Color _activeColor = Colors.blue;
  double _screenWidth = 0;

  // ✅ PERFORMANCE OPTIMIZED CONSTANTS
  static const EdgeInsets _screenPadding = EdgeInsets.all(16.0);
  static const EdgeInsets _sectionPadding = EdgeInsets.only(bottom: 32.0);
  static const EdgeInsets _cardPadding = EdgeInsets.all(20.0);
  static const double _sectionSpacing = 24.0;
  static const double _itemSpacing = 16.0;
  static const double _componentSpacing = 12.0;

  // ✅ COLOR SCHEME FOR CONSISTENT STYLING
  final Map<String, Color> _breakpointColors = {
    'XS': Colors.red,
    'SM': Colors.orange,
    'MD': Colors.green,
    'LG': Colors.blue,
    'XL': Colors.purple,
    'XXL': Colors.pink,
  };

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    // Update screen dimensions when they change (orientation, resize, etc.)
    _updateScreenDimensions();
  }

  void _updateScreenDimensions() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final mediaQuery = MediaQuery.of(context);
        setState(() {
          _screenWidth = mediaQuery.size.width;
          _updateBreakpoint(_screenWidth);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Initialize screen width on first build
    if (_screenWidth == 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _updateScreenDimensions();
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutstrap Layout System'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 2,
        actions: [
          // ✅ LIVE BREAKPOINT INDICATOR
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: _breakpointColors[_currentBreakpoint]?.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: _breakpointColors[_currentBreakpoint] ?? Colors.grey,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.view_week,
                  color: _breakpointColors[_currentBreakpoint],
                  size: 16,
                ),
                const SizedBox(width: 6),
                Text(
                  _currentBreakpoint,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _breakpointColors[_currentBreakpoint],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: _screenPadding,
        child: ListView(
          children: [
            // ✅ INTRODUCTION SECTION WITH LIVE INFO
            _buildIntroductionSection(context),
            const SizedBox(height: _sectionSpacing),

            // ✅ INTERACTIVE CONTAINER PLAYGROUND
            _buildContainerPlaygroundSection(context),
            const SizedBox(height: _sectionSpacing),

            // ✅ DYNAMIC GRID SYSTEM
            _buildGridSystemSection(context),
            const SizedBox(height: _sectionSpacing),

            // ✅ ROW & COLUMN LAYOUTS WITH VISUALIZATION
            _buildRowColumnSection(context),
            const SizedBox(height: _sectionSpacing),

            // ✅ RESPONSIVE VISIBILITY WITH LIVE DEMO
            _buildVisibilitySection(context),
            const SizedBox(height: _sectionSpacing),

            // ✅ ADVANCED LAYOUT PATTERNS - COMPLETELY FIXED OVERFLOW
            _buildAdvancedPatternsSection(context),
            const SizedBox(height: _sectionSpacing),

            // ✅ INTERACTIVE DEMO & PLAYGROUND - COMPLETELY FIXED OVERFLOW
            _buildInteractivePlaygroundSection(context),

            // ✅ BOTTOM SPACING TO PREVENT OVERFLOW
            const SizedBox(height: 32.0),
          ],
        ),
      ),
    );
  }

  /// ✅ ENHANCED INTRODUCTION SECTION WITH LIVE INFO
  Widget _buildIntroductionSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Flutstrap Layout System',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          const SizedBox(height: _itemSpacing),
          Text(
            'Comprehensive layout component system with Bootstrap-inspired responsive design, '
            'flexible grid system, and mobile-first approach. All components are '
            'performance-optimized, fully accessible, and theme-aware.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  height: 1.5,
                ),
          ),
          const SizedBox(height: _itemSpacing),

          // ✅ LIVE SCREEN INFO CARD
          Card(
            color: Theme.of(context).colorScheme.surfaceVariant,
            child: Padding(
              padding: _cardPadding,
              child: Row(
                children: [
                  Icon(
                    Icons.smartphone,
                    color: _breakpointColors[_currentBreakpoint],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Current Screen: $_currentBreakpoint',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Width: ${_screenWidth.toStringAsFixed(0)}px',
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _breakpointColors[_currentBreakpoint]
                          ?.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      _currentBreakpoint,
                      style: TextStyle(
                        color: _breakpointColors[_currentBreakpoint],
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: _itemSpacing),
          _buildFeatureGrid(context),
        ],
      ),
    );
  }

  /// ✅ ENHANCED FEATURE GRID
  Widget _buildFeatureGrid(BuildContext context) {
    return FlutstrapGrid.responsive(
      children: [
        _buildFeatureItem(context, Icons.dashboard, 'Container System',
            'Responsive containers with max-width constraints', Colors.blue),
        _buildFeatureItem(context, Icons.grid_on, 'Grid System',
            '12-column responsive grid with breakpoints', Colors.green),
        _buildFeatureItem(
            context,
            Icons.view_array,
            'Row & Column',
            'Flexible layout containers with consistent spacing',
            Colors.orange),
        _buildFeatureItem(context, Icons.visibility, 'Visibility',
            'Show/hide content based on screen size', Colors.purple),
      ],
      xsColumns: 1,
      smColumns: 2,
      mdColumns: 2,
      lgColumns: 4,
      gap: _componentSpacing,
    );
  }

  Widget _buildFeatureItem(BuildContext context, IconData icon, String title,
      String description, Color color) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: _cardPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.6),
                  ),
            ),
          ],
        ),
      ),
    );
  }

  /// ✅ INTERACTIVE CONTAINER PLAYGROUND
  Widget _buildContainerPlaygroundSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Container System Playground',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Interactive demonstration of responsive containers with live property controls',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: _itemSpacing),

          // ✅ INTERACTIVE CONTROLS
          Card(
            child: Padding(
              padding: _cardPadding,
              child: Column(
                children: [
                  _buildControlRow(
                    'Max Width: ${_containerMaxWidth.toInt()}px',
                    Slider(
                      value: _containerMaxWidth,
                      min: 200,
                      max: 800,
                      divisions: 12,
                      onChanged: (value) =>
                          setState(() => _containerMaxWidth = value),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildControlRow(
                    'Fluid Container',
                    Switch(
                      value: _containerFluid,
                      onChanged: (value) =>
                          setState(() => _containerFluid = value),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: _componentSpacing),

          // ✅ LIVE CONTAINER DEMONSTRATION
          Card(
            child: Padding(
              padding: _cardPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _containerFluid ? 'Fluid Container' : 'Fixed Container',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 12),
                  FlutstrapContainer(
                    fluid: _containerFluid,
                    width: _containerFluid ? null : _containerMaxWidth,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        border: Border.all(color: Colors.blue.withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Text(
                            _containerFluid
                                ? 'Fluid Container - Full Width'
                                : 'Fixed Container - ${_containerMaxWidth.toInt()}px max width',
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Resize screen to see responsive behavior',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.blue.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildCodeExample(
                    context,
                    '''FlutstrapContainer(
  fluid: $_containerFluid,
  ${_containerFluid ? '' : 'width: $_containerMaxWidth,'}
  child: YourContent(),
)''',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ✅ DYNAMIC GRID SYSTEM SECTION - FIXED OVERFLOW
  Widget _buildGridSystemSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Grid System',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            '12-column responsive grid system with automatic row wrapping and breakpoint-based layouts',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: _itemSpacing),

          // ✅ GRID COLUMN CONTROLS
          Card(
            child: Padding(
              padding: _cardPadding,
              child: Column(
                children: [
                  _buildControlRow(
                    'Columns per Row: $_gridColumnCount',
                    Slider(
                      value: _gridColumnCount.toDouble(),
                      min: 1,
                      max: 6,
                      divisions: 5,
                      onChanged: (value) =>
                          setState(() => _gridColumnCount = value.toInt()),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Items will automatically wrap to create $_gridColumnCount columns per row',
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: _componentSpacing),

          // ✅ RESPONSIVE GRID EXAMPLE - FIXED OVERFLOW
          Card(
            child: Padding(
              padding: _cardPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Responsive Grid Demo',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Current breakpoint: $_currentBreakpoint • Showing $_gridColumnCount columns per row',
                    style: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.7),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // ✅ FIXED: Safe dynamic height calculation
                  Container(
                    height:
                        180, // Safe fixed height that works for all column counts
                    child: FlutstrapGrid.responsive(
                      children: List.generate(
                          6, (index) => _buildGridItem(index + 1)),
                      xsColumns: 1,
                      smColumns: 2,
                      mdColumns: _gridColumnCount,
                      lgColumns: _gridColumnCount,
                      xlColumns: _gridColumnCount,
                      gap: _componentSpacing,
                    ),
                  ),

                  const SizedBox(height: 12),
                  _buildCodeExample(
                    context,
                    '''FlutstrapGrid.responsive(
  children: [Item1, Item2, ..., Item6],
  xsColumns: 1,    // Mobile: 1 column
  smColumns: 2,    // Small: 2 columns  
  mdColumns: $_gridColumnCount,   // Tablet: $_gridColumnCount columns
  lgColumns: $_gridColumnCount,   // Desktop: $_gridColumnCount columns
  gap: $_componentSpacing,
)''',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ✅ ROW & COLUMN SECTION WITH VISUALIZATION
  Widget _buildRowColumnSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Row & Column Layouts',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Flexible layout containers with consistent spacing and alignment visualization',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: _itemSpacing),

          // ✅ GAP CONTROLS - FIXED: Show both row and column gap examples
          Card(
            child: Padding(
              padding: _cardPadding,
              child: Column(
                children: [
                  _buildControlRow(
                    'Row Gap: ${_rowGap.toInt()}px',
                    Slider(
                      value: _rowGap,
                      min: 0,
                      max: 32,
                      divisions: 8,
                      onChanged: (value) => setState(() => _rowGap = value),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildControlRow(
                    'Column Gap: ${_columnGap.toInt()}px',
                    Slider(
                      value: _columnGap,
                      min: 0,
                      max: 32,
                      divisions: 8,
                      onChanged: (value) => setState(() => _columnGap = value),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: _componentSpacing),

          // ✅ ROW WITH GAP DEMO
          _buildComponentWithCode(
            context,
            'Row with Gap (Horizontal spacing)',
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: FlutstrapRow(
                children: [
                  _buildNonExpandedLayoutItem('Item 1'),
                  _buildNonExpandedLayoutItem('Item 2'),
                  _buildNonExpandedLayoutItem('Item 3'),
                ],
                gap: _rowGap,
              ),
            ),
            '''FlutstrapRow(
  children: [Item1, Item2, Item3],
  gap: $_rowGap, // Horizontal spacing between items
)''',
          ),
          const SizedBox(height: _componentSpacing),

          // ✅ COLUMN WITH GAP DEMO - NEW: Show column gap visualization
          _buildComponentWithCode(
            context,
            'Column with Gap (Vertical spacing)',
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  _buildNonExpandedLayoutItem('Item 1'),
                  SizedBox(height: _columnGap), // Show column gap
                  _buildNonExpandedLayoutItem('Item 2'),
                  SizedBox(height: _columnGap), // Show column gap
                  _buildNonExpandedLayoutItem('Item 3'),
                ],
              ),
            ),
            '''Column(
  children: [
    Item1,
    SizedBox(height: $_columnGap), // Vertical spacing
    Item2,
    SizedBox(height: $_columnGap), // Vertical spacing  
    Item3,
  ],
)''',
          ),
          const SizedBox(height: _componentSpacing),

          // ✅ ALIGNMENT VARIANTS
          Card(
            child: Padding(
              padding: _cardPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Row Alignment Variants',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 12),
                  ..._buildRowAlignmentExamples(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ✅ RESPONSIVE VISIBILITY SECTION
  Widget _buildVisibilitySection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Responsive Visibility',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Show or hide content based on screen size with live breakpoint detection',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: _itemSpacing),

          // ✅ VISIBILITY CONTROLS
          Card(
            child: Padding(
              padding: _cardPadding,
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                    child: FlutstrapRow(
                      children: [
                        Expanded(
                          child: FlutstrapButton(
                            onPressed: _toggleMobileContent,
                            text: _showMobileOnlyContent
                                ? 'Hide Mobile'
                                : 'Show Mobile',
                            variant: FSButtonVariant.primary,
                          ),
                        ),
                        const SizedBox(width: _componentSpacing),
                        Expanded(
                          child: FlutstrapButton(
                            onPressed: _toggleDesktopContent,
                            text: _showDesktopOnlyContent
                                ? 'Hide Desktop'
                                : 'Show Desktop',
                            variant: FSButtonVariant.outlinePrimary,
                          ),
                        ),
                      ],
                      gap: _componentSpacing,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: _componentSpacing),

          // ✅ VISIBILITY EXAMPLES
          Card(
            child: Padding(
              padding: _cardPadding,
              child: Column(
                children: [
                  _buildVisibilityExample(
                    context,
                    'Mobile Only Content',
                    SizedBox(
                      height: 60,
                      child: FlutstrapVisibility.mobileOnly(
                        child: _buildVisibilityItem(
                            'This only shows on mobile screens', Colors.blue),
                      ),
                    ),
                    'FlutstrapVisibility.mobileOnly(child: ...)',
                    isVisible: _showMobileOnlyContent,
                  ),
                  const SizedBox(height: _componentSpacing),
                  _buildVisibilityExample(
                    context,
                    'Desktop Only Content',
                    SizedBox(
                      height: 60,
                      child: FlutstrapVisibility.desktopOnly(
                        child: _buildVisibilityItem(
                            'This only shows on desktop screens', Colors.green),
                      ),
                    ),
                    'FlutstrapVisibility.desktopOnly(child: ...)',
                    isVisible: _showDesktopOnlyContent,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ✅ ADVANCED LAYOUT PATTERNS - COMPLETELY FIXED OVERFLOW
  Widget _buildAdvancedPatternsSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Advanced Layout Patterns',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Common layout patterns and best practices for real-world applications',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: _itemSpacing),

          // ✅ CARD GRID PATTERN - COMPLETELY FIXED OVERFLOW
          Card(
            child: Padding(
              padding: _cardPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Card Grid Pattern',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 12),

                  // ✅ FIXED: Use a simple custom grid instead of FlutstrapGrid.cards
                  Container(
                    height: 200, // Safe fixed height
                    child: _buildCustomCardGrid(),
                  ),
                  const SizedBox(height: 12),
                  _buildCodeExample(
                    context,
                    '''// Custom card grid implementation
Container(
  height: 200,
  child: YourCardGrid(),
)''',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ✅ CUSTOM CARD GRID - No overflow guaranteed
  Widget _buildCustomCardGrid() {
    return Column(
      children: [
        // First row of cards
        Expanded(
          child: Row(
            children: [
              Expanded(child: _buildUltraCompactCardItem(1)),
              const SizedBox(width: 8),
              Expanded(child: _buildUltraCompactCardItem(2)),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // Second row of cards
        Expanded(
          child: Row(
            children: [
              Expanded(child: _buildUltraCompactCardItem(3)),
              const SizedBox(width: 8),
              Expanded(child: _buildUltraCompactCardItem(4)),
            ],
          ),
        ),
      ],
    );
  }

  /// ✅ ULTRA COMPACT CARD ITEM - Guaranteed to fit
  Widget _buildUltraCompactCardItem(int number) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.zero, // Remove margin to save space
      child: Container(
        padding: const EdgeInsets.all(6), // Minimal padding
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.crop_square, // Smaller icon
              color: _activeColor,
              size: 16,
            ),
            const SizedBox(height: 4),
            Text(
              'Card $number',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: _activeColor,
                fontSize: 10, // Very small font
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  /// ✅ INTERACTIVE PLAYGROUND SECTION - COMPLETELY FIXED OVERFLOW
  Widget _buildInteractivePlaygroundSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Interactive Playground',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Experiment with different layout configurations in real-time',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: _itemSpacing),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12.0), // Reduced padding
              child: Column(
                children: [
                  // ✅ COLOR SELECTOR - FIXED FOR MOBILE
                  Text(
                    'Theme Color:',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 35, // Smaller height
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: _breakpointColors.entries.map((entry) {
                        return Container(
                          width: 45, // Smaller width
                          margin: const EdgeInsets.only(right: 4),
                          child: GestureDetector(
                            onTap: () =>
                                setState(() => _activeColor = entry.value),
                            child: Container(
                              height: 25, // Smaller height
                              decoration: BoxDecoration(
                                color: entry.value,
                                borderRadius: BorderRadius.circular(3),
                                border: _activeColor == entry.value
                                    ? Border.all(color: Colors.white, width: 1)
                                    : null,
                              ),
                              child: Center(
                                child: Text(
                                  entry.key,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 8, // Very small font
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // ✅ DYNAMIC CONTENT AREA - COMPLETELY FIXED OVERFLOW
                  Container(
                    padding: const EdgeInsets.all(8), // Minimal padding
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.grey.shade50,
                    ),
                    child: Column(
                      children: [
                        // DYNAMIC GRID - Ultra compact
                        Container(
                          height: 80, // Very small height
                          child: _buildCustomMiniGrid(),
                        ),
                        const SizedBox(height: 8),

                        // CONDITIONAL VISIBILITY CONTENT - Ultra compact
                        if (_showMobileOnlyContent) ...[
                          Container(
                            height: 30, // Very small height
                            child: FlutstrapVisibility.mobileOnly(
                              child: _buildMicroVisibilityItem(
                                  'Mobile', _activeColor),
                            ),
                          ),
                          const SizedBox(height: 4),
                        ],
                        if (_showDesktopOnlyContent) ...[
                          Container(
                            height: 30, // Very small height
                            child: FlutstrapVisibility.desktopOnly(
                              child: _buildMicroVisibilityItem(
                                  'Desktop', _activeColor),
                            ),
                          ),
                          const SizedBox(height: 4),
                        ],
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

  /// ✅ CUSTOM MINI GRID - No overflow guaranteed
  Widget _buildCustomMiniGrid() {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: _activeColor.withOpacity(0.1),
              border: Border.all(color: _activeColor.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Center(
              child: Text(
                '1',
                style: TextStyle(fontSize: 10, color: _activeColor),
              ),
            ),
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: _activeColor.withOpacity(0.1),
              border: Border.all(color: _activeColor.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Center(
              child: Text(
                '2',
                style: TextStyle(fontSize: 10, color: _activeColor),
              ),
            ),
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: _activeColor.withOpacity(0.1),
              border: Border.all(color: _activeColor.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Center(
              child: Text(
                '3',
                style: TextStyle(fontSize: 10, color: _activeColor),
              ),
            ),
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: _activeColor.withOpacity(0.1),
              border: Border.all(color: _activeColor.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Center(
              child: Text(
                '4',
                style: TextStyle(fontSize: 10, color: _activeColor),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ✅ ENHANCED HELPER METHODS

  Widget _buildControlRow(String label, Widget control) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child:
              Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        ),
        Expanded(
          flex: 3,
          child: control,
        ),
      ],
    );
  }

  Widget _buildComponentWithCode(
    BuildContext context,
    String title,
    Widget component,
    String code,
  ) {
    return Card(
      child: Padding(
        padding: _cardPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 12),
            component,
            const SizedBox(height: 12),
            _buildCodeExample(context, code),
          ],
        ),
      ),
    );
  }

  Widget _buildCodeExample(BuildContext context, String code) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(8),
      ),
      child: SelectableText(
        code,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontFamily: 'RobotoMono',
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
      ),
    );
  }

  Widget _buildGridItem(int number) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _activeColor.withOpacity(0.1),
        border: Border.all(color: _activeColor.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: Text(
          'Item $number',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: _activeColor,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildNonExpandedLayoutItem(String text) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _activeColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(color: _activeColor, fontSize: 12),
      ),
    );
  }

  Widget _buildVisibilityItem(String text, Color color) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        border: Border.all(color: color.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.info, color: color, size: 14),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              text,
              style: TextStyle(
                  color: color, fontWeight: FontWeight.w500, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  /// ✅ MICRO VISIBILITY ITEM - Ultra compact
  Widget _buildMicroVisibilityItem(String text, Color color) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        border: Border.all(color: color.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.info, color: color, size: 10),
          const SizedBox(width: 2),
          Text(
            text,
            style: TextStyle(
                color: color, fontWeight: FontWeight.w500, fontSize: 8),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildRowAlignmentExamples() {
    return [
      _buildAlignmentExample(
        'Start (Default) - Items aligned to the left',
        FlutstrapRow(
          children: [
            _buildNonExpandedLayoutItem('Item 1'),
            _buildNonExpandedLayoutItem('Item 2'),
            _buildNonExpandedLayoutItem('Item 3'),
          ],
        ).start(),
      ),
      const SizedBox(height: 12),
      _buildAlignmentExample(
        'Center - Items centered in the row',
        FlutstrapRow(
          children: [
            _buildNonExpandedLayoutItem('Item 1'),
            _buildNonExpandedLayoutItem('Item 2'),
            _buildNonExpandedLayoutItem('Item 3'),
          ],
        ).center(),
      ),
      const SizedBox(height: 12),
      _buildAlignmentExample(
        'End - Items aligned to the right',
        FlutstrapRow(
          children: [
            _buildNonExpandedLayoutItem('Item 1'),
            _buildNonExpandedLayoutItem('Item 2'),
            _buildNonExpandedLayoutItem('Item 3'),
          ],
        ).end(),
      ),
    ];
  }

  Widget _buildAlignmentExample(String label, Widget row) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(4),
          ),
          child: row,
        ),
      ],
    );
  }

  Widget _buildVisibilityExample(
    BuildContext context,
    String title,
    Widget visibility,
    String code, {
    bool isVisible = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(title, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: isVisible
                    ? Colors.green.withOpacity(0.1)
                    : Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                isVisible ? 'VISIBLE' : 'HIDDEN',
                style: TextStyle(
                  color: isVisible ? Colors.green : Colors.red,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        visibility,
        const SizedBox(height: 8),
        _buildCodeExample(context, code),
      ],
    );
  }

  // ✅ INTERACTION HANDLERS

  void _toggleMobileContent() {
    setState(() {
      _showMobileOnlyContent = !_showMobileOnlyContent;
    });
  }

  void _toggleDesktopContent() {
    setState(() {
      _showDesktopOnlyContent = !_showDesktopOnlyContent;
    });
  }

  void _updateBreakpoint(double screenWidth) {
    if (screenWidth < 576) {
      _currentBreakpoint = 'XS';
    } else if (screenWidth < 768) {
      _currentBreakpoint = 'SM';
    } else if (screenWidth < 992) {
      _currentBreakpoint = 'MD';
    } else if (screenWidth < 1200) {
      _currentBreakpoint = 'LG';
    } else if (screenWidth < 1400) {
      _currentBreakpoint = 'XL';
    } else {
      _currentBreakpoint = 'XXL';
    }
  }
}
