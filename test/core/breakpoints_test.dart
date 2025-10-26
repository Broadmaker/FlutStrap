import 'package:flutter_test/flutter_test.dart';
import 'package:master_flutstrap/core/breakpoints.dart';

void main() {
  group('FSBreakpoints', () {
    test('should have correct default values', () {
      expect(FSBreakpoints.xs, 576);
      expect(FSBreakpoints.sm, 768);
      expect(FSBreakpoints.md, 992);
      expect(FSBreakpoints.lg, 1200);
      expect(FSBreakpoints.xl, 1400);
    });

    test('value() should return correct numeric values', () {
      expect(FSBreakpoints.value(FSBreakpoint.xs), 576);
      expect(FSBreakpoints.value(FSBreakpoint.sm), 768);
      expect(FSBreakpoints.value(FSBreakpoint.md), 992);
      expect(FSBreakpoints.value(FSBreakpoint.lg), 1200);
      expect(FSBreakpoints.value(FSBreakpoint.xl), 1400);
      expect(FSBreakpoints.value(FSBreakpoint.xxl), 1400);
    });

    test('name() should return correct string names', () {
      expect(FSBreakpoints.name(FSBreakpoint.xs), 'xs');
      expect(FSBreakpoints.name(FSBreakpoint.sm), 'sm');
      expect(FSBreakpoints.name(FSBreakpoint.md), 'md');
      expect(FSBreakpoints.name(FSBreakpoint.lg), 'lg');
      expect(FSBreakpoints.name(FSBreakpoint.xl), 'xl');
      expect(FSBreakpoints.name(FSBreakpoint.xxl), 'xxl');
    });

    test('displayName() should return human-readable names', () {
      expect(FSBreakpoints.displayName(FSBreakpoint.xs), 'Extra Small');
      expect(FSBreakpoints.displayName(FSBreakpoint.sm), 'Small');
      expect(FSBreakpoints.displayName(FSBreakpoint.md), 'Medium');
      expect(FSBreakpoints.displayName(FSBreakpoint.lg), 'Large');
      expect(FSBreakpoints.displayName(FSBreakpoint.xl), 'Extra Large');
      expect(FSBreakpoints.displayName(FSBreakpoint.xxl), 'Double Extra Large');
    });
  });

  group('FSBreakpointExtensions', () {
    test('value getter should return correct values', () {
      expect(FSBreakpoint.xs.value, 576);
      expect(FSBreakpoint.sm.value, 768);
      expect(FSBreakpoint.md.value, 992);
    });

    test('name getter should return correct names', () {
      expect(FSBreakpoint.xs.name, 'xs');
      expect(FSBreakpoint.sm.name, 'sm');
      expect(FSBreakpoint.md.name, 'md');
    });

    test('displayName getter should return correct display names', () {
      expect(FSBreakpoint.xs.displayName, 'Extra Small');
      expect(FSBreakpoint.sm.displayName, 'Small');
      expect(FSBreakpoint.md.displayName, 'Medium');
    });

    test('isLargerThan should correctly compare breakpoints', () {
      expect(FSBreakpoint.lg.isLargerThan(FSBreakpoint.md), true);
      expect(FSBreakpoint.sm.isLargerThan(FSBreakpoint.lg), false);
      expect(FSBreakpoint.md.isLargerThan(FSBreakpoint.md), false);
    });

    test('isSmallerThan should correctly compare breakpoints', () {
      expect(FSBreakpoint.sm.isSmallerThan(FSBreakpoint.md), true);
      expect(FSBreakpoint.lg.isSmallerThan(FSBreakpoint.sm), false);
      expect(FSBreakpoint.md.isSmallerThan(FSBreakpoint.md), false);
    });

    test('isEqualOrLargerThan should correctly compare breakpoints', () {
      expect(FSBreakpoint.lg.isEqualOrLargerThan(FSBreakpoint.md), true);
      expect(FSBreakpoint.md.isEqualOrLargerThan(FSBreakpoint.md), true);
      expect(FSBreakpoint.sm.isEqualOrLargerThan(FSBreakpoint.lg), false);
    });

    test('isEqualOrSmallerThan should correctly compare breakpoints', () {
      expect(FSBreakpoint.sm.isEqualOrSmallerThan(FSBreakpoint.md), true);
      expect(FSBreakpoint.md.isEqualOrSmallerThan(FSBreakpoint.md), true);
      expect(FSBreakpoint.lg.isEqualOrSmallerThan(FSBreakpoint.sm), false);
    });
  });

  group('FSCustomBreakpoints', () {
    test('should use default values when not provided', () {
      const custom = FSCustomBreakpoints();
      expect(custom.xs, FSBreakpoints.xs);
      expect(custom.sm, FSBreakpoints.sm);
      expect(custom.md, FSBreakpoints.md);
      expect(custom.lg, FSBreakpoints.lg);
      expect(custom.xl, FSBreakpoints.xl);
      expect(custom.xxl, FSBreakpoints.xl);
    });

    test('should use custom values when provided', () {
      const custom = FSCustomBreakpoints(
        xs: 480,
        sm: 640,
        md: 800,
        lg: 1024,
        xl: 1280,
        xxl: 1536,
      );
      expect(custom.xs, 480);
      expect(custom.sm, 640);
      expect(custom.md, 800);
      expect(custom.lg, 1024);
      expect(custom.xl, 1280);
      expect(custom.xxl, 1536);
    });

    test('value() should return correct values for custom breakpoints', () {
      const custom = FSCustomBreakpoints(
        xs: 480,
        sm: 640,
        md: 800,
      );
      expect(custom.value(FSBreakpoint.xs), 480);
      expect(custom.value(FSBreakpoint.sm), 640);
      expect(custom.value(FSBreakpoint.md), 800);
      expect(custom.value(FSBreakpoint.lg), FSBreakpoints.lg); // default
    });

    test('getBreakpoint() should correctly identify breakpoints', () {
      const custom = FSCustomBreakpoints();

      expect(custom.getBreakpoint(400), FSBreakpoint.xs);
      expect(custom.getBreakpoint(600), FSBreakpoint.sm);
      expect(custom.getBreakpoint(800), FSBreakpoint.md);
      expect(custom.getBreakpoint(1100), FSBreakpoint.lg);
      expect(custom.getBreakpoint(1300), FSBreakpoint.xl);
      expect(custom.getBreakpoint(1500), FSBreakpoint.xxl);
    });

    test('copyWith should create updated instance', () {
      const original = FSCustomBreakpoints();
      final updated = original.copyWith(xs: 500, sm: 700);

      expect(updated.xs, 500);
      expect(updated.sm, 700);
      expect(updated.md, original.md); // unchanged
      expect(updated.lg, original.lg); // unchanged
    });
  });

  group('Breakpoint Edge Cases', () {
    test('should handle exact breakpoint values correctly', () {
      const custom = FSCustomBreakpoints();

      // Testing exact breakpoint values (should fall into the next larger category)
      expect(custom.getBreakpoint(576),
          FSBreakpoint.sm); // xs breakpoint, should be sm
      expect(custom.getBreakpoint(768),
          FSBreakpoint.md); // sm breakpoint, should be md
      expect(custom.getBreakpoint(992),
          FSBreakpoint.lg); // md breakpoint, should be lg
      expect(custom.getBreakpoint(1200),
          FSBreakpoint.xl); // lg breakpoint, should be xl
      expect(custom.getBreakpoint(1400),
          FSBreakpoint.xxl); // xl breakpoint, should be xxl
    });

    test('should handle zero and negative width', () {
      const custom = FSCustomBreakpoints();
      expect(custom.getBreakpoint(0), FSBreakpoint.xs);
      expect(custom.getBreakpoint(-100), FSBreakpoint.xs);
    });

    test('should handle very large widths', () {
      const custom = FSCustomBreakpoints();
      expect(custom.getBreakpoint(10000), FSBreakpoint.xxl);
      expect(custom.getBreakpoint(double.infinity), FSBreakpoint.xxl);
    });
  });
}
