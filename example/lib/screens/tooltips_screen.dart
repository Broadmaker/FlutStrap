import 'package:flutter/material.dart';
import 'package:master_flutstrap/flutstrap.dart';

class TooltipsScreen extends StatefulWidget {
  const TooltipsScreen({super.key});

  @override
  State<TooltipsScreen> createState() => _TooltipsScreenState();
}

class _TooltipsScreenState extends State<TooltipsScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fsTheme = FSTheme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tooltips'),
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
            _buildSectionTitle(context, 'Basic Tooltips'),
            _buildBasicTooltipsSection(context),
            const SizedBox(height: 32),
            _buildSectionTitle(context, 'Tooltip Variants'),
            _buildVariantTooltipsSection(context),
            const SizedBox(height: 32),
            _buildSectionTitle(context, 'Tooltip Placement'),
            _buildPlacementTooltipsSection(context),
            const SizedBox(height: 32),
            _buildSectionTitle(context, 'Advanced Features'),
            _buildAdvancedFeaturesSection(context),
            const SizedBox(height: 32),
            _buildSectionTitle(context, 'Real-world Examples'),
            _buildRealWorldExamplesSection(context, fsTheme),
            const SizedBox(height: 32),
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

  Widget _buildBasicTooltipsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Hover over or tap on the elements below to see tooltips:',
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            FlutstrapTooltip(
              message: 'This is a basic tooltip',
              child: FlutstrapButton(
                onPressed: () {},
                text: 'Hover Me',
                size: FSButtonSize.sm,
              ),
            ),
            FlutstrapTooltip(
              message: 'Tooltip with primary variant',
              variant: FSTooltipVariant.primary,
              child: FlutstrapButton(
                onPressed: () {},
                text: 'Primary Tip',
                variant: FSButtonVariant.primary,
                size: FSButtonSize.sm,
              ),
            ),
            FlutstrapTooltip(
              message: 'Tooltip on an icon',
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.info, size: 24),
              ),
            ),
            FlutstrapTooltip(
              message: 'Tooltip on text',
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'Hover this text',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildVariantTooltipsSection(BuildContext context) {
    final variants = FSTooltipVariant.values;

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: variants.map((variant) {
        return FlutstrapTooltip(
          message: '${_getVariantName(variant)} tooltip variant',
          variant: variant,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: _getVariantColor(context, variant),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              _getVariantName(variant),
              style: TextStyle(
                color: _getVariantTextColor(variant),
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPlacementTooltipsSection(BuildContext context) {
    final placements = [
      FSTooltipPlacement.top,
      FSTooltipPlacement.right,
      FSTooltipPlacement.bottom,
      FSTooltipPlacement.left,
      FSTooltipPlacement.topStart,
      FSTooltipPlacement.topEnd,
      FSTooltipPlacement.bottomStart,
      FSTooltipPlacement.bottomEnd,
    ];

    return Column(
      children: [
        const Text(
          'Try hovering over the buttons to see different tooltip placements:',
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 20),
        // Top placements
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildPlacementButton(
                context, FSTooltipPlacement.topStart, 'Top Start'),
            _buildPlacementButton(context, FSTooltipPlacement.top, 'Top'),
            _buildPlacementButton(
                context, FSTooltipPlacement.topEnd, 'Top End'),
          ],
        ),
        const SizedBox(height: 80),

        // Middle row with left and right
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildPlacementButton(context, FSTooltipPlacement.left, 'Left'),
            _buildPlacementButton(context, FSTooltipPlacement.right, 'Right'),
          ],
        ),
        const SizedBox(height: 80),

        // Bottom placements
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildPlacementButton(
                context, FSTooltipPlacement.bottomStart, 'Bottom Start'),
            _buildPlacementButton(context, FSTooltipPlacement.bottom, 'Bottom'),
            _buildPlacementButton(
                context, FSTooltipPlacement.bottomEnd, 'Bottom End'),
          ],
        ),
      ],
    );
  }

  Widget _buildPlacementButton(
      BuildContext context, FSTooltipPlacement placement, String label) {
    return FlutstrapTooltip(
      message: 'Tooltip placed $label',
      placement: placement,
      child: FlutstrapButton(
        onPressed: () {},
        text: label,
        size: FSButtonSize.sm,
        variant: FSButtonVariant.outlinePrimary,
      ),
    );
  }

  Widget _buildAdvancedFeaturesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Custom styling
        const Text(
          'Custom Styled Tooltip:',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        FlutstrapTooltip(
          message: 'This tooltip has custom styling',
          backgroundColor: Colors.purple,
          textStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          padding: const EdgeInsets.all(12),
          borderRadius: BorderRadius.circular(8),
          child: FlutstrapButton(
            onPressed: () {},
            text: 'Custom Style',
            variant: FSButtonVariant.outlinePrimary,
            size: FSButtonSize.sm,
          ),
        ),
        const SizedBox(height: 20),

        // Without arrow
        const Text(
          'Tooltip Without Arrow:',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        FlutstrapTooltip(
          message: 'This tooltip has no arrow',
          showArrow: false,
          child: FlutstrapButton(
            onPressed: () {},
            text: 'No Arrow',
            variant: FSButtonVariant.outlineSecondary,
            size: FSButtonSize.sm,
          ),
        ),
        const SizedBox(height: 20),

        // Long content
        const Text(
          'Tooltip with Long Content:',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        FlutstrapTooltip(
          message:
              'This is a longer tooltip message that demonstrates how the tooltip handles multi-line content and text wrapping within the maximum width constraints.',
          maxWidth: 250,
          child: FlutstrapButton(
            onPressed: () {},
            text: 'Long Content',
            variant: FSButtonVariant.outlineInfo,
            size: FSButtonSize.sm,
          ),
        ),
        const SizedBox(height: 20),

        // Different delays
        const Text(
          'Tooltip with Custom Delay:',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        FlutstrapTooltip(
          message: 'This tooltip appears after 500ms delay',
          showDelay: const Duration(milliseconds: 500),
          hideDelay: const Duration(milliseconds: 200),
          child: FlutstrapButton(
            onPressed: () {},
            text: 'Custom Delay',
            variant: FSButtonVariant.outlineWarning,
            size: FSButtonSize.sm,
          ),
        ),
      ],
    );
  }

  Widget _buildRealWorldExamplesSection(
      BuildContext context, FSThemeData fsTheme) {
    return Column(
      children: [
        // Icon buttons with tooltips
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Icon Buttons with Tooltips',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Common UI pattern for action buttons',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FlutstrapTooltip(
                      message: 'Edit item',
                      placement: FSTooltipPlacement.bottom,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.edit),
                        style: IconButton.styleFrom(
                          backgroundColor: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.1),
                        ),
                      ),
                    ),
                    FlutstrapTooltip(
                      message: 'Delete item',
                      placement: FSTooltipPlacement.bottom,
                      variant: FSTooltipVariant.danger,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.delete),
                        style: IconButton.styleFrom(
                          backgroundColor: Theme.of(context)
                              .colorScheme
                              .error
                              .withOpacity(0.1),
                        ),
                      ),
                    ),
                    FlutstrapTooltip(
                      message: 'Share content',
                      placement: FSTooltipPlacement.bottom,
                      variant: FSTooltipVariant.success,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.share),
                        style: IconButton.styleFrom(
                          backgroundColor: _getVariantColor(
                                  context, FSTooltipVariant.success)
                              .withOpacity(0.1),
                        ),
                      ),
                    ),
                    FlutstrapTooltip(
                      message: 'Download file',
                      placement: FSTooltipPlacement.bottom,
                      variant: FSTooltipVariant.info,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.download),
                        style: IconButton.styleFrom(
                          backgroundColor:
                              _getVariantColor(context, FSTooltipVariant.info)
                                  .withOpacity(0.1),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Form field hints
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Form Field Hints',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Tooltips for form field explanations',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Username',
                          suffixIcon: FlutstrapTooltip(
                            message:
                                'Your username must be 3-20 characters long and can contain letters, numbers, and underscores.',
                            placement: FSTooltipPlacement.right,
                            child: const Icon(Icons.help_outline, size: 18),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'API Key',
                          suffixIcon: FlutstrapTooltip(
                            message:
                                'Find your API key in the developer settings of your account dashboard.',
                            placement: FSTooltipPlacement.right,
                            variant: FSTooltipVariant.warning,
                            child: const Icon(Icons.info_outline, size: 18),
                          ),
                        ),
                        obscureText: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Feature explanations
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Feature Explanations',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Tooltips for explaining features or settings',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    FlutstrapTooltip(
                      message:
                          'Enable this to receive notifications for important updates',
                      placement: FSTooltipPlacement.bottom,
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.notifications, size: 16),
                          SizedBox(width: 8),
                          Text('Notifications'),
                        ],
                      ),
                    ),
                    FlutstrapTooltip(
                      message:
                          'Automatically sync your data across all your devices',
                      placement: FSTooltipPlacement.bottom,
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.sync, size: 16),
                          SizedBox(width: 8),
                          Text('Auto Sync'),
                        ],
                      ),
                    ),
                    FlutstrapTooltip(
                      message:
                          'Use dark theme for better battery life on OLED screens',
                      placement: FSTooltipPlacement.bottom,
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.dark_mode, size: 16),
                          SizedBox(width: 8),
                          Text('Dark Mode'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Color _getVariantColor(BuildContext context, FSTooltipVariant variant) {
    final colors = Theme.of(context).colorScheme;
    final fsTheme = FSTheme.of(context);

    switch (variant) {
      case FSTooltipVariant.primary:
        return colors.primary;
      case FSTooltipVariant.secondary:
        return colors.secondary;
      case FSTooltipVariant.success:
        return fsTheme.colors.success; // Use Flutstrap theme colors
      case FSTooltipVariant.danger:
        return colors.error;
      case FSTooltipVariant.warning:
        return fsTheme.colors.warning; // Use Flutstrap theme colors
      case FSTooltipVariant.info:
        return fsTheme.colors.info; // Use Flutstrap theme colors
      case FSTooltipVariant.light:
        return colors.surfaceVariant;
      case FSTooltipVariant.dark:
        return colors.onSurface;
    }
  }

  Color _getVariantTextColor(FSTooltipVariant variant) {
    switch (variant) {
      case FSTooltipVariant.light:
        return Colors.black87;
      case FSTooltipVariant.dark:
        return Colors.white;
      default:
        return Colors.white;
    }
  }

  String _getVariantName(FSTooltipVariant variant) {
    switch (variant) {
      case FSTooltipVariant.primary:
        return 'Primary';
      case FSTooltipVariant.secondary:
        return 'Secondary';
      case FSTooltipVariant.success:
        return 'Success';
      case FSTooltipVariant.danger:
        return 'Danger';
      case FSTooltipVariant.warning:
        return 'Warning';
      case FSTooltipVariant.info:
        return 'Info';
      case FSTooltipVariant.light:
        return 'Light';
      case FSTooltipVariant.dark:
        return 'Dark';
    }
  }
}
