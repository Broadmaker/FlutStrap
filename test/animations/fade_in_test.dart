// test/animations/fade_in_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutstrap/animations/fade_in.dart';

void main() {
  // Helper function to build test widget with proper disposal
  Future<void> pumpFadeInWidget(
    WidgetTester tester, {
    required Widget child,
    Duration duration = const Duration(milliseconds: 100),
    Duration delay = Duration.zero,
    Curve curve = Curves.easeInOut,
    bool autoPlay = true,
    VoidCallback? onComplete,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FadeIn(
            child: child,
            duration: duration,
            delay: delay,
            curve: curve,
            autoPlay: autoPlay,
            onComplete: onComplete,
          ),
        ),
      ),
    );
  }

  group('FadeIn', () {
    testWidgets('renders child widget', (tester) async {
      await pumpFadeInWidget(
        tester,
        child: const Text('Hello World'),
      );

      expect(find.text('Hello World'), findsOneWidget);

      // Ensure proper disposal
      await tester.pumpAndSettle();
    });

    testWidgets('starts with opacity 0 and animates to opacity 1',
        (tester) async {
      await pumpFadeInWidget(
        tester,
        child: const Text('Test'),
        duration: const Duration(milliseconds: 100),
      );

      // Initially should have opacity 0
      final opacityWidget = tester.widget<Opacity>(find.byType(Opacity));
      expect(opacityWidget.opacity, 0.0);

      // Advance animation partially
      await tester.pump(const Duration(milliseconds: 50));
      final midOpacityWidget = tester.widget<Opacity>(find.byType(Opacity));
      expect(midOpacityWidget.opacity, greaterThan(0.0));
      expect(midOpacityWidget.opacity, lessThan(1.0));

      // Complete animation and settle
      await tester.pumpAndSettle(const Duration(milliseconds: 50));
      final finalOpacityWidget = tester.widget<Opacity>(find.byType(Opacity));
      expect(finalOpacityWidget.opacity, 1.0);
    });

    testWidgets('respects custom duration', (tester) async {
      await pumpFadeInWidget(
        tester,
        child: const Text('Test'),
        duration: const Duration(milliseconds: 200),
      );

      // Initially opacity 0
      expect(tester.widget<Opacity>(find.byType(Opacity)).opacity, 0.0);

      // Halfway through custom duration
      await tester.pump(const Duration(milliseconds: 100));
      expect(
        tester.widget<Opacity>(find.byType(Opacity)).opacity,
        closeTo(0.5, 0.1),
      );

      // Complete and settle
      await tester.pumpAndSettle(const Duration(milliseconds: 100));
      expect(tester.widget<Opacity>(find.byType(Opacity)).opacity, 1.0);
    });

    testWidgets('respects delay before starting animation', (tester) async {
      await pumpFadeInWidget(
        tester,
        child: const Text('Test'),
        duration: const Duration(milliseconds: 100),
        delay: const Duration(milliseconds: 100),
      );

      // Initially opacity 0
      expect(tester.widget<Opacity>(find.byType(Opacity)).opacity, 0.0);

      // After delay but before animation should start
      await tester.pump(const Duration(milliseconds: 100));
      expect(tester.widget<Opacity>(find.byType(Opacity)).opacity, 0.0);

      // Animation should start after delay
      await tester.pump(const Duration(milliseconds: 50));
      expect(
        tester.widget<Opacity>(find.byType(Opacity)).opacity,
        greaterThan(0.0),
      );

      // Complete and settle
      await tester.pumpAndSettle(const Duration(milliseconds: 50));
    });

    testWidgets('respects custom curve', (tester) async {
      await pumpFadeInWidget(
        tester,
        child: const Text('Test'),
        duration: const Duration(milliseconds: 100),
        curve: Curves.linear,
      );

      // With linear curve, opacity should increase linearly
      await tester.pump(const Duration(milliseconds: 50));
      expect(
        tester.widget<Opacity>(find.byType(Opacity)).opacity,
        closeTo(0.5, 0.1),
      );

      await tester.pumpAndSettle(const Duration(milliseconds: 50));
    });

    testWidgets('calls onComplete callback when animation finishes',
        (tester) async {
      bool completed = false;

      await pumpFadeInWidget(
        tester,
        child: const Text('Test'),
        duration: const Duration(milliseconds: 100),
        onComplete: () {
          completed = true;
        },
      );

      expect(completed, false);

      // Complete animation and settle
      await tester.pumpAndSettle(const Duration(milliseconds: 100));
      expect(completed, true);
    });

    testWidgets('does not auto-play when autoPlay is false', (tester) async {
      await pumpFadeInWidget(
        tester,
        child: const Text('Test'),
        duration: const Duration(milliseconds: 100),
        autoPlay: false,
      );

      // Initially opacity 0
      expect(tester.widget<Opacity>(find.byType(Opacity)).opacity, 0.0);

      // Should not animate without manual trigger
      await tester.pump(const Duration(milliseconds: 100));
      expect(tester.widget<Opacity>(find.byType(Opacity)).opacity, 0.0);
    });

    testWidgets('handles widget disposal properly', (tester) async {
      await pumpFadeInWidget(
        tester,
        child: const Text('Test'),
        duration: const Duration(milliseconds: 100),
      );

      // Should not throw when disposed - use pumpAndSettle for proper cleanup
      await tester.pumpAndSettle();
      await tester.pumpWidget(const SizedBox.shrink());
      expect(tester.takeException(), isNull);
    });
  });

  // Simplified variant tests
  group('FadeIn Variants', () {
    testWidgets('FadeInQuick uses quick duration', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FadeInQuick(
              child: const Text('Quick'),
            ),
          ),
        ),
      );

      // Complete quick animation and settle
      await tester.pumpAndSettle(const Duration(milliseconds: 200));
      expect(tester.widget<Opacity>(find.byType(Opacity)).opacity, 1.0);
    });

    testWidgets('FadeInStandard uses standard duration', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FadeInStandard(
              child: const Text('Standard'),
            ),
          ),
        ),
      );

      // Halfway through standard duration
      await tester.pump(const Duration(milliseconds: 250));
      expect(
        tester.widget<Opacity>(find.byType(Opacity)).opacity,
        closeTo(0.5, 0.1),
      );

      await tester.pumpAndSettle(const Duration(milliseconds: 250));
    });

    testWidgets('FadeInSlow uses slow duration', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FadeInSlow(
              child: const Text('Slow'),
            ),
          ),
        ),
      );

      // Quarter through slow duration - use a more flexible check
      await tester.pump(const Duration(milliseconds: 250));
      final opacity = tester.widget<Opacity>(find.byType(Opacity)).opacity;

      // Should be approximately 25% through, but not exactly due to curve
      expect(opacity, greaterThan(0.1)); // At least 10%
      expect(opacity, lessThan(0.4)); // But less than 40%

      await tester.pumpAndSettle(const Duration(milliseconds: 750));
    });
  });

  group('Edge Cases', () {
    testWidgets('handles zero duration', (tester) async {
      await pumpFadeInWidget(
        tester,
        child: const Text('Instant'),
        duration: Duration.zero,
      );

      // With zero duration, should be immediately visible
      await tester.pump();
      expect(tester.widget<Opacity>(find.byType(Opacity)).opacity, 1.0);
    });

    testWidgets('works with complex child widgets', (tester) async {
      final complexChild = Column(
        children: [
          const Text('Title'),
          Container(
            padding: const EdgeInsets.all(16),
            child: const Text('Content'),
          ),
          Row(
            children: const [
              Icon(Icons.star),
              Text('Rating'),
            ],
          ),
        ],
      );

      await pumpFadeInWidget(
        tester,
        child: complexChild,
        duration: const Duration(milliseconds: 100),
      );

      expect(find.text('Title'), findsOneWidget);
      expect(find.text('Content'), findsOneWidget);
      expect(find.text('Rating'), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);

      // Complete animation and settle
      await tester.pumpAndSettle(const Duration(milliseconds: 100));
      expect(tester.widget<Opacity>(find.byType(Opacity)).opacity, 1.0);
    });

    testWidgets('does not crash when onComplete is null', (tester) async {
      await pumpFadeInWidget(
        tester,
        child: const Text('Test'),
        duration: const Duration(milliseconds: 100),
        onComplete: null,
      );

      // Should complete without throwing
      await tester.pumpAndSettle(const Duration(milliseconds: 100));
      expect(tester.takeException(), isNull);
    });
  });
}
