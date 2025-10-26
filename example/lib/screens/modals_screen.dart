import 'package:flutter/material.dart';
import 'package:master_flutstrap/flutstrap.dart';

class ModalsScreen extends StatefulWidget {
  const ModalsScreen({super.key});

  @override
  State<ModalsScreen> createState() => _ModalsScreenState();
}

class _ModalsScreenState extends State<ModalsScreen> {
  String _confirmationResult = 'No action taken';
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modals'),
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
            _buildSectionTitle(context, 'Modal Variants'),
            _buildModalVariantsSection(context),
            const SizedBox(height: 32),
            _buildSectionTitle(context, 'Modal Sizes'),
            _buildModalSizesSection(context),
            const SizedBox(height: 32),
            _buildSectionTitle(context, 'Service Methods'),
            _buildServiceMethodsSection(context),
            const SizedBox(height: 32),
            _buildSectionTitle(context, 'Interactive Examples'),
            _buildInteractiveExamplesSection(context),
            const SizedBox(height: 32),
            _buildSectionTitle(context, 'Custom Modals'),
            _buildCustomModalsSection(context),
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

  Widget _buildModalVariantsSection(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        FlutstrapButton(
          onPressed: () => _showVariantModal(context, FSModalVariant.primary),
          text: 'Primary',
          variant: FSButtonVariant.primary,
          size: FSButtonSize.sm,
        ),
        FlutstrapButton(
          onPressed: () => _showVariantModal(context, FSModalVariant.secondary),
          text: 'Secondary',
          variant: FSButtonVariant.secondary,
          size: FSButtonSize.sm,
        ),
        FlutstrapButton(
          onPressed: () => _showVariantModal(context, FSModalVariant.success),
          text: 'Success',
          variant: FSButtonVariant.success,
          size: FSButtonSize.sm,
        ),
        FlutstrapButton(
          onPressed: () => _showVariantModal(context, FSModalVariant.danger),
          text: 'Danger',
          variant: FSButtonVariant.danger,
          size: FSButtonSize.sm,
        ),
        FlutstrapButton(
          onPressed: () => _showVariantModal(context, FSModalVariant.warning),
          text: 'Warning',
          variant: FSButtonVariant.warning,
          size: FSButtonSize.sm,
        ),
        FlutstrapButton(
          onPressed: () => _showVariantModal(context, FSModalVariant.info),
          text: 'Info',
          variant: FSButtonVariant.info,
          size: FSButtonSize.sm,
        ),
        FlutstrapButton(
          onPressed: () => _showVariantModal(context, FSModalVariant.light),
          text: 'Light',
          variant: FSButtonVariant.light,
          size: FSButtonSize.sm,
        ),
        FlutstrapButton(
          onPressed: () => _showVariantModal(context, FSModalVariant.dark),
          text: 'Dark',
          variant: FSButtonVariant.dark,
          size: FSButtonSize.sm,
        ),
      ],
    );
  }

  Widget _buildModalSizesSection(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        FlutstrapButton(
          onPressed: () => _showSizeModal(context, FSModalSize.sm),
          text: 'Small',
          variant: FSButtonVariant.outlinePrimary,
          size: FSButtonSize.sm,
        ),
        FlutstrapButton(
          onPressed: () => _showSizeModal(context, FSModalSize.md),
          text: 'Medium',
          variant: FSButtonVariant.outlinePrimary,
          size: FSButtonSize.sm,
        ),
        FlutstrapButton(
          onPressed: () => _showSizeModal(context, FSModalSize.lg),
          text: 'Large',
          variant: FSButtonVariant.outlinePrimary,
          size: FSButtonSize.sm,
        ),
        FlutstrapButton(
          onPressed: () => _showSizeModal(context, FSModalSize.xl),
          text: 'Extra Large',
          variant: FSButtonVariant.outlinePrimary,
          size: FSButtonSize.sm,
        ),
      ],
    );
  }

  Widget _buildServiceMethodsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            FlutstrapButton(
              onPressed: () => _showAlertModal(context),
              text: 'Show Alert',
              variant: FSButtonVariant.warning,
              size: FSButtonSize.sm,
            ),
            FlutstrapButton(
              onPressed: () => _showSuccessModal(context),
              text: 'Show Success',
              variant: FSButtonVariant.success,
              size: FSButtonSize.sm,
            ),
            FlutstrapButton(
              onPressed: () => _showErrorModal(context),
              text: 'Show Error',
              variant: FSButtonVariant.danger,
              size: FSButtonSize.sm,
            ),
            FlutstrapButton(
              onPressed: () => _showConfirmModal(context),
              text: 'Show Confirm',
              variant: FSButtonVariant.primary,
              size: FSButtonSize.sm,
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'Confirmation Result: $_confirmationResult',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }

  Widget _buildInteractiveExamplesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            FlutstrapButton(
              onPressed: () => _showNonDismissibleModal(context),
              text: 'Non-dismissible',
              variant: FSButtonVariant.outlineWarning,
              size: FSButtonSize.sm,
            ),
            FlutstrapButton(
              onPressed: () => _showModalWithoutCloseButton(context),
              text: 'No Close Button',
              variant: FSButtonVariant.outlineInfo,
              size: FSButtonSize.sm,
            ),
            FlutstrapButton(
              onPressed: () => _showModalWithCustomActions(context),
              text: 'Custom Actions',
              variant: FSButtonVariant.outlineSuccess,
              size: FSButtonSize.sm,
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Counter: $_counter',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                'Try the counter modal!',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCustomModalsSection(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        FlutstrapButton(
          onPressed: () => _showFormModal(context),
          text: 'Form Modal',
          variant: FSButtonVariant.outlinePrimary,
          size: FSButtonSize.sm,
        ),
        FlutstrapButton(
          onPressed: () => _showListModal(context),
          text: 'List Modal',
          variant: FSButtonVariant.outlineSecondary,
          size: FSButtonSize.sm,
        ),
        FlutstrapButton(
          onPressed: () => _showImageModal(context),
          text: 'Image Modal',
          variant: FSButtonVariant.outlineInfo,
          size: FSButtonSize.sm,
        ),
        FlutstrapModalTrigger(
          modalTitle: const Text('Modal Trigger'),
          modalContent: const Text(
              'This modal was triggered by a FlutstrapModalTrigger widget!'),
          modalVariant: FSModalVariant.info,
          child: FlutstrapBadge(
            text: 'Modal Trigger',
            variant: FSBadgeVariant.info,
          ),
        ),
      ],
    );
  }

  // Modal display methods
  void _showVariantModal(BuildContext context, FSModalVariant variant) {
    FlutstrapModalService.showModal(
      context: context,
      title: '${variant.name.toUpperCase()} Modal',
      content:
          'This is a ${variant.name} variant modal. It demonstrates the different color schemes available for modals.',
      variant: variant,
    );
  }

  void _showSizeModal(BuildContext context, FSModalSize size) {
    FlutstrapModalService.showModal(
      context: context,
      title: '${size.name.toUpperCase()} Size Modal',
      content:
          'This is a ${size.name} sized modal. It demonstrates the different size options available for modals.',
      size: size,
    );
  }

  void _showAlertModal(BuildContext context) {
    FlutstrapModalService.showAlert(
      context: context,
      title: 'Important Notice',
      content:
          'This is an alert modal. Use it for important information that requires user attention.',
    );
  }

  void _showSuccessModal(BuildContext context) {
    FlutstrapModalService.showSuccess(
      context: context,
      title: 'Operation Successful',
      content: 'Your action has been completed successfully!',
    );
  }

  void _showErrorModal(BuildContext context) {
    FlutstrapModalService.showError(
      context: context,
      title: 'Operation Failed',
      content: 'There was an error processing your request. Please try again.',
    );
  }

  void _showConfirmModal(BuildContext context) async {
    final result = await FlutstrapModalService.showConfirmModal(
      context: context,
      title: 'Confirm Action',
      content: 'Are you sure you want to proceed with this action?',
      confirmText: 'Yes, Proceed',
      cancelText: 'Cancel',
    );

    setState(() {
      _confirmationResult = result ? 'Confirmed!' : 'Cancelled';
    });
  }

  void _showNonDismissibleModal(BuildContext context) {
    FlutstrapModalService.showModal(
      context: context,
      title: 'Non-dismissible Modal',
      content:
          'This modal cannot be dismissed by tapping outside. You must use the close button or action buttons.',
      dismissible: false,
    );
  }

  void _showModalWithoutCloseButton(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => FlutstrapModal(
        title: const Text('No Close Button'),
        content: const Text(
            'This modal does not have a close button in the header. Users must use the action buttons below.'),
        showCloseButton: false,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showModalWithCustomActions(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => FlutstrapModal(
        title: const Text('Custom Actions'),
        content: const Text(
            'This modal demonstrates custom action buttons with different variants and behaviors.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FlutstrapButton(
            onPressed: () {
              Navigator.of(context).pop();
              _showSuccessModal(context);
            },
            text: 'Save',
            variant: FSButtonVariant.success,
          ),
          FlutstrapButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() => _counter++);
            },
            text: 'Increment Counter',
            variant: FSButtonVariant.primary,
          ),
        ],
      ),
    );
  }

  void _showFormModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => FlutstrapModal(
        title: const Text('Contact Form'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FlutstrapInput(
              labelText: 'Name',
              hintText: 'Enter your name',
            ),
            const SizedBox(height: 16),
            FlutstrapInput(
              labelText: 'Email',
              hintText: 'Enter your email',
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            // Note: Using FlutstrapInput with maxLines for textarea functionality
            FlutstrapInput(
              labelText: 'Message',
              hintText: 'Enter your message',
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FlutstrapButton(
            onPressed: () {
              Navigator.of(context).pop();
              _showSuccessModal(context);
            },
            text: 'Submit',
            variant: FSButtonVariant.primary,
          ),
        ],
        size: FSModalSize.lg,
      ),
    );
  }

  void _showListModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => FlutstrapModal(
        title: const Text('Select an Option'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: [
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('User Profile'),
                onTap: () {
                  Navigator.of(context).pop();
                  _showSuccessModal(context);
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () {
                  Navigator.of(context).pop();
                  _showSuccessModal(context);
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.help),
                title: const Text('Help & Support'),
                onTap: () {
                  Navigator.of(context).pop();
                  _showSuccessModal(context);
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text('About'),
                onTap: () {
                  Navigator.of(context).pop();
                  _showSuccessModal(context);
                },
              ),
            ],
          ),
        ),
        size: FSModalSize.sm,
      ),
    );
  }

  void _showImageModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => FlutstrapModal(
        title: const Text('Image Preview'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 200,
              height: 150,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.image,
                size: 64,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'This demonstrates how you can display images or custom content in modals.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
          FlutstrapButton(
            onPressed: () => Navigator.of(context).pop(),
            text: 'Download',
            variant: FSButtonVariant.primary,
          ),
        ],
      ),
    );
  }
}
