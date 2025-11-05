/// Flutstrap Modals Demo Screen
///
/// Comprehensive demonstration of Flutstrap modal components including:
/// - 🎨 All modal variants (primary, success, danger, warning, info, etc.)
/// - 📏 Multiple sizes (small, medium, large, xlarge)
/// - ⚡ Interactive features (dismissible, custom actions, callbacks)
/// - 🛠️ Service methods (confirm, alert, success, error modals)
/// - 🎯 Advanced usage (custom content, forms, triggers)
///
/// Features:
/// - Live interactive modal demonstrations
/// - Code examples for each modal type
/// - Service method demonstrations
/// - Custom modal content examples
///
/// {@category Demo}
/// {@category Screens}
/// {@category Overlays}

import 'package:flutter/material.dart';
import 'package:flutstrap/flutstrap.dart';

class ModalsScreen extends StatefulWidget {
  const ModalsScreen({super.key});

  /// Route name for navigation
  static const String routeName = '/modals';

  @override
  State<ModalsScreen> createState() => _ModalsScreenState();
}

class _ModalsScreenState extends State<ModalsScreen> {
  // ✅ STATE FOR INTERACTIVE EXAMPLES
  String _lastModalResult = 'No modal results yet';
  int _modalCounter = 0;

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
        title: const Text('Modal Components'),
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

            // ✅ BASIC MODAL VARIANTS
            _buildBasicModalsSection(context),
            const SizedBox(height: _sectionSpacing),

            // ✅ MODAL SIZES
            _buildModalSizesSection(context),
            const SizedBox(height: _sectionSpacing),

            // ✅ SERVICE METHOD MODALS
            _buildServiceModalsSection(context),
            const SizedBox(height: _sectionSpacing),

            // ✅ CUSTOM CONTENT MODALS
            _buildCustomContentModalsSection(context),
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
            'Flutstrap Modals',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: _itemSpacing),
          Text(
            'Flexible modal dialog components with multiple variants, sizes, '
            'and service methods for common patterns. Modals support custom content, '
            'actions, dismissible behavior, and comprehensive theming.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  height: 1.5,
                ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Last Modal Result: $_lastModalResult',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  /// Build basic modal variants section
  Widget _buildBasicModalsSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Basic Modal Variants',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Different semantic modal types for various use cases',
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
                spacing: 12,
                runSpacing: 12,
                children: [
                  _buildModalButton(
                    'Primary Modal',
                    FSModalVariant.primary,
                    _showPrimaryModal,
                  ),
                  _buildModalButton(
                    'Success Modal',
                    FSModalVariant.success,
                    _showSuccessModal,
                  ),
                  _buildModalButton(
                    'Danger Modal',
                    FSModalVariant.danger,
                    _showDangerModal,
                  ),
                  _buildModalButton(
                    'Warning Modal',
                    FSModalVariant.warning,
                    _showWarningModal,
                  ),
                  _buildModalButton(
                    'Info Modal',
                    FSModalVariant.info,
                    _showInfoModal,
                  ),
                  _buildModalButton(
                    'Light Modal',
                    FSModalVariant.light,
                    _showLightModal,
                  ),
                  _buildModalButton(
                    'Dark Modal',
                    FSModalVariant.dark,
                    _showDarkModal,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build modal sizes section
  Widget _buildModalSizesSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Modal Sizes',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Different modal sizes for various content requirements',
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
                spacing: 12,
                runSpacing: 12,
                children: [
                  _buildSizeModalButton('Small Modal', FSModalSize.sm),
                  _buildSizeModalButton('Medium Modal', FSModalSize.md),
                  _buildSizeModalButton('Large Modal', FSModalSize.lg),
                  _buildSizeModalButton('XLarge Modal', FSModalSize.xl),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build service method modals section
  Widget _buildServiceModalsSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Service Method Modals',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Convenient service methods for common modal patterns',
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
                spacing: 12,
                runSpacing: 12,
                children: [
                  FlutstrapButton(
                    onPressed: () => _showConfirmModal(context),
                    text: 'Confirm Modal',
                    variant: FSButtonVariant.primary,
                    size: FSButtonSize.sm,
                  ),
                  FlutstrapButton(
                    onPressed: () => _showAlertModal(context),
                    text: 'Alert Modal',
                    variant: FSButtonVariant.warning,
                    size: FSButtonSize.sm,
                  ),
                  FlutstrapButton(
                    onPressed: () => _showSuccessServiceModal(context),
                    text: 'Success Modal',
                    variant: FSButtonVariant.success,
                    size: FSButtonSize.sm,
                  ),
                  FlutstrapButton(
                    onPressed: () => _showErrorServiceModal(context),
                    text: 'Error Modal',
                    variant: FSButtonVariant.danger,
                    size: FSButtonSize.sm,
                  ),
                  FlutstrapButton(
                    onPressed: () => _showBasicServiceModal(context),
                    text: 'Basic Modal',
                    variant: FSButtonVariant.outlinePrimary,
                    size: FSButtonSize.sm,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build custom content modals section
  Widget _buildCustomContentModalsSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Custom Content Modals',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Modals with custom widgets, forms, and complex layouts',
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
                spacing: 12,
                runSpacing: 12,
                children: [
                  FlutstrapButton(
                    onPressed: () => _showFormModal(context),
                    text: 'Form Modal',
                    variant: FSButtonVariant.primary,
                    size: FSButtonSize.sm,
                  ),
                  FlutstrapButton(
                    onPressed: () => _showProfileModal(context),
                    text: 'Profile Modal',
                    variant: FSButtonVariant.success,
                    size: FSButtonSize.sm,
                  ),
                  FlutstrapButton(
                    onPressed: () => _showListModal(context),
                    text: 'List Modal',
                    variant: FSButtonVariant.info,
                    size: FSButtonSize.sm,
                  ),
                  FlutstrapButton(
                    onPressed: () => _showCustomActionsModal(context),
                    text: 'Custom Actions',
                    variant: FSButtonVariant.warning,
                    size: FSButtonSize.sm,
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
            'Dynamic modal demonstrations with user input',
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
                  Text(
                    'Modal Counter: $_modalCounter',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),

                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      FlutstrapButton(
                        onPressed: () => _showCounterModal(context),
                        text: 'Counter Modal',
                        variant: FSButtonVariant.primary,
                        size: FSButtonSize.sm,
                      ),
                      FlutstrapButton(
                        onPressed: _incrementCounter,
                        text: 'Increment Counter',
                        variant: FSButtonVariant.success,
                        size: FSButtonSize.sm,
                      ),
                      FlutstrapButton(
                        onPressed: _resetCounter,
                        text: 'Reset Counter',
                        variant: FSButtonVariant.outlineDanger,
                        size: FSButtonSize.sm,
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Modal Trigger Example
                  const Text('Modal Trigger Component:',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  FlutstrapModalTrigger(
                    modalTitle: const Text('Trigger Modal'),
                    modalContent: const Text(
                        'This modal was triggered by the FlutstrapModalTrigger component!'),
                    modalVariant: FSModalVariant.info,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.touch_app, size: 16),
                          SizedBox(width: 8),
                          Text('Click Me to Open Modal'),
                        ],
                      ),
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

  // ✅ HELPER METHODS

  /// Build modal button with variant styling
  Widget _buildModalButton(
    String text,
    FSModalVariant variant,
    VoidCallback onPressed,
  ) {
    FSButtonVariant buttonVariant;

    switch (variant) {
      case FSModalVariant.primary:
        buttonVariant = FSButtonVariant.primary;
      case FSModalVariant.success:
        buttonVariant = FSButtonVariant.success;
      case FSModalVariant.danger:
        buttonVariant = FSButtonVariant.danger;
      case FSModalVariant.warning:
        buttonVariant = FSButtonVariant.warning;
      case FSModalVariant.info:
        buttonVariant = FSButtonVariant.info;
      case FSModalVariant.light:
        buttonVariant = FSButtonVariant.light;
      case FSModalVariant.dark:
        buttonVariant = FSButtonVariant.dark;
      default:
        buttonVariant = FSButtonVariant.primary;
    }

    return FlutstrapButton(
      onPressed: onPressed,
      text: text,
      variant: buttonVariant,
      size: FSButtonSize.sm,
    );
  }

  /// Build size modal button
  Widget _buildSizeModalButton(String text, FSModalSize size) {
    return FlutstrapButton(
      onPressed: () => _showSizeModal(size),
      text: text,
      variant: FSButtonVariant.outlinePrimary,
      size: FSButtonSize.sm,
    );
  }

  // ✅ BASIC MODAL HANDLERS

  void _showPrimaryModal() {
    showDialog(
      context: context,
      builder: (context) => FlutstrapModal(
        title: const Text('Primary Modal'),
        content: const Text('This is a primary modal with default styling. '
            'It can be dismissed by clicking outside or using the close button.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _updateModalResult('Primary modal closed');
            },
            child: const Text('Close'),
          ),
        ],
        variant: FSModalVariant.primary,
      ),
    );
  }

  void _showSuccessModal() {
    showDialog(
      context: context,
      builder: (context) => FlutstrapModal(
        title: const Text('Success!'),
        content: const Text('Your operation was completed successfully. '
            'All changes have been saved.'),
        actions: [
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              _updateModalResult('Success action completed');
            },
            child: const Text('Great!'),
          ),
        ],
        variant: FSModalVariant.success,
      ),
    );
  }

  void _showDangerModal() {
    showDialog(
      context: context,
      builder: (context) => FlutstrapModal(
        title: const Text('Warning!'),
        content: const Text('This action cannot be undone. '
            'Please make sure you want to proceed.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _updateModalResult('Danger action cancelled');
            },
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              _updateModalResult('Danger action confirmed');
            },
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Proceed'),
          ),
        ],
        variant: FSModalVariant.danger,
      ),
    );
  }

  void _showWarningModal() {
    showDialog(
      context: context,
      builder: (context) => FlutstrapModal(
        title: const Text('Attention Required'),
        content: const Text(
            'Please review the following information before continuing. '
            'Some settings may affect your user experience.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Dismiss'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              _updateModalResult('Warning acknowledged');
            },
            child: const Text('Acknowledge'),
          ),
        ],
        variant: FSModalVariant.warning,
      ),
    );
  }

  void _showInfoModal() {
    showDialog(
      context: context,
      builder: (context) => FlutstrapModal(
        title: const Text('Information'),
        content: const Text('This is an informational modal. '
            'It provides helpful details about the current context.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _updateModalResult('Info modal closed');
            },
            child: const Text('Got it'),
          ),
        ],
        variant: FSModalVariant.info,
      ),
    );
  }

  void _showLightModal() {
    showDialog(
      context: context,
      builder: (context) => FlutstrapModal(
        title: const Text('Light Modal'),
        content: const Text('This modal uses the light variant styling. '
            'Perfect for neutral information displays.'),
        variant: FSModalVariant.light,
      ),
    );
  }

  void _showDarkModal() {
    showDialog(
      context: context,
      builder: (context) => FlutstrapModal(
        title: const Text('Dark Modal'),
        content: const Text('This modal uses the dark variant styling. '
            'Great for focused attention or dark themes.'),
        variant: FSModalVariant.dark,
      ),
    );
  }

  // ✅ SIZE MODAL HANDLERS

  void _showSizeModal(FSModalSize size) {
    String sizeName = size.toString().split('.').last.toUpperCase();

    showDialog(
      context: context,
      builder: (context) => FlutstrapModal(
        title: Text('$sizeName Modal'),
        content: Text('This is a $sizeName sized modal. '
            'Different sizes are useful for different content amounts and contexts.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
        size: size,
      ),
    );
  }

  // ✅ SERVICE METHOD HANDLERS

  void _showConfirmModal(BuildContext context) async {
    final confirmed = await FlutstrapModalService.showConfirmModal(
      context: context,
      title: 'Confirm Action',
      content: 'Are you sure you want to proceed with this action? '
          'This cannot be undone.',
      confirmText: 'Yes, Proceed',
      cancelText: 'Cancel',
      variant: FSModalVariant.warning,
    );

    _updateModalResult(
        'Confirm modal: ${confirmed ? 'Confirmed' : 'Cancelled'}');
  }

  void _showAlertModal(BuildContext context) {
    FlutstrapModalService.showAlert(
      context: context,
      title: 'Important Notice',
      content: 'Your session will expire in 5 minutes. '
          'Please save your work to avoid losing progress.',
      variant: FSModalVariant.warning,
    );
    _updateModalResult('Alert modal shown');
  }

  void _showSuccessServiceModal(BuildContext context) {
    FlutstrapModalService.showSuccess(
      context: context,
      title: 'Operation Successful',
      content: 'Your changes have been saved successfully. '
          'All data has been updated in the system.',
    );
    _updateModalResult('Success modal shown');
  }

  void _showErrorServiceModal(BuildContext context) {
    FlutstrapModalService.showError(
      context: context,
      title: 'Upload Failed',
      content: 'The file could not be uploaded. '
          'Please check your internet connection and try again.',
    );
    _updateModalResult('Error modal shown');
  }

  void _showBasicServiceModal(BuildContext context) {
    FlutstrapModalService.showModal(
      context: context,
      title: 'Basic Modal',
      content: 'This modal was created using the service method. '
          'Service methods provide convenient shortcuts for common modal patterns.',
      variant: FSModalVariant.primary,
    );
    _updateModalResult('Basic service modal shown');
  }

  // ✅ CUSTOM CONTENT HANDLERS

  void _showFormModal(BuildContext context) {
    FlutstrapModalService.showCustomModal(
      context: context,
      title: const Text('Contact Form'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: const InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Message',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            Navigator.pop(context);
            _updateModalResult('Form submitted');
          },
          child: const Text('Submit'),
        ),
      ],
      variant: FSModalVariant.primary,
      size: FSModalSize.lg,
    );
  }

  void _showProfileModal(BuildContext context) {
    FlutstrapModalService.showCustomModal(
      context: context,
      title: const Text('User Profile'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage('https://via.placeholder.com/80'),
          ),
          const SizedBox(height: 16),
          const Text(
            'John Doe',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text('john.doe@example.com'),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text('125', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Posts', style: TextStyle(fontSize: 12)),
                ],
              ),
              Column(
                children: [
                  Text('1.2K', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Followers', style: TextStyle(fontSize: 12)),
                ],
              ),
              Column(
                children: [
                  Text('456', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Following', style: TextStyle(fontSize: 12)),
                ],
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
        FilledButton(
          onPressed: () {
            Navigator.pop(context);
            _updateModalResult('Profile action taken');
          },
          child: const Text('Message'),
        ),
      ],
      variant: FSModalVariant.info,
    );
  }

  void _showListModal(BuildContext context) {
    FlutstrapModalService.showCustomModal(
      context: context,
      title: const Text('Settings'),
      content: SizedBox(
        height: 200,
        child: ListView(
          children: [
            _buildListTile('Account Settings', Icons.person),
            _buildListTile('Notifications', Icons.notifications),
            _buildListTile('Privacy', Icons.lock),
            _buildListTile('Help & Support', Icons.help),
            _buildListTile('About', Icons.info),
          ],
        ),
      ),
      variant: FSModalVariant.light,
    );
  }

  void _showCustomActionsModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => FlutstrapModal(
        title: const Text('Custom Actions'),
        content: const Text('This modal demonstrates custom action layouts '
            'with multiple buttons and different styles.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Skip'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Learn More'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              _updateModalResult('Primary action taken');
            },
            child: const Text('Continue'),
          ),
        ],
        showCloseButton: false, // Hide the X button
        dismissible: false, // Force user to choose an action
      ),
    );
  }

  // ✅ INTERACTIVE DEMO HANDLERS

  void _showCounterModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => FlutstrapModal(
        title: const Text('Counter Modal'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('This modal shows the current counter value '
                'and allows you to interact with it.'),
            const SizedBox(height: 16),
            Text(
              'Current Count: $_modalCounter',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          FilledButton(
            onPressed: () {
              _incrementCounter();
              Navigator.pop(context);
              _updateModalResult('Counter incremented from modal');
            },
            child: const Text('Increment'),
          ),
        ],
      ),
    );
  }

  void _incrementCounter() {
    setState(() {
      _modalCounter++;
    });
    _updateModalResult('Counter incremented to $_modalCounter');
  }

  void _resetCounter() {
    setState(() {
      _modalCounter = 0;
    });
    _updateModalResult('Counter reset to 0');
  }

  void _updateModalResult(String result) {
    setState(() {
      _lastModalResult = result;
    });
  }

  // ✅ HELPER WIDGETS

  Widget _buildListTile(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        Navigator.pop(context);
        _updateModalResult('$title selected');
      },
    );
  }
}
