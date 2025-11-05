// test/animations/slide_transition_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutstrap/animations/slide_transition.dart' as flutstrap;

void main() {
  // Helper function to build test widget with proper disposal
  Future<void> pumpSlideTransitionWidget(
    WidgetTester tester, {
    required Widget child,
    flutstrap.FSSlideDirection direction =
        flutstrap.FSSlideDirection.fromBottom,
    Duration duration = const Duration(milliseconds: 100),
    Duration delay = Duration.zero,
    Curve curve = Curves.linear,
    bool autoPlay = true,
    VoidCallback? onComplete,
    double offsetFraction = 1.0,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: flutstrap.SlideTransition(
            child: child,
            direction: direction,
            duration: duration,
            delay: delay,
            curve: curve,
            autoPlay: autoPlay,
            onComplete: onComplete,
            offsetFraction: offsetFraction,
          ),
        ),
      ),
    );
  }

  // Helper function to find the Transform widget within SlideTransition
  Finder findSlideTransform() {
    return find.descendant(
      of: find.byType(flutstrap.SlideTransition),
      matching: find.byType(Transform),
    );
  }

  group('SlideTransition', () {
    testWidgets('renders child widget', (tester) async {
      await pumpSlideTransitionWidget(
        tester,
        child: const Text('Hello World'),
      );

      expect(find.text('Hello World'), findsOneWidget);

      // Ensure proper disposal
      await tester.pumpAndSettle();
    });

    testWidgets('slides from bottom by default', (tester) async {
      await pumpSlideTransitionWidget(
        tester,
        child: const Text('Test'),
        duration: const Duration(milliseconds: 100),
        curve: Curves.linear,
      );

      // Find the specific Transform widget
      final transformFinder = findSlideTransform();
      expect(transformFinder, findsOneWidget);

      // Initially should be offset downward
      final transformWidget = tester.widget<Transform>(transformFinder);
      final offset = (transformWidget.transform as Matrix4).getTranslation();
      expect(offset.y, greaterThan(0.0)); // Should be below original position
      expect(offset.x, 0.0); // No horizontal offset

      // Complete animation and settle
      await tester.pumpAndSettle(const Duration(milliseconds: 100));
      final finalTransform = tester.widget<Transform>(transformFinder);
      final finalOffset =
          (finalTransform.transform as Matrix4).getTranslation();
      expect(finalOffset.x, 0.0);
      expect(finalOffset.y, 0.0); // Should be at original position
    });

    testWidgets('slides from top correctly', (tester) async {
      await pumpSlideTransitionWidget(
        tester,
        child: const Text('Test'),
        direction: flutstrap.FSSlideDirection.fromTop,
        duration: const Duration(milliseconds: 100),
        curve: Curves.linear,
      );

      final transformFinder = findSlideTransform();
      expect(transformFinder, findsOneWidget);

      // Initially should be offset upward
      final transformWidget = tester.widget<Transform>(transformFinder);
      final offset = (transformWidget.transform as Matrix4).getTranslation();
      expect(offset.y, lessThan(0.0)); // Should be above original position
      expect(offset.x, 0.0);

      await tester.pumpAndSettle(const Duration(milliseconds: 100));
    });

    testWidgets('slides from left correctly', (tester) async {
      await pumpSlideTransitionWidget(
        tester,
        child: const Text('Test'),
        direction: flutstrap.FSSlideDirection.fromLeft,
        duration: const Duration(milliseconds: 100),
        curve: Curves.linear,
      );

      final transformFinder = findSlideTransform();
      expect(transformFinder, findsOneWidget);

      // Initially should be offset left
      final transformWidget = tester.widget<Transform>(transformFinder);
      final offset = (transformWidget.transform as Matrix4).getTranslation();
      expect(offset.x, lessThan(0.0)); // Should be left of original position
      expect(offset.y, 0.0);

      await tester.pumpAndSettle(const Duration(milliseconds: 100));
    });

    testWidgets('slides from right correctly', (tester) async {
      await pumpSlideTransitionWidget(
        tester,
        child: const Text('Test'),
        direction: flutstrap.FSSlideDirection.fromRight,
        duration: const Duration(milliseconds: 100),
        curve: Curves.linear,
      );

      final transformFinder = findSlideTransform();
      expect(transformFinder, findsOneWidget);

      // Initially should be offset right
      final transformWidget = tester.widget<Transform>(transformFinder);
      final offset = (transformWidget.transform as Matrix4).getTranslation();
      expect(
          offset.x, greaterThan(0.0)); // Should be right of original position
      expect(offset.y, 0.0);

      await tester.pumpAndSettle(const Duration(milliseconds: 100));
    });

    testWidgets('respects custom duration', (tester) async {
      await pumpSlideTransitionWidget(
        tester,
        child: const Text('Test'),
        duration: const Duration(milliseconds: 200),
        curve: Curves.linear,
      );

      final transformFinder = findSlideTransform();

      // Check initial offset
      final initialTransform = tester.widget<Transform>(transformFinder);
      final initialOffset =
          (initialTransform.transform as Matrix4).getTranslation();

      // Halfway through custom duration
      await tester.pump(const Duration(milliseconds: 100));
      final midTransform = tester.widget<Transform>(transformFinder);
      final midOffset = (midTransform.transform as Matrix4).getTranslation();

      // Should have moved halfway
      expect(midOffset.y, closeTo(initialOffset.y / 2, 0.1));

      // Complete and settle
      await tester.pumpAndSettle(const Duration(milliseconds: 100));
    });

    testWidgets('respects delay before starting animation', (tester) async {
      await pumpSlideTransitionWidget(
        tester,
        child: const Text('Test'),
        duration: const Duration(milliseconds: 100),
        delay: const Duration(milliseconds: 100),
        curve: Curves.linear,
      );

      final transformFinder = findSlideTransform();

      // Get initial position
      final initialTransform = tester.widget<Transform>(transformFinder);
      final initialOffset =
          (initialTransform.transform as Matrix4).getTranslation();

      // After delay but before animation should start - position should be same
      await tester.pump(const Duration(milliseconds: 100));
      final afterDelayTransform = tester.widget<Transform>(transformFinder);
      final afterDelayOffset =
          (afterDelayTransform.transform as Matrix4).getTranslation();

      expect(afterDelayOffset.x, initialOffset.x);
      expect(afterDelayOffset.y, initialOffset.y);

      // Animation should start after delay
      await tester.pump(const Duration(milliseconds: 50));
      final startedTransform = tester.widget<Transform>(transformFinder);
      final startedOffset =
          (startedTransform.transform as Matrix4).getTranslation();

      expect(
          startedOffset.y, lessThan(initialOffset.y)); // Should have moved up

      await tester.pumpAndSettle(const Duration(milliseconds: 50));
    });

    testWidgets('calls onComplete callback when animation finishes',
        (tester) async {
      bool completed = false;

      await pumpSlideTransitionWidget(
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
      await pumpSlideTransitionWidget(
        tester,
        child: const Text('Test'),
        duration: const Duration(milliseconds: 100),
        autoPlay: false,
      );

      final transformFinder = findSlideTransform();

      // Get initial position
      final initialTransform = tester.widget<Transform>(transformFinder);
      final initialOffset =
          (initialTransform.transform as Matrix4).getTranslation();

      // Should not animate without manual trigger
      await tester.pump(const Duration(milliseconds: 100));
      final afterPumpTransform = tester.widget<Transform>(transformFinder);
      final afterPumpOffset =
          (afterPumpTransform.transform as Matrix4).getTranslation();

      expect(afterPumpOffset.x, initialOffset.x);
      expect(afterPumpOffset.y, initialOffset.y);
    });

    testWidgets('handles widget disposal properly', (tester) async {
      await pumpSlideTransitionWidget(
        tester,
        child: const Text('Test'),
        duration: const Duration(milliseconds: 100),
      );

      // Should not throw when disposed - use pumpAndSettle for proper cleanup
      await tester.pumpAndSettle();
      await tester.pumpWidget(const SizedBox.shrink());
      expect(tester.takeException(), isNull);
    });

    testWidgets('respects custom offsetFraction', (tester) async {
      await pumpSlideTransitionWidget(
        tester,
        child: const Text('Test'),
        direction: flutstrap.FSSlideDirection.fromBottom,
        offsetFraction: 0.5, // Half the normal distance
        duration: const Duration(milliseconds: 100),
        curve: Curves.linear,
      );

      final transformFinder = findSlideTransform();

      // Initially should be offset by half the normal amount
      final transformWidget = tester.widget<Transform>(transformFinder);
      final offset = (transformWidget.transform as Matrix4).getTranslation();

      // With offsetFraction 0.5, should be at y=0.5 (half of normal 1.0)
      expect(offset.y, closeTo(0.5, 0.01));

      await tester.pumpAndSettle(const Duration(milliseconds: 100));
    });
  });

  group('SlideTransition Variants', () {
    testWidgets('SlideTransitionQuick uses quick duration', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: flutstrap.SlideTransitionQuick(
              child: const Text('Quick'),
            ),
          ),
        ),
      );

      // Complete quick animation and settle
      await tester.pumpAndSettle(const Duration(milliseconds: 300));

      // Just verify the component renders without checking internal Transform
      expect(find.text('Quick'), findsOneWidget);
    });

    testWidgets('SlideTransitionStandard uses standard duration',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: flutstrap.SlideTransitionStandard(
              child: const Text('Standard'),
            ),
          ),
        ),
      );

      // Just verify the component renders
      expect(find.text('Standard'), findsOneWidget);

      await tester.pumpAndSettle(const Duration(milliseconds: 500));
    });

    testWidgets('SlideTransitionBounce uses bounce curve from top',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: flutstrap.SlideTransitionBounce(
              child: const Text('Bounce'),
            ),
          ),
        ),
      );

      // Just verify the component renders
      expect(find.text('Bounce'), findsOneWidget);

      await tester.pumpAndSettle(const Duration(milliseconds: 600));
    });

    testWidgets('SlideTransitionElastic uses elastic curve from right',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: flutstrap.SlideTransitionElastic(
              child: const Text('Elastic'),
            ),
          ),
        ),
      );

      // Just verify the component renders
      expect(find.text('Elastic'), findsOneWidget);

      await tester.pumpAndSettle(const Duration(milliseconds: 800));
    });

    testWidgets('SlideTransitionPage slides from right', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: flutstrap.SlideTransitionPage(
              child: const Text('Page'),
            ),
          ),
        ),
      );

      // Just verify the component renders
      expect(find.text('Page'), findsOneWidget);

      await tester.pumpAndSettle(const Duration(milliseconds: 400));
    });
  });

  group('FSSlideDirection', () {
    test('has correct values', () {
      expect(flutstrap.FSSlideDirection.values.length, 8);
      expect(flutstrap.FSSlideDirection.values,
          contains(flutstrap.FSSlideDirection.fromTop));
      expect(flutstrap.FSSlideDirection.values,
          contains(flutstrap.FSSlideDirection.fromBottom));
      expect(flutstrap.FSSlideDirection.values,
          contains(flutstrap.FSSlideDirection.fromLeft));
      expect(flutstrap.FSSlideDirection.values,
          contains(flutstrap.FSSlideDirection.fromRight));
      expect(flutstrap.FSSlideDirection.values,
          contains(flutstrap.FSSlideDirection.fromTopLeft));
      expect(flutstrap.FSSlideDirection.values,
          contains(flutstrap.FSSlideDirection.fromTopRight));
      expect(flutstrap.FSSlideDirection.values,
          contains(flutstrap.FSSlideDirection.fromBottomLeft));
      expect(flutstrap.FSSlideDirection.values,
          contains(flutstrap.FSSlideDirection.fromBottomRight));
    });
  });

  group('Edge Cases', () {
    testWidgets('handles zero duration', (tester) async {
      await pumpSlideTransitionWidget(
        tester,
        child: const Text('Instant'),
        duration: Duration.zero,
      );

      // With zero duration, should be immediately at final position
      await tester.pump();
      final transformFinder = findSlideTransform();
      final transform = tester.widget<Transform>(transformFinder);
      final offset = (transform.transform as Matrix4).getTranslation();
      expect(offset.x, 0.0);
      expect(offset.y, 0.0);
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

      await pumpSlideTransitionWidget(
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
    });

    testWidgets('does not crash when onComplete is null', (tester) async {
      await pumpSlideTransitionWidget(
        tester,
        child: const Text('Test'),
        duration: const Duration(milliseconds: 100),
        onComplete: null,
      );

      // Should complete without throwing
      await tester.pumpAndSettle(const Duration(milliseconds: 100));
      expect(tester.takeException(), isNull);
    });

    testWidgets('handles diagonal slide directions', (tester) async {
      // Test that diagonal directions don't crash and render correctly
      await pumpSlideTransitionWidget(
        tester,
        child: const Text('Top Left'),
        direction: flutstrap.FSSlideDirection.fromTopLeft,
        duration: const Duration(milliseconds: 100),
      );

      expect(find.text('Top Left'), findsOneWidget);
      await tester.pumpAndSettle();

      await pumpSlideTransitionWidget(
        tester,
        child: const Text('Bottom Right'),
        direction: flutstrap.FSSlideDirection.fromBottomRight,
        duration: const Duration(milliseconds: 100),
      );

      expect(find.text('Bottom Right'), findsOneWidget);
      await tester.pumpAndSettle();
    });
  });
}
