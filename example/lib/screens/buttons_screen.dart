import 'package:flutter/material.dart';
import 'package:master_flutstrap/flutstrap.dart';

class ButtonsScreen extends StatelessWidget {
  const ButtonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buttons'),
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
            _buildSectionTitle(context, 'Button Variants'),
            _buildButtonVariantsSection(context),
            const SizedBox(height: 32),
            _buildSectionTitle(context, 'Button Sizes'),
            _buildButtonSizesSection(context),
            const SizedBox(height: 32),
            _buildSectionTitle(context, 'Button States'),
            _buildButtonStatesSection(context),
            const SizedBox(height: 32),
            _buildSectionTitle(context, 'With Icons'),
            _buildButtonWithIconsSection(context),
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

  Widget _buildButtonVariantsSection(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        FlutstrapButton(
          onPressed: () {},
          text: 'Primary',
          variant: FSButtonVariant.primary,
        ),
        FlutstrapButton(
          onPressed: () {},
          text: 'Secondary',
          variant: FSButtonVariant.secondary,
        ),
        FlutstrapButton(
          onPressed: () {},
          text: 'Success',
          variant: FSButtonVariant.success,
        ),
        FlutstrapButton(
          onPressed: () {},
          text: 'Danger',
          variant: FSButtonVariant.danger,
        ),
        FlutstrapButton(
          onPressed: () {},
          text: 'Warning',
          variant: FSButtonVariant.warning,
        ),
        FlutstrapButton(
          onPressed: () {},
          text: 'Info',
          variant: FSButtonVariant.info,
        ),
        FlutstrapButton(
          onPressed: () {},
          text: 'Light',
          variant: FSButtonVariant.light,
        ),
        FlutstrapButton(
          onPressed: () {},
          text: 'Dark',
          variant: FSButtonVariant.dark,
        ),
        FlutstrapButton(
          onPressed: () {},
          text: 'Link',
          variant: FSButtonVariant.link,
        ),
        FlutstrapButton(
          onPressed: () {},
          text: 'Outline Primary',
          variant: FSButtonVariant.outlinePrimary,
        ),
        FlutstrapButton(
          onPressed: () {},
          text: 'Outline Danger',
          variant: FSButtonVariant.outlineDanger,
        ),
      ],
    );
  }

  Widget _buildButtonSizesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        FlutstrapButton(
          onPressed: () {},
          text: 'Small',
          variant: FSButtonVariant.primary,
          size: FSButtonSize.sm,
        ),
        const SizedBox(height: 8),
        FlutstrapButton(
          onPressed: () {},
          text: 'Medium (Default)',
          variant: FSButtonVariant.primary,
          size: FSButtonSize.md,
        ),
        const SizedBox(height: 8),
        FlutstrapButton(
          onPressed: () {},
          text: 'Large',
          variant: FSButtonVariant.primary,
          size: FSButtonSize.lg,
        ),
        const SizedBox(height: 8),
        FlutstrapButton(
          onPressed: () {},
          text: 'Expanded Full Width',
          variant: FSButtonVariant.primary,
          expanded: true,
        ),
      ],
    );
  }

  Widget _buildButtonStatesSection(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        FlutstrapButton(
          onPressed: () {},
          text: 'Normal',
          variant: FSButtonVariant.primary,
        ),
        FlutstrapButton(
          onPressed: null,
          text: 'Disabled',
          variant: FSButtonVariant.primary,
        ),
        FlutstrapButton(
          onPressed: () {},
          text: 'Loading',
          variant: FSButtonVariant.primary,
          loading: true,
        ),
        FlutstrapButton(
          onPressed: null,
          text: 'Disabled Loading',
          variant: FSButtonVariant.primary,
          loading: true,
        ),
      ],
    );
  }

  Widget _buildButtonWithIconsSection(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        FlutstrapButton(
          onPressed: () {},
          text: 'Leading Icon',
          variant: FSButtonVariant.primary,
          leading: const Icon(Icons.add, size: 16),
        ),
        FlutstrapButton(
          onPressed: () {},
          text: 'Trailing Icon',
          variant: FSButtonVariant.success,
          trailing: const Icon(Icons.check, size: 16),
        ),
        FlutstrapButton(
          onPressed: () {},
          child: const Icon(Icons.favorite),
          variant: FSButtonVariant.danger,
        ),
      ],
    );
  }
}
