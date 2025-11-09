/// Flutstrap Theme System Demo Screen
///
/// Demonstrates the comprehensive Flutstrap theming system including:
/// - 🎨 Color schemes (light/dark, seed-based)
/// - 📝 Typography scale and text styles
/// - 📏 Spacing system and design tokens
/// - 🌙 Theme mode switching
/// - 🔧 Custom theme customization
///
/// Features:
/// - Interactive theme preview with real-time updates
/// - Color palette visualization
/// - Typography scale demonstration
/// - Spacing system examples
/// - Component preview with correct APIs
///
/// {@category Demo}
/// {@category Screens}
/// {@category Theming}

import 'package:flutter/material.dart';
import 'package:flutstrap/flutstrap.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({super.key});

  /// Route name for navigation
  static const String routeName = '/theme';

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  // ✅ STATE MANAGEMENT - FIXED: Use Brightness instead of ThemeMode
  Brightness _currentBrightness = Brightness.light;
  Color _seedColor = const Color(0xFF0D6EFD); // ✅ FIXED: Default Flutstrap blue
  bool _useSeedColor = true;

  // ✅ CONSTANTS FOR PERFORMANCE
  static const EdgeInsets _screenPadding = EdgeInsets.all(16.0);
  static const EdgeInsets _sectionPadding = EdgeInsets.only(bottom: 32.0);
  static const EdgeInsets _cardPadding = EdgeInsets.all(16.0);
  static const double _sectionSpacing = 24.0;
  static const double _itemSpacing = 16.0;
  static const double _colorSwatchSize = 48.0;
  static const double _colorSwatchSpacing = 8.0;

  // ✅ PREDEFINED SEED COLORS
  static const List<Color> _seedColorOptions = [
    Color(0xFF0D6EFD), // Flutstrap Blue
    Color(0xFF6610F2), // Purple
    Color(0xFF6F42C1), // Indigo
    Color(0xFFD63384), // Pink
    Color(0xFFDC3545), // Red
    Color(0xFFFD7E14), // Orange
    Color(0xFFFFC107), // Yellow
    Color(0xFF198754), // Green
    Color(0xFF20C997), // Teal
    Color(0xFF0DCAF0), // Cyan
  ];

  @override
  Widget build(BuildContext context) {
    // ✅ FIXED: Use Theme widget to override theme for this screen only
    return Theme(
      data: _buildMaterialTheme(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Theme System'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          elevation: 0,
          actions: [
            // ✅ THEME MODE SWITCHER - FIXED: Use Brightness
            IconButton(
              icon: Icon(_currentBrightness == Brightness.dark
                  ? Icons.light_mode
                  : Icons.dark_mode),
              onPressed: _toggleThemeMode,
              tooltip: 'Toggle theme mode',
            ),
          ],
        ),
        body: Padding(
          padding: _screenPadding,
          child: ListView(
            children: [
              // ✅ THEME CONTROLS SECTION
              _buildThemeControlsSection(context),
              const SizedBox(height: _sectionSpacing),

              // ✅ COLOR SCHEME PREVIEW
              _buildColorSchemeSection(context),
              const SizedBox(height: _sectionSpacing),

              // ✅ TYPOGRAPHY SCALE
              _buildTypographySection(context),
              const SizedBox(height: _sectionSpacing),

              // ✅ SPACING SYSTEM
              _buildSpacingSection(context),
              const SizedBox(height: _sectionSpacing),

              // ✅ COMPONENT PREVIEW
              _buildComponentPreviewSection(context),
            ],
          ),
        ),
      ),
    );
  }

  /// ✅ FIXED: Build Material Theme that syncs with FSThemeData
  ThemeData _buildMaterialTheme() {
    final fsTheme = _buildCurrentTheme();

    return ThemeData(
      useMaterial3: true,
      brightness: fsTheme.brightness,
      colorScheme: ColorScheme(
        primary: fsTheme.colors.primary,
        secondary: fsTheme.colors.secondary,
        surface: fsTheme.colors.surface,
        background: fsTheme.colors.background,
        error: fsTheme.colors.danger,
        onPrimary: fsTheme.colors.onPrimary,
        onSecondary: fsTheme.colors.onSecondary,
        onSurface: fsTheme.colors.onSurface,
        onBackground: fsTheme.colors.onBackground,
        onError: fsTheme.colors.onPrimary,
        brightness: fsTheme.brightness,
      ),
      // Sync text theme with FS typography
      textTheme: TextTheme(
        displayLarge: fsTheme.typography.displayLarge,
        displayMedium: fsTheme.typography.displayMedium,
        displaySmall: fsTheme.typography.displaySmall,
        headlineLarge: fsTheme.typography.headlineLarge,
        headlineMedium: fsTheme.typography.headlineMedium,
        headlineSmall: fsTheme.typography.headlineSmall,
        titleLarge: fsTheme.typography.titleLarge,
        titleMedium: fsTheme.typography.titleMedium,
        titleSmall: fsTheme.typography.titleSmall,
        bodyLarge: fsTheme.typography.bodyLarge,
        bodyMedium: fsTheme.typography.bodyMedium,
        bodySmall: fsTheme.typography.bodySmall,
        labelLarge: fsTheme.typography.labelLarge,
        labelMedium: fsTheme.typography.labelMedium,
        labelSmall: fsTheme.typography.labelSmall,
      ),
    );
  }

  /// Build current theme based on user selections
  FSThemeData _buildCurrentTheme() {
    if (_useSeedColor) {
      return _currentBrightness == Brightness.light
          ? FSThemeData.light(seedColor: _seedColor)
          : FSThemeData.dark(seedColor: _seedColor);
    } else {
      return _currentBrightness == Brightness.light
          ? FSThemeData.light()
          : FSThemeData.dark();
    }
  }

  /// Toggle between light and dark theme modes
  void _toggleThemeMode() {
    setState(() {
      _currentBrightness = _currentBrightness == Brightness.light
          ? Brightness.dark
          : Brightness.light;
    });
  }

  /// Build theme controls section
  Widget _buildThemeControlsSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Theme Configuration',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: _itemSpacing),
          Card(
            child: Padding(
              padding: _cardPadding,
              child: Column(
                children: [
                  // ✅ THEME MODE SELECTOR - FIXED: Use Brightness
                  _buildThemeModeSelector(context),
                  const SizedBox(height: _itemSpacing),

                  // ✅ SEED COLOR TOGGLE
                  SwitchListTile(
                    title: const Text('Use Seed Color'),
                    subtitle: const Text('Generate colors from a base color'),
                    value: _useSeedColor,
                    onChanged: (value) {
                      setState(() => _useSeedColor = value);
                    },
                  ),

                  // ✅ SEED COLOR SELECTOR
                  if (_useSeedColor) ...[
                    const SizedBox(height: _itemSpacing),
                    _buildSeedColorSelector(context),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build theme mode selector - FIXED: Use Brightness
  Widget _buildThemeModeSelector(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Theme Mode:',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const Spacer(),
        ChoiceChip(
          label: const Text('Light'),
          selected: _currentBrightness == Brightness.light,
          onSelected: (selected) {
            if (selected) {
              setState(() => _currentBrightness = Brightness.light);
            }
          },
        ),
        const SizedBox(width: 8),
        ChoiceChip(
          label: const Text('Dark'),
          selected: _currentBrightness == Brightness.dark,
          onSelected: (selected) {
            if (selected) {
              setState(() => _currentBrightness = Brightness.dark);
            }
          },
        ),
      ],
    );
  }

  /// Build seed color selector
  Widget _buildSeedColorSelector(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Seed Color:',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: _colorSwatchSpacing,
          runSpacing: _colorSwatchSpacing,
          children: _seedColorOptions.map((color) {
            return GestureDetector(
              onTap: () => setState(() => _seedColor = color),
              child: Container(
                width: _colorSwatchSize,
                height: _colorSwatchSize,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: _seedColor == color
                        ? Theme.of(context).colorScheme.primary
                        : Colors.transparent,
                    width: 3,
                  ),
                ),
                child: _seedColor == color
                    ? const Icon(Icons.check, color: Colors.white)
                    : null,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  /// Build color scheme preview section
  Widget _buildColorSchemeSection(BuildContext context) {
    // ✅ FIXED: Use the current theme we're building, not from context
    final colors = _buildCurrentTheme().colors;

    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Color Scheme',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: _itemSpacing),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 2.5,
            children: [
              _buildColorCard('Primary', colors.primary, colors.onPrimary),
              _buildColorCard(
                  'Secondary', colors.secondary, colors.onSecondary),
              _buildColorCard('Success', colors.success, Colors.white),
              _buildColorCard('Danger', colors.danger, Colors.white),
              _buildColorCard('Warning', colors.warning, Colors.black),
              _buildColorCard('Info', colors.info, Colors.white),
              _buildColorCard(
                  'Background', colors.background, colors.onBackground),
              _buildColorCard('Surface', colors.surface, colors.onSurface),
            ],
          ),
        ],
      ),
    );
  }

  /// Build individual color card
  Widget _buildColorCard(String name, Color color, Color textColor) {
    return Card(
      elevation: 2,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              name,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}',
              style: TextStyle(
                color: textColor.withOpacity(0.8),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build typography scale section
  Widget _buildTypographySection(BuildContext context) {
    // ✅ FIXED: Use the current theme we're building
    final typography = _buildCurrentTheme().typography;

    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Typography Scale',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: _itemSpacing),
          Card(
            child: Padding(
              padding: _cardPadding,
              child: Column(
                children: [
                  _buildTypographyItem(
                      'Display Large', typography.displayLarge),
                  const Divider(),
                  _buildTypographyItem(
                      'Display Medium', typography.displayMedium),
                  const Divider(),
                  _buildTypographyItem(
                      'Display Small', typography.displaySmall),
                  const Divider(),
                  _buildTypographyItem(
                      'Headline Large', typography.headlineLarge),
                  const Divider(),
                  _buildTypographyItem(
                      'Headline Medium', typography.headlineMedium),
                  const Divider(),
                  _buildTypographyItem(
                      'Headline Small', typography.headlineSmall),
                  const Divider(),
                  _buildTypographyItem('Title Large', typography.titleLarge),
                  const Divider(),
                  _buildTypographyItem('Title Medium', typography.titleMedium),
                  const Divider(),
                  _buildTypographyItem('Title Small', typography.titleSmall),
                  const Divider(),
                  _buildTypographyItem('Body Large', typography.bodyLarge),
                  const Divider(),
                  _buildTypographyItem('Body Medium', typography.bodyMedium),
                  const Divider(),
                  _buildTypographyItem('Body Small', typography.bodySmall),
                  const Divider(),
                  _buildTypographyItem('Label Large', typography.labelLarge),
                  const Divider(),
                  _buildTypographyItem('Label Medium', typography.labelMedium),
                  const Divider(),
                  _buildTypographyItem('Label Small', typography.labelSmall),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build individual typography item
  Widget _buildTypographyItem(String name, TextStyle style) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(name, style: style),
      subtitle: Text(
        '${style.fontSize?.toStringAsFixed(0)}sp • ${style.fontWeight?.toString().split('.').last ?? 'Regular'}',
        style: const TextStyle(fontSize: 12),
      ),
    );
  }

  /// Build spacing system section
  Widget _buildSpacingSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Spacing System',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: _itemSpacing),
          Card(
            child: Padding(
              padding: _cardPadding,
              child: Column(
                children: [
                  _buildSpacingItem('Extra Small', FSSpacing.xs),
                  const Divider(),
                  _buildSpacingItem('Small', FSSpacing.sm),
                  const Divider(),
                  _buildSpacingItem('Medium', FSSpacing.md),
                  const Divider(),
                  _buildSpacingItem('Large', FSSpacing.lg),
                  const Divider(),
                  _buildSpacingItem('Extra Large', FSSpacing.xl),
                  const Divider(),
                  _buildSpacingItem('2X Large', FSSpacing.xxl),
                  const Divider(),
                  _buildSpacingItem('3X Large', FSSpacing.xxxl),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build individual spacing item
  Widget _buildSpacingItem(String name, double value) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(name),
      trailing: Chip(
        label: Text('${value.toStringAsFixed(0)}px'),
      ),
      subtitle: Container(
        margin: const EdgeInsets.only(top: 8),
        height: 4,
        width: value,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  /// Build component preview section
  Widget _buildComponentPreviewSection(BuildContext context) {
    // ✅ FIXED: Use FSTheme widget to provide theme to Flutstrap components
    return FSTheme(
      data: _buildCurrentTheme(),
      child: Container(
        padding: _sectionPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Component Preview',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: _itemSpacing),
            Card(
              child: Padding(
                padding: _cardPadding,
                child: Column(
                  children: [
                    // ✅ BUTTON VARIANTS
                    const Text('Button Variants',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _buildFlutstrapButton(
                            'Primary', FSButtonVariant.primary),
                        _buildFlutstrapButton(
                            'Secondary', FSButtonVariant.secondary),
                        _buildFlutstrapButton(
                            'Success', FSButtonVariant.success),
                        _buildFlutstrapButton('Danger', FSButtonVariant.danger),
                        _buildFlutstrapButton(
                            'Warning', FSButtonVariant.warning),
                        _buildFlutstrapButton('Info', FSButtonVariant.info),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // ✅ BUTTON SIZES
                    const Text('Button Sizes',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _buildFlutstrapButtonSize('Small', FSButtonSize.sm),
                        _buildFlutstrapButtonSize('Medium', FSButtonSize.md),
                        _buildFlutstrapButtonSize('Large', FSButtonSize.lg),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // ✅ CARD PREVIEW
                    const Text('Cards',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 12),
                    FlutstrapCard(
                      headerText: 'Card Component',
                      bodyText:
                          'This card demonstrates the current theme configuration including colors, typography, and spacing.',
                      footerText: 'Theme Demo',
                    ),

                    const SizedBox(height: 24),

                    // ✅ CARD VARIANTS
                    const Text('Card Variants',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        FlutstrapCard(
                          headerText: 'Elevated Card',
                          bodyText: 'Default elevated variant',
                          variant: FSCardVariant.elevated,
                        ),
                        FlutstrapCard(
                          headerText: 'Outlined Card',
                          bodyText: 'Card with border outline',
                          variant: FSCardVariant.outlined,
                        ),
                        FlutstrapCard(
                          headerText: 'Filled Card',
                          bodyText: 'Card with filled background',
                          variant: FSCardVariant.filled,
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // ✅ ALERTS
                    const Text('Alerts',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 12),
                    Column(
                      children: [
                        _buildFlutstrapAlert(
                            'Primary alert message', FSAlertVariant.primary),
                        const SizedBox(height: 8),
                        _buildFlutstrapAlert(
                            'Success alert message', FSAlertVariant.success),
                        const SizedBox(height: 8),
                        _buildFlutstrapAlert(
                            'Danger alert message', FSAlertVariant.danger),
                        const SizedBox(height: 8),
                        _buildFlutstrapAlert(
                            'Warning alert message', FSAlertVariant.warning),
                        const SizedBox(height: 8),
                        _buildFlutstrapAlert(
                            'Info alert message', FSAlertVariant.info),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Helper method for FlutstrapButton
  Widget _buildFlutstrapButton(String text, FSButtonVariant variant) {
    return FlutstrapButton(
      onPressed: () {
        print('$text button pressed');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$text button pressed!')),
        );
      },
      text: text,
      variant: variant,
      size: FSButtonSize.md,
    );
  }

  /// Helper method for button size demonstration
  Widget _buildFlutstrapButtonSize(String text, FSButtonSize size) {
    return FlutstrapButton(
      onPressed: () {
        print('$size button pressed');
      },
      text: text,
      variant: FSButtonVariant.primary,
      size: size,
    );
  }

  /// Helper method for FlutstrapAlert
  Widget _buildFlutstrapAlert(String message, FSAlertVariant variant) {
    return FlutstrapAlert(
      message: message,
      variant: variant,
      dismissible: true,
    );
  }
}
