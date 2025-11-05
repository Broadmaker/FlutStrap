/// Flutstrap Cards Demo Screen
///
/// Comprehensive demonstration of Flutstrap card components including:
/// - 🎨 All card variants (elevated, outlined, filled, surface)
/// - 📐 Multiple layouts (simple, image, action, interactive)
/// - 🎯 Advanced features (dividers, padding, custom content)
/// - ⚡ Performance optimizations (caching, error boundaries)
///
/// Features:
/// - Live interactive card demonstrations
/// - Code examples for each card type
/// - Responsive card layouts
/// - Accessibility compliance
///
/// {@category Demo}
/// {@category Screens}
/// {@category Cards}

import 'package:flutter/material.dart';
import 'package:flutstrap/flutstrap.dart';

class CardsScreen extends StatefulWidget {
  const CardsScreen({super.key});

  /// Route name for navigation
  static const String routeName = '/cards';

  @override
  State<CardsScreen> createState() => _CardsScreenState();
}

class _CardsScreenState extends State<CardsScreen> {
  // ✅ STATE FOR INTERACTIVE EXAMPLES
  int _cardTapCount = 0;
  bool _showDividers = true;

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
        title: const Text('Card Components'),
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

            // ✅ CARD VARIANTS
            _buildCardVariantsSection(context),
            const SizedBox(height: _sectionSpacing),

            // ✅ SIMPLE CARDS
            _buildSimpleCardsSection(context),
            const SizedBox(height: _sectionSpacing),

            // ✅ IMAGE CARDS
            _buildImageCardsSection(context),
            const SizedBox(height: _sectionSpacing),

            // ✅ ACTION CARDS
            _buildActionCardsSection(context),
            const SizedBox(height: _sectionSpacing),

            // ✅ INTERACTIVE CARDS
            _buildInteractiveCardsSection(context),
            const SizedBox(height: _sectionSpacing),

            // ✅ ADVANCED FEATURES
            _buildAdvancedFeaturesSection(context),
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
            'Flutstrap Cards',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: _itemSpacing),
          Text(
            'Flexible card components with multiple variants, layouts, and '
            'performance optimizations. Cards support headers, bodies, footers, '
            'images, actions, and interactive behaviors.',
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

  /// Build card variants section
  Widget _buildCardVariantsSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Card Variants',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Different visual styles for cards',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: _itemSpacing),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _buildCardVariantExample(
                context,
                'Elevated',
                'Default card with shadow',
                FSCardVariant.elevated,
              ),
              _buildCardVariantExample(
                context,
                'Outlined',
                'Card with border',
                FSCardVariant.outlined,
              ),
              _buildCardVariantExample(
                context,
                'Filled',
                'Card with background fill',
                FSCardVariant.filled,
              ),
              _buildCardVariantExample(
                context,
                'Surface',
                'Uses surface color',
                FSCardVariant.surface,
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Build simple cards section
  Widget _buildSimpleCardsSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Simple Cards',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Basic cards with header, body, and footer content',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: _itemSpacing),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              // Basic card
              FlutstrapCard(
                headerText: 'Basic Card',
                bodyText: 'This is a simple card with header and body text. '
                    'It demonstrates the default card styling.',
                variant: FSCardVariant.elevated,
              ),

              // Card with footer
              FlutstrapCard(
                headerText: 'Card with Footer',
                bodyText:
                    'This card includes footer content below the main body.',
                footerText: 'Footer information',
                variant: FSCardVariant.outlined,
              ),

              // Using factory method
              FlutstrapCard.simple(
                title: 'Factory Card',
                content: 'Created using FlutstrapCard.simple() factory method '
                    'for common patterns.',
                footer: 'Factory methods are cached for performance',
                variant: FSCardVariant.filled,
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Build image cards section
  Widget _buildImageCardsSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Image Cards',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Cards with image headers and various content layouts',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: _itemSpacing),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              // Image card with factory
              FlutstrapCard.image(
                image: Container(
                  height: 120,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.blue.shade400,
                        Colors.purple.shade400,
                      ],
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.photo,
                      color: Colors.white,
                      size: 48,
                    ),
                  ),
                ),
                title: 'Beautiful Landscape',
                content: 'This card features a gradient image header with '
                    'overlaid title and description content.',
                variant: FSCardVariant.elevated,
              ),

              // Custom image card
              FlutstrapCard(
                header: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(8),
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.nature,
                          color: Colors.green,
                          size: 48,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'Nature Card',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ],
                ),
                bodyText: 'Custom header with nature theme and icon.',
                variant: FSCardVariant.outlined,
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Build action cards section
  Widget _buildActionCardsSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Action Cards',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Cards with action buttons in the footer',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: _itemSpacing),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              // Using factory method
              FlutstrapCard.action(
                title: 'Action Card',
                content: 'This card includes action buttons in the footer '
                    'for user interactions.',
                actions: [
                  FlutstrapButton(
                    onPressed: () => _showSnackbar('Primary action'),
                    text: 'Action',
                    variant: FSButtonVariant.primary,
                    size: FSButtonSize.sm,
                  ),
                  const SizedBox(width: 8),
                  FlutstrapButton(
                    onPressed: () => _showSnackbar('Secondary action'),
                    text: 'Cancel',
                    variant: FSButtonVariant.outlineSecondary,
                    size: FSButtonSize.sm,
                  ),
                ],
                variant: FSCardVariant.elevated,
              ),

              // Manual action card
              FlutstrapCard(
                headerText: 'Manual Action Card',
                bodyText: 'This card manually defines footer actions '
                    'using the footer parameter.',
                footer: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Custom Footer',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withOpacity(0.6),
                            ),
                      ),
                      FlutstrapButton(
                        onPressed: () => _showSnackbar('Custom action'),
                        text: 'Learn More',
                        variant: FSButtonVariant.link,
                        size: FSButtonSize.sm,
                      ),
                    ],
                  ),
                ),
                variant: FSCardVariant.filled,
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Build interactive cards section
  Widget _buildInteractiveCardsSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Interactive Cards',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Clickable cards with tap handlers and visual feedback',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: _itemSpacing),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              // Using factory method
              FlutstrapCard.interactive(
                title: 'Interactive Card',
                content: 'Tap this card to trigger an action. '
                    'Notice the visual feedback and cursor change.',
                onTap: () => _handleCardTap('Factory interactive card'),
                trailing: const Icon(Icons.chevron_right),
                variant: FSCardVariant.elevated,
              ),

              // Manual interactive card
              FlutstrapCard(
                headerText: 'Manual Interactive',
                bodyText: 'This card uses the onTap parameter directly '
                    'for click handling.',
                footerText: 'Tap anywhere on the card',
                onTap: () => _handleCardTap('Manual interactive card'),
                interactive: true,
                variant: FSCardVariant.outlined,
              ),

              // Card with long press
              FlutstrapCard(
                headerText: 'Long Press Card',
                bodyText: 'This card supports both tap and long press actions.',
                onTap: () => _handleCardTap('Card tapped'),
                onLongPress: () => _showSnackbar('Card long pressed!'),
                interactive: true,
                variant: FSCardVariant.filled,
              ),
            ],
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
            'Custom padding, dividers, and other advanced card features',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: _itemSpacing),
          Column(
            children: [
              // Custom padding
              FlutstrapCard(
                headerText: 'Custom Padding',
                bodyText: 'This card uses custom padding values for '
                    'more control over spacing.',
                footerText: 'Footer with custom padding',
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
                variant: FSCardVariant.elevated,
              ),
              const SizedBox(height: 16),

              // Without dividers
              FlutstrapCard(
                headerText: 'No Dividers',
                bodyText: 'This card hides the dividers between sections '
                    'for a cleaner look.',
                footerText: 'Sections flow together seamlessly',
                showDividers: false,
                variant: FSCardVariant.outlined,
              ),
              const SizedBox(height: 16),

              // Interactive demo card
              Card(
                child: Padding(
                  padding: _cardPadding,
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
                        'Cards tapped: $_cardTapCount times',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 16),
                      FlutstrapCard.interactive(
                        title: 'Demo Card',
                        content: 'Tap this card to increment the counter '
                            'and see Flutstrap cards in action!',
                        onTap: _incrementCardTapCount,
                        trailing: const Icon(Icons.touch_app),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          FlutstrapButton(
                            onPressed: _toggleDividers,
                            text: _showDividers
                                ? 'Hide Dividers'
                                : 'Show Dividers',
                            variant: FSButtonVariant.outlinePrimary,
                            size: FSButtonSize.sm,
                          ),
                          const SizedBox(width: 8),
                          FlutstrapButton(
                            onPressed: _resetCardCounter,
                            text: 'Reset Counter',
                            variant: FSButtonVariant.outlineDanger,
                            size: FSButtonSize.sm,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ✅ HELPER METHODS

  /// Build card variant example
  Widget _buildCardVariantExample(
    BuildContext context,
    String title,
    String description,
    FSCardVariant variant,
  ) {
    return SizedBox(
      width: 280,
      child: FlutstrapCard(
        headerText: title,
        bodyText: description,
        footerText: 'Variant: ${variant.name}',
        variant: variant,
      ),
    );
  }

  // ✅ INTERACTION HANDLERS

  void _handleCardTap(String message) {
    _showSnackbar(message);
  }

  void _incrementCardTapCount() {
    setState(() {
      _cardTapCount++;
    });
    _showSnackbar('Card tapped! Total: $_cardTapCount');
  }

  void _toggleDividers() {
    setState(() {
      _showDividers = !_showDividers;
    });
    _showSnackbar(_showDividers ? 'Dividers shown' : 'Dividers hidden');
  }

  void _resetCardCounter() {
    setState(() {
      _cardTapCount = 0;
    });
    _showSnackbar('Counter reset!');
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
