/// Flutstrap Layout Components Demo Screen
///
/// Comprehensive demonstration of Flutstrap layout components including:
/// 🏗️ Container system with responsive constraints
/// 📱 Grid system with breakpoint-based columns
/// 📐 Row & Column layouts with consistent spacing
/// 👁️ Responsive visibility utilities
/// 🎯 Advanced layout patterns and best practices
///
/// Features:
/// - Live interactive layout demonstrations
/// - Code examples for each layout pattern
/// - Responsive design showcase
/// - State management for interactive examples
/// - Performance-optimized layout rendering
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

class _LayoutScreenState extends State<LayoutScreen> {
  // ✅ STATE FOR INTERACTIVE EXAMPLES
  int _containerPressCount = 0;
  bool _showMobileOnlyContent = true;
  bool _showDesktopOnlyContent = false;
  int _gridColumnCount = 3;

  // ✅ CONSTANTS FOR PERFORMANCE
  static const EdgeInsets _screenPadding = EdgeInsets.all(16.0);
  static const EdgeInsets _sectionPadding = EdgeInsets.only(bottom: 32.0);
  static const EdgeInsets _cardPadding = EdgeInsets.all(16.0);
  static const double _sectionSpacing = 24.0;
  static const double _itemSpacing = 16.0;
  static const double _componentSpacing = 12.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Layout Components'),
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

            // ✅ CONTAINER SYSTEM
            _buildContainerSection(context),
            const SizedBox(height: _sectionSpacing),

            // ✅ GRID SYSTEM
            _buildGridSystemSection(context),
            const SizedBox(height: _sectionSpacing),

            // ✅ ROW & COLUMN LAYOUTS
            _buildRowColumnSection(context),
            const SizedBox(height: _sectionSpacing),

            // ✅ RESPONSIVE VISIBILITY
            _buildVisibilitySection(context),
            const SizedBox(height: _sectionSpacing),

            // ✅ ADVANCED LAYOUT PATTERNS
            _buildAdvancedPatternsSection(context),
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
            'Flutstrap Layout System',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
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
          _buildFeatureGrid(context),
        ],
      ),
    );
  }

  /// Build feature grid
  /// Build feature grid
  Widget _buildFeatureGrid(BuildContext context) {
    return FlutstrapGrid.responsive(
      children: [
        _buildFeatureItem(context, Icons.dashboard, 'Container System',
            'Responsive containers with max-width constraints'),
        _buildFeatureItem(context, Icons.grid_on, 'Grid System',
            '12-column responsive grid with breakpoints'),
        _buildFeatureItem(context, Icons.view_array, 'Row & Column',
            'Flexible layout containers with consistent spacing'),
        _buildFeatureItem(context, Icons.visibility, 'Visibility',
            'Show/hide content based on screen size'),
      ],
      xsColumns: 1,
      smColumns: 2,
      mdColumns: 2,
      lgColumns: 4,
      gap: _componentSpacing,
    );
  }

  Widget _buildFeatureItem(
      BuildContext context, IconData icon, String title, String description) {
    return Card(
      child: Padding(
        padding: _cardPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 8),
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

  /// Build container system section
  Widget _buildContainerSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Container System',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Responsive containers with consistent spacing and max-width constraints',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: _itemSpacing),

          // Regular Container
          _buildComponentWithCode(
            context,
            'Regular Container',
            FlutstrapContainer(
              child: Container(
                padding: const EdgeInsets.all(16),
                color: Colors.blue.withOpacity(0.1),
                child: const Text('Respects max-width breakpoints'),
              ),
            ),
            '''FlutstrapContainer(
  child: Text('Content'),
)''',
          ),
          const SizedBox(height: _componentSpacing),

          // Fluid Container
          _buildComponentWithCode(
            context,
            'Fluid Container',
            FlutstrapContainer(
              fluid: true,
              child: Container(
                padding: const EdgeInsets.all(16),
                color: Colors.green.withOpacity(0.1),
                child: const Text('Full width - no max-width constraints'),
              ),
            ),
            '''FlutstrapContainer(
  fluid: true,
  child: Text('Full width content'),
)''',
          ),
          const SizedBox(height: _componentSpacing),

          // Card Container
          _buildComponentWithCode(
            context,
            'Card Container',
            FlutstrapContainer(
              child: const Text('Card-style container with shadow'),
            ).card(),
            '''FlutstrapContainer(child: Text('Content')).card()''',
          ),
        ],
      ),
    );
  }

  /// Build grid system section
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
            '12-column responsive grid system with mobile-first approach',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: _itemSpacing),

          // Responsive Grid Example
          Card(
            child: Padding(
              padding: _cardPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Responsive Grid (resize to see changes)',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 12),
                  FlutstrapGrid.responsive(
                    children:
                        List.generate(6, (index) => _buildGridItem(index + 1)),
                    xsColumns: 1,
                    smColumns: 2,
                    mdColumns: 3,
                    lgColumns: 6,
                    gap: _componentSpacing,
                  ),
                  const SizedBox(height: 12),
                  _buildCodeExample(
                    context,
                    '''FlutstrapGrid.responsive(
  children: [/* your items */],
  xsColumns: 1,  // 1 column on mobile
  smColumns: 2,  // 2 columns on small screens  
  mdColumns: 3,  // 3 columns on tablets
  lgColumns: 6,  // 6 columns on desktop
)''',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: _componentSpacing),

          // Manual Grid with Rows and Columns
          Card(
            child: Padding(
              padding: _cardPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Manual Grid with Rows & Columns',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 12),
                  FlutstrapGrid(
                    children: [
                      FlutstrapRow(
                        children: [
                          FlutstrapCol(
                            size: const FSColSize(xs: 12, md: 6),
                            child: _buildGridItem(1),
                          ),
                          FlutstrapCol(
                            size: const FSColSize(xs: 12, md: 6),
                            child: _buildGridItem(2),
                          ),
                        ],
                        gap: _componentSpacing,
                      ),
                      const SizedBox(height: _componentSpacing),
                      FlutstrapRow(
                        children: [
                          FlutstrapCol(
                            size: const FSColSize(xs: 12, md: 4),
                            child: _buildGridItem(3),
                          ),
                          FlutstrapCol(
                            size: const FSColSize(xs: 12, md: 4),
                            child: _buildGridItem(4),
                          ),
                          FlutstrapCol(
                            size: const FSColSize(xs: 12, md: 4),
                            child: _buildGridItem(5),
                          ),
                        ],
                        gap: _componentSpacing,
                      ),
                    ],
                    rowGap: _componentSpacing,
                  ),
                  const SizedBox(height: 12),
                  _buildCodeExample(
                    context,
                    '''FlutstrapGrid(
  children: [
    FlutstrapRow(
      children: [
        FlutstrapCol(size: FSColSize(xs: 12, md: 6), ...),
        FlutstrapCol(size: FSColSize(xs: 12, md: 6), ...),
      ],
    ),
    // More rows...
  ],
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

  /// Build row and column section
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
            'Flexible layout containers with consistent spacing and alignment',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: _itemSpacing),

          // Row with Gap
          _buildComponentWithCode(
            context,
            'Row with Consistent Gap',
            FlutstrapRow(
              children: [
                _buildLayoutItem('Item 1'),
                _buildLayoutItem('Item 2'),
                _buildLayoutItem('Item 3'),
              ],
              gap: _componentSpacing,
            ),
            '''FlutstrapRow(
  children: [Item1, Item2, Item3],
  gap: 12.0, // Consistent spacing
)''',
          ),
          const SizedBox(height: _componentSpacing),

          // Row Alignment Variants
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

  /// Build visibility section
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
            'Show or hide content based on screen size and breakpoints',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: _itemSpacing),

          // Visibility Examples
          Card(
            child: Padding(
              padding: _cardPadding,
              child: Column(
                children: [
                  _buildVisibilityExample(
                    context,
                    'Mobile Only Content',
                    FlutstrapVisibility.mobileOnly(
                      child: _buildVisibilityItem(
                          'This only shows on mobile', Colors.blue),
                    ),
                    'FlutstrapVisibility.mobileOnly(child: ...)',
                  ),
                  const SizedBox(height: _componentSpacing),
                  _buildVisibilityExample(
                    context,
                    'Desktop Only Content',
                    FlutstrapVisibility.desktopOnly(
                      child: _buildVisibilityItem(
                          'This only shows on desktop', Colors.green),
                    ),
                    'FlutstrapVisibility.desktopOnly(child: ...)',
                  ),
                  const SizedBox(height: _componentSpacing),
                  _buildVisibilityExample(
                    context,
                    'Hide on Mobile',
                    FlutstrapVisibility.hideOnMobile(
                      child: _buildVisibilityItem(
                          'Hidden on mobile screens', Colors.orange),
                    ),
                    'FlutstrapVisibility.hideOnMobile(child: ...)',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build advanced patterns section
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
            'Common layout patterns and best practices',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: _itemSpacing),

          // Card Grid Pattern
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
                  FlutstrapGrid.cards(
                    cards:
                        List.generate(4, (index) => _buildCardItem(index + 1)),
                    columns: 2,
                    gap: _componentSpacing,
                    equalHeight: true,
                  ),
                  const SizedBox(height: 12),
                  _buildCodeExample(
                    context,
                    '''FlutstrapGrid.cards(
  cards: [Card1, Card2, Card3, Card4],
  columns: 2,
  equalHeight: true, // Uniform card heights
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

  /// Build interactive demo section
  Widget _buildInteractiveDemoSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Interactive Layout Demo',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Experiment with different layout configurations',
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
                  // Interactive Controls
                  FlutstrapRow(
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
                  const SizedBox(height: 16),

                  // Grid Column Control
                  FlutstrapRow(
                    children: [
                      const Text('Grid Columns:'),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Slider(
                          value: _gridColumnCount.toDouble(),
                          min: 1,
                          max: 6,
                          divisions: 5,
                          onChanged: (value) {
                            setState(() {
                              _gridColumnCount = value.toInt();
                            });
                          },
                        ),
                      ),
                      Text('$_gridColumnCount'),
                    ],
                    gap: _componentSpacing,
                  ),
                  const SizedBox(height: 16),

                  // Dynamic Content Area
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        // Dynamic Grid
                        FlutstrapGrid.responsive(
                          children: List.generate(6,
                              (index) => _buildInteractiveGridItem(index + 1)),
                          xsColumns: 1,
                          smColumns: 2,
                          mdColumns: _gridColumnCount,
                          lgColumns: _gridColumnCount,
                          gap: _componentSpacing,
                        ),
                        const SizedBox(height: 16),

                        // Conditional Visibility Content
                        if (_showMobileOnlyContent) ...[
                          FlutstrapVisibility.mobileOnly(
                            child: _buildVisibilityItem(
                                'Mobile Only Content (Visible)', Colors.blue),
                          ),
                          const SizedBox(height: 8),
                        ],
                        if (_showDesktopOnlyContent) ...[
                          FlutstrapVisibility.desktopOnly(
                            child: _buildVisibilityItem(
                                'Desktop Only Content (Visible)', Colors.green),
                          ),
                          const SizedBox(height: 8),
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

  // ✅ HELPER METHODS

  /// Build component with code example
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

  /// Build code example widget
  Widget _buildCodeExample(BuildContext context, String code) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        code,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontFamily: 'Monospace',
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
      ),
    );
  }

  /// Build grid item for examples
  Widget _buildGridItem(int number) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        border: Border.all(color: Colors.blue.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          'Item $number',
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  /// Build interactive grid item
  Widget _buildInteractiveGridItem(int number) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.purple.withOpacity(0.1),
        border: Border.all(color: Colors.purple.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: Text(
          'Dynamic $number',
          style: const TextStyle(fontSize: 12),
        ),
      ),
    );
  }

  /// Build layout item
  Widget _buildLayoutItem(String text) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(text),
    );
  }

  /// Build visibility item
  Widget _buildVisibilityItem(String text, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        border: Border.all(color: color.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.info, color: color, size: 16),
          const SizedBox(width: 8),
          Text(text, style: TextStyle(color: color)),
        ],
      ),
    );
  }

  /// Build card item
  Widget _buildCardItem(int number) {
    return Card(
      child: Padding(
        padding: _cardPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(child: Text('Image $number')),
            ),
            const SizedBox(height: 8),
            Text(
              'Card Title $number',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Text(
              'This is a sample card description that demonstrates equal height cards in a grid layout.',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build row alignment examples
  List<Widget> _buildRowAlignmentExamples() {
    return [
      _buildAlignmentExample(
          'Start (Default)',
          FlutstrapRow(
            children: [_buildLayoutItem('A'), _buildLayoutItem('B')],
          ).start()),
      const SizedBox(height: 8),
      _buildAlignmentExample(
          'Center',
          FlutstrapRow(
            children: [_buildLayoutItem('A'), _buildLayoutItem('B')],
          ).center()),
      const SizedBox(height: 8),
      _buildAlignmentExample(
          'End',
          FlutstrapRow(
            children: [_buildLayoutItem('A'), _buildLayoutItem('B')],
          ).end()),
      const SizedBox(height: 8),
      _buildAlignmentExample(
          'Space Between',
          FlutstrapRow(
            children: [_buildLayoutItem('A'), _buildLayoutItem('B')],
          ).spaceBetween()),
    ];
  }

  Widget _buildAlignmentExample(String label, Widget row) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 4),
        row,
      ],
    );
  }

  /// Build visibility example
  Widget _buildVisibilityExample(
      BuildContext context, String title, Widget visibility, String code) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleSmall),
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
}
