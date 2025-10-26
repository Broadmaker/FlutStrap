// typography_screen.dart
import 'package:flutter/material.dart';
import 'package:master_flutstrap/flutstrap.dart';

class TypographyScreen extends StatefulWidget {
  const TypographyScreen({super.key});

  @override
  State<TypographyScreen> createState() => _TypographyScreenState();
}

class _TypographyScreenState extends State<TypographyScreen> {
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
  ];

  @override
  Widget build(BuildContext context) {
    final theme = FSTheme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Typography & Icons'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Typography Section
            _buildSectionTitle('Typography System'),
            const SizedBox(height: 16),
            _buildTypographyExamples(theme),

            const SizedBox(height: 32),

            // Text Scale Factor Demo
            _buildSectionTitle('Text Scaling'),
            const SizedBox(height: 16),
            _buildTextScalingExamples(theme),

            const SizedBox(height: 32),

            // Icons Section
            _buildSectionTitle('Material Icons'),
            const SizedBox(height: 16),
            _buildIconExamples(),

            const SizedBox(height: 32),

            // Icon Usage Patterns
            _buildSectionTitle('Icon Usage Patterns'),
            const SizedBox(height: 16),
            _buildIconUsageExamples(theme),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }

  Widget _buildTypographyExamples(FSThemeData theme) {
    return Column(
      children: [
        _buildExampleCard(
          'Display Styles',
          'Large display text for hero sections',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTypographyExample(
                  'Display Large', theme.typography.displayLarge),
              _buildTypographyExample(
                  'Display Medium', theme.typography.displayMedium),
              _buildTypographyExample(
                  'Display Small', theme.typography.displaySmall),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildExampleCard(
          'Headline Styles',
          'Section headings and prominent text',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTypographyExample(
                  'Headline Large', theme.typography.headlineLarge),
              _buildTypographyExample(
                  'Headline Medium', theme.typography.headlineMedium),
              _buildTypographyExample(
                  'Headline Small', theme.typography.headlineSmall),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildExampleCard(
          'Title Styles',
          'Titles and prominent labels',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTypographyExample(
                  'Title Large', theme.typography.titleLarge),
              _buildTypographyExample(
                  'Title Medium', theme.typography.titleMedium),
              _buildTypographyExample(
                  'Title Small', theme.typography.titleSmall),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildExampleCard(
          'Body Styles',
          'Main content and paragraph text',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTypographyExample('Body Large', theme.typography.bodyLarge),
              _buildTypographyExample(
                  'Body Medium', theme.typography.bodyMedium),
              _buildTypographyExample('Body Small', theme.typography.bodySmall),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildExampleCard(
          'Label Styles',
          'Labels, captions, and helper text',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTypographyExample(
                  'Label Large', theme.typography.labelLarge),
              _buildTypographyExample(
                  'Label Medium', theme.typography.labelMedium),
              _buildTypographyExample(
                  'Label Small', theme.typography.labelSmall),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTextScalingExamples(FSThemeData theme) {
    return Column(
      children: [
        _buildExampleCard(
          'Accessibility Scaling',
          'Text scales with system accessibility settings',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildScaledTextExample(
                  'Body Medium - Normal', theme.typography.bodyMedium, 1.0),
              _buildScaledTextExample(
                  'Body Medium - Large', theme.typography.bodyMedium, 1.25),
              _buildScaledTextExample(
                  'Body Medium - Larger', theme.typography.bodyMedium, 1.5),
              _buildScaledTextExample(
                  'Body Medium - Largest', theme.typography.bodyMedium, 2.0),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildExampleCard(
          'Responsive Typography',
          'Text size adapts to screen size',
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'This text uses your theme\'s responsive typography system.',
                  style: theme.typography.bodyMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'On larger screens, display styles become more prominent.',
                  style: theme.typography.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIconExamples() {
    return Column(
      children: _iconCategories.map((category) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _buildExampleCard(
            category.name,
            'Common ${category.name.toLowerCase()} icons',
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: category.icons.map((icon) {
                return _buildIconItem(icon);
              }).toList(),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildIconUsageExamples(FSThemeData theme) {
    return Column(
      children: [
        _buildExampleCard(
          'Icons with Text',
          'Common icon and text combinations',
          Column(
            children: [
              _buildIconTextRow(Icons.home, 'Home', theme),
              _buildIconTextRow(Icons.settings, 'Settings', theme),
              _buildIconTextRow(Icons.favorite, 'Favorites', theme),
              _buildIconTextRow(Icons.share, 'Share', theme),
              _buildIconTextRow(Icons.download, 'Download', theme),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildExampleCard(
          'Icon Buttons',
          'Interactive icon buttons',
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite_border),
                tooltip: 'Like',
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.share),
                tooltip: 'Share',
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.download),
                tooltip: 'Download',
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.print),
                tooltip: 'Print',
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.refresh),
                tooltip: 'Refresh',
              ),
              FloatingActionButton(
                onPressed: () {},
                child: const Icon(Icons.add),
                tooltip: 'Add',
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildExampleCard(
          'Colored Icons',
          'Icons with different colors and states',
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _buildColoredIcon(Icons.star, Colors.amber),
              _buildColoredIcon(Icons.favorite, Colors.red),
              _buildColoredIcon(Icons.thumb_up, Colors.blue),
              _buildColoredIcon(Icons.check_circle, Colors.green),
              _buildColoredIcon(Icons.error, Colors.orange),
              _buildColoredIcon(Icons.warning, Colors.yellow[700]!),
              _buildColoredIcon(Icons.info, Colors.blue[300]!),
              _buildColoredIcon(Icons.lightbulb, Colors.yellow[600]!),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildExampleCard(String title, String description, Widget content) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
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
            'Font: ${style.fontFamily ?? 'System'} • Size: ${style.fontSize} • Weight: ${_getFontWeightName(style.fontWeight)}',
            style: const TextStyle(
              fontSize: 10,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScaledTextExample(
      String label, TextStyle baseStyle, double scale) {
    final scaledStyle =
        baseStyle.copyWith(fontSize: (baseStyle.fontSize ?? 14) * scale);

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
            'Scaled text example (${scale}x)',
            style: scaledStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildIconItem(IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 24),
        const SizedBox(height: 4),
        Text(
          icon.toString().split('.').last,
          style: const TextStyle(fontSize: 10),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildIconTextRow(IconData icon, String text, FSThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: theme.colors.primary),
          const SizedBox(width: 12),
          Text(text, style: theme.typography.bodyMedium),
        ],
      ),
    );
  }

  Widget _buildColoredIcon(IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, size: 32, color: color),
        const SizedBox(height: 4),
        Container(
          width: 40,
          height: 4,
          color: color,
        ),
      ],
    );
  }

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
}

class IconCategory {
  final String name;
  final List<IconData> icons;

  IconCategory({required this.name, required this.icons});
}
