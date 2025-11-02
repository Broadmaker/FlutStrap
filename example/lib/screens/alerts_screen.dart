/// Flutstrap Alerts Demo Screen
///
/// Comprehensive demonstration of Flutstrap alert components including:
/// - 🎨 All alert variants (primary, success, danger, warning, info, etc.)
/// - ⚡ Interactive states (dismissible, auto-dismiss)
/// - 🎯 Advanced features (icons, titles, custom content, actions)
/// - 📱 Responsive behavior and animations
///
/// Features:
/// - Live interactive alert demonstrations
/// - Code examples for each alert type
/// - State management for dynamic alerts
/// - Accessibility compliance
///
/// {@category Demo}
/// {@category Screens}
/// {@category Feedback}

import 'package:flutter/material.dart';
import 'package:master_flutstrap/flutstrap.dart';

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  /// Route name for navigation
  static const String routeName = '/alerts';

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  // ✅ STATE FOR INTERACTIVE EXAMPLES
  final List<Widget> _dynamicAlerts = [];
  bool _showAutoDismissAlert = false;
  int _alertCounter = 0;

  // ✅ CONSTANTS FOR PERFORMANCE
  static const EdgeInsets _screenPadding = EdgeInsets.all(16.0);
  static const EdgeInsets _sectionPadding = EdgeInsets.only(bottom: 32.0);
  static const EdgeInsets _cardPadding = EdgeInsets.all(16.0);
  static const double _sectionSpacing = 24.0;
  static const double _itemSpacing = 16.0;
  static const double _alertSpacing = 12.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alert Components'),
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

            // ✅ BASIC ALERT VARIANTS
            _buildBasicAlertsSection(context),
            const SizedBox(height: _sectionSpacing),

            // ✅ ALERTS WITH TITLES
            _buildTitledAlertsSection(context),
            const SizedBox(height: _sectionSpacing),

            // ✅ DISMISSIBLE ALERTS
            _buildDismissibleAlertsSection(context),
            const SizedBox(height: _sectionSpacing),

            // ✅ AUTO-DISMISS ALERTS
            _buildAutoDismissAlertsSection(context),
            const SizedBox(height: _sectionSpacing),

            // ✅ CUSTOM CONTENT ALERTS
            _buildCustomContentAlertsSection(context),
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
            'Flutstrap Alerts',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: _itemSpacing),
          Text(
            'Flexible alert components for displaying contextual feedback messages. '
            'Alerts support multiple variants, dismissible behavior, auto-dismiss timers, '
            'and custom content with comprehensive theming.',
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

  /// Build basic alert variants section
  Widget _buildBasicAlertsSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Basic Alert Variants',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Different semantic alert types for various feedback scenarios',
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
                  _buildAlertWithCode(
                    context,
                    FlutstrapAlert(
                      message:
                          'This is a primary alert with important information.',
                      variant: FSAlertVariant.primary,
                    ),
                    'FSAlertVariant.primary',
                  ),
                  const SizedBox(height: _alertSpacing),
                  _buildAlertWithCode(
                    context,
                    FlutstrapAlert(
                      message: 'Operation completed successfully!',
                      variant: FSAlertVariant.success,
                    ),
                    'FSAlertVariant.success',
                  ),
                  const SizedBox(height: _alertSpacing),
                  _buildAlertWithCode(
                    context,
                    FlutstrapAlert(
                      message: 'Warning: This action requires attention.',
                      variant: FSAlertVariant.warning,
                    ),
                    'FSAlertVariant.warning',
                  ),
                  const SizedBox(height: _alertSpacing),
                  _buildAlertWithCode(
                    context,
                    FlutstrapAlert(
                      message: 'Error: Something went wrong. Please try again.',
                      variant: FSAlertVariant.danger,
                    ),
                    'FSAlertVariant.danger',
                  ),
                  const SizedBox(height: _alertSpacing),
                  _buildAlertWithCode(
                    context,
                    FlutstrapAlert(
                      message: 'Information: Here are some helpful details.',
                      variant: FSAlertVariant.info,
                    ),
                    'FSAlertVariant.info',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build alerts with titles section
  Widget _buildTitledAlertsSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Alerts with Titles',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Alerts can include titles for better content organization',
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
                  _buildAlertWithCode(
                    context,
                    FlutstrapAlert(
                      title: 'Success!',
                      message: 'Your changes have been saved successfully.',
                      variant: FSAlertVariant.success,
                    ),
                    'title: "Success!"',
                  ),
                  const SizedBox(height: _alertSpacing),
                  _buildAlertWithCode(
                    context,
                    FlutstrapAlert(
                      title: 'Upload Failed',
                      message:
                          'The file could not be uploaded. Check your connection.',
                      variant: FSAlertVariant.danger,
                    ),
                    'title: "Upload Failed"',
                  ),
                  const SizedBox(height: _alertSpacing),
                  _buildAlertWithCode(
                    context,
                    FlutstrapAlert(
                      title: 'Maintenance Notice',
                      message:
                          'System maintenance scheduled for tonight at 2 AM.',
                      variant: FSAlertVariant.info,
                    ),
                    'title: "Maintenance Notice"',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build dismissible alerts section
  Widget _buildDismissibleAlertsSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dismissible Alerts',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Alerts that can be manually dismissed by users',
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
                  _buildAlertWithCode(
                    context,
                    FlutstrapAlert(
                      message:
                          'This alert can be dismissed. Click the X button.',
                      variant: FSAlertVariant.info,
                      dismissible: true,
                      onDismiss: () => _showSnackbar('Alert dismissed!'),
                    ),
                    'dismissible: true',
                  ),
                  const SizedBox(height: _alertSpacing),
                  _buildAlertWithCode(
                    context,
                    FlutstrapAlert(
                      title: 'Important Notice',
                      message: 'This important alert can also be dismissed.',
                      variant: FSAlertVariant.warning,
                      dismissible: true,
                    ),
                    'dismissible: true (with title)',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build auto-dismiss alerts section
  Widget _buildAutoDismissAlertsSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Auto-Dismiss Alerts',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Alerts that automatically disappear after a specified duration',
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
                  if (_showAutoDismissAlert) ...[
                    FlutstrapAlert(
                      message: 'This alert will auto-dismiss in 5 seconds...',
                      variant: FSAlertVariant.success,
                      autoDismissDuration: const Duration(seconds: 5),
                      onDismiss: () =>
                          setState(() => _showAutoDismissAlert = false),
                    ),
                    const SizedBox(height: _alertSpacing),
                  ],
                  FlutstrapButton(
                    onPressed: _showAutoDismissAlert
                        ? null
                        : () {
                            setState(() => _showAutoDismissAlert = true);
                            _showSnackbar('Auto-dismiss alert shown!');
                          },
                    text: _showAutoDismissAlert
                        ? 'Alert Active'
                        : 'Show Auto-Dismiss Alert',
                    variant: FSButtonVariant.primary,
                    size: FSButtonSize.sm,
                  ),
                  const SizedBox(height: 12),
                  _buildAlertWithCode(
                    context,
                    FlutstrapAlert(
                      message: 'Quick notification (3 seconds)',
                      variant: FSAlertVariant.info,
                      autoDismissDuration: const Duration(seconds: 3),
                      dismissible: true,
                    ),
                    'autoDismissDuration: Duration(seconds: 3)',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build custom content alerts section
  Widget _buildCustomContentAlertsSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Custom Content Alerts',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Alerts with custom icons, actions, and advanced content',
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
                  // Custom icon alert
                  _buildAlertWithCode(
                    context,
                    FlutstrapAlert(
                      message: 'Custom icon alert with different symbol',
                      variant: FSAlertVariant.primary,
                      leading: const Icon(Icons.flag, size: 20),
                    ),
                    'leading: Icon(Icons.flag)',
                  ),
                  const SizedBox(height: _alertSpacing),

                  // Alert with action button
                  _buildAlertWithCode(
                    context,
                    FlutstrapAlert(
                      title: 'Session Expiring',
                      message: 'Your session will expire in 5 minutes.',
                      variant: FSAlertVariant.warning,
                      trailing: FlutstrapButton(
                        onPressed: () => _showSnackbar('Session extended!'),
                        text: 'Extend',
                        variant: FSButtonVariant.outlineWarning,
                        size: FSButtonSize.sm,
                      ),
                      dismissible: true,
                    ),
                    'trailing: FlutstrapButton(...)',
                  ),
                  const SizedBox(height: _alertSpacing),

                  // Complex custom alert
                  _buildAlertWithCode(
                    context,
                    FlutstrapAlert(
                      leading: const Icon(Icons.download, size: 20),
                      title: 'Download Complete',
                      message:
                          'File "document.pdf" has been downloaded successfully.',
                      variant: FSAlertVariant.success,
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FlutstrapButton(
                            onPressed: () => _showSnackbar('File opened'),
                            text: 'Open',
                            variant: FSButtonVariant.outlineSuccess,
                            size: FSButtonSize.sm,
                          ),
                          const SizedBox(width: 8),
                          FlutstrapButton(
                            onPressed: () => _showSnackbar('File shared'),
                            text: 'Share',
                            variant: FSButtonVariant.success,
                            size: FSButtonSize.sm,
                          ),
                        ],
                      ),
                      dismissible: true,
                    ),
                    'Custom leading + trailing + actions',
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
            'Dynamically create and manage alerts',
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
                  // Dynamic alerts display
                  if (_dynamicAlerts.isNotEmpty) ...[
                    ..._dynamicAlerts,
                    const SizedBox(height: 16),
                  ] else ...[
                    const Text(
                      'No dynamic alerts yet. Use buttons below to create some!',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                  ],

                  // Control buttons
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      FlutstrapButton(
                        onPressed: _addSuccessAlert,
                        text: 'Add Success Alert',
                        variant: FSButtonVariant.success,
                        size: FSButtonSize.sm,
                      ),
                      FlutstrapButton(
                        onPressed: _addWarningAlert,
                        text: 'Add Warning Alert',
                        variant: FSButtonVariant.warning,
                        size: FSButtonSize.sm,
                      ),
                      FlutstrapButton(
                        onPressed: _addErrorAlert,
                        text: 'Add Error Alert',
                        variant: FSButtonVariant.danger,
                        size: FSButtonSize.sm,
                      ),
                      FlutstrapButton(
                        onPressed: _clearAllAlerts,
                        text: 'Clear All',
                        variant: FSButtonVariant.outlineDanger,
                        size: FSButtonSize.sm,
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Stats
                  Text(
                    'Active alerts: ${_dynamicAlerts.length}',
                    style: Theme.of(context).textTheme.bodyMedium,
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

  /// Build alert with code example
  Widget _buildAlertWithCode(BuildContext context, Widget alert, String code) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        alert,
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            code,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontFamily: 'Monospace',
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
        ),
      ],
    );
  }

  // ✅ INTERACTION HANDLERS

  void _addSuccessAlert() {
    setState(() {
      _alertCounter++;
      _dynamicAlerts.add(
        FlutstrapAlert(
          title: 'Dynamic Alert #$_alertCounter',
          message: 'This is a dynamically created success alert.',
          variant: FSAlertVariant.success,
          dismissible: true,
          onDismiss: () => _removeAlert(_dynamicAlerts.length - 1),
        ),
      );
    });
    _showSnackbar('Success alert added!');
  }

  void _addWarningAlert() {
    setState(() {
      _alertCounter++;
      _dynamicAlerts.add(
        FlutstrapAlert(
          title: 'Warning #$_alertCounter',
          message: 'This is a dynamically created warning alert.',
          variant: FSAlertVariant.warning,
          dismissible: true,
          onDismiss: () => _removeAlert(_dynamicAlerts.length - 1),
        ),
      );
    });
    _showSnackbar('Warning alert added!');
  }

  void _addErrorAlert() {
    setState(() {
      _alertCounter++;
      _dynamicAlerts.add(
        FlutstrapAlert(
          title: 'Error #$_alertCounter',
          message: 'This is a dynamically created error alert.',
          variant: FSAlertVariant.danger,
          dismissible: true,
          onDismiss: () => _removeAlert(_dynamicAlerts.length - 1),
        ),
      );
    });
    _showSnackbar('Error alert added!');
  }

  void _removeAlert(int index) {
    setState(() {
      if (index >= 0 && index < _dynamicAlerts.length) {
        _dynamicAlerts.removeAt(index);
      }
    });
  }

  void _clearAllAlerts() {
    setState(() {
      _dynamicAlerts.clear();
    });
    _showSnackbar('All alerts cleared!');
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
