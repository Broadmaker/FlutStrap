// theme_screen.dart
import 'package:flutter/material.dart';
import 'package:master_flutstrap/flutstrap.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({super.key});

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  bool _isDarkMode = false;
  Color _selectedColor = FlutstrapTheme.defaultPrimary;

  final Map<String, Color> _colorSchemes = {
    'Primary Blue': FlutstrapTheme.defaultPrimary,
    'Success Green': FlutstrapTheme.defaultSuccess,
    'Danger Red': FlutstrapTheme.defaultDanger,
    'Warning Yellow': FlutstrapTheme.defaultWarning,
    'Info Cyan': FlutstrapTheme.defaultInfo,
    'Purple': const Color(0xFF6F42C1),
    'Pink': const Color(0xFFD63384),
    'Orange': const Color(0xFFFD7E14),
    'Teal': const Color(0xFF20C997),
    'Indigo': const Color(0xFF6610F2),
  };

  void _updateTheme(Color color, bool isDark) {
    final newTheme = isDark
        ? FSThemeData.dark(seedColor: color)
        : FSThemeData.light(seedColor: color);

    _showThemePreview(newTheme, color, isDark);
  }

  void _showThemePreview(FSThemeData theme, Color color, bool isDark) {
    showDialog(
      context: context,
      builder: (context) => FSTheme(
        data: theme,
        child: Dialog(
          backgroundColor: theme.colors.background,
          child: Container(
            padding: const EdgeInsets.all(24),
            width: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Theme Preview',
                  style: theme.typography.headlineSmall.copyWith(
                    color: theme.colors.onBackground,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  '${isDark ? 'Dark' : 'Light'} Mode - ${_colorSchemes.entries.firstWhere((entry) => entry.value == color).key}',
                  style: theme.typography.bodyMedium.copyWith(
                    color: theme.colors.onBackground,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme.colors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Primary Color',
                    style: theme.typography.bodyMedium.copyWith(
                      color: theme.colors.onPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Close',
                        style: TextStyle(
                          color: theme.colors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = FSTheme.of(context);

    return FSTheme(
      data: theme,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Theme System'),
          backgroundColor: theme.colors.surface,
          foregroundColor: theme.colors.onSurface,
        ),
        backgroundColor: theme.colors.background,
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              // Theme Controls
              _buildSectionTitle('Theme Controls', theme),
              Card(
                color: theme.colors.surface,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Dark Mode',
                            style: theme.typography.bodyMedium.copyWith(
                              color: theme.colors.onSurface,
                            ),
                          ),
                          const Spacer(),
                          Switch(
                            value: _isDarkMode,
                            onChanged: (value) {
                              setState(() {
                                _isDarkMode = value;
                              });
                              _updateTheme(_selectedColor, value);
                            },
                            activeColor: theme.colors.primary,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Color Scheme',
                        style: theme.typography.bodyMedium.copyWith(
                          color: theme.colors.onSurface,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _colorSchemes.entries.map((entry) {
                          final isSelected = _selectedColor == entry.value;
                          return ChoiceChip(
                            label: Text(
                              entry.key,
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : theme.colors.onSurface,
                              ),
                            ),
                            selected: isSelected,
                            onSelected: (selected) {
                              setState(() {
                                _selectedColor = entry.value;
                              });
                              _updateTheme(entry.value, _isDarkMode);
                            },
                            backgroundColor: theme.colors.surface,
                            selectedColor: entry.value,
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Typography Section
              _buildSectionTitle('Typography', theme),
              Card(
                color: theme.colors.surface,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTypographyExample('Display Large',
                          theme.typography.displayLarge, theme),
                      _buildTypographyExample('Display Medium',
                          theme.typography.displayMedium, theme),
                      _buildTypographyExample('Display Small',
                          theme.typography.displaySmall, theme),
                      _buildTypographyExample('Headline Large',
                          theme.typography.headlineLarge, theme),
                      _buildTypographyExample('Headline Medium',
                          theme.typography.headlineMedium, theme),
                      _buildTypographyExample('Headline Small',
                          theme.typography.headlineSmall, theme),
                      _buildTypographyExample(
                          'Title Large', theme.typography.titleLarge, theme),
                      _buildTypographyExample(
                          'Title Medium', theme.typography.titleMedium, theme),
                      _buildTypographyExample(
                          'Title Small', theme.typography.titleSmall, theme),
                      _buildTypographyExample(
                          'Body Large', theme.typography.bodyLarge, theme),
                      _buildTypographyExample(
                          'Body Medium', theme.typography.bodyMedium, theme),
                      _buildTypographyExample(
                          'Body Small', theme.typography.bodySmall, theme),
                      _buildTypographyExample(
                          'Label Large', theme.typography.labelLarge, theme),
                      _buildTypographyExample(
                          'Label Medium', theme.typography.labelMedium, theme),
                      _buildTypographyExample(
                          'Label Small', theme.typography.labelSmall, theme),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Color Palette Section
              _buildSectionTitle('Color Palette', theme),
              Card(
                color: theme.colors.surface,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildColorSwatch('Primary', theme.colors.primary,
                          theme.colors.onPrimary),
                      _buildColorSwatch('Secondary', theme.colors.secondary,
                          theme.colors.onSecondary),
                      _buildColorSwatch(
                          'Success', theme.colors.success, Colors.white),
                      _buildColorSwatch(
                          'Danger', theme.colors.danger, Colors.white),
                      _buildColorSwatch(
                          'Warning', theme.colors.warning, Colors.black),
                      _buildColorSwatch(
                          'Info', theme.colors.info, Colors.white),
                      _buildColorSwatch('Background', theme.colors.background,
                          theme.colors.onBackground),
                      _buildColorSwatch('Surface', theme.colors.surface,
                          theme.colors.onSurface),
                      _buildColorSwatch(
                          'Light', theme.colors.light, Colors.black),
                      _buildColorSwatch(
                          'Dark', theme.colors.dark, Colors.white),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Design Tokens Section
              _buildSectionTitle('Design Tokens', theme),
              Card(
                color: theme.colors.surface,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Border Radius',
                        style: theme.typography.bodyMedium.copyWith(
                          color: theme.colors.onSurface,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          _buildBorderRadiusExample(
                              'SM', FlutstrapTheme.borderRadiusSm, theme),
                          const SizedBox(width: 16),
                          _buildBorderRadiusExample(
                              'MD', FlutstrapTheme.borderRadiusMd, theme),
                          const SizedBox(width: 16),
                          _buildBorderRadiusExample(
                              'LG', FlutstrapTheme.borderRadiusLg, theme),
                          const SizedBox(width: 16),
                          _buildBorderRadiusExample(
                              'XL', FlutstrapTheme.borderRadiusXl, theme),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Shadows',
                        style: theme.typography.bodyMedium.copyWith(
                          color: theme.colors.onSurface,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          _buildShadowExample(
                              'SM', FlutstrapTheme.shadowSm, theme),
                          const SizedBox(width: 16),
                          _buildShadowExample(
                              'MD', FlutstrapTheme.shadowMd, theme),
                          const SizedBox(width: 16),
                          _buildShadowExample(
                              'LG', FlutstrapTheme.shadowLg, theme),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Spacing',
                        style: theme.typography.bodyMedium.copyWith(
                          color: theme.colors.onSurface,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: [
                          _buildSpacingExample('XS', 4, theme),
                          _buildSpacingExample('SM', 8, theme),
                          _buildSpacingExample('MD', 16, theme),
                          _buildSpacingExample('LG', 24, theme),
                          _buildSpacingExample('XL', 32, theme),
                          _buildSpacingExample('2XL', 48, theme),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, FSThemeData theme) {
    return Text(
      title,
      style: theme.typography.headlineSmall.copyWith(
        color: theme.colors.onBackground,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildTypographyExample(
      String label, TextStyle style, FSThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.typography.bodySmall.copyWith(
              color: theme.colors.onSurface.withOpacity(0.7),
            ),
          ),
          Text(
            'The quick brown fox jumps over the lazy dog',
            style: style.copyWith(
              color: theme.colors.onBackground,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildColorSwatch(String name, Color color, Color textColor) {
    return Container(
      width: 100,
      height: 60,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Center(
        child: Text(
          name,
          style: TextStyle(
            color: textColor,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildBorderRadiusExample(
      String label, double radius, FSThemeData theme) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: theme.colors.primary.withOpacity(0.2),
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: theme.typography.bodySmall.copyWith(
            color: theme.colors.onSurface,
          ),
        ),
        Text(
          '${radius.toInt()}px',
          style: theme.typography.bodySmall.copyWith(
            color: theme.colors.onSurface.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildShadowExample(
      String label, List<BoxShadow> shadows, FSThemeData theme) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: theme.colors.surface,
            borderRadius: BorderRadius.circular(8),
            boxShadow: shadows,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: theme.typography.bodySmall.copyWith(
            color: theme.colors.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _buildSpacingExample(String label, double spacing, FSThemeData theme) {
    return Column(
      children: [
        Container(
          width: spacing,
          height: 20,
          color: theme.colors.primary.withOpacity(0.2),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: theme.typography.bodySmall.copyWith(
            color: theme.colors.onSurface,
          ),
        ),
        Text(
          '${spacing.toInt()}px',
          style: theme.typography.bodySmall.copyWith(
            color: theme.colors.onSurface.withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}
