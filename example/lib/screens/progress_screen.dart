/// Flutstrap Progress Bars Demo Screen
///
/// Comprehensive demonstration of Flutstrap progress bar components including:
/// - 🎨 All progress variants (primary, success, danger, warning, info, light, dark)
/// - 📏 Multiple sizes (small, medium, large)
/// - ⚡ Advanced features (animated, striped, indeterminate, custom colors)
/// - 📊 Progress groups and stacked progress bars
/// - 🎯 Interactive demonstrations with real-time controls
///
/// Features:
/// - Live interactive progress demonstrations
/// - Code examples for each progress type
/// - State management for dynamic examples
/// - Real-time progress simulation
///
/// {@category Demo}
/// {@category Screens}
/// {@category Feedback}

import 'package:flutter/material.dart';
import 'package:flutstrap/flutstrap.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  /// Route name for navigation
  static const String routeName = '/progress';

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen>
    with SingleTickerProviderStateMixin {
  // ✅ STATE FOR INTERACTIVE EXAMPLES
  double _basicProgress = 25.0;
  double _animatedProgress = 0.0;
  double _customProgress = 50.0;
  bool _isSimulationRunning = false;
  late AnimationController _simulationController;

  // ✅ CONSTANTS FOR PERFORMANCE
  static const EdgeInsets _screenPadding = EdgeInsets.all(16.0);
  static const EdgeInsets _sectionPadding = EdgeInsets.only(bottom: 32.0);
  static const EdgeInsets _demoPadding = EdgeInsets.all(16.0);
  static const double _sectionSpacing = 24.0;
  static const double _itemSpacing = 16.0;

  @override
  void initState() {
    super.initState();

    // ✅ SETUP: Animation controller for progress simulation
    _simulationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..addListener(_updateAnimatedProgress);
  }

  void _updateAnimatedProgress() {
    setState(() {
      _animatedProgress = _simulationController.value * 100;
    });
  }

  void _startProgressSimulation() {
    if (!_isSimulationRunning) {
      setState(() => _isSimulationRunning = true);
      _simulationController.forward(from: 0).then((_) {
        setState(() => _isSimulationRunning = false);
      });
    }
  }

  void _resetProgressSimulation() {
    _simulationController.reset();
    setState(() {
      _animatedProgress = 0.0;
      _isSimulationRunning = false;
    });
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  void dispose() {
    _simulationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress Components'),
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

            // ✅ BASIC PROGRESS BARS
            _buildBasicProgressSection(context),
            const SizedBox(height: _sectionSpacing),

            // ✅ PROGRESS VARIANTS
            _buildProgressVariantsSection(context),
            const SizedBox(height: _sectionSpacing),

            // ✅ PROGRESS SIZES
            _buildProgressSizesSection(context),
            const SizedBox(height: _sectionSpacing),

            // ✅ ANIMATED PROGRESS BARS
            _buildAnimatedProgressSection(context),
            const SizedBox(height: _sectionSpacing),

            // ✅ PROGRESS GROUPS
            _buildProgressGroupsSection(context),
            const SizedBox(height: _sectionSpacing),

            // ✅ CUSTOM PROGRESS BARS
            _buildCustomProgressSection(context),
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
            'Flutstrap Progress Bars',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: _itemSpacing),
          Text(
            'High-performance, customizable progress indicators with Bootstrap-inspired styling. '
            'Progress bars support animations, stripes, custom colors, multiple sizes, '
            'and comprehensive accessibility features.',
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

  /// Build basic progress bars section
  Widget _buildBasicProgressSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Basic Progress Bars',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Simple progress indicators with labels and value display',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: _itemSpacing),
          Card(
            child: Padding(
              padding: _demoPadding,
              child: Column(
                children: [
                  _buildProgressWithCode(
                    context,
                    FlutstrapProgress(
                      value: _basicProgress,
                      variant: FSProgressVariant.primary,
                      label: 'Basic Progress',
                    ),
                    'Basic progress bar with label',
                  ),
                  const SizedBox(height: 16),

                  _buildProgressWithCode(
                    context,
                    FlutstrapProgress(
                      value: _basicProgress,
                      variant: FSProgressVariant.success,
                    ),
                    'Without label (value shown inside bar)',
                  ),
                  const SizedBox(height: 16),

                  _buildProgressWithCode(
                    context,
                    FlutstrapProgress(
                      value: _basicProgress,
                      variant: FSProgressVariant.info,
                      customLabel: Row(
                        children: [
                          const Icon(Icons.download, size: 16),
                          const SizedBox(width: 8),
                          Text('Download: ${_basicProgress.toInt()}%'),
                          const Spacer(),
                          Text(
                            '${(_basicProgress / 100 * 250).toInt()}MB / 250MB',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    'Custom label with additional information',
                  ),

                  const SizedBox(height: 16),

                  // Progress controls
                  _buildProgressControls(
                    'Adjust Progress:',
                    _basicProgress,
                    (value) => setState(() => _basicProgress = value),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build progress variants section
  Widget _buildProgressVariantsSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Progress Variants',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Different color variants for various contexts and semantic meanings',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: _itemSpacing),
          Card(
            child: Padding(
              padding: _demoPadding,
              child: Column(
                children: [
                  _buildVariantProgress(
                      'Primary', FSProgressVariant.primary, 75),
                  const SizedBox(height: 12),
                  _buildVariantProgress(
                      'Success', FSProgressVariant.success, 70),
                  const SizedBox(height: 12),
                  _buildVariantProgress('Danger', FSProgressVariant.danger, 65),
                  const SizedBox(height: 12),
                  _buildVariantProgress(
                      'Warning', FSProgressVariant.warning, 60),
                  const SizedBox(height: 12),
                  _buildVariantProgress('Info', FSProgressVariant.info, 55),
                  const SizedBox(height: 12),
                  _buildVariantProgress('Light', FSProgressVariant.light, 50),
                  const SizedBox(height: 12),
                  _buildVariantProgress('Dark', FSProgressVariant.dark, 45),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build progress sizes section
  Widget _buildProgressSizesSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Progress Sizes',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Different sizes for various UI contexts and visual prominence',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: _itemSpacing),
          Card(
            child: Padding(
              padding: _demoPadding,
              child: Column(
                children: [
                  _buildSizeProgress('Small (4px)', FSProgressSize.sm, 80),
                  const SizedBox(height: 16),
                  _buildSizeProgress('Medium (8px)', FSProgressSize.md, 80),
                  const SizedBox(height: 16),
                  _buildSizeProgress('Large (12px)', FSProgressSize.lg, 80),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build animated progress section
  Widget _buildAnimatedProgressSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Animated Progress Bars',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Progress bars with smooth animations and visual effects',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: _itemSpacing),
          Card(
            child: Padding(
              padding: _demoPadding,
              child: Column(
                children: [
                  _buildProgressWithCode(
                    context,
                    FlutstrapProgress(
                      value: _animatedProgress,
                      variant: FSProgressVariant.primary,
                      animated: true,
                      label: 'Animated Progress',
                    ),
                    'Smooth animation on value change',
                  ),
                  const SizedBox(height: 16),

                  _buildProgressWithCode(
                    context,
                    FlutstrapProgress(
                      value: _animatedProgress,
                      variant: FSProgressVariant.success,
                      animated: true,
                      striped: true,
                      label: 'Animated Stripes',
                    ),
                    'Striped pattern with animation',
                  ),
                  const SizedBox(height: 16),

                  _buildProgressWithCode(
                    context,
                    const FlutstrapProgress.indeterminate(
                      variant: FSProgressVariant.info,
                      label: 'Indeterminate Progress',
                    ),
                    'Indeterminate state for unknown duration',
                  ),

                  const SizedBox(height: 16),

                  // Simulation controls
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Progress: ${_animatedProgress.toInt()}%',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 4),
                            LinearProgressIndicator(
                              value: _animatedProgress / 100,
                              backgroundColor:
                                  Theme.of(context).colorScheme.surfaceVariant,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Wrap(
                        spacing: 8,
                        children: [
                          FlutstrapButton(
                            onPressed: _isSimulationRunning
                                ? null
                                : _startProgressSimulation,
                            text: _isSimulationRunning
                                ? 'Running...'
                                : 'Start Simulation',
                            size: FSButtonSize.sm,
                            variant: _isSimulationRunning
                                ? FSButtonVariant.secondary
                                : FSButtonVariant.primary,
                          ),
                          FlutstrapButton(
                            onPressed: _resetProgressSimulation,
                            text: 'Reset',
                            size: FSButtonSize.sm,
                            variant: FSButtonVariant.outlineDanger,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build progress groups section
  Widget _buildProgressGroupsSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Progress Groups',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Multiple progress bars grouped together for related tasks',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: _itemSpacing),
          Card(
            child: Padding(
              padding: _demoPadding,
              child: Column(
                children: [
                  _buildProgressWithCode(
                    context,
                    FlutstrapProgressGroup(
                      children: [
                        FlutstrapProgress(
                          value: 25,
                          variant: FSProgressVariant.primary,
                          label: 'Frontend',
                        ),
                        FlutstrapProgress(
                          value: 50,
                          variant: FSProgressVariant.success,
                          label: 'Backend',
                        ),
                        FlutstrapProgress(
                          value: 75,
                          variant: FSProgressVariant.warning,
                          label: 'Database',
                        ),
                        FlutstrapProgress(
                          value: 90,
                          variant: FSProgressVariant.info,
                          label: 'Testing',
                        ),
                      ],
                      spacing: 12,
                    ),
                    'Progress group with different tasks',
                  ),
                  const SizedBox(height: 16),
                  _buildProgressWithCode(
                    context,
                    FlutstrapProgressGroup(
                      children: [
                        FlutstrapProgress(
                          value: 40,
                          variant: FSProgressVariant.primary,
                          animated: true,
                          label: 'Step 1: Analysis',
                        ),
                        FlutstrapProgress(
                          value: 60,
                          variant: FSProgressVariant.success,
                          animated: true,
                          label: 'Step 2: Development',
                        ),
                        FlutstrapProgress(
                          value: 30,
                          variant: FSProgressVariant.warning,
                          animated: true,
                          label: 'Step 3: Testing',
                        ),
                        FlutstrapProgress(
                          value: 10,
                          variant: FSProgressVariant.info,
                          animated: true,
                          label: 'Step 4: Deployment',
                        ),
                      ],
                    ),
                    'Animated progress group',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build custom progress section
  Widget _buildCustomProgressSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Custom Progress Bars',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Progress bars with custom colors, fixed widths, and advanced styling',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: _itemSpacing),
          Card(
            child: Padding(
              padding: _demoPadding,
              child: Column(
                children: [
                  _buildProgressWithCode(
                    context,
                    FlutstrapProgress(
                      value: _customProgress,
                      progressColor: Colors.purple,
                      backgroundColor: Colors.purple.withOpacity(0.2),
                      height: 16,
                      borderRadius: BorderRadius.circular(8),
                      label: 'Custom Colors & Height',
                    ),
                    'Custom colors and rounded corners',
                  ),
                  const SizedBox(height: 16),

                  _buildProgressWithCode(
                    context,
                    FlutstrapProgress(
                      value: _customProgress,
                      fixedWidth: 200,
                      expandToFill: false,
                      variant: FSProgressVariant.success,
                      label: 'Fixed Width Progress',
                    ),
                    'Fixed width (200px) without expansion',
                  ),
                  const SizedBox(height: 16),

                  _buildProgressWithCode(
                    context,
                    FlutstrapProgress(
                      value: _customProgress,
                      variant: FSProgressVariant.warning,
                      animated: true,
                      striped: true,
                      animationDuration: const Duration(milliseconds: 2000),
                      animationCurve: Curves.bounceOut,
                      label: 'Custom Animation',
                    ),
                    'Custom animation duration and curve',
                  ),

                  const SizedBox(height: 16),

                  // Custom progress controls
                  _buildProgressControls(
                    'Adjust Custom Progress:',
                    _customProgress,
                    (value) => setState(() => _customProgress = value),
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
            'Test progress bar features with real-time controls and feedback',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: _itemSpacing),
          Card(
            child: Padding(
              padding: _demoPadding,
              child: Column(
                children: [
                  // Current progress display
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Current Progress Values:',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        Text('Basic: ${_basicProgress.toInt()}%'),
                        Text('Animated: ${_animatedProgress.toInt()}%'),
                        Text('Custom: ${_customProgress.toInt()}%'),
                        Text(
                            'Simulation: ${_isSimulationRunning ? 'Running' : 'Stopped'}'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Demo progress bars
                  FlutstrapProgress(
                    value: _basicProgress,
                    variant: FSProgressVariant.primary,
                    animated: true,
                    label: 'Live Demo Progress',
                  ),

                  const SizedBox(height: 16),

                  // Control buttons
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      FlutstrapButton(
                        onPressed: () {
                          setState(() {
                            _basicProgress = 0;
                            _customProgress = 0;
                          });
                          _resetProgressSimulation();
                          _showSnackbar('All progress reset');
                        },
                        text: 'Reset All',
                        size: FSButtonSize.sm,
                        variant: FSButtonVariant.outlineDanger,
                      ),
                      FlutstrapButton(
                        onPressed: () {
                          setState(() {
                            _basicProgress = 100;
                            _customProgress = 100;
                          });
                          _showSnackbar('All progress set to 100%');
                        },
                        text: 'Set to 100%',
                        size: FSButtonSize.sm,
                        variant: FSButtonVariant.outlineSuccess,
                      ),
                      FlutstrapButton(
                        onPressed: () {
                          final random = DateTime.now().millisecond % 100;
                          setState(() {
                            _basicProgress = random.toDouble();
                            _customProgress = (100 - random).toDouble();
                          });
                          _showSnackbar('Random progress applied');
                        },
                        text: 'Randomize',
                        size: FSButtonSize.sm,
                        variant: FSButtonVariant.outlinePrimary,
                      ),
                    ],
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

  /// Build progress with code example
  Widget _buildProgressWithCode(
      BuildContext context, Widget progress, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        progress,
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            description,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
        ),
      ],
    );
  }

  /// Build variant progress
  Widget _buildVariantProgress(
      String label, FSProgressVariant variant, double value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 4),
        FlutstrapProgress(
          value: value,
          variant: variant,
        ),
      ],
    );
  }

  /// Build size progress
  Widget _buildSizeProgress(String label, FSProgressSize size, double value) {
    return Row(
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
          child: FlutstrapProgress(
            value: value,
            size: size,
            variant: FSProgressVariant.primary,
          ),
        ),
      ],
    );
  }

  /// Build progress controls
  Widget _buildProgressControls(
      String label, double value, ValueChanged<double> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Slider(
          value: value,
          min: 0,
          max: 100,
          divisions: 100,
          onChanged: onChanged,
          label: value.round().toString(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '0%',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              '${value.toInt()}%',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Text(
              '100%',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ],
    );
  }
}
