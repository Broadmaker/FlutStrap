/// Flutstrap Typography & Icons Demo Screen
///
/// Comprehensive demonstration of Flutstrap typography system and iconography including:
/// - 📝 Complete typography scale (display, headline, title, body, label)
/// - 🎨 Interactive typography customization
/// - ⚡ Text scaling and accessibility features
/// - 🔠 Font weight and style demonstrations
/// - 🎯 Material icons showcase with categories
/// - 📱 Responsive typography behavior
///
/// Features:
/// - Live interactive typography demonstrations
/// - Real-time text scaling preview
/// - Comprehensive icon library browser
/// - Accessibility testing tools
///
/// {@category Demo}
/// {@category Screens}
/// {@category Typography}

import 'package:flutter/material.dart';
import 'package:flutstrap/flutstrap.dart';

class TypographyScreen extends StatefulWidget {
  const TypographyScreen({super.key});

  /// Route name for navigation
  static const String routeName = '/typography';

  @override
  State<TypographyScreen> createState() => _TypographyScreenState();
}

class _TypographyScreenState extends State<TypographyScreen> {
  // ✅ STATE FOR INTERACTIVE FEATURES
  double _textScaleFactor = 1.0;
  bool _showFontMetrics = false;
  String _customText = 'The quick brown fox jumps over the lazy dog';
  Color _selectedColor = Colors.black;
  double _customLetterSpacing = 0.0;
  double _customWordSpacing = 0.0;
  double _customLineHeight = 1.0;

  // ✅ ICON CATEGORIES
  final List<IconCategory> _iconCategories = [
    IconCategory(
      name: 'Actions',
      icons: [
        Icons.home,
        Icons.search,
        Icons.settings,
        Icons.favorite,
        Icons.share,
        Icons.download,
        Icons.upload,
        Icons.print,
        Icons.refresh,
        Icons.menu,
      ],
    ),
    IconCategory(
      name: 'Communication',
      icons: [
        Icons.email,
        Icons.phone,
        Icons.chat,
        Icons.message,
        Icons.notifications,
        Icons.contact_mail,
        Icons.contact_phone,
        Icons.video_call,
        Icons.call,
        Icons.ring_volume,
      ],
    ),
    IconCategory(
      name: 'Content',
      icons: [
        Icons.add,
        Icons.create,
        Icons.edit,
        Icons.delete,
        Icons.copy,
        Icons.cut,
        Icons.paste,
        Icons.save,
        Icons.archive,
        Icons.unarchive,
      ],
    ),
    IconCategory(
      name: 'Navigation',
      icons: [
        Icons.arrow_back,
        Icons.arrow_forward,
        Icons.arrow_upward,
        Icons.arrow_downward,
        Icons.expand_more,
        Icons.expand_less,
        Icons.chevron_left,
        Icons.chevron_right,
        Icons.more_vert,
        Icons.more_horiz,
      ],
    ),
    IconCategory(
      name: 'Toggle',
      icons: [
        Icons.check_box,
        Icons.radio_button_checked,
        Icons.toggle_on,
        Icons.star,
        Icons.star_border,
        Icons.favorite_border,
        Icons.bookmark,
        Icons.bookmark_border,
        Icons.visibility,
        Icons.visibility_off,
      ],
    ),
    IconCategory(
      name: 'File & Devices',
      icons: [
        Icons.folder,
        Icons.folder_open,
        Icons.insert_drive_file,
        Icons.cloud,
        Icons.cloud_download,
        Icons.cloud_upload,
        Icons.computer,
        Icons.phone_iphone,
        Icons.tablet,
        Icons.watch,
      ],
    ),
    IconCategory(
      name: 'Media',
      icons: [
        Icons.play_arrow,
        Icons.pause,
        Icons.stop,
        Icons.skip_next,
        Icons.skip_previous,
        Icons.volume_up,
        Icons.volume_off,
        Icons.mic,
        Icons.headset,
        Icons.camera_alt,
      ],
    ),
  ];

  // ✅ CONSTANTS
  static const EdgeInsets _screenPadding = EdgeInsets.all(16.0);
  static const EdgeInsets _sectionPadding = EdgeInsets.only(bottom: 32.0);
  static const EdgeInsets _demoPadding = EdgeInsets.all(16.0);
  static const double _sectionSpacing = 24.0;

  @override
  Widget build(BuildContext context) {
    final theme = FSTheme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Typography & Icons'),
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

            // ✅ TYPOGRAPHY SYSTEM
            _buildTypographySystemSection(theme),
            const SizedBox(height: _sectionSpacing),

            // ✅ INTERACTIVE TYPOGRAPHY
            _buildInteractiveTypographySection(theme),
            const SizedBox(height: _sectionSpacing),

            // ✅ TEXT SCALING & ACCESSIBILITY
            _buildTextScalingSection(theme),
            const SizedBox(height: _sectionSpacing),

            // ✅ ICONS SHOWCASE
            _buildIconsShowcaseSection(),
            const SizedBox(height: _sectionSpacing),

            // ✅ ICON USAGE PATTERNS
            _buildIconUsageSection(theme),
            const SizedBox(height: _sectionSpacing),
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
            'Flutstrap Typography & Icons',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            'Comprehensive typography system and iconography with Bootstrap-inspired styling. '
            'Features responsive text scaling, accessibility support, and a complete Material Design icon library.',
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

  /// Build typography system section
  Widget _buildTypographySystemSection(FSThemeData theme) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Typography System',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Complete typography scale with semantic text styles',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: 16),
          Column(
            children: [
              _buildTypographyCategoryCard(
                'Display Styles',
                'Large display text for hero sections and marketing',
                [
                  _buildTypographyExample(
                      'Display Large', theme.typography.displayLarge),
                  _buildTypographyExample(
                      'Display Medium', theme.typography.displayMedium),
                  _buildTypographyExample(
                      'Display Small', theme.typography.displaySmall),
                ],
              ),
              const SizedBox(height: 16),
              _buildTypographyCategoryCard(
                'Headline Styles',
                'Section headings and prominent text elements',
                [
                  _buildTypographyExample(
                      'Headline Large', theme.typography.headlineLarge),
                  _buildTypographyExample(
                      'Headline Medium', theme.typography.headlineMedium),
                  _buildTypographyExample(
                      'Headline Small', theme.typography.headlineSmall),
                ],
              ),
              const SizedBox(height: 16),
              _buildTypographyCategoryCard(
                'Title Styles',
                'Titles, card headers, and prominent labels',
                [
                  _buildTypographyExample(
                      'Title Large', theme.typography.titleLarge),
                  _buildTypographyExample(
                      'Title Medium', theme.typography.titleMedium),
                  _buildTypographyExample(
                      'Title Small', theme.typography.titleSmall),
                ],
              ),
              const SizedBox(height: 16),
              _buildTypographyCategoryCard(
                'Body Styles',
                'Main content, paragraphs, and general text',
                [
                  _buildTypographyExample(
                      'Body Large', theme.typography.bodyLarge),
                  _buildTypographyExample(
                      'Body Medium', theme.typography.bodyMedium),
                  _buildTypographyExample(
                      'Body Small', theme.typography.bodySmall),
                ],
              ),
              const SizedBox(height: 16),
              _buildTypographyCategoryCard(
                'Label Styles',
                'Labels, captions, helper text, and metadata',
                [
                  _buildTypographyExample(
                      'Label Large', theme.typography.labelLarge),
                  _buildTypographyExample(
                      'Label Medium', theme.typography.labelMedium),
                  _buildTypographyExample(
                      'Label Small', theme.typography.labelSmall),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Build interactive typography section
  Widget _buildInteractiveTypographySection(FSThemeData theme) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Interactive Typography',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Customize and test typography in real-time',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: _demoPadding,
              child: Column(
                children: [
                  // Custom text input
                  TextField(
                    controller: TextEditingController(text: _customText),
                    decoration: const InputDecoration(
                      labelText: 'Custom Text',
                      border: OutlineInputBorder(),
                      helperText: 'Enter text to preview with different styles',
                    ),
                    onChanged: (value) => setState(() => _customText = value),
                    maxLines: 2,
                  ),

                  const SizedBox(height: 16),

                  // Custom style controls
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Style Controls:',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 8),

                      // Color selection
                      Wrap(
                        spacing: 8,
                        children: [
                          _buildColorOption('Black', Colors.black),
                          _buildColorOption(
                              'Primary', Theme.of(context).colorScheme.primary),
                          _buildColorOption(
                              'Error', Theme.of(context).colorScheme.error),
                          _buildColorOption('Success', Colors.green),
                          _buildColorOption('Warning', Colors.orange),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Spacing controls
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'Letter Spacing: ${_customLetterSpacing.toStringAsFixed(1)}'),
                          Slider(
                            value: _customLetterSpacing,
                            min: -2.0,
                            max: 10.0,
                            divisions: 24,
                            onChanged: (value) =>
                                setState(() => _customLetterSpacing = value),
                          ),
                          const SizedBox(height: 8),
                          Text(
                              'Word Spacing: ${_customWordSpacing.toStringAsFixed(1)}'),
                          Slider(
                            value: _customWordSpacing,
                            min: 0.0,
                            max: 20.0,
                            divisions: 20,
                            onChanged: (value) =>
                                setState(() => _customWordSpacing = value),
                          ),
                          const SizedBox(height: 8),
                          Text(
                              'Line Height: ${_customLineHeight.toStringAsFixed(2)}'),
                          Slider(
                            value: _customLineHeight,
                            min: 0.8,
                            max: 2.5,
                            divisions: 17,
                            onChanged: (value) =>
                                setState(() => _customLineHeight = value),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Live preview
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Live Preview:',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _customText,
                          style: theme.typography.bodyMedium.copyWith(
                            //deleted the ?
                            color: _selectedColor,
                            letterSpacing: _customLetterSpacing,
                            wordSpacing: _customWordSpacing,
                            height: _customLineHeight,
                          ),
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

  /// Build text scaling section
  Widget _buildTextScalingSection(FSThemeData theme) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Text Scaling & Accessibility',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Accessibility features and responsive text scaling',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: _demoPadding,
              child: Column(
                children: [
                  // Text scale factor control
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Text Scale Factor: ${_textScaleFactor.toStringAsFixed(2)}x'),
                      Slider(
                        value: _textScaleFactor,
                        min: 0.5,
                        max: 3.0,
                        divisions: 10,
                        label: '${_textScaleFactor.toStringAsFixed(2)}x',
                        onChanged: (value) =>
                            setState(() => _textScaleFactor = value),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('0.5x', style: TextStyle(fontSize: 12)),
                          Text('1.0x', style: TextStyle(fontSize: 12)),
                          Text('2.0x', style: TextStyle(fontSize: 12)),
                          Text('3.0x', style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Scaling examples
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildScaledTextExample('Small Text',
                          theme.typography.bodySmall, _textScaleFactor),
                      const SizedBox(height: 12),
                      _buildScaledTextExample('Medium Text',
                          theme.typography.bodyMedium, _textScaleFactor),
                      const SizedBox(height: 12),
                      _buildScaledTextExample('Large Text',
                          theme.typography.bodyLarge, _textScaleFactor),
                      const SizedBox(height: 12),
                      _buildScaledTextExample('Title Text',
                          theme.typography.titleMedium, _textScaleFactor),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Font metrics toggle
                  Row(
                    children: [
                      Switch(
                        value: _showFontMetrics,
                        onChanged: (value) =>
                            setState(() => _showFontMetrics = value),
                      ),
                      const SizedBox(width: 8),
                      const Text('Show Font Metrics'),
                    ],
                  ),

                  if (_showFontMetrics) ...[
                    const SizedBox(height: 16),
                    _buildFontMetricsInfo(theme),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build icons showcase section
  Widget _buildIconsShowcaseSection() {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Material Icons Library',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Comprehensive Material Design icon collection',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: 16),
          Column(
            children: _iconCategories.map((category) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _buildIconCategoryCard(category),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  /// Build icon usage section
  Widget _buildIconUsageSection(FSThemeData theme) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Icon Usage Patterns',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Common icon implementation patterns and best practices',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: 16),
          Column(
            children: [
              _buildIconUsageCard(
                'Icons with Text',
                'Common icon and text combinations for navigation and actions',
                Column(
                  children: [
                    _buildIconTextExample(Icons.home, 'Home', theme),
                    _buildIconTextExample(Icons.settings, 'Settings', theme),
                    _buildIconTextExample(Icons.favorite, 'Favorites', theme),
                    _buildIconTextExample(Icons.share, 'Share', theme),
                    _buildIconTextExample(Icons.download, 'Download', theme),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _buildIconUsageCard(
                'Icon Buttons',
                'Interactive icon buttons with different styles and states',
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_border),
                      tooltip: 'Like',
                    ),
                    IconButton.filled(
                      onPressed: () {},
                      icon: const Icon(Icons.share),
                      tooltip: 'Share',
                    ),
                    IconButton.filledTonal(
                      onPressed: () {},
                      icon: const Icon(Icons.download),
                      tooltip: 'Download',
                    ),
                    IconButton.outlined(
                      onPressed: () {},
                      icon: const Icon(Icons.print),
                      tooltip: 'Print',
                    ),
                    FloatingActionButton.small(
                      onPressed: () {},
                      child: const Icon(Icons.add),
                      tooltip: 'Add',
                    ),
                    FloatingActionButton(
                      onPressed: () {},
                      child: const Icon(Icons.edit),
                      tooltip: 'Edit',
                    ),
                    FloatingActionButton.extended(
                      onPressed: () {},
                      icon: const Icon(Icons.create),
                      label: const Text('Create'),
                      tooltip: 'Create New',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _buildIconUsageCard(
                'Colored Icons',
                'Icons with semantic colors for different states and meanings',
                Wrap(
                  spacing: 20,
                  runSpacing: 16,
                  children: [
                    _buildColoredIconExample(
                        Icons.star, Colors.amber, 'Favorite'),
                    _buildColoredIconExample(
                        Icons.favorite, Colors.red, 'Like'),
                    _buildColoredIconExample(
                        Icons.thumb_up, Colors.blue, 'Approved'),
                    _buildColoredIconExample(
                        Icons.check_circle, Colors.green, 'Completed'),
                    _buildColoredIconExample(
                        Icons.error, Colors.orange, 'Error'),
                    _buildColoredIconExample(
                        Icons.warning, Colors.yellow[700]!, 'Warning'),
                    _buildColoredIconExample(
                        Icons.info, Colors.blue[300]!, 'Info'),
                    _buildColoredIconExample(
                        Icons.lightbulb, Colors.yellow[600]!, 'Idea'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ✅ HELPER METHODS

  /// Build typography category card
  Widget _buildTypographyCategoryCard(
      String title, String description, List<Widget> examples) {
    return Card(
      child: Padding(
        padding: _demoPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            ...examples,
          ],
        ),
      ),
    );
  }

  /// Build typography example
  Widget _buildTypographyExample(String label, TextStyle style) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'The quick brown fox jumps over the lazy dog',
            style: style,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            '${style.fontFamily ?? 'System'} • ${style.fontSize}px • ${_getFontWeightName(style.fontWeight)}',
            style: const TextStyle(
              fontSize: 10,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  /// Build scaled text example
  Widget _buildScaledTextExample(
      String label, TextStyle baseStyle, double scale) {
    final scaledStyle = baseStyle.copyWith(
      fontSize: (baseStyle.fontSize ?? 14) * scale,
    );

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Scaled text (${scale.toStringAsFixed(2)}x) - ${scaledStyle.fontSize?.toStringAsFixed(1)}px',
            style: scaledStyle,
          ),
        ],
      ),
    );
  }

  /// Build font metrics info
  Widget _buildFontMetricsInfo(FSThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.blue[100]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Font Metrics:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '• Line Height: Adjusts text density and readability\n'
            '• Letter Spacing: Controls character spacing\n'
            '• Word Spacing: Adjusts space between words\n'
            '• Text Scale: Supports accessibility preferences',
            style: theme.typography.bodySmall
                .copyWith(color: Colors.blue[800]), //deleted the ?
          ),
        ],
      ),
    );
  }

  /// Build icon category card
  Widget _buildIconCategoryCard(IconCategory category) {
    return Card(
      child: Padding(
        padding: _demoPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              category.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: category.icons.map((icon) {
                return _buildIconItem(icon);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  /// Build icon item
  Widget _buildIconItem(IconData icon) {
    return Tooltip(
      message: icon.toString().split('.').last,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 24),
          ),
          const SizedBox(height: 4),
          Text(
            _getShortIconName(icon),
            style: const TextStyle(fontSize: 10),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  /// Build icon usage card
  Widget _buildIconUsageCard(String title, String description, Widget content) {
    return Card(
      child: Padding(
        padding: _demoPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            content,
          ],
        ),
      ),
    );
  }

  /// Build icon text example
  Widget _buildIconTextExample(IconData icon, String text, FSThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: theme.colors.primary),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: theme.typography.bodyMedium)),
          FlutstrapBadge(
            text: 'Tap',
            variant: FSBadgeVariant.primary,
            size: FSBadgeSize.sm,
          ),
        ],
      ),
    );
  }

  /// Build colored icon example
  Widget _buildColoredIconExample(IconData icon, Color color, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Icon(icon, size: 32, color: color),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
        Text(
          'RGB: ${color.red}, ${color.green}, ${color.blue}',
          style: const TextStyle(fontSize: 10, color: Colors.grey),
        ),
      ],
    );
  }

  /// Build color option
  Widget _buildColorOption(String label, Color color) {
    return ChoiceChip(
      label: Text(label),
      selected: _selectedColor == color,
      onSelected: (selected) => setState(() => _selectedColor = color),
      selectedColor: color,
      labelStyle: TextStyle(
        color: _selectedColor == color ? Colors.white : null,
      ),
    );
  }

  /// Get font weight name
  String _getFontWeightName(FontWeight? fontWeight) {
    if (fontWeight == null) return 'Regular';

    switch (fontWeight) {
      case FontWeight.w100:
        return 'Thin';
      case FontWeight.w200:
        return 'ExtraLight';
      case FontWeight.w300:
        return 'Light';
      case FontWeight.w400:
        return 'Regular';
      case FontWeight.w500:
        return 'Medium';
      case FontWeight.w600:
        return 'SemiBold';
      case FontWeight.w700:
        return 'Bold';
      case FontWeight.w800:
        return 'ExtraBold';
      case FontWeight.w900:
        return 'Black';
      default:
        return 'Regular';
    }
  }

  /// Get short icon name
  String _getShortIconName(IconData icon) {
    final fullName = icon.toString().split('.').last;
    // Convert camelCase to space separated
    final readableName = fullName
        .replaceAllMapped(
          RegExp(r'([A-Z])'),
          (match) => ' ${match.group(1)}',
        )
        .trim();

    // Take first 2 words max
    final words = readableName.split(' ');
    return words.length > 2 ? '${words[0]} ${words[1]}' : readableName;
  }
}

class IconCategory {
  final String name;
  final List<IconData> icons;

  const IconCategory({required this.name, required this.icons});
}
