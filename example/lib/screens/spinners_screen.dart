/// Flutstrap Spinners Demo Screen
///
/// Comprehensive demonstration of Flutstrap spinner components including:
/// - 🎨 All spinner variants (primary, success, danger, warning, info, light, dark)
/// - 📏 Multiple sizes (small, medium, large)
/// - ⚡ Advanced spinner types (border, growing, dots)
/// - 🔧 Interactive features (loading states, error handling, customizations)
/// - 🎯 Real-world examples (buttons, forms, loading states)
///
/// Features:
/// - Live interactive spinner demonstrations
/// - Code examples for each spinner type
/// - State management for dynamic examples
/// - Real-time loading simulations
///
/// {@category Demo}
/// {@category Screens}
/// {@category Feedback}

import 'package:flutter/material.dart';
import 'package:flutstrap/flutstrap.dart';

class SpinnersScreen extends StatefulWidget {
  const SpinnersScreen({super.key});

  /// Route name for navigation
  static const String routeName = '/spinners';

  @override
  State<SpinnersScreen> createState() => _SpinnersScreenState();
}

class _SpinnersScreenState extends State<SpinnersScreen> {
  // ✅ STATE FOR INTERACTIVE EXAMPLES
  bool _isFormSubmitting = false;
  bool _isDataLoading = false;
  bool _isProcessing = false;
  bool _showErrorHandling = false;
  double _animationSpeed = 1.0; // 1x normal speed
  int _selectedSpinnerType = 0;
  FSSpinnerVariant _selectedVariant = FSSpinnerVariant.primary;

  // ✅ CONSTANTS FOR PERFORMANCE
  static const EdgeInsets _screenPadding = EdgeInsets.all(16.0);
  static const EdgeInsets _sectionPadding = EdgeInsets.only(bottom: 32.0);
  static const EdgeInsets _demoPadding = EdgeInsets.all(16.0);
  static const double _sectionSpacing = 24.0;
  static const double _itemSpacing = 16.0;

  // ✅ SPINNER TYPE OPTIONS
  final List<Map<String, dynamic>> _spinnerTypes = [
    {
      'type': FSSpinnerType.border,
      'name': 'Border Spinner',
      'description': 'Classic rotating border animation'
    },
    {
      'type': FSSpinnerType.growing,
      'name': 'Growing Spinner',
      'description': 'Pulsing circle animation'
    },
    {
      'type': FSSpinnerType.dots,
      'name': 'Dots Spinner',
      'description': 'Bouncing dots animation'
    },
  ];

  // ✅ SPINNER VARIANTS
  final List<Map<String, dynamic>> _spinnerVariants = [
    {'variant': FSSpinnerVariant.primary, 'name': 'Primary'},
    {'variant': FSSpinnerVariant.secondary, 'name': 'Secondary'},
    {'variant': FSSpinnerVariant.success, 'name': 'Success'},
    {'variant': FSSpinnerVariant.danger, 'name': 'Danger'},
    {'variant': FSSpinnerVariant.warning, 'name': 'Warning'},
    {'variant': FSSpinnerVariant.info, 'name': 'Info'},
    {'variant': FSSpinnerVariant.light, 'name': 'Light'},
    {'variant': FSSpinnerVariant.dark, 'name': 'Dark'},
  ];

  void _simulateFormSubmission() async {
    setState(() => _isFormSubmitting = true);
    await Future.delayed(const Duration(seconds: 3));
    setState(() => _isFormSubmitting = false);
    _showSnackbar('Form submitted successfully!');
  }

  void _simulateDataLoading() async {
    setState(() => _isDataLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isDataLoading = false);
    _showSnackbar('Data loaded successfully!');
  }

  void _simulateProcessing() async {
    setState(() => _isProcessing = true);
    await Future.delayed(const Duration(seconds: 4));
    setState(() => _isProcessing = false);
    _showSnackbar('Processing completed!');
  }

  void _triggerErrorHandling() {
    setState(() => _showErrorHandling = true);
    Future.delayed(const Duration(seconds: 2), () {
      setState(() => _showErrorHandling = false);
    });
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Duration _getAnimationDuration() {
    return Duration(milliseconds: (1000 / _animationSpeed).round());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spinner Components'),
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

            // ✅ BASIC SPINNERS
            _buildBasicSpinnersSection(context),
            const SizedBox(height: _sectionSpacing),

            // ✅ SPINNER TYPES
            _buildSpinnerTypesSection(context),
            const SizedBox(height: _sectionSpacing),

            // ✅ SPINNER VARIANTS
            _buildSpinnerVariantsSection(context),
            const SizedBox(height: _sectionSpacing),

            // ✅ SPINNER SIZES
            _buildSpinnerSizesSection(context),
            const SizedBox(height: _sectionSpacing),

            // ✅ SPINNER BUTTONS
            _buildSpinnerButtonsSection(context),
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
            'Flutstrap Spinners',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: _itemSpacing),
          Text(
            'High-performance, customizable loading indicators with Bootstrap-inspired styling. '
            'Spinners support multiple animation types, sizes, variants, and comprehensive '
            'accessibility features for all loading scenarios.',
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

  /// Build basic spinners section
  Widget _buildBasicSpinnersSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Basic Spinners',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Simple loading indicators with different configurations',
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
                  _buildSpinnerWithCode(
                    context,
                    const FlutstrapSpinner(
                      variant: FSSpinnerVariant.primary,
                    ),
                    'Default border spinner',
                  ),
                  const SizedBox(height: 16),
                  _buildSpinnerWithCode(
                    context,
                    const FlutstrapSpinner(
                      variant: FSSpinnerVariant.primary,
                      label: 'Loading...',
                    ),
                    'With text label',
                  ),
                  const SizedBox(height: 16),
                  _buildSpinnerWithCode(
                    context,
                    const FlutstrapSpinner(
                      variant: FSSpinnerVariant.primary,
                      centered: true,
                      label: 'Centered spinner',
                    ),
                    'Centered with label',
                  ),
                  const SizedBox(height: 16),
                  _buildSpinnerWithCode(
                    context,
                    FlutstrapSpinner(
                      variant: FSSpinnerVariant.primary,
                      customLabel: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.download, size: 16),
                          const SizedBox(width: 8),
                          Text(
                            'Downloading files...',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    'Custom label with icon',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build spinner types section
  Widget _buildSpinnerTypesSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Spinner Types',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Different animation styles for various loading contexts',
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
                  for (int i = 0; i < _spinnerTypes.length; i++) ...[
                    if (i > 0) const SizedBox(height: 16),
                    _buildSpinnerWithCode(
                      context,
                      FlutstrapSpinner(
                        type: _spinnerTypes[i]['type'] as FSSpinnerType,
                        variant: FSSpinnerVariant.primary,
                        label: _spinnerTypes[i]['name'] as String,
                      ),
                      _spinnerTypes[i]['description'] as String,
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

  /// Build spinner variants section
  Widget _buildSpinnerVariantsSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Spinner Variants',
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
              child: Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  for (final variant in _spinnerVariants)
                    _buildVariantSpinner(
                      variant['name'] as String,
                      variant['variant'] as FSSpinnerVariant,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build spinner sizes section
  Widget _buildSpinnerSizesSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Spinner Sizes',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Different sizes for various UI contexts and visual prominence',
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
                  _buildSizeSpinner('Small (16px)', FSSpinnerSize.sm),
                  const SizedBox(height: 16),
                  _buildSizeSpinner('Medium (24px)', FSSpinnerSize.md),
                  const SizedBox(height: 16),
                  _buildSizeSpinner('Large (32px)', FSSpinnerSize.lg),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build spinner buttons section
  Widget _buildSpinnerButtonsSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Spinner Buttons',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Buttons that show spinners during loading states',
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
                  _buildSpinnerWithCode(
                    context,
                    FlutstrapSpinnerButton(
                      isLoading: _isFormSubmitting,
                      onPressed: _simulateFormSubmission,
                      child: const Text('Submit Form'),
                      spinner: const FlutstrapSpinner(
                        variant: FSSpinnerVariant.light,
                        size: FSSpinnerSize.sm,
                      ),
                      loadingLabel: 'Submitting form...',
                    ),
                    'Form submission with spinner',
                  ),
                  const SizedBox(height: 16),
                  _buildSpinnerWithCode(
                    context,
                    FlutstrapSpinnerButton(
                      isLoading: _isDataLoading,
                      onPressed: _simulateDataLoading,
                      child: const Text('Load Data'),
                      spinner: const FlutstrapSpinner(
                        variant: FSSpinnerVariant.light,
                        size: FSSpinnerSize.sm,
                        type: FSSpinnerType.growing,
                      ),
                    ),
                    'Data loading with growing spinner',
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      FlutstrapSpinnerButton(
                        isLoading: _isFormSubmitting,
                        onPressed: _simulateFormSubmission,
                        child: const Text('Primary'),
                        spinner: const FlutstrapSpinner(
                          variant: FSSpinnerVariant.light,
                          size: FSSpinnerSize.sm,
                        ),
                      ),
                      FlutstrapSpinnerButton(
                        isLoading: _isDataLoading,
                        onPressed: _simulateDataLoading,
                        child: const Text('Success'),
                        spinner: const FlutstrapSpinner(
                          variant: FSSpinnerVariant.light,
                          size: FSSpinnerSize.sm,
                        ),
                      ),
                      FlutstrapSpinnerButton(
                        isLoading: _isProcessing,
                        onPressed: _simulateProcessing,
                        child: const Text('Warning'),
                        spinner: const FlutstrapSpinner(
                          variant: FSSpinnerVariant.light,
                          size: FSSpinnerSize.sm,
                        ),
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
                  _buildSpinnerWithCode(
                    context,
                    FlutstrapSpinner(
                      variant: FSSpinnerVariant.primary,
                      animationDuration: _getAnimationDuration(),
                      label: 'Custom Speed: ${_animationSpeed}x',
                    ),
                    'Custom animation speed',
                  ),

                  const SizedBox(height: 16),

                  // Speed controls
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Animation Speed:',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 8),
                      Slider(
                        value: _animationSpeed,
                        min: 0.5,
                        max: 3.0,
                        divisions: 5,
                        label: '${_animationSpeed}x',
                        onChanged: (value) {
                          setState(() => _animationSpeed = value);
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('0.5x', style: TextStyle(fontSize: 12)),
                          Text('1x', style: TextStyle(fontSize: 12)),
                          Text('2x', style: TextStyle(fontSize: 12)),
                          Text('3x', style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  _buildSpinnerWithCode(
                    context,
                    FlutstrapSpinner(
                      variant: FSSpinnerVariant.primary,
                      type: FSSpinnerType.border,
                      strokeWidth: 4.0,
                      label: 'Custom stroke width',
                    ),
                    'Custom stroke width (4.0)',
                  ),

                  const SizedBox(height: 16),

                  _buildSpinnerWithCode(
                    context,
                    FlutstrapSpinner(
                      variant: FSSpinnerVariant.primary,
                      color: Colors.purple,
                      label: 'Custom color',
                    ),
                    'Custom color (purple)',
                  ),

                  const SizedBox(height: 16),

                  // Error handling demo
                  _buildSpinnerWithCode(
                    context,
                    _showErrorHandling
                        ? FlutstrapSpinner(
                            variant: FSSpinnerVariant.danger,
                            label: 'Error State',
                            fallbackWidget: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.red, width: 2),
                              ),
                              child: const Icon(Icons.error,
                                  size: 12, color: Colors.red),
                            ),
                            onAnimationError: (error) {
                              _showSnackbar('Spinner animation error occurred');
                            },
                          )
                        : const FlutstrapSpinner(
                            variant: FSSpinnerVariant.primary,
                            label: 'Normal State',
                          ),
                    'Error handling with fallback',
                  ),

                  const SizedBox(height: 16),

                  FlutstrapButton(
                    onPressed: _triggerErrorHandling,
                    text: 'Trigger Error State',
                    size: FSButtonSize.sm,
                    variant: FSButtonVariant.outlineDanger,
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
            'Customize and test spinner features in real-time',
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
                        Text(
                            'Type: ${_spinnerTypes[_selectedSpinnerType]['name']}'),
                        Text('Variant: ${_selectedVariant.name}'),
                        Text('Speed: ${_animationSpeed}x'),
                        Text(
                            'Animation: ${_getAnimationDuration().inMilliseconds}ms'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Live spinner preview
                  _buildSpinnerWithCode(
                    context,
                    FlutstrapSpinner(
                      type: _spinnerTypes[_selectedSpinnerType]['type']
                          as FSSpinnerType,
                      variant: _selectedVariant,
                      animationDuration: _getAnimationDuration(),
                      label: 'Live Preview',
                      centered: true,
                    ),
                    'Live spinner preview',
                  ),

                  const SizedBox(height: 16),

                  // Configuration controls
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Spinner Type:',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: [
                          for (int i = 0; i < _spinnerTypes.length; i++)
                            FlutstrapButton(
                              onPressed: () =>
                                  setState(() => _selectedSpinnerType = i),
                              text: _spinnerTypes[i]['name'] as String,
                              size: FSButtonSize.sm,
                              variant: _selectedSpinnerType == i
                                  ? FSButtonVariant.primary
                                  : FSButtonVariant.outlinePrimary,
                            ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Spinner Variant:',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 8),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Wrap(
                          spacing: 8,
                          children: [
                            for (final variant in _spinnerVariants)
                              FlutstrapButton(
                                onPressed: () => setState(() =>
                                    _selectedVariant =
                                        variant['variant'] as FSSpinnerVariant),
                                text: variant['name'] as String,
                                size: FSButtonSize.sm,
                                variant: _selectedVariant == variant['variant']
                                    ? FSButtonVariant.primary
                                    : FSButtonVariant.outlinePrimary,
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Demo actions
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      FlutstrapButton(
                        onPressed: _simulateFormSubmission,
                        text: 'Test Form Submission',
                        size: FSButtonSize.sm,
                      ),
                      FlutstrapButton(
                        onPressed: _simulateDataLoading,
                        text: 'Test Data Loading',
                        size: FSButtonSize.sm,
                        variant: FSButtonVariant.success,
                      ),
                      FlutstrapButton(
                        onPressed: _simulateProcessing,
                        text: 'Test Processing',
                        size: FSButtonSize.sm,
                        variant: FSButtonVariant.warning,
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

  /// Build spinner with code example
  Widget _buildSpinnerWithCode(
      BuildContext context, Widget spinner, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        spinner,
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

  /// Build variant spinner
  Widget _buildVariantSpinner(String label, FSSpinnerVariant variant) {
    return Column(
      children: [
        FlutstrapSpinner(
          variant: variant,
          size: FSSpinnerSize.md,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  /// Build size spinner
  Widget _buildSizeSpinner(String label, FSSpinnerSize size) {
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
          child: Center(
            child: FlutstrapSpinner(
              size: size,
              variant: FSSpinnerVariant.primary,
            ),
          ),
        ),
      ],
    );
  }
}
