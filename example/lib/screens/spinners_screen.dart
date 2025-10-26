import 'package:flutter/material.dart';
import 'package:master_flutstrap/flutstrap.dart';

class SpinnersScreen extends StatefulWidget {
  const SpinnersScreen({super.key});

  @override
  State<SpinnersScreen> createState() => _SpinnersScreenState();
}

class _SpinnersScreenState extends State<SpinnersScreen> {
  bool _isLoading = false;
  bool _isButtonLoading = false;
  bool _showOverlaySpinner = false;

  void _toggleLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  void _simulateButtonAction() async {
    setState(() {
      _isButtonLoading = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        _isButtonLoading = false;
      });
    }
  }

  void _showOverlayLoader() {
    setState(() {
      _showOverlaySpinner = true;
    });

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _showOverlaySpinner = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spinners'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle(context, 'Spinner Types'),
                _buildSpinnerTypesSection(context),
                const SizedBox(height: 32),
                _buildSectionTitle(context, 'Spinner Variants'),
                _buildSpinnerVariantsSection(context),
                const SizedBox(height: 32),
                _buildSectionTitle(context, 'Spinner Sizes'),
                _buildSpinnerSizesSection(context),
                const SizedBox(height: 32),
                _buildSectionTitle(context, 'With Labels'),
                _buildSpinnerWithLabelsSection(context),
                const SizedBox(height: 32),
                _buildSectionTitle(context, 'Interactive Examples'),
                _buildInteractiveExamplesSection(context),
                const SizedBox(height: 32),
                _buildSectionTitle(context, 'Real-world Usage'),
                _buildRealWorldExamplesSection(context),
                const SizedBox(height: 32),
              ],
            ),
          ),

          // Overlay spinner
          if (_showOverlaySpinner)
            Container(
              color: Colors.black54,
              child: const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FlutstrapSpinner(
                      size: FSSpinnerSize.lg,
                      variant: FSSpinnerVariant.light,
                      centered: true,
                      label: 'Loading...',
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Please wait',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
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

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }

  Widget _buildSpinnerTypesSection(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 40,
          runSpacing: 20,
          alignment: WrapAlignment.spaceAround,
          children: [
            _buildSpinnerCard(
              context,
              'Border Spinner',
              'Classic rotating border',
              const FlutstrapSpinner(
                type: FSSpinnerType.border,
                variant: FSSpinnerVariant.primary,
              ),
            ),
            _buildSpinnerCard(
              context,
              'Growing Spinner',
              'Pulsing circle animation',
              const FlutstrapSpinner(
                type: FSSpinnerType.growing,
                variant: FSSpinnerVariant.success,
              ),
            ),
            _buildSpinnerCard(
              context,
              'Dots Spinner',
              'Bouncing dots animation',
              const FlutstrapSpinner(
                type: FSSpinnerType.dots,
                variant: FSSpinnerVariant.danger,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSpinnerVariantsSection(BuildContext context) {
    final variants = FSSpinnerVariant.values;

    return Wrap(
      spacing: 20,
      runSpacing: 20,
      alignment: WrapAlignment.start,
      children: variants.map((variant) {
        return _buildSpinnerCard(
          context,
          _getVariantName(variant),
          '${_getVariantName(variant)} variant',
          FlutstrapSpinner(
            type: FSSpinnerType.border,
            variant: variant,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSpinnerSizesSection(BuildContext context) {
    return Wrap(
      spacing: 40,
      runSpacing: 20,
      alignment: WrapAlignment.spaceAround,
      children: [
        _buildSpinnerCard(
          context,
          'Small',
          'Compact size',
          const FlutstrapSpinner(
            size: FSSpinnerSize.sm,
            variant: FSSpinnerVariant.primary,
          ),
        ),
        _buildSpinnerCard(
          context,
          'Medium',
          'Default size',
          const FlutstrapSpinner(
            size: FSSpinnerSize.md,
            variant: FSSpinnerVariant.primary,
          ),
        ),
        _buildSpinnerCard(
          context,
          'Large',
          'Prominent size',
          const FlutstrapSpinner(
            size: FSSpinnerSize.lg,
            variant: FSSpinnerVariant.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildSpinnerWithLabelsSection(BuildContext context) {
    return Column(
      children: [
        FlutstrapSpinner(
          variant: FSSpinnerVariant.primary,
          label: 'Loading data...',
          centered: true,
        ),
        const SizedBox(height: 20),
        FlutstrapSpinner(
          variant: FSSpinnerVariant.success,
          customLabel: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.cloud_download, size: 16, color: Colors.green),
              const SizedBox(width: 8),
              Text(
                'Downloading files...',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
          centered: true,
        ),
        const SizedBox(height: 20),
        FlutstrapSpinner(
          variant: FSSpinnerVariant.warning,
          label: 'Processing request...',
          type: FSSpinnerType.growing,
          centered: true,
        ),
      ],
    );
  }

  Widget _buildInteractiveExamplesSection(BuildContext context) {
    return Column(
      children: [
        // Toggle spinner example
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Text(
                  'Toggle Spinner',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 16),
                _isLoading
                    ? const FlutstrapSpinner(
                        variant: FSSpinnerVariant.info,
                        label: 'Loading content...',
                        centered: true,
                      )
                    : const Text(
                        'Content loaded successfully!',
                        style: TextStyle(color: Colors.grey),
                      ),
                const SizedBox(height: 16),
                FlutstrapButton(
                  onPressed: _toggleLoading,
                  text: _isLoading ? 'Stop Loading' : 'Start Loading',
                  variant: _isLoading
                      ? FSButtonVariant.secondary
                      : FSButtonVariant.primary,
                  size: FSButtonSize.sm,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Button with spinner example - FIXED VERSION
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Text(
                  'Loading Button',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 16),
                // Using Row to manually create button with icon and spinner
                Container(
                  decoration: BoxDecoration(
                    color: _isButtonLoading
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: _isButtonLoading ? null : _simulateButtonAction,
                      borderRadius: BorderRadius.circular(6),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (_isButtonLoading)
                              const Padding(
                                padding: EdgeInsets.only(right: 8),
                                child: FlutstrapSpinner(
                                  size: FSSpinnerSize.sm,
                                  variant: FSSpinnerVariant.light,
                                ),
                              )
                            else
                              const Padding(
                                padding: EdgeInsets.only(right: 8),
                                child: Icon(Icons.send,
                                    size: 16, color: Colors.white),
                              ),
                            Text(
                              _isButtonLoading
                                  ? 'Processing...'
                                  : 'Submit Data',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _isButtonLoading
                      ? 'Please wait while we process your request...'
                      : 'Click to simulate an API call',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey,
                      ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRealWorldExamplesSection(BuildContext context) {
    return Column(
      children: [
        // Content loading example
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Content Loading State',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: _isLoading
                      ? const Center(
                          child: FlutstrapSpinner(
                            variant: FSSpinnerVariant.primary,
                            label: 'Loading content...',
                            centered: true,
                          ),
                        )
                      : const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.article, size: 32, color: Colors.grey),
                              SizedBox(height: 8),
                              Text('Content loaded successfully!'),
                            ],
                          ),
                        ),
                ),
                const SizedBox(height: 12),
                FlutstrapButton(
                  onPressed: _toggleLoading,
                  text: _isLoading ? 'Hide Content' : 'Load Content',
                  size: FSButtonSize.sm,
                  variant: FSButtonVariant.outlinePrimary,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Page overlay example
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Text(
                  'Full Page Loader',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Simulates a full-page loading overlay',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                FlutstrapButton(
                  onPressed: _showOverlayLoader,
                  text: 'Show Overlay Loader',
                  variant: FSButtonVariant.warning,
                  size: FSButtonSize.sm,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Inline loading example
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Inline Loading States',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                _buildInlineLoadingExample(context),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInlineLoadingExample(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text('User Profile'),
          trailing: _isLoading
              ? const FlutstrapSpinner(size: FSSpinnerSize.sm)
              : const Icon(Icons.chevron_right),
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Settings'),
          trailing: _isLoading
              ? const FlutstrapSpinner(size: FSSpinnerSize.sm)
              : const Icon(Icons.chevron_right),
        ),
        ListTile(
          leading: const Icon(Icons.help),
          title: const Text('Help & Support'),
          trailing: _isLoading
              ? const FlutstrapSpinner(size: FSSpinnerSize.sm)
              : const Icon(Icons.chevron_right),
        ),
      ],
    );
  }

  Widget _buildSpinnerCard(
    BuildContext context,
    String title,
    String description,
    FlutstrapSpinner spinner,
  ) {
    return Container(
      width: 120,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          spinner,
          const SizedBox(height: 12),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  String _getVariantName(FSSpinnerVariant variant) {
    switch (variant) {
      case FSSpinnerVariant.primary:
        return 'Primary';
      case FSSpinnerVariant.secondary:
        return 'Secondary';
      case FSSpinnerVariant.success:
        return 'Success';
      case FSSpinnerVariant.danger:
        return 'Danger';
      case FSSpinnerVariant.warning:
        return 'Warning';
      case FSSpinnerVariant.info:
        return 'Info';
      case FSSpinnerVariant.light:
        return 'Light';
      case FSSpinnerVariant.dark:
        return 'Dark';
    }
  }
}
