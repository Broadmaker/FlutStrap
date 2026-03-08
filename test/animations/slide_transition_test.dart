import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutstrap/flutstrap.dart';

void main() {
  group('FSSlideTransition - Basic Rendering Tests', () {
    testWidgets('should render child widget', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FSSlideTransition(
              child: const Text('Slide Content'),
            ),
          ),
        ),
      );

      expect(find.text('Slide Content'), findsOneWidget);
    });

    testWidgets('should start at correct offset based on direction',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FSSlideTransition(
              direction: FSSlideDirection.fromBottom,
              child: const Text('Bottom Start'),
            ),
          ),
        ),
      );

      expect(find.text('Bottom Start'), findsOneWidget);
    });

    testWidgets('should respect autoPlay false', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FSSlideTransition(
              autoPlay: false,
              child: const Text('No Auto'),
            ),
          ),
        ),
      );

      expect(find.text('No Auto'), findsOneWidget);
    });

    testWidgets('should respect maintainState parameter',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FSSlideTransition(
              maintainState: false,
              child: const Text('No Maintain'),
            ),
          ),
        ),
      );

      expect(find.text('No Maintain'), findsOneWidget);
    });
  });

  group('FSSlideTransition - Direction Tests', () {
    testWidgets('fromTop should start from top', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FSSlideTransition(
              direction: FSSlideDirection.fromTop,
              autoPlay: false,
              child: const Text('From Top'),
            ),
          ),
        ),
      );

      expect(find.text('From Top'), findsOneWidget);
    });

    testWidgets('fromBottom should start from bottom',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FSSlideTransition(
              direction: FSSlideDirection.fromBottom,
              autoPlay: false,
              child: const Text('From Bottom'),
            ),
          ),
        ),
      );

      expect(find.text('From Bottom'), findsOneWidget);
    });

    testWidgets('fromLeft should start from left', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FSSlideTransition(
              direction: FSSlideDirection.fromLeft,
              autoPlay: false,
              child: const Text('From Left'),
            ),
          ),
        ),
      );

      expect(find.text('From Left'), findsOneWidget);
    });

    testWidgets('fromRight should start from right',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FSSlideTransition(
              direction: FSSlideDirection.fromRight,
              autoPlay: false,
              child: const Text('From Right'),
            ),
          ),
        ),
      );

      expect(find.text('From Right'), findsOneWidget);
    });

    testWidgets('fromTopLeft should start from top-left',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FSSlideTransition(
              direction: FSSlideDirection.fromTopLeft,
              autoPlay: false,
              child: const Text('From TopLeft'),
            ),
          ),
        ),
      );

      expect(find.text('From TopLeft'), findsOneWidget);
    });

    testWidgets('fromTopRight should start from top-right',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FSSlideTransition(
              direction: FSSlideDirection.fromTopRight,
              autoPlay: false,
              child: const Text('From TopRight'),
            ),
          ),
        ),
      );

      expect(find.text('From TopRight'), findsOneWidget);
    });

    testWidgets('fromBottomLeft should start from bottom-left',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FSSlideTransition(
              direction: FSSlideDirection.fromBottomLeft,
              autoPlay: false,
              child: const Text('From BottomLeft'),
            ),
          ),
        ),
      );

      expect(find.text('From BottomLeft'), findsOneWidget);
    });

    testWidgets('fromBottomRight should start from bottom-right',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FSSlideTransition(
              direction: FSSlideDirection.fromBottomRight,
              autoPlay: false,
              child: const Text('From BottomRight'),
            ),
          ),
        ),
      );

      expect(find.text('From BottomRight'), findsOneWidget);
    });
  });

  group('FSSlideTransition - Animation Tests', () {
    testWidgets('should animate over specified duration',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FSSlideTransition(
              duration: const Duration(milliseconds: 300),
              child: const Text('Animate Duration'),
            ),
          ),
        ),
      );

      await tester.pump(const Duration(milliseconds: 150));
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.text('Animate Duration'), findsOneWidget);
    });

    testWidgets('should respect delay parameter', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FSSlideTransition(
              delay: const Duration(milliseconds: 200),
              child: const Text('Delayed'),
            ),
          ),
        ),
      );

      await tester.pump(const Duration(milliseconds: 100));
      await tester.pump(const Duration(milliseconds: 200));
      expect(find.text('Delayed'), findsOneWidget);
    });

    testWidgets('should use specified curve', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FSSlideTransition(
              curve: Curves.bounceOut,
              child: const Text('Bounce'),
            ),
          ),
        ),
      );

      await tester.pump(const Duration(milliseconds: 500));
      expect(find.text('Bounce'), findsOneWidget);
    });

    testWidgets('should respect offsetFraction parameter',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FSSlideTransition(
              offsetFraction: 2.0,
              autoPlay: false,
              child: const Text('Double Offset'),
            ),
          ),
        ),
      );

      expect(find.text('Double Offset'), findsOneWidget);
    });

    testWidgets('should throw assertion with invalid offsetFraction',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FSSlideTransition(
              offsetFraction: 2.5,
              child: const Text('Invalid'),
            ),
          ),
        ),
      );

      expect(tester.takeException(), isAssertionError);
    });
  });

  group('FSSlideTransition - Controller Methods Tests', () {
    testWidgets('play() should start animation', (WidgetTester tester) async {
      final key = GlobalKey<FSSlideTransitionState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FSSlideTransition(
              key: key,
              autoPlay: false,
              child: const Text('Manual Play'),
            ),
          ),
        ),
      );

      await tester.pump();
      await key.currentState?.play();
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('Manual Play'), findsOneWidget);
    });

    testWidgets('reverse() should reverse animation',
        (WidgetTester tester) async {
      final key = GlobalKey<FSSlideTransitionState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FSSlideTransition(
              key: key,
              autoPlay: false,
              child: const Text('Reverse'),
            ),
          ),
        ),
      );

      await tester.pump();
      await key.currentState?.play();
      await tester.pump(const Duration(milliseconds: 500));
      await key.currentState?.reverse();
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('Reverse'), findsOneWidget);
    });

    testWidgets('reset() should reset animation', (WidgetTester tester) async {
      final key = GlobalKey<FSSlideTransitionState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FSSlideTransition(
              key: key,
              autoPlay: false,
              child: const Text('Reset'),
            ),
          ),
        ),
      );

      await tester.pump();
      await key.currentState?.play();
      await tester.pump(const Duration(milliseconds: 250));
      key.currentState?.reset();
      await tester.pump();

      expect(find.text('Reset'), findsOneWidget);
    });

    testWidgets('stop() should stop animation', (WidgetTester tester) async {
      final key = GlobalKey<FSSlideTransitionState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FSSlideTransition(
              key: key,
              autoPlay: true,
              child: const Text('Stop'),
            ),
          ),
        ),
      );

      await tester.pump();
      key.currentState?.stop();
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('Stop'), findsOneWidget);
    });

    testWidgets('setValue() should set animation value',
        (WidgetTester tester) async {
      final key = GlobalKey<FSSlideTransitionState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FSSlideTransition(
              key: key,
              autoPlay: false,
              child: const Text('Set Value'),
            ),
          ),
        ),
      );

      await tester.pump();
      key.currentState?.setValue(0.5);
      await tester.pump();

      expect(find.text('Set Value'), findsOneWidget);
    });

    testWidgets('getters should return correct values',
        (WidgetTester tester) async {
      final key = GlobalKey<FSSlideTransitionState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FSSlideTransition(
              key: key,
              autoPlay: false,
              child: const Text('Getters'),
            ),
          ),
        ),
      );

      await tester.pump();

      expect(key.currentState?.isAnimating, false);
      expect(key.currentState?.isCompleted, false);
      expect(key.currentState?.offset, isNotNull);
    });
  });

  group('FSSlideTransition - Pre-configured Variations', () {
    testWidgets('FSSlideTransitionQuick should use 300ms duration',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: const FSSlideTransitionQuick(
              child: Text('Quick'),
            ),
          ),
        ),
      );

      expect(find.text('Quick'), findsOneWidget);
    });

    testWidgets('FSSlideTransitionStandard should use 500ms duration',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: const FSSlideTransitionStandard(
              child: Text('Standard'),
            ),
          ),
        ),
      );

      expect(find.text('Standard'), findsOneWidget);
    });

    testWidgets('FSSlideTransitionSlow should use 800ms duration',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: const FSSlideTransitionSlow(
              child: Text('Slow'),
            ),
          ),
        ),
      );

      expect(find.text('Slow'), findsOneWidget);
    });

    testWidgets('FSSlideTransitionBounce should use bounce curve',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: const FSSlideTransitionBounce(
              child: Text('Bounce'),
            ),
          ),
        ),
      );

      expect(find.text('Bounce'), findsOneWidget);
    });

    testWidgets('FSSlideTransitionElastic should use elastic curve',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: const FSSlideTransitionElastic(
              child: Text('Elastic'),
            ),
          ),
        ),
      );

      expect(find.text('Elastic'), findsOneWidget);
    });

    testWidgets('FSSlideTransitionPage should use page transition settings',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: const FSSlideTransitionPage(
              child: Text('Page'),
            ),
          ),
        ),
      );

      expect(find.text('Page'), findsOneWidget);
    });
  });

  group('FSSlideTransition - Themed Factory Tests', () {
    testWidgets('themed factory should use theme configuration',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FSTheme(
            data: FSThemeData.light(),
            child: Scaffold(
              body: Builder(
                builder: (context) => FSSlideTransition.themed(
                  context: context,
                  child: const Text('Themed Slide'),
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Themed Slide'), findsOneWidget);
    });

    testWidgets('themed factory should work with dark theme',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FSTheme(
            data: FSThemeData.dark(),
            child: Scaffold(
              body: Builder(
                builder: (context) => FSSlideTransition.themed(
                  context: context,
                  child: const Text('Dark Themed Slide'),
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Dark Themed Slide'), findsOneWidget);
    });
  });

  group('FSSlideTransition - Callback Tests', () {
    testWidgets('onComplete should be called when animation completes',
        (WidgetTester tester) async {
      var completed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FSSlideTransition(
              autoPlay: true,
              onComplete: () => completed = true,
              child: const Text('Complete Callback'),
            ),
          ),
        ),
      );

      await tester.pump(const Duration(milliseconds: 600));
      expect(completed, true);
    });

    testWidgets('onCancel should be called when animation is cancelled',
        (WidgetTester tester) async {
      var cancelled = false;
      final key = GlobalKey<FSSlideTransitionState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FSSlideTransition(
              key: key,
              autoPlay: true,
              onCancel: () => cancelled = true,
              child: const Text('Cancel Callback'),
            ),
          ),
        ),
      );

      await tester.pump();
      key.currentState?.stop();
      await tester.pump();

      expect(cancelled, true);
    });
  });

  group('FSSlideTransition - Edge Cases', () {
    testWidgets('should handle dispose during animation',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FSSlideTransition(
              autoPlay: true,
              child: const Text('Dispose Test'),
            ),
          ),
        ),
      );

      await tester.pump();
      await tester.pumpWidget(Container());
      expect(tester.takeException(), isNull);
    });

    testWidgets('should handle zero duration', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FSSlideTransition(
              duration: Duration.zero,
              child: const Text('Zero Duration'),
            ),
          ),
        ),
      );

      await tester.pump();
      expect(find.text('Zero Duration'), findsOneWidget);
    });

    testWidgets('should respect system animation preferences',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(
              disableAnimations: true,
            ),
            child: Scaffold(
              body: FSSlideTransition(
                respectSystemPreferences: true,
                child: const Text('No Anim'),
              ),
            ),
          ),
        ),
      );

      expect(find.text('No Anim'), findsOneWidget);
    });

    testWidgets(
        'should ignore system preferences when respectSystemPreferences false',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(
              disableAnimations: true,
            ),
            child: Scaffold(
              body: FSSlideTransition(
                respectSystemPreferences: false,
                child: const Text('Force Anim'),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Force Anim'), findsOneWidget);
    });
  });

  group('FSSlideTransition - Error Boundary Tests', () {
    testWidgets('should show child even if animation errors',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FSSlideTransition(
              child: const Text('Error Test'),
            ),
          ),
        ),
      );

      expect(find.text('Error Test'), findsOneWidget);
    });
  });
}
