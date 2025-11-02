/// Flutstrap Tooltips Demo Screen
///
/// Comprehensive demonstration of Flutstrap tooltip components including:
/// - 🎨 All tooltip variants (primary, success, danger, warning, info, light, dark)
/// - 📍 Multiple placements (top, bottom, left, right with start/end variations)
/// - ⚡ Advanced features (custom delays, animations, error handling)
/// - 🎯 Interactive demonstrations with real-time controls
/// - 📱 Mobile-friendly touch interactions
///
/// Features:
/// - Live interactive tooltip demonstrations
/// - Code examples for each tooltip configuration
/// - State management for dynamic examples
/// - Real-time positioning testing
///
/// {@category Demo}
/// {@category Screens}
/// {@category Overlays}

import 'package:flutter/material.dart';
import 'package:master_flutstrap/flutstrap.dart';

class TooltipsScreen extends StatefulWidget {
  const TooltipsScreen({super.key});

  /// Route name for navigation
  static const String routeName = '/tooltips';

  @override
  State<TooltipsScreen> createState() => _TooltipsScreenState();
}

class _TooltipsScreenState extends State<TooltipsScreen> {
  // ✅ STATE FOR INTERACTIVE EXAMPLES
  FSTooltipVariant _selectedVariant = FSTooltipVariant.primary;
  FSTooltipPlacement _selectedPlacement = FSTooltipPlacement.top;
  double _showDelay = 100.0;
  double _hideDelay = 100.0;
  double _animationDuration = 200.0;
  bool _showArrow = true;
  double _maxWidth = 200.0;
  bool _useErrorBoundary = false;
  String _customMessage = 'Custom tooltip message';

  // ✅ ADD: TextEditingController for custom message
  late TextEditingController _messageController;

  // ✅ CONSTANTS FOR PERFORMANCE
  static const EdgeInsets _screenPadding = EdgeInsets.all(16.0);
  static const EdgeInsets _sectionPadding = EdgeInsets.only(bottom: 32.0);
  static const EdgeInsets _demoPadding = EdgeInsets.all(16.0);
  static const double _sectionSpacing = 24.0;
  static const double _itemSpacing = 16.0;

  // ✅ TOOLTIP VARIANTS
  final List<Map<String, dynamic>> _tooltipVariants = [
    {
      'variant': FSTooltipVariant.primary,
      'name': 'Primary',
      'color': Colors.blue
    },
    {
      'variant': FSTooltipVariant.secondary,
      'name': 'Secondary',
      'color': Colors.grey
    },
    {
      'variant': FSTooltipVariant.success,
      'name': 'Success',
      'color': Colors.green
    },
    {'variant': FSTooltipVariant.danger, 'name': 'Danger', 'color': Colors.red},
    {
      'variant': FSTooltipVariant.warning,
      'name': 'Warning',
      'color': Colors.orange
    },
    {'variant': FSTooltipVariant.info, 'name': 'Info', 'color': Colors.cyan},
    {
      'variant': FSTooltipVariant.light,
      'name': 'Light',
      'color': Colors.grey.shade200
    },
    {
      'variant': FSTooltipVariant.dark,
      'name': 'Dark',
      'color': Colors.grey.shade800
    },
  ];

  // ✅ TOOLTIP PLACEMENTS
  final List<Map<String, dynamic>> _tooltipPlacements = [
    {
      'placement': FSTooltipPlacement.top,
      'name': 'Top',
      'icon': Icons.arrow_upward
    },
    {
      'placement': FSTooltipPlacement.topStart,
      'name': 'Top Start',
      'icon': Icons.arrow_upward
    },
    {
      'placement': FSTooltipPlacement.topEnd,
      'name': 'Top End',
      'icon': Icons.arrow_upward
    },
    {
      'placement': FSTooltipPlacement.bottom,
      'name': 'Bottom',
      'icon': Icons.arrow_downward
    },
    {
      'placement': FSTooltipPlacement.bottomStart,
      'name': 'Bottom Start',
      'icon': Icons.arrow_downward
    },
    {
      'placement': FSTooltipPlacement.bottomEnd,
      'name': 'Bottom End',
      'icon': Icons.arrow_downward
    },
    {
      'placement': FSTooltipPlacement.left,
      'name': 'Left',
      'icon': Icons.arrow_back
    },
    {
      'placement': FSTooltipPlacement.leftStart,
      'name': 'Left Start',
      'icon': Icons.arrow_back
    },
    {
      'placement': FSTooltipPlacement.leftEnd,
      'name': 'Left End',
      'icon': Icons.arrow_back
    },
    {
      'placement': FSTooltipPlacement.right,
      'name': 'Right',
      'icon': Icons.arrow_forward
    },
    {
      'placement': FSTooltipPlacement.rightStart,
      'name': 'Right Start',
      'icon': Icons.arrow_forward
    },
    {
      'placement': FSTooltipPlacement.rightEnd,
      'name': 'Right End',
      'icon': Icons.arrow_forward
    },
  ];

  @override
  void initState() {
    super.initState();
    // ✅ INITIALIZE: TextEditingController with initial value
    _messageController = TextEditingController(text: _customMessage);
  }

  @override
  void dispose() {
    // ✅ DISPOSE: TextEditingController to prevent memory leaks
    _messageController.dispose();
    super.dispose();
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _testErrorHandling() {
    _showSnackbar('Error handling test triggered - check console for errors');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tooltip Components'),
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

            // ✅ BASIC TOOLTIPS
            _buildBasicTooltipsSection(context),
            const SizedBox(height: _sectionSpacing),

            // ✅ TOOLTIP VARIANTS
            _buildTooltipVariantsSection(context),
            const SizedBox(height: _sectionSpacing),

            // ✅ TOOLTIP PLACEMENTS
            _buildTooltipPlacementsSection(context),
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
            'Flutstrap Tooltips',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: _itemSpacing),
          Text(
            'High-performance, customizable tooltips with Bootstrap-inspired styling. '
            'Tooltips support multiple variants, placements, animations, and comprehensive '
            'accessibility features for all interaction methods.',
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

  /// Build basic tooltips section
  Widget _buildBasicTooltipsSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Basic Tooltips',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Simple tooltips with default configurations',
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
                  _buildTooltipWithCode(
                    context,
                    FlutstrapTooltip(
                      message: 'This is a basic tooltip',
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Hover or Tap Me',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    'Basic tooltip with default settings',
                  ),
                  const SizedBox(height: 16),
                  _buildTooltipWithCode(
                    context,
                    FlutstrapTooltip(
                      message:
                          'Tooltip with longer message that might wrap to multiple lines',
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Long Message',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    'Tooltip with longer message',
                  ),
                  const SizedBox(height: 16),
                  _buildTooltipWithCode(
                    context,
                    FlutstrapTooltip(
                      message: 'No arrow tooltip',
                      showArrow: false,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.tertiary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'No Arrow',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    'Tooltip without arrow',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build tooltip variants section
  Widget _buildTooltipVariantsSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tooltip Variants',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Different color variants for various contexts and semantic meanings',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: _itemSpacing),
          Card(
            child: Padding(
              padding: _demoPadding,
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  for (final variant in _tooltipVariants)
                    _buildVariantTooltip(
                      variant['name'] as String,
                      variant['variant'] as FSTooltipVariant,
                      variant['color'] as Color,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build tooltip placements section
  Widget _buildTooltipPlacementsSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tooltip Placements',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Different positioning options relative to the target element',
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
                  // Placement grid
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.5,
                    ),
                    itemCount: _tooltipPlacements.length,
                    itemBuilder: (context, index) {
                      final placement = _tooltipPlacements[index];
                      return _buildPlacementTooltip(
                        placement['name'] as String,
                        placement['placement'] as FSTooltipPlacement,
                        placement['icon'] as IconData,
                      );
                    },
                  ),

                  const SizedBox(height: 16),

                  // Placement explanation
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
                          'Placement Guide:',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '• Start: Aligns with the start of the target\n'
                          '• End: Aligns with the end of the target\n'
                          '• Default: Centers relative to the target',
                          style: Theme.of(context).textTheme.bodySmall,
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
            'Custom animations, error handling, and performance optimizations',
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
                  _buildTooltipWithCode(
                    context,
                    FlutstrapTooltip(
                      message: 'Tooltip with custom animation',
                      animationDuration:
                          Duration(milliseconds: _animationDuration.round()),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Custom Animation',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    'Custom animation duration: ${_animationDuration.round()}ms',
                  ),

                  const SizedBox(height: 16),

                  _buildTooltipWithCode(
                    context,
                    FlutstrapTooltip(
                      message: 'Tooltip with custom styling',
                      backgroundColor: Colors.deepOrange,
                      textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Custom Style',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    'Custom colors, typography, and border radius',
                  ),

                  const SizedBox(height: 16),

                  _buildTooltipWithCode(
                    context,
                    FlutstrapTooltip(
                      message: 'Wide tooltip with maximum width constraint',
                      maxWidth: _maxWidth,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Max Width: ${_maxWidth.round()}px',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    'Custom maximum width constraint',
                  ),

                  const SizedBox(height: 16),

                  // Error boundary demo
                  _buildTooltipWithCode(
                    context,
                    _useErrorBoundary
                        ? FlutstrapTooltip.buildWithErrorBoundary(
                            message: _customMessage,
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                'With Error Boundary',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            fallback: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                'Tooltip Error',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        : FlutstrapTooltip(
                            message: _customMessage,
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                'Normal Tooltip',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                    'Error boundary protection for dynamic content',
                  ),

                  const SizedBox(height: 16),

                  // Configuration controls
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Advanced Configuration:',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 16),

                      // Animation duration
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'Animation Duration: ${_animationDuration.round()}ms'),
                          Slider(
                            value: _animationDuration,
                            min: 100,
                            max: 1000,
                            divisions: 9,
                            onChanged: (value) =>
                                setState(() => _animationDuration = value),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Max width
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Max Width: ${_maxWidth.round()}px'),
                          Slider(
                            value: _maxWidth,
                            min: 100,
                            max: 400,
                            divisions: 6,
                            onChanged: (value) =>
                                setState(() => _maxWidth = value),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Error boundary toggle
                      Row(
                        children: [
                          Switch(
                            value: _useErrorBoundary,
                            onChanged: (value) =>
                                setState(() => _useErrorBoundary = value),
                          ),
                          const SizedBox(width: 8),
                          const Text('Use Error Boundary'),
                        ],
                      ),

                      const SizedBox(height: 8),

                      // Custom message - ✅ FIXED: Use TextEditingController instead of value parameter
                      TextField(
                        controller:
                            _messageController, // ✅ FIX: Use controller instead of value
                        decoration: const InputDecoration(
                          labelText: 'Custom Tooltip Message',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) =>
                            setState(() => _customMessage = value),
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
            'Customize and test tooltip features in real-time',
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
                  // Current configuration display
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
                        Text('Placement: ${_selectedPlacement.name}'),
                        Text('Show Delay: ${_showDelay.round()}ms'),
                        Text('Hide Delay: ${_hideDelay.round()}ms'),
                        Text('Show Arrow: $_showArrow'),
                        Text('Error Boundary: $_useErrorBoundary'),
                        Text('Custom Message: $_customMessage'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Live tooltip preview
                  Center(
                    child: _buildTooltipWithCode(
                      context,
                      FlutstrapTooltip(
                        message:
                            _customMessage, // ✅ USE: Updated custom message
                        variant: _selectedVariant,
                        placement: _selectedPlacement,
                        showDelay: Duration(milliseconds: _showDelay.round()),
                        hideDelay: Duration(milliseconds: _hideDelay.round()),
                        showArrow: _showArrow,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Test Tooltip',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      'Live tooltip preview',
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Configuration controls
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Variant Selection:',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 8),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Wrap(
                          spacing: 8,
                          children: [
                            for (final variant in _tooltipVariants)
                              FlutstrapButton(
                                onPressed: () => setState(() =>
                                    _selectedVariant =
                                        variant['variant'] as FSTooltipVariant),
                                text: variant['name'] as String,
                                size: FSButtonSize.sm,
                                variant: _selectedVariant == variant['variant']
                                    ? FSButtonVariant.primary
                                    : FSButtonVariant.outlinePrimary,
                              ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      const Text(
                        'Placement Selection:',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          for (final placement in _tooltipPlacements)
                            FlutstrapButton(
                              onPressed: () => setState(() =>
                                  _selectedPlacement = placement['placement']
                                      as FSTooltipPlacement),
                              text: placement['name'] as String,
                              size: FSButtonSize.sm,
                              variant:
                                  _selectedPlacement == placement['placement']
                                      ? FSButtonVariant.success
                                      : FSButtonVariant.outlineSuccess,
                            ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Delay controls
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Show Delay: ${_showDelay.round()}ms'),
                          Slider(
                            value: _showDelay,
                            min: 0,
                            max: 1000,
                            divisions: 10,
                            onChanged: (value) =>
                                setState(() => _showDelay = value),
                          ),
                          const SizedBox(height: 8),
                          Text('Hide Delay: ${_hideDelay.round()}ms'),
                          Slider(
                            value: _hideDelay,
                            min: 0,
                            max: 1000,
                            divisions: 10,
                            onChanged: (value) =>
                                setState(() => _hideDelay = value),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Arrow toggle
                      Row(
                        children: [
                          Switch(
                            value: _showArrow,
                            onChanged: (value) =>
                                setState(() => _showArrow = value),
                          ),
                          const SizedBox(width: 8),
                          const Text('Show Arrow'),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Test buttons
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          FlutstrapButton(
                            onPressed: _testErrorHandling,
                            text: 'Test Error Handling',
                            size: FSButtonSize.sm,
                            variant: FSButtonVariant.warning,
                          ),
                          FlutstrapButton(
                            onPressed: () =>
                                _showSnackbar('Tooltip configuration saved'),
                            text: 'Save Configuration',
                            size: FSButtonSize.sm,
                            variant: FSButtonVariant.success,
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

  /// Build tooltip with code example
  Widget _buildTooltipWithCode(
      BuildContext context, Widget tooltip, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(child: tooltip),
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

  /// Build variant tooltip
  Widget _buildVariantTooltip(
      String label, FSTooltipVariant variant, Color color) {
    return FlutstrapTooltip(
      message: '$label tooltip variant',
      variant: variant,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            color:
                variant == FSTooltipVariant.light ? Colors.black : Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  /// Build placement tooltip
  Widget _buildPlacementTooltip(
      String label, FSTooltipPlacement placement, IconData icon) {
    return FlutstrapTooltip(
      message: '$label placement',
      placement: placement,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
