import 'package:flutter_test/flutter_test.dart';
import 'package:master_flutstrap/core/spacing.dart';
import 'package:master_flutstrap/core/breakpoints.dart';

void main() {
  group('FSSpacing', () {
    test('should have correct default values', () {
      expect(FSSpacing.none, 0.0);
      expect(FSSpacing.xs, 4.0);
      expect(FSSpacing.sm, 8.0);
      expect(FSSpacing.md, 16.0);
      expect(FSSpacing.lg, 24.0);
      expect(FSSpacing.xl, 32.0);
      expect(FSSpacing.xxl, 48.0);
      expect(FSSpacing.xxxl, 64.0);
    });

    test('byIndex should return correct values', () {
      expect(FSSpacing.byIndex(0), 0.0);
      expect(FSSpacing.byIndex(1), 4.0);
      expect(FSSpacing.byIndex(2), 8.0);
      expect(FSSpacing.byIndex(3), 16.0);
      expect(FSSpacing.byIndex(4), 24.0);
      expect(FSSpacing.byIndex(5), 32.0);
      expect(FSSpacing.byIndex(6), 48.0);
      expect(FSSpacing.byIndex(7), 64.0);
    });

    test('byIndex should handle indices beyond scale', () {
      expect(FSSpacing.byIndex(8), 64.0); // 8 * 8 = 64
      expect(FSSpacing.byIndex(10), 80.0); // 8 * 10 = 80
    });

    test('values should return all spacing values', () {
      expect(FSSpacing.values, [0.0, 4.0, 8.0, 16.0, 24.0, 32.0, 48.0, 64.0]);
    });

    test('map should return correct mapping', () {
      final map = FSSpacing.map;
      expect(map['none'], 0.0);
      expect(map['xs'], 4.0);
      expect(map['sm'], 8.0);
      expect(map['md'], 16.0);
      expect(map['lg'], 24.0);
      expect(map['xl'], 32.0);
      expect(map['xxl'], 48.0);
      expect(map['xxxl'], 64.0);
    });
  });

  group('FSSpacingScaleExtensions', () {
    test('value getter should return correct values', () {
      expect(FSSpacingScale.none.value, 0.0);
      expect(FSSpacingScale.xs.value, 4.0);
      expect(FSSpacingScale.sm.value, 8.0);
      expect(FSSpacingScale.md.value, 16.0);
      expect(FSSpacingScale.lg.value, 24.0);
      expect(FSSpacingScale.xl.value, 32.0);
      expect(FSSpacingScale.xxl.value, 48.0);
      expect(FSSpacingScale.xxxl.value, 64.0);
    });

    test('name getter should return correct names', () {
      expect(FSSpacingScale.none.name, 'none');
      expect(FSSpacingScale.xs.name, 'xs');
      expect(FSSpacingScale.sm.name, 'sm');
      expect(FSSpacingScale.md.name, 'md');
      expect(FSSpacingScale.lg.name, 'lg');
      expect(FSSpacingScale.xl.name, 'xl');
      expect(FSSpacingScale.xxl.name, 'xxl');
      expect(FSSpacingScale.xxxl.name, 'xxxl');
    });
  });

  group('FSCustomSpacing', () {
    test('should use default values when not provided', () {
      const custom = FSCustomSpacing();
      expect(custom.none, FSSpacing.none);
      expect(custom.xs, FSSpacing.xs);
      expect(custom.sm, FSSpacing.sm);
      expect(custom.md, FSSpacing.md);
      expect(custom.lg, FSSpacing.lg);
      expect(custom.xl, FSSpacing.xl);
      expect(custom.xxl, FSSpacing.xxl);
      expect(custom.xxxl, FSSpacing.xxxl);
    });

    test('should use custom values when provided', () {
      const custom = FSCustomSpacing(
        none: 2.0,
        xs: 6.0,
        sm: 12.0,
        md: 20.0,
        lg: 28.0,
        xl: 36.0,
        xxl: 56.0,
        xxxl: 72.0,
      );
      expect(custom.none, 2.0);
      expect(custom.xs, 6.0);
      expect(custom.sm, 12.0);
      expect(custom.md, 20.0);
      expect(custom.lg, 28.0);
      expect(custom.xl, 36.0);
      expect(custom.xxl, 56.0);
      expect(custom.xxxl, 72.0);
    });

    test('value() should return correct values for spacing scales', () {
      const custom = FSCustomSpacing(
        sm: 12.0,
        md: 20.0,
      );
      expect(custom.value(FSSpacingScale.none), FSSpacing.none);
      expect(custom.value(FSSpacingScale.sm), 12.0);
      expect(custom.value(FSSpacingScale.md), 20.0);
      expect(custom.value(FSSpacingScale.lg), FSSpacing.lg);
    });

    test('byIndex() should return correct values', () {
      const custom = FSCustomSpacing(
        xs: 6.0,
        md: 20.0,
      );
      expect(custom.byIndex(0), FSSpacing.none);
      expect(custom.byIndex(1), 6.0);
      expect(custom.byIndex(2), FSSpacing.sm);
      expect(custom.byIndex(3), 20.0);
    });

    test('values should return all custom values', () {
      const custom = FSCustomSpacing(
        xs: 6.0,
        md: 20.0,
      );
      expect(custom.values, [
        FSSpacing.none,
        6.0,
        FSSpacing.sm,
        20.0,
        FSSpacing.lg,
        FSSpacing.xl,
        FSSpacing.xxl,
        FSSpacing.xxxl,
      ]);
    });

    test('copyWith should create updated instance', () {
      const original = FSCustomSpacing();
      final updated = original.copyWith(sm: 12.0, md: 20.0);

      expect(updated.sm, 12.0);
      expect(updated.md, 20.0);
      expect(updated.xs, original.xs); // unchanged
      expect(updated.lg, original.lg); // unchanged
    });

    test('withMultiplier should scale all values', () {
      const original = FSCustomSpacing();
      final scaled = original.withMultiplier(1.5);

      expect(scaled.none, 0.0); // 0 * 1.5 = 0
      expect(scaled.xs, 6.0); // 4 * 1.5 = 6
      expect(scaled.sm, 12.0); // 8 * 1.5 = 12
      expect(scaled.md, 24.0); // 16 * 1.5 = 24
      expect(scaled.lg, 36.0); // 24 * 1.5 = 36
    });
  });

  group('FSResponsiveSpacing', () {
    test('should use default values when not provided', () {
      const responsive = FSResponsiveSpacing();
      expect(responsive.xs, const FSCustomSpacing());
      expect(responsive.sm, const FSCustomSpacing());
      expect(responsive.md, const FSCustomSpacing());
      expect(responsive.lg, const FSCustomSpacing());
      expect(responsive.xl, const FSCustomSpacing());
      expect(responsive.xxl, const FSCustomSpacing());
    });

    test('should use custom values when provided', () {
      const customXs = FSCustomSpacing(sm: 4.0, md: 8.0);
      const customMd = FSCustomSpacing(sm: 12.0, md: 20.0);
      const responsive = FSResponsiveSpacing(
        xs: customXs,
        md: customMd,
      );

      expect(responsive.xs, customXs);
      expect(responsive.md, customMd);
      expect(responsive.sm, const FSCustomSpacing()); // default
    });

    test('forBreakpoint should return correct spacing', () {
      const customXs = FSCustomSpacing(sm: 4.0);
      const customMd = FSCustomSpacing(sm: 12.0);
      const responsive = FSResponsiveSpacing(
        xs: customXs,
        md: customMd,
      );

      expect(responsive.forBreakpoint(FSBreakpoint.xs), customXs);
      expect(responsive.forBreakpoint(FSBreakpoint.md), customMd);
      expect(
          responsive.forBreakpoint(FSBreakpoint.sm), const FSCustomSpacing());
    });

    test('copyWith should create updated instance', () {
      const original = FSResponsiveSpacing();
      const customXs = FSCustomSpacing(sm: 4.0);
      final updated = original.copyWith(xs: customXs);

      expect(updated.xs, customXs);
      expect(updated.sm, original.sm); // unchanged
      expect(updated.md, original.md); // unchanged
    });
  });

  group('Spacing Integration', () {
    test('should work with breakpoint system', () {
      const responsiveSpacing = FSResponsiveSpacing();
      const breakpoints = FSCustomBreakpoints();

      final currentBreakpoint = breakpoints.getBreakpoint(800); // md breakpoint
      final currentSpacing = responsiveSpacing.forBreakpoint(currentBreakpoint);

      expect(currentBreakpoint, FSBreakpoint.md);
      expect(currentSpacing.value(FSSpacingScale.md), FSSpacing.md);
    });
  });
}
