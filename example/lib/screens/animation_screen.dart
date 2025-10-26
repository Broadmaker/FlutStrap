// animations_screen.dart
import 'package:flutter/material.dart';
import 'package:master_flutstrap/flutstrap.dart';

class AnimationsScreen extends StatefulWidget {
  const AnimationsScreen({super.key});

  @override
  State<AnimationsScreen> createState() => _AnimationsScreenState();
}

class _AnimationsScreenState extends State<AnimationsScreen> {
  final Map<String, int> _animationCounters = {};

  int _getCounter(String key) {
    return _animationCounters[key] ?? 0;
  }

  void _incrementCounter(String key) {
    setState(() {
      _animationCounters[key] = (_animationCounters[key] ?? 0) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final crossAxisCount = isMobile ? 1 : 2;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Animations'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _buildSectionTitle('FadeIn Animations'),
            const SizedBox(height: 16),
            _buildAnimationGrid(_buildFadeInExamples(), crossAxisCount),
            const SizedBox(height: 32),
            _buildSectionTitle('Slide Transitions'),
            const SizedBox(height: 16),
            _buildAnimationGrid(_buildSlideExamples(), crossAxisCount),
            const SizedBox(height: 32),
            _buildSectionTitle('Combination & Advanced'),
            const SizedBox(height: 16),
            _buildAnimationGrid(_buildCombinationExamples(), crossAxisCount),
          ],
        ),
      ),
    );
  }

  List<AnimationExample> _buildFadeInExamples() {
    return [
      AnimationExample(
        key: 'fade_quick',
        name: 'Quick FadeIn',
        description: '200ms duration',
        builder: (counter) => FadeInQuick(
          key: Key('fade_quick_$counter'),
          child: _buildAnimatedBox('Quick Fade', Colors.blue),
          autoPlay: true,
        ),
      ),
      AnimationExample(
        key: 'fade_standard',
        name: 'Standard FadeIn',
        description: '500ms duration',
        builder: (counter) => FadeInStandard(
          key: Key('fade_standard_$counter'),
          child: _buildAnimatedBox('Standard Fade', Colors.green),
          autoPlay: true,
        ),
      ),
      AnimationExample(
        key: 'fade_slow',
        name: 'Slow FadeIn',
        description: '1000ms duration',
        builder: (counter) => FadeInSlow(
          key: Key('fade_slow_$counter'),
          child: _buildAnimatedBox('Slow Fade', Colors.orange),
          autoPlay: true,
        ),
      ),
      AnimationExample(
        key: 'fade_bounce',
        name: 'Bounce FadeIn',
        description: 'BounceOut curve',
        builder: (counter) => FadeInBounce(
          key: Key('fade_bounce_$counter'),
          child: _buildAnimatedBox('Bounce Fade', Colors.purple),
          autoPlay: true,
        ),
      ),
      AnimationExample(
        key: 'fade_elastic',
        name: 'Elastic FadeIn',
        description: 'ElasticOut curve',
        builder: (counter) => FadeInElastic(
          key: Key('fade_elastic_$counter'),
          child: _buildAnimatedBox('Elastic Fade', Colors.red),
          autoPlay: true,
        ),
      ),
    ];
  }

  List<AnimationExample> _buildSlideExamples() {
    return [
      AnimationExample(
        key: 'slide_top',
        name: 'Slide from Top',
        description: 'Standard slide',
        builder: (counter) => FSSlideTransitionStandard(
          key: Key('slide_top_$counter'),
          child: _buildAnimatedBox('Slide Top', Colors.blue),
          direction: FSSlideDirection.fromTop,
          autoPlay: true,
        ),
      ),
      AnimationExample(
        key: 'slide_bottom',
        name: 'Slide from Bottom',
        description: 'Standard slide',
        builder: (counter) => FSSlideTransitionStandard(
          key: Key('slide_bottom_$counter'),
          child: _buildAnimatedBox('Slide Bottom', Colors.green),
          direction: FSSlideDirection.fromBottom,
          autoPlay: true,
        ),
      ),
      AnimationExample(
        key: 'slide_left',
        name: 'Slide from Left',
        description: 'Standard slide',
        builder: (counter) => FSSlideTransitionStandard(
          key: Key('slide_left_$counter'),
          child: _buildAnimatedBox('Slide Left', Colors.orange),
          direction: FSSlideDirection.fromLeft,
          autoPlay: true,
        ),
      ),
      AnimationExample(
        key: 'slide_right',
        name: 'Slide from Right',
        description: 'Standard slide',
        builder: (counter) => FSSlideTransitionStandard(
          key: Key('slide_right_$counter'),
          child: _buildAnimatedBox('Slide Right', Colors.purple),
          direction: FSSlideDirection.fromRight,
          autoPlay: true,
        ),
      ),
      AnimationExample(
        key: 'slide_quick',
        name: 'Quick Slide',
        description: '300ms duration',
        builder: (counter) => FSSlideTransitionQuick(
          key: Key('slide_quick_$counter'),
          child: _buildAnimatedBox('Quick Slide', Colors.teal),
          direction: FSSlideDirection.fromBottom,
          autoPlay: true,
        ),
      ),
      AnimationExample(
        key: 'slide_bounce',
        name: 'Bounce Slide',
        description: 'Bounce curve from top',
        builder: (counter) => FSSlideTransitionBounce(
          key: Key('slide_bounce_$counter'),
          child: _buildAnimatedBox('Bounce Slide', Colors.pink),
          autoPlay: true,
        ),
      ),
      AnimationExample(
        key: 'slide_elastic',
        name: 'Elastic Slide',
        description: 'Elastic curve from right',
        builder: (counter) => FSSlideTransitionElastic(
          key: Key('slide_elastic_$counter'),
          child: _buildAnimatedBox('Elastic Slide', Colors.indigo),
          autoPlay: true,
        ),
      ),
      AnimationExample(
        key: 'slide_page',
        name: 'Page Transition',
        description: 'Slide from right for pages',
        builder: (counter) => FSSlideTransitionPage(
          key: Key('slide_page_$counter'),
          child: _buildAnimatedBox('Page Transition', Colors.amber),
          autoPlay: true,
        ),
      ),
    ];
  }

  List<AnimationExample> _buildCombinationExamples() {
    return [
      AnimationExample(
        key: 'combo_fade_slide',
        name: 'Fade + Slide Up',
        description: 'Combined entrance effect',
        builder: (counter) => FadeInStandard(
          key: Key('combo_fade_$counter'),
          child: FSSlideTransitionStandard(
            key: Key('combo_slide_$counter'),
            child: _buildAnimatedBox('Fade + Slide', Colors.blue),
            direction: FSSlideDirection.fromBottom,
            autoPlay: true,
          ),
          autoPlay: true,
        ),
      ),
      AnimationExample(
        key: 'staggered_fade',
        name: 'Staggered FadeIn',
        description: 'Multiple items with delay',
        builder: (counter) => Column(
          children: [
            FadeInQuick(
              key: Key('staggered_1_$counter'),
              child: _buildAnimatedBox('Item 1', Colors.green, height: 40),
              autoPlay: true,
            ),
            const SizedBox(height: 8),
            FadeInQuick(
              key: Key('staggered_2_$counter'),
              child: _buildAnimatedBox('Item 2', Colors.orange, height: 40),
              delay: const Duration(milliseconds: 100),
              autoPlay: true,
            ),
            const SizedBox(height: 8),
            FadeInQuick(
              key: Key('staggered_3_$counter'),
              child: _buildAnimatedBox('Item 3', Colors.purple, height: 40),
              delay: const Duration(milliseconds: 200),
              autoPlay: true,
            ),
          ],
        ),
      ),
      AnimationExample(
        key: 'slide_sequence',
        name: 'Slide Sequence',
        description: 'Items sliding from different directions',
        builder: (counter) => Column(
          children: [
            FSSlideTransitionQuick(
              key: Key('sequence_1_$counter'),
              child: _buildAnimatedBox('Left', Colors.red, height: 40),
              direction: FSSlideDirection.fromLeft,
              autoPlay: true,
            ),
            const SizedBox(height: 8),
            FSSlideTransitionQuick(
              key: Key('sequence_2_$counter'),
              child: _buildAnimatedBox('Right', Colors.blue, height: 40),
              direction: FSSlideDirection.fromRight,
              delay: const Duration(milliseconds: 150),
              autoPlay: true,
            ),
            const SizedBox(height: 8),
            FSSlideTransitionQuick(
              key: Key('sequence_3_$counter'),
              child: _buildAnimatedBox('Top', Colors.green, height: 40),
              direction: FSSlideDirection.fromTop,
              delay: const Duration(milliseconds: 300),
              autoPlay: true,
            ),
          ],
        ),
      ),
    ];
  }

  Widget _buildAnimatedBox(String text, Color color, {double height = 60}) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }

  Widget _buildAnimationGrid(
      List<AnimationExample> examples, int crossAxisCount) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: crossAxisCount == 1 ? 1.5 : 1.2,
      ),
      itemCount: examples.length,
      itemBuilder: (context, index) {
        return _buildAnimationCard(examples[index]);
      },
    );
  }

  Widget _buildAnimationCard(AnimationExample example) {
    final counter = _getCounter(example.key);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              example.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              example.description,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Center(
                child: example.builder(counter),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _incrementCounter(example.key);
                },
                child: const Text('Replay'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimationExample {
  final String key;
  final String name;
  final String description;
  final Widget Function(int counter) builder;

  AnimationExample({
    required this.key,
    required this.name,
    required this.description,
    required this.builder,
  });
}
