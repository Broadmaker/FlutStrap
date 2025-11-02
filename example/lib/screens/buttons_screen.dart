/// Flutstrap Buttons Demo Screen
///
/// Comprehensive demonstration of Flutstrap button components including:
/// - 🎨 All button variants (filled, outline, link)
/// - 📏 Multiple sizes (small, medium, large)
/// - ⚡ Interactive states (enabled, disabled, loading)
/// - 🎯 Advanced features (icons, expanded, custom styles)
///
/// Features:
/// - Live interactive button demonstrations
/// - Code examples for each button type
/// - State management for interactive examples
/// - Responsive layout design
/// - Accessibility compliance
///
/// {@category Demo}
/// {@category Screens}
/// {@category Buttons}

import 'package:flutter/material.dart';
import 'package:master_flutstrap/flutstrap.dart';

class ButtonsScreen extends StatefulWidget {
  const ButtonsScreen({super.key});

  /// Route name for navigation
  static const String routeName = '/buttons';

  @override
  State<ButtonsScreen> createState() => _ButtonsScreenState();
}

class _ButtonsScreenState extends State<ButtonsScreen> {
  // ✅ STATE FOR INTERACTIVE EXAMPLES
  int _pressCount = 0;
  bool _isLoading = false;
  bool _isExpanded = false;

  // ✅ CONSTANTS FOR PERFORMANCE
  static const EdgeInsets _screenPadding = EdgeInsets.all(16.0);
  static const EdgeInsets _sectionPadding = EdgeInsets.only(bottom: 32.0);
  static const EdgeInsets _cardPadding = EdgeInsets.all(16.0);
  static const double _sectionSpacing = 24.0;
  static const double _itemSpacing = 16.0;
  static const double _buttonSpacing = 12.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Button Components'),
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

            // ✅ FILLED BUTTON VARIANTS
            _buildFilledButtonsSection(context),
            const SizedBox(height: _sectionSpacing),

            // ✅ OUTLINE BUTTON VARIANTS
            _buildOutlineButtonsSection(context),
            const SizedBox(height: _sectionSpacing),

            // ✅ LINK BUTTON
            _buildLinkButtonSection(context),
            const SizedBox(height: _sectionSpacing),

            // ✅ BUTTON SIZES
            _buildButtonSizesSection(context),
            const SizedBox(height: _sectionSpacing),

            // ✅ BUTTON STATES
            _buildButtonStatesSection(context),
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
            'Flutstrap Buttons',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: _itemSpacing),
          Text(
            'Comprehensive button component system with Bootstrap-inspired variants, '
            'multiple sizes, and flexible states. Buttons are fully accessible, '
            'performance-optimized, and theme-aware.',
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

  /// Build filled button variants section
  Widget _buildFilledButtonsSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Filled Button Variants',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Solid buttons with different semantic meanings',
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
                spacing: _buttonSpacing,
                runSpacing: _buttonSpacing,
                children: [
                  _buildButtonWithCode(
                    context,
                    FlutstrapButton(
                      onPressed: _handleButtonPress,
                      text: 'Primary',
                      variant: FSButtonVariant.primary,
                    ),
                    'FSButtonVariant.primary',
                  ),
                  _buildButtonWithCode(
                    context,
                    FlutstrapButton(
                      onPressed: _handleButtonPress,
                      text: 'Secondary',
                      variant: FSButtonVariant.secondary,
                    ),
                    'FSButtonVariant.secondary',
                  ),
                  _buildButtonWithCode(
                    context,
                    FlutstrapButton(
                      onPressed: _handleButtonPress,
                      text: 'Success',
                      variant: FSButtonVariant.success,
                    ),
                    'FSButtonVariant.success',
                  ),
                  _buildButtonWithCode(
                    context,
                    FlutstrapButton(
                      onPressed: _handleButtonPress,
                      text: 'Danger',
                      variant: FSButtonVariant.danger,
                    ),
                    'FSButtonVariant.danger',
                  ),
                  _buildButtonWithCode(
                    context,
                    FlutstrapButton(
                      onPressed: _handleButtonPress,
                      text: 'Warning',
                      variant: FSButtonVariant.warning,
                    ),
                    'FSButtonVariant.warning',
                  ),
                  _buildButtonWithCode(
                    context,
                    FlutstrapButton(
                      onPressed: _handleButtonPress,
                      text: 'Info',
                      variant: FSButtonVariant.info,
                    ),
                    'FSButtonVariant.info',
                  ),
                  _buildButtonWithCode(
                    context,
                    FlutstrapButton(
                      onPressed: _handleButtonPress,
                      text: 'Light',
                      variant: FSButtonVariant.light,
                    ),
                    'FSButtonVariant.light',
                  ),
                  _buildButtonWithCode(
                    context,
                    FlutstrapButton(
                      onPressed: _handleButtonPress,
                      text: 'Dark',
                      variant: FSButtonVariant.dark,
                    ),
                    'FSButtonVariant.dark',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build outline button variants section
  Widget _buildOutlineButtonsSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Outline Button Variants',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Buttons with transparent background and colored borders',
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
                spacing: _buttonSpacing,
                runSpacing: _buttonSpacing,
                children: [
                  _buildButtonWithCode(
                    context,
                    FlutstrapButton(
                      onPressed: _handleButtonPress,
                      text: 'Outline Primary',
                      variant: FSButtonVariant.outlinePrimary,
                    ),
                    'FSButtonVariant.outlinePrimary',
                  ),
                  _buildButtonWithCode(
                    context,
                    FlutstrapButton(
                      onPressed: _handleButtonPress,
                      text: 'Outline Secondary',
                      variant: FSButtonVariant.outlineSecondary,
                    ),
                    'FSButtonVariant.outlineSecondary',
                  ),
                  _buildButtonWithCode(
                    context,
                    FlutstrapButton(
                      onPressed: _handleButtonPress,
                      text: 'Outline Success',
                      variant: FSButtonVariant.outlineSuccess,
                    ),
                    'FSButtonVariant.outlineSuccess',
                  ),
                  _buildButtonWithCode(
                    context,
                    FlutstrapButton(
                      onPressed: _handleButtonPress,
                      text: 'Outline Danger',
                      variant: FSButtonVariant.outlineDanger,
                    ),
                    'FSButtonVariant.outlineDanger',
                  ),
                  _buildButtonWithCode(
                    context,
                    FlutstrapButton(
                      onPressed: _handleButtonPress,
                      text: 'Outline Warning',
                      variant: FSButtonVariant.outlineWarning,
                    ),
                    'FSButtonVariant.outlineWarning',
                  ),
                  _buildButtonWithCode(
                    context,
                    FlutstrapButton(
                      onPressed: _handleButtonPress,
                      text: 'Outline Info',
                      variant: FSButtonVariant.outlineInfo,
                    ),
                    'FSButtonVariant.outlineInfo',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build link button section
  Widget _buildLinkButtonSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Link Button',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Text-only button that looks like a link',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: _itemSpacing),
          Card(
            child: Padding(
              padding: _cardPadding,
              child: _buildButtonWithCode(
                context,
                FlutstrapButton(
                  onPressed: _handleButtonPress,
                  text: 'Link Button',
                  variant: FSButtonVariant.link,
                ),
                'FSButtonVariant.link',
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build button sizes section
  Widget _buildButtonSizesSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Button Sizes',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Different button sizes for various UI contexts',
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
                  _buildButtonSizeRow('Small', FSButtonSize.sm),
                  const SizedBox(height: 12),
                  _buildButtonSizeRow('Medium', FSButtonSize.md),
                  const SizedBox(height: 12),
                  _buildButtonSizeRow('Large', FSButtonSize.lg),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build button states section
  Widget _buildButtonStatesSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Button States',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Different interactive states and behaviors',
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
                spacing: _buttonSpacing,
                runSpacing: _buttonSpacing,
                children: [
                  _buildButtonWithCode(
                    context,
                    FlutstrapButton(
                      onPressed: _handleButtonPress,
                      text: 'Enabled',
                      variant: FSButtonVariant.primary,
                    ),
                    'Enabled (onPressed provided)',
                  ),
                  _buildButtonWithCode(
                    context,
                    FlutstrapButton(
                      onPressed: null, // Disabled state
                      text: 'Disabled',
                      variant: FSButtonVariant.primary,
                    ),
                    'Disabled (onPressed: null)',
                  ),
                  _buildButtonWithCode(
                    context,
                    FlutstrapButton(
                      onPressed: _handleButtonPress,
                      text: 'Loading',
                      variant: FSButtonVariant.primary,
                      loading: true,
                    ),
                    'loading: true',
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
            'Buttons with icons, expanded width, and custom content',
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
                  // Button with leading icon
                  _buildButtonWithCode(
                    context,
                    FlutstrapButton(
                      onPressed: _handleButtonPress,
                      text: 'With Icon',
                      variant: FSButtonVariant.primary,
                      leading: const Icon(Icons.star, size: 16),
                    ),
                    'leading: Icon(Icons.star)',
                  ),
                  const SizedBox(height: 12),

                  // Expanded button
                  _buildButtonWithCode(
                    context,
                    FlutstrapButton(
                      onPressed: _handleButtonPress,
                      text: 'Expanded Width',
                      variant: FSButtonVariant.success,
                      expanded: true,
                    ),
                    'expanded: true',
                  ),
                  const SizedBox(height: 12),

                  // Custom child button
                  _buildButtonWithCode(
                    context,
                    FlutstrapButton(
                      onPressed: _handleButtonPress,
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.code, size: 16),
                          SizedBox(width: 8),
                          Text('Custom Child'),
                        ],
                      ),
                      variant: FSButtonVariant.info,
                    ),
                    'child: Row(...) // Custom content',
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
            'Try the buttons below to see interactive behavior',
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
                  // Counter display
                  Text(
                    'Button pressed $_pressCount times',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),

                  // Interactive buttons
                  Wrap(
                    spacing: _buttonSpacing,
                    runSpacing: _buttonSpacing,
                    children: [
                      FlutstrapButton(
                        onPressed: _handleButtonPress,
                        text: 'Press Me!',
                        variant: FSButtonVariant.primary,
                      ),
                      FlutstrapButton(
                        onPressed: _toggleLoading,
                        text: _isLoading ? 'Stop Loading' : 'Start Loading',
                        variant: FSButtonVariant.warning,
                      ),
                      FlutstrapButton(
                        onPressed: _toggleExpanded,
                        text: _isExpanded ? 'Shrink' : 'Expand',
                        variant: FSButtonVariant.success,
                        expanded: _isExpanded,
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Loading button demo
                  if (_isLoading) ...[
                    FlutstrapButton(
                      onPressed: _handleButtonPress,
                      text: 'Loading Button',
                      variant: FSButtonVariant.primary,
                      loading: true,
                    ),
                    const SizedBox(height: 12),
                  ],

                  // Reset button
                  FlutstrapButton(
                    onPressed: _resetDemo,
                    text: 'Reset Demo',
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

  // ✅ HELPER METHODS

  /// Build button with code example
  Widget _buildButtonWithCode(
      BuildContext context, Widget button, String code) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        button,
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            code,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontFamily: 'Monospace',
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
        ),
      ],
    );
  }

  /// Build button size demonstration row
  Widget _buildButtonSizeRow(String label, FSButtonSize size) {
    return Row(
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
          child: FlutstrapButton(
            onPressed: _handleButtonPress,
            text: label,
            variant: FSButtonVariant.primary,
            size: size,
          ),
        ),
      ],
    );
  }

  // ✅ INTERACTION HANDLERS

  void _handleButtonPress() {
    setState(() {
      _pressCount++;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Button pressed! Count: $_pressCount'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _toggleLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void _resetDemo() {
    setState(() {
      _pressCount = 0;
      _isLoading = false;
      _isExpanded = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Demo reset!')),
    );
  }
}
