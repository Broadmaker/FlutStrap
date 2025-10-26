import 'package:flutter/material.dart';
import 'package:master_flutstrap/flutstrap.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  double _basicProgress = 25.0;
  double _animatedProgress = 0.0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    // Simulate progress updates
    _simulateProgress();
  }

  void _simulateProgress() async {
    while (true) {
      await Future.delayed(const Duration(milliseconds: 100));
      if (mounted) {
        setState(() {
          _animatedProgress = (_animatedProgress + 2) % 100;
        });
      }
    }
  }

  void _startLoading() {
    setState(() {
      _isLoading = true;
    });
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress Bars'),
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
            _buildSectionTitle(context, 'Basic Progress Bars'),
            _buildBasicProgressSection(context),
            const SizedBox(height: 32),
            _buildSectionTitle(context, 'Progress Variants'),
            _buildVariantProgressSection(context),
            const SizedBox(height: 32),
            _buildSectionTitle(context, 'Progress Sizes'),
            _buildSizeProgressSection(context),
            const SizedBox(height: 32),
            _buildSectionTitle(context, 'Animated Progress'),
            _buildAnimatedProgressSection(context),
            const SizedBox(height: 32),
            _buildSectionTitle(context, 'Special Effects'),
            _buildSpecialEffectsSection(context),
            const SizedBox(height: 32),
            _buildSectionTitle(context, 'Progress Groups'),
            _buildProgressGroupSection(context),
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

  Widget _buildBasicProgressSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Basic Progress Bar: ${_basicProgress.toInt()}%',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 8),
        FlutstrapProgress(
          value: _basicProgress,
          label: 'Loading...',
        ),
        const SizedBox(height: 16),
        Slider(
          value: _basicProgress,
          min: 0,
          max: 100,
          onChanged: (value) {
            setState(() {
              _basicProgress = value;
            });
          },
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: [
            FlutstrapButton(
              onPressed: () => setState(() => _basicProgress = 0),
              text: '0%',
              size: FSButtonSize.sm,
              variant: FSButtonVariant.outlinePrimary,
            ),
            FlutstrapButton(
              onPressed: () => setState(() => _basicProgress = 25),
              text: '25%',
              size: FSButtonSize.sm,
              variant: FSButtonVariant.outlinePrimary,
            ),
            FlutstrapButton(
              onPressed: () => setState(() => _basicProgress = 50),
              text: '50%',
              size: FSButtonSize.sm,
              variant: FSButtonVariant.outlinePrimary,
            ),
            FlutstrapButton(
              onPressed: () => setState(() => _basicProgress = 75),
              text: '75%',
              size: FSButtonSize.sm,
              variant: FSButtonVariant.outlinePrimary,
            ),
            FlutstrapButton(
              onPressed: () => setState(() => _basicProgress = 100),
              text: '100%',
              size: FSButtonSize.sm,
              variant: FSButtonVariant.outlinePrimary,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildVariantProgressSection(BuildContext context) {
    final variants = FSProgressVariant.values;

    return Column(
      children: [
        for (final variant in variants)
          Column(
            children: [
              FlutstrapProgress(
                value: 65,
                variant: variant,
                label: '${_getVariantName(variant)} Variant',
              ),
              const SizedBox(height: 16),
            ],
          ),
      ],
    );
  }

  Widget _buildSizeProgressSection(BuildContext context) {
    return Column(
      children: [
        FlutstrapProgress(
          value: 40,
          size: FSProgressSize.sm,
          label: 'Small Size',
        ),
        const SizedBox(height: 16),
        FlutstrapProgress(
          value: 40,
          size: FSProgressSize.md,
          label: 'Medium Size (Default)',
        ),
        const SizedBox(height: 16),
        FlutstrapProgress(
          value: 40,
          size: FSProgressSize.lg,
          label: 'Large Size',
        ),
      ],
    );
  }

  Widget _buildAnimatedProgressSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Live Progress: ${_animatedProgress.toInt()}%',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 8),
        FlutstrapProgress(
          value: _animatedProgress,
          animated: true,
          label: 'Uploading files...',
        ),
        const SizedBox(height: 16),
        FlutstrapProgress(
          value: 75,
          animated: true,
          striped: true,
          label: 'Animated with stripes',
          variant: FSProgressVariant.success,
        ),
        const SizedBox(height: 16),
        const FlutstrapProgress.indeterminate(
          label: 'Indeterminate progress',
          variant: FSProgressVariant.warning,
        ),
      ],
    );
  }

  Widget _buildSpecialEffectsSection(BuildContext context) {
    return Column(
      children: [
        FlutstrapProgress(
          value: 80,
          striped: true,
          label: 'Striped effect',
          variant: FSProgressVariant.info,
        ),
        const SizedBox(height: 16),
        FlutstrapProgress(
          value: 60,
          animated: true,
          striped: true,
          label: 'Animated stripes',
          variant: FSProgressVariant.danger,
        ),
        const SizedBox(height: 16),
        FlutstrapProgress(
          value: 90,
          label: 'Custom colors',
          backgroundColor: Colors.grey[200],
          progressColor: Colors.purple,
          customLabel: Row(
            children: [
              Icon(Icons.cloud_upload, size: 16, color: Colors.purple),
              const SizedBox(width: 8),
              Text(
                'Custom Styled Progress',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.purple,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProgressGroupSection(BuildContext context) {
    return Column(
      children: [
        FlutstrapProgressGroup(
          children: [
            FlutstrapProgress(
              value: 25,
              label: 'Frontend Development',
              variant: FSProgressVariant.primary,
            ),
            FlutstrapProgress(
              value: 50,
              label: 'Backend Development',
              variant: FSProgressVariant.success,
            ),
            FlutstrapProgress(
              value: 75,
              label: 'Testing',
              variant: FSProgressVariant.warning,
            ),
            FlutstrapProgress(
              value: 90,
              label: 'Deployment',
              variant: FSProgressVariant.info,
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color:
                Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Project Completion Status',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              Text(
                'Use FlutstrapProgressGroup to display multiple related progress bars together.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRealWorldExamplesSection(BuildContext context) {
    return Column(
      children: [
        // File Upload Example
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'File Upload',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                FlutstrapProgress(
                  value: 65,
                  animated: true,
                  striped: true,
                  label: 'document.pdf - 65%',
                  variant: FSProgressVariant.primary,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '4.2 MB / 6.5 MB',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      '2.3 MB/s',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Storage Usage Example
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Storage Usage',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                FlutstrapProgressGroup(
                  children: [
                    FlutstrapProgress(
                      value: 45,
                      label: 'Photos (4.5 GB)',
                      variant: FSProgressVariant.primary,
                    ),
                    FlutstrapProgress(
                      value: 25,
                      label: 'Documents (2.5 GB)',
                      variant: FSProgressVariant.success,
                    ),
                    FlutstrapProgress(
                      value: 15,
                      label: 'Apps (1.5 GB)',
                      variant: FSProgressVariant.warning,
                    ),
                    FlutstrapProgress(
                      value: 15,
                      label: 'Other (1.5 GB)',
                      variant: FSProgressVariant.info,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Loading State Example
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Processing Request',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                FlutstrapProgress(
                  value: _isLoading ? _animatedProgress : 0,
                  animated: true,
                  label: _isLoading ? 'Processing...' : 'Ready to process',
                  variant: _isLoading
                      ? FSProgressVariant.success
                      : FSProgressVariant.secondary,
                ),
                const SizedBox(height: 12),
                FlutstrapButton(
                  onPressed: _isLoading ? null : _startLoading,
                  text: _isLoading ? 'Processing...' : 'Start Processing',
                  variant: _isLoading
                      ? FSButtonVariant.secondary
                      : FSButtonVariant.primary,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _getVariantName(FSProgressVariant variant) {
    switch (variant) {
      case FSProgressVariant.primary:
        return 'Primary';
      case FSProgressVariant.secondary:
        return 'Secondary';
      case FSProgressVariant.success:
        return 'Success';
      case FSProgressVariant.danger:
        return 'Danger';
      case FSProgressVariant.warning:
        return 'Warning';
      case FSProgressVariant.info:
        return 'Info';
      case FSProgressVariant.light:
        return 'Light';
      case FSProgressVariant.dark:
        return 'Dark';
    }
  }
}
