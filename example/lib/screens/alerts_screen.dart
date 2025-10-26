import 'package:flutter/material.dart';
import 'package:master_flutstrap/flutstrap.dart';

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  final List<Widget> _activeAlerts = [];
  int _notificationCount = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alerts & Badges'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          // Badge example in app bar
          FlutstrapBadgePositioned(
            child: IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: _showNotification,
            ),
            badge: FlutstrapBadge.count(
              count: _notificationCount,
              variant: FSBadgeVariant.danger,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(context, 'Alert Variants'),
            _buildAlertVariantsSection(context),
            const SizedBox(height: 32),
            _buildSectionTitle(context, 'Interactive Alerts'),
            ..._activeAlerts,
            _buildInteractiveAlertsSection(context),
            const SizedBox(height: 32),
            _buildSectionTitle(context, 'Badge Types'),
            _buildBadgeTypesSection(context),
            const SizedBox(height: 32),
            _buildSectionTitle(context, 'Badge Positioning'),
            _buildBadgePositioningSection(context),
            const SizedBox(height: 32),
            _buildSectionTitle(context, 'Real-world Examples'),
            _buildRealWorldExamplesSection(context),
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

  Widget _buildAlertVariantsSection(BuildContext context) {
    return Column(
      children: [
        FlutstrapAlert(
          title: 'Primary Alert',
          message: 'This is a primary alert with important information.',
          variant: FSAlertVariant.primary,
          dismissible: true,
          onDismiss: () {},
        ),
        const SizedBox(height: 12),
        FlutstrapAlert(
          title: 'Success Alert',
          message: 'Operation completed successfully!',
          variant: FSAlertVariant.success,
          dismissible: true,
          onDismiss: () {},
        ),
        const SizedBox(height: 12),
        FlutstrapAlert(
          title: 'Danger Alert',
          message: 'There was a problem with your request.',
          variant: FSAlertVariant.danger,
          dismissible: true,
          onDismiss: () {},
        ),
        const SizedBox(height: 12),
        FlutstrapAlert(
          title: 'Warning Alert',
          message: 'Please check your input and try again.',
          variant: FSAlertVariant.warning,
          dismissible: true,
          onDismiss: () {},
        ),
        const SizedBox(height: 12),
        FlutstrapAlert(
          title: 'Info Alert',
          message: 'New features are available in the latest update.',
          variant: FSAlertVariant.info,
          dismissible: true,
          onDismiss: () {},
        ),
        const SizedBox(height: 12),
        FlutstrapAlert(
          message: 'Simple alert without a title for less important messages.',
          variant: FSAlertVariant.secondary,
          dismissible: true,
          onDismiss: () {},
        ),
      ],
    );
  }

  Widget _buildInteractiveAlertsSection(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            FlutstrapButton(
              onPressed: _showSuccessAlert,
              text: 'Show Success',
              variant: FSButtonVariant.success,
              size: FSButtonSize.sm,
            ),
            FlutstrapButton(
              onPressed: _showErrorAlert,
              text: 'Show Error',
              variant: FSButtonVariant.danger,
              size: FSButtonSize.sm,
            ),
            FlutstrapButton(
              onPressed: _showAutoDismissAlert,
              text: 'Auto Dismiss',
              variant: FSButtonVariant.warning,
              size: FSButtonSize.sm,
            ),
            FlutstrapButton(
              onPressed: _clearAlerts,
              text: 'Clear All',
              variant: FSButtonVariant.outlineDanger,
              size: FSButtonSize.sm,
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Click buttons above to add interactive alerts',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
        ),
      ],
    );
  }

  Widget _buildBadgeTypesSection(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        FlutstrapBadge(
          text: 'Default',
          variant: FSBadgeVariant.primary,
        ),
        FlutstrapBadge(
          text: 'Success',
          variant: FSBadgeVariant.success,
        ),
        FlutstrapBadge(
          text: 'Danger',
          variant: FSBadgeVariant.danger,
        ),
        FlutstrapBadge(
          text: 'Warning',
          variant: FSBadgeVariant.warning,
        ),
        FlutstrapBadge(
          text: 'Info',
          variant: FSBadgeVariant.info,
        ),
        FlutstrapBadge(
          text: 'Light',
          variant: FSBadgeVariant.light,
        ),
        FlutstrapBadge(
          text: 'Dark',
          variant: FSBadgeVariant.dark,
        ),
        const SizedBox(height: 8),
        FlutstrapBadge.count(
          count: 5,
          variant: FSBadgeVariant.primary,
        ),
        FlutstrapBadge.count(
          count: 23,
          variant: FSBadgeVariant.success,
        ),
        FlutstrapBadge.count(
          count: 99,
          variant: FSBadgeVariant.danger,
        ),
        FlutstrapBadge.count(
          count: 150,
          maxCount: 99,
          variant: FSBadgeVariant.warning,
        ),
        const SizedBox(height: 8),
        FlutstrapBadge.dot(
          variant: FSBadgeVariant.danger,
        ),
        FlutstrapBadge.dot(
          variant: FSBadgeVariant.success,
        ),
        FlutstrapBadge.dot(
          variant: FSBadgeVariant.warning,
        ),
        const SizedBox(height: 8),
        FlutstrapBadge(
          text: 'Pill',
          variant: FSBadgeVariant.primary,
          pill: true,
        ),
        FlutstrapBadge(
          text: 'Rounded',
          variant: FSBadgeVariant.success,
          pill: true,
        ),
      ],
    );
  }

  Widget _buildBadgePositioningSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Badges on Icons',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 20,
          children: [
            FlutstrapBadgePositioned(
              child: Icon(
                Icons.shopping_cart,
                size: 32,
                color: Theme.of(context).colorScheme.primary,
              ),
              badge: FlutstrapBadge.count(
                count: 3,
                variant: FSBadgeVariant.danger,
              ),
            ),
            FlutstrapBadgePositioned(
              child: Icon(
                Icons.email,
                size: 32,
                color: Theme.of(context).colorScheme.secondary,
              ),
              badge: FlutstrapBadge.dot(
                variant: FSBadgeVariant.success,
              ),
            ),
            FlutstrapBadgePositioned(
              child: Icon(
                Icons.notifications,
                size: 32,
                color: Theme.of(context).colorScheme.tertiary,
              ),
              badge: FlutstrapBadge.count(
                count: 12,
                variant: FSBadgeVariant.warning,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          'Badges on Buttons',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            FlutstrapBadgePositioned(
              child: FlutstrapButton(
                onPressed: () {},
                text: 'Inbox',
                variant: FSButtonVariant.primary,
                size: FSButtonSize.sm,
              ),
              badge: FlutstrapBadge.count(
                count: 5,
                variant: FSBadgeVariant.danger,
              ),
            ),
            FlutstrapBadgePositioned(
              child: FlutstrapButton(
                onPressed: () {},
                text: 'Messages',
                variant: FSButtonVariant.outlinePrimary,
                size: FSButtonSize.sm,
              ),
              badge: FlutstrapBadge.count(
                count: 23,
                variant: FSBadgeVariant.success,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          'Badges on Avatars',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 20,
          children: [
            FlutstrapBadgePositioned(
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: const Text('JD', style: TextStyle(color: Colors.white)),
              ),
              badge: FlutstrapBadge.dot(
                variant: FSBadgeVariant.success,
              ),
            ),
            FlutstrapBadgePositioned(
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Theme.of(context).colorScheme.secondary,
                child: const Text('AS', style: TextStyle(color: Colors.white)),
              ),
              badge: FlutstrapBadge.dot(
                variant: FSBadgeVariant.danger,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRealWorldExamplesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FlutstrapCard(
          headerText: 'Notification Center',
          body: Column(
            children: [
              ListTile(
                leading: FlutstrapBadgePositioned(
                  child: const Icon(Icons.message),
                  badge: FlutstrapBadge.count(
                    count: 5,
                    variant: FSBadgeVariant.primary,
                  ),
                ),
                title: const Text('Messages'),
                subtitle: const Text('You have unread messages'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
              const Divider(),
              ListTile(
                leading: FlutstrapBadgePositioned(
                  child: const Icon(Icons.notifications),
                  badge: FlutstrapBadge.count(
                    count: 12,
                    variant: FSBadgeVariant.warning,
                  ),
                ),
                title: const Text('Notifications'),
                subtitle: const Text('New notifications available'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
              const Divider(),
              ListTile(
                leading: FlutstrapBadgePositioned(
                  child: const Icon(Icons.shopping_cart),
                  badge: FlutstrapBadge.dot(
                    variant: FSBadgeVariant.success,
                  ),
                ),
                title: const Text('Cart'),
                subtitle: const Text('Items ready for checkout'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        FlutstrapCard(
          headerText: 'Status Indicators',
          body: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _buildStatusItem(context, 'Online', FSBadgeVariant.success),
              _buildStatusItem(context, 'Away', FSBadgeVariant.warning),
              _buildStatusItem(context, 'Busy', FSBadgeVariant.danger),
              _buildStatusItem(context, 'Offline', FSBadgeVariant.secondary),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatusItem(
      BuildContext context, String status, FSBadgeVariant variant) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        FlutstrapBadge.dot(variant: variant),
        const SizedBox(width: 8),
        Text(status),
      ],
    );
  }

  // Fixed interactive alert methods using a different approach
  void _showSuccessAlert() {
    final key = GlobalKey();

    final alertWidget = Column(
      key: key,
      children: [
        FlutstrapAlert(
          title: 'Success!',
          message: 'Your action was completed successfully!',
          variant: FSAlertVariant.success,
          dismissible: true,
          onDismiss: () {
            setState(() {
              _activeAlerts.removeWhere((element) => element.key == key);
            });
          },
        ),
        const SizedBox(height: 8),
      ],
    );

    setState(() {
      _activeAlerts.add(alertWidget);
    });
  }

  void _showErrorAlert() {
    final key = GlobalKey();

    final alertWidget = Column(
      key: key,
      children: [
        FlutstrapAlert(
          title: 'Error!',
          message: 'Something went wrong. Please try again.',
          variant: FSAlertVariant.danger,
          dismissible: true,
          onDismiss: () {
            setState(() {
              _activeAlerts.removeWhere((element) => element.key == key);
            });
          },
        ),
        const SizedBox(height: 8),
      ],
    );

    setState(() {
      _activeAlerts.add(alertWidget);
    });
  }

  void _showAutoDismissAlert() {
    final key = GlobalKey();

    final alertWidget = Column(
      key: key,
      children: [
        FlutstrapAlert(
          message: 'This alert will disappear in 3 seconds...',
          variant: FSAlertVariant.info,
          autoDismissDuration: const Duration(seconds: 3),
          onDismiss: () {
            setState(() {
              _activeAlerts.removeWhere((element) => element.key == key);
            });
          },
        ),
        const SizedBox(height: 8),
      ],
    );

    setState(() {
      _activeAlerts.add(alertWidget);
    });
  }

  void _clearAlerts() {
    setState(() {
      _activeAlerts.clear();
    });
  }

  void _showNotification() {
    setState(() {
      _notificationCount++;
    });

    final key = GlobalKey();

    final alertWidget = Column(
      key: key,
      children: [
        FlutstrapAlert(
          title: 'New Notification',
          message: 'You have $_notificationCount unread notifications',
          variant: FSAlertVariant.info,
          autoDismissDuration: const Duration(seconds: 2),
          onDismiss: () {
            setState(() {
              _activeAlerts.removeWhere((element) => element.key == key);
            });
          },
        ),
        const SizedBox(height: 8),
      ],
    );

    setState(() {
      _activeAlerts.add(alertWidget);
    });
  }
}
