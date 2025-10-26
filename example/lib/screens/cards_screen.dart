import 'package:flutter/material.dart';
import 'package:master_flutstrap/flutstrap.dart';

class CardsScreen extends StatelessWidget {
  const CardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cards'),
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
            _buildSectionTitle(context, 'Basic Cards'),
            _buildBasicCardsSection(context),
            const SizedBox(height: 32),
            _buildSectionTitle(context, 'Card with Header & Footer'),
            _buildHeaderFooterCardsSection(context),
            const SizedBox(height: 32),
            _buildSectionTitle(context, 'Outlined Cards'),
            _buildOutlinedCardsSection(context),
            const SizedBox(height: 32),
            _buildSectionTitle(context, 'Special Card Types'),
            _buildSpecialCardsSection(context),
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

  Widget _buildBasicCardsSection(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        SizedBox(
          width: 300,
          child: FlutstrapCard(
            bodyText: 'This is a simple card with just body content.',
          ),
        ),
        SizedBox(
          width: 300,
          child: FlutstrapCard(
            bodyText: 'Card with custom background color.',
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderFooterCardsSection(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        SizedBox(
          width: 300,
          child: FlutstrapCard(
            headerText: 'Card Header',
            bodyText: 'This card has a header, body, and footer sections.',
            footerText: 'Card Footer',
          ),
        ),
        SizedBox(
          width: 300,
          child: FlutstrapCard(
            headerText: 'Featured Content',
            bodyText:
                'This is the main content of the card. It can contain any widgets or text.',
            footer: Row(
              children: [
                FlutstrapButton(
                  onPressed: () {},
                  text: 'Action',
                  variant: FSButtonVariant.primary,
                  size: FSButtonSize.sm,
                ),
                const SizedBox(width: 8),
                FlutstrapButton(
                  onPressed: () {},
                  text: 'Cancel',
                  variant: FSButtonVariant.outlinePrimary,
                  size: FSButtonSize.sm,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOutlinedCardsSection(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        SizedBox(
          width: 300,
          child: FlutstrapCard(
            headerText: 'Outlined Card',
            bodyText: 'This card uses outline styling instead of shadow.',
            outlined: true,
          ),
        ),
        SizedBox(
          width: 300,
          child: FlutstrapCard(
            headerText: 'Custom Border',
            bodyText: 'Card with custom border color and width.',
            borderColor: Theme.of(context).colorScheme.error,
            borderWidth: 2,
            outlined: true,
          ),
        ),
      ],
    );
  }

  Widget _buildSpecialCardsSection(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        SizedBox(
          width: 300,
          child: FlutstrapCard.simple(
            title: 'Simple Factory Card',
            content: 'Created using the simple factory constructor.',
            footer: 'Easy to use',
          ),
        ),
        SizedBox(
          width: 300,
          child: FlutstrapCard.action(
            title: 'Action Card',
            content: 'Card with built-in action buttons in the footer.',
            actions: [
              FlutstrapButton(
                onPressed: () {},
                text: 'Save',
                variant: FSButtonVariant.primary,
                size: FSButtonSize.sm,
              ),
              const SizedBox(width: 8),
              FlutstrapButton(
                onPressed: () {},
                text: 'Delete',
                variant: FSButtonVariant.outlineDanger,
                size: FSButtonSize.sm,
              ),
            ],
          ),
        ),
        SizedBox(
          width: 300,
          child: FlutstrapCard.image(
            image: Container(
              height: 120,
              width: double.infinity,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              child: Icon(
                Icons.photo,
                size: 48,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            title: 'Image Card',
            content: 'Card with header image and content below.',
          ),
        ),
      ],
    );
  }
}
