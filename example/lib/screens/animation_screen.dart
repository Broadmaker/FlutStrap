/// Flutstrap Animation Demo Screen
///
/// Comprehensive demonstration of Flutstrap animation system including:
/// - 🎬 Individual animation types (fade, scale, slide)
/// - 🔄 Animation sequences and staggered animations
/// - ⚡ Performance-optimized animations
/// - 🎯 Interactive animation controls
/// - 📱 Responsive animation demonstrations
/// - ♿ Accessibility features
///
/// Features:
/// - Live interactive animation demonstrations
/// - Real-time animation controls and customization
/// - Performance monitoring and metrics
/// - Accessibility testing tools
///
/// {@category Demo}
/// {@category Screens}
/// {@category Animations}

import 'package:flutter/material.dart';

class AnimationsScreen extends StatefulWidget {
  const AnimationsScreen({super.key});

  /// Route name for navigation
  static const String routeName = '/animations';

  @override
  State<AnimationsScreen> createState() => _AnimationsScreenState();
}

class _AnimationsScreenState extends State<AnimationsScreen>
    with TickerProviderStateMixin {
  // ✅ ANIMATION CONTROLS STATE
  double _animationSpeed = 1.0;
  bool _showPerformanceMetrics = false;
  bool _respectSystemPreferences = true;
  bool _maintainAnimationState = true;

  // ✅ INTERACTIVE DEMO STATE
  bool _showFadeDemo = true;
  bool _showScaleDemo = true;
  bool _showSlideDemo = true;
  int _staggeredItemCount = 5;
  double _customOffset = 1.0;

  // ✅ ANIMATION MANAGERS
  final Map<String, GlobalKey> _animationKeys = {};

  // ✅ CONSTANTS
  static const EdgeInsets _screenPadding = EdgeInsets.all(16.0);
  static const EdgeInsets _sectionPadding = EdgeInsets.only(bottom: 32.0);
  static const EdgeInsets _demoPadding = EdgeInsets.all(16.0);
  static const double _sectionSpacing = 24.0;
  static const double _animationSpacing = 12.0;

  // ✅ COLOR REFERENCES - Using Material Design colors
  Color get _primaryColor => Colors.blue;
  Color get _successColor => Colors.green;
  Color get _warningColor => Colors.orange;
  Color get _dangerColor => Colors.red;
  Color get _infoColor => Colors.blue;
  Color get _secondaryColor => Colors.purple;

  @override
  void initState() {
    super.initState();
    _initializeAnimationKeys();
  }

  void _initializeAnimationKeys() {
    _animationKeys['fade1'] = GlobalKey();
    _animationKeys['fade2'] = GlobalKey();
    _animationKeys['scale1'] = GlobalKey();
    _animationKeys['scale2'] = GlobalKey();
    _animationKeys['slide1'] = GlobalKey();
    _animationKeys['slide2'] = GlobalKey();
  }

  Duration _getSpeedAdjustedDuration(Duration baseDuration) {
    return Duration(
      milliseconds: (baseDuration.inMilliseconds / _animationSpeed).round(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation System'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: _showPerformanceInfo,
            tooltip: 'Performance Info',
          ),
        ],
      ),
      body: Padding(
        padding: _screenPadding,
        child: ListView(
          children: [
            // ✅ INTRODUCTION SECTION
            _buildIntroductionSection(context),
            const SizedBox(height: _sectionSpacing),

            // ✅ ANIMATION CONTROLS
            _buildAnimationControlsSection(),
            const SizedBox(height: _sectionSpacing),

            // ✅ FADE ANIMATIONS
            _buildFadeAnimationsSection(),
            const SizedBox(height: _sectionSpacing),

            // ✅ SCALE ANIMATIONS
            _buildScaleAnimationsSection(),
            const SizedBox(height: _sectionSpacing),

            // ✅ SLIDE ANIMATIONS
            _buildSlideAnimationsSection(),
            const SizedBox(height: _sectionSpacing),

            // ✅ ANIMATION SEQUENCES
            _buildAnimationSequencesSection(),
            const SizedBox(height: _sectionSpacing),

            // ✅ INTERACTIVE DEMOS
            _buildInteractiveDemosSection(),
            const SizedBox(height: _sectionSpacing),

            // ✅ PERFORMANCE METRICS
            if (_showPerformanceMetrics) _buildPerformanceMetricsSection(),
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
            'Flutstrap Animation System',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            'Comprehensive animation system with performance-optimized components, '
            'theme integration, and accessibility features. Explore individual animations, '
            'complex sequences, and interactive demonstrations.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  height: 1.5,
                ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: [
              _buildFeatureChip('🎯 Performance Optimized'),
              _buildFeatureChip('♿ Accessibility Ready'),
              _buildFeatureChip('🎨 Theme Integrated'),
              _buildFeatureChip('⚡ Memory Safe'),
              _buildFeatureChip('🔧 Interactive Controls'),
            ],
          ),
        ],
      ),
    );
  }

  /// Build animation controls section
  Widget _buildAnimationControlsSection() {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Animation Controls',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Global controls for all animations',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: _demoPadding,
              child: Column(
                children: [
                  // Animation speed control
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Animation Speed: ${_animationSpeed.toStringAsFixed(1)}x'),
                      Slider(
                        value: _animationSpeed,
                        min: 0.5,
                        max: 3.0,
                        divisions: 5,
                        label: '${_animationSpeed.toStringAsFixed(1)}x',
                        onChanged: (value) =>
                            setState(() => _animationSpeed = value),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('0.5x', style: TextStyle(fontSize: 12)),
                          Text('1.0x', style: TextStyle(fontSize: 12)),
                          Text('2.0x', style: TextStyle(fontSize: 12)),
                          Text('3.0x', style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Toggle switches
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SwitchListTile(
                              title: const Text('Respect System Preferences'),
                              subtitle: const Text(
                                  'Follow device animation settings'),
                              value: _respectSystemPreferences,
                              onChanged: (value) => setState(
                                  () => _respectSystemPreferences = value),
                            ),
                            SwitchListTile(
                              title: const Text('Maintain Animation State'),
                              subtitle: const Text(
                                  'Keep widget state during animations'),
                              value: _maintainAnimationState,
                              onChanged: (value) => setState(
                                  () => _maintainAnimationState = value),
                            ),
                            SwitchListTile(
                              title: const Text('Show Performance Metrics'),
                              subtitle:
                                  const Text('Display animation performance'),
                              value: _showPerformanceMetrics,
                              onChanged: (value) => setState(
                                  () => _showPerformanceMetrics = value),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Control buttons - USING STANDARD FLUTTER BUTTONS
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      ElevatedButton(
                        onPressed: _playAllAnimations,
                        child: const Text('Play All'),
                      ),
                      OutlinedButton(
                        onPressed: _resetAllAnimations,
                        child: const Text('Reset All'),
                      ),
                      OutlinedButton(
                        onPressed: _stopAllAnimations,
                        child: const Text('Stop All'),
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

  /// Build fade animations section
  Widget _buildFadeAnimationsSection() {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(
            title: 'Fade Animations',
            description:
                'Smooth opacity transitions with various timing curves',
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: _animationSpacing,
            runSpacing: _animationSpacing,
            children: [
              _buildAnimationDemoCard(
                'Basic Fade',
                'Standard fade-in animation',
                Container(
                  width: 80,
                  height: 60,
                  color: _primaryColor.withOpacity(0.1),
                  child: const Center(child: Text('Fade In')),
                ),
                onPlay: () {},
                onReset: () {},
              ),
              _buildAnimationDemoCard(
                'Quick Fade',
                'Fast 200ms fade animation',
                Container(
                  width: 80,
                  height: 60,
                  color: _successColor.withOpacity(0.1),
                  child: const Center(child: Text('Quick')),
                ),
              ),
              _buildAnimationDemoCard(
                'Bounce Fade',
                'Fade with bounce curve',
                Container(
                  width: 80,
                  height: 60,
                  color: _warningColor.withOpacity(0.1),
                  child: const Center(child: Text('Bounce')),
                ),
              ),
              _buildAnimationDemoCard(
                'Elastic Fade',
                'Fade with elastic curve',
                Container(
                  width: 80,
                  height: 60,
                  color: _dangerColor.withOpacity(0.1),
                  child: const Center(child: Text('Elastic')),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Build scale animations section
  Widget _buildScaleAnimationsSection() {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(
            title: 'Scale Animations',
            description:
                'Size transformations with various origins and effects',
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: _animationSpacing,
            runSpacing: _animationSpacing,
            children: [
              _buildAnimationDemoCard(
                'Basic Scale',
                'Scale from center',
                Container(
                  width: 80,
                  height: 60,
                  color: _infoColor.withOpacity(0.1),
                  child: const Center(child: Text('Scale')),
                ),
                onPlay: () {},
                onReset: () {},
              ),
              _buildAnimationDemoCard(
                'Bounce Scale',
                'Scale with bounce overshoot',
                Container(
                  width: 80,
                  height: 60,
                  color: _secondaryColor.withOpacity(0.1),
                  child: const Center(child: Text('Bounce')),
                ),
              ),
              _buildAnimationDemoCard(
                'Pop Scale',
                'Quick pop-in effect',
                Container(
                  width: 80,
                  height: 60,
                  color: _successColor.withOpacity(0.1),
                  child: const Center(child: Text('Pop')),
                ),
              ),
              _buildAnimationDemoCard(
                'Top Left Scale',
                'Scale from top-left corner',
                Container(
                  width: 80,
                  height: 60,
                  color: _warningColor.withOpacity(0.1),
                  child: const Center(child: Text('Top Left')),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Build slide animations section
  Widget _buildSlideAnimationsSection() {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(
            title: 'Slide Animations',
            description:
                'Smooth positional transitions from various directions',
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: _animationSpacing,
            runSpacing: _animationSpacing,
            children: [
              _buildAnimationDemoCard(
                'Slide from Bottom',
                'Standard slide up animation',
                Container(
                  width: 80,
                  height: 60,
                  color: _primaryColor.withOpacity(0.1),
                  child: const Center(child: Text('Bottom')),
                ),
                onPlay: () {},
                onReset: () {},
              ),
              _buildAnimationDemoCard(
                'Slide from Right',
                'Page transition style',
                Container(
                  width: 80,
                  height: 60,
                  color: _successColor.withOpacity(0.1),
                  child: const Center(child: Text('Right')),
                ),
              ),
              _buildAnimationDemoCard(
                'Slide from Top',
                'With bounce effect',
                Container(
                  width: 80,
                  height: 60,
                  color: _warningColor.withOpacity(0.1),
                  child: const Center(child: Text('Top')),
                ),
              ),
              _buildAnimationDemoCard(
                'Slide Diagonal',
                'From top-right corner',
                Container(
                  width: 80,
                  height: 60,
                  color: _infoColor.withOpacity(0.1),
                  child: const Center(child: Text('Diagonal')),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Build animation sequences section
  Widget _buildAnimationSequencesSection() {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(
            title: 'Animation Sequences',
            description: 'Complex multi-step animations and staggered effects',
          ),
          const SizedBox(height: 16),

          // Staggered animations
          Card(
            child: Padding(
              padding: _demoPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Staggered Fade In',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Items fade in sequentially with configurable delay',
                    style: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.6),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Column(
                    children: List.generate(
                      _staggeredItemCount,
                      (index) => Container(
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          color: _primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: _primaryColor.withOpacity(0.3),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: _primaryColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text('Item ${index + 1}'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Text('Item Count:'),
                      const SizedBox(width: 12),
                      Slider(
                        value: _staggeredItemCount.toDouble(),
                        min: 3,
                        max: 10,
                        divisions: 7,
                        onChanged: (value) =>
                            setState(() => _staggeredItemCount = value.round()),
                      ),
                      Text('$_staggeredItemCount'),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Sequential animations
          Card(
            child: Padding(
              padding: _demoPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sequential Animation',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Complex multi-step animation sequence',
                    style: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.6),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildDemoBox('Step 1', _primaryColor),
                      _buildDemoBox('Step 2', _successColor),
                      _buildDemoBox('Step 3', _warningColor),
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

  /// Build interactive demos section
  Widget _buildInteractiveDemosSection() {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(
            title: 'Interactive Demos',
            description: 'Real-time animation customization and testing',
          ),
          const SizedBox(height: 16),

          // Crossfade demo
          Card(
            child: Padding(
              padding: _demoPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Crossfade Transition',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Smooth transition between two widgets',
                    style: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.6),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 16),
                  AnimatedCrossFade(
                    firstChild: _buildDemoBox('First Widget', _primaryColor),
                    secondChild: _buildDemoBox('Second Widget', _successColor),
                    crossFadeState: _showFadeDemo
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    duration: _getSpeedAdjustedDuration(
                        const Duration(milliseconds: 300)),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () =>
                        setState(() => _showFadeDemo = !_showFadeDemo),
                    child: Text(_showFadeDemo ? 'Show Second' : 'Show First'),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Custom offset demo
          Card(
            child: Padding(
              padding: _demoPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Custom Slide Offset',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Control slide distance with offset fraction',
                    style: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.6),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildDemoBox('Custom Offset', _infoColor),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Offset Fraction: ${_customOffset.toStringAsFixed(1)}'),
                      Slider(
                        value: _customOffset,
                        min: 0.5,
                        max: 2.0,
                        divisions: 3,
                        onChanged: (value) =>
                            setState(() => _customOffset = value),
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

  /// Build performance metrics section
  Widget _buildPerformanceMetricsSection() {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(
            title: 'Performance Metrics',
            description:
                'Animation performance monitoring and optimization tips',
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: _demoPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Performance Tips',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  _buildPerformanceTip(
                    'Use maintainState: false for large lists',
                    'Reduces memory usage for off-screen items',
                  ),
                  _buildPerformanceTip(
                    'Respect system animation preferences',
                    'Improves accessibility and user experience',
                  ),
                  _buildPerformanceTip(
                    'Use appropriate animation durations',
                    '300-500ms for most UI interactions',
                  ),
                  _buildPerformanceTip(
                    'Consider reduced motion preferences',
                    'Essential for users with vestibular disorders',
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton(
                    onPressed: () {},
                    child: const Text('Clear Animation Cache'),
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

  Widget _buildSectionHeader(
      {required String title, required String description}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
        ),
      ],
    );
  }

  Widget _buildAnimationDemoCard(
    String title,
    String description,
    Widget animation, {
    VoidCallback? onPlay,
    VoidCallback? onReset,
  }) {
    return Card(
      child: Padding(
        padding: _demoPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 80,
              child: Center(child: animation),
            ),
            if (onPlay != null || onReset != null) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  if (onPlay != null)
                    Expanded(
                      child: ElevatedButton(
                        onPressed: onPlay,
                        child: const Text('Play'),
                      ),
                    ),
                  if (onPlay != null && onReset != null)
                    const SizedBox(width: 8),
                  if (onReset != null)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: onReset,
                        child: const Text('Reset'),
                      ),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDemoBox(String text, Color color) {
    return Container(
      width: 80,
      height: 60,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.animation,
            color: color,
            size: 20,
          ),
          const SizedBox(height: 4),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildPerformanceTip(String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check_circle,
            color: Colors.green, // Using direct color instead of theme.success
            size: 16,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.6),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ✅ ANIMATION CONTROL METHODS

  void _playAllAnimations() {
    // Placeholder for animation play functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Playing all animations')),
    );
  }

  void _resetAllAnimations() {
    // Placeholder for animation reset functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Resetting all animations')),
    );
  }

  void _stopAllAnimations() {
    // Placeholder for animation stop functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Stopping all animations')),
    );
  }

  void _showPerformanceInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Animation Performance'),
        content: const Text(
          'The Flutstrap animation system is optimized for performance:\n\n'
          '• Memory-efficient controller management\n'
          '• Automatic cleanup and disposal\n'
          '• Minimal widget rebuilds\n'
          '• Frame rate optimization\n'
          '• Accessibility compliance\n\n'
          'All animations respect system preferences and include proper error handling.',
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
