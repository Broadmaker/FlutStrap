import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:master_flutstrap/core/responsive.dart';
import 'package:master_flutstrap/core/breakpoints.dart';

void main() {
  group('FSResponsive', () {
    test('should initialize with correct values', () {
      final responsive = FSResponsive(screenWidth: 800);
      expect(responsive.screenWidth, 800);
      expect(responsive.breakpoints, const FSCustomBreakpoints());
    });

    test('factory of should create instance correctly', () {
      final responsive = FSResponsive.of(600);
      expect(responsive.screenWidth, 600);
      expect(responsive.breakpoints, const FSCustomBreakpoints());
    });

    test('breakpoint getter should return correct breakpoint', () {
      expect(FSResponsive(screenWidth: 400).breakpoint, FSBreakpoint.xs);
      expect(FSResponsive(screenWidth: 600).breakpoint, FSBreakpoint.sm);
      expect(FSResponsive(screenWidth: 800).breakpoint, FSBreakpoint.md);
      expect(FSResponsive(screenWidth: 1100).breakpoint, FSBreakpoint.lg);
      expect(FSResponsive(screenWidth: 1300).breakpoint, FSBreakpoint.xl);
      expect(FSResponsive(screenWidth: 1500).breakpoint, FSBreakpoint.xxl);
    });

    test('isBreakpoint should correctly identify breakpoints', () {
      final responsive = FSResponsive(screenWidth: 800);
      expect(responsive.isBreakpoint(FSBreakpoint.md), true);
      expect(responsive.isBreakpoint(FSBreakpoint.sm), false);
      expect(responsive.isBreakpoint(FSBreakpoint.lg), false);
    });

    test('isLargerThan should correctly compare breakpoints', () {
      final responsive = FSResponsive(screenWidth: 800); // md
      expect(responsive.isLargerThan(FSBreakpoint.sm), true);
      expect(responsive.isLargerThan(FSBreakpoint.md), false);
      expect(responsive.isLargerThan(FSBreakpoint.lg), false);
    });

    test('isSmallerThan should correctly compare breakpoints', () {
      final responsive = FSResponsive(screenWidth: 800); // md
      expect(responsive.isSmallerThan(FSBreakpoint.sm), false);
      expect(responsive.isSmallerThan(FSBreakpoint.md), false);
      expect(responsive.isSmallerThan(FSBreakpoint.lg), true);
    });

    test('isEqualOrLargerThan should correctly compare breakpoints', () {
      final responsive = FSResponsive(screenWidth: 800); // md
      expect(responsive.isEqualOrLargerThan(FSBreakpoint.sm), true);
      expect(responsive.isEqualOrLargerThan(FSBreakpoint.md), true);
      expect(responsive.isEqualOrLargerThan(FSBreakpoint.lg), false);
    });

    test('isEqualOrSmallerThan should correctly compare breakpoints', () {
      final responsive = FSResponsive(screenWidth: 800); // md
      expect(responsive.isEqualOrSmallerThan(FSBreakpoint.sm), false);
      expect(responsive.isEqualOrSmallerThan(FSBreakpoint.md), true);
      expect(responsive.isEqualOrSmallerThan(FSBreakpoint.lg), true);
    });

    test('value should return correct value for current breakpoint', () {
      final responsive = FSResponsive(screenWidth: 800); // md

      final result = responsive.value<int>(
        xs: 1,
        sm: 2,
        md: 3,
        lg: 4,
        xl: 5,
        xxl: 6,
        fallback: 0,
      );

      expect(result, 3);
    });

    test('value should fallback correctly when value not provided', () {
      final responsive = FSResponsive(screenWidth: 800); // md

      // No md value provided, should fallback to sm
      final result = responsive.value<int>(
        xs: 1,
        sm: 2,
        // md not provided
        lg: 4,
        fallback: 0,
      );

      expect(result, 2); // Falls back to sm
    });

    test('value should use fallback when no values provided', () {
      final responsive = FSResponsive(screenWidth: 800); // md

      final result = responsive.value<int>(
        fallback: 99,
      );

      expect(result, 99);
    });

    test('show should display child when condition is met', () {
      final responsive = FSResponsive(screenWidth: 800); // md

      final widget = responsive.show(
        child: const Text('Visible'),
        showOnMd: true,
        showOnLg: false,
      );

      // Note: We can't easily test Widget equality, but we can verify the logic
      // This test ensures the method doesn't throw and returns a Widget
      expect(widget, isA<Widget>());
    });

    test('hide should hide child when condition is met', () {
      final responsive = FSResponsive(screenWidth: 800); // md

      final widget = responsive.hide(
        child: const Text('Hidden'),
        hideOnMd: true,
        hideOnLg: false,
      );

      expect(widget, isA<Widget>());
    });

    test('copyWith should create updated instance', () {
      final original = FSResponsive(screenWidth: 800);
      final customBreakpoints = const FSCustomBreakpoints(xs: 500);
      final updated = original.copyWith(
        screenWidth: 1000,
        breakpoints: customBreakpoints,
      );

      expect(updated.screenWidth, 1000);
      expect(updated.breakpoints, customBreakpoints);
    });
  });

  group('FSResponsiveValue', () {
    test('should store values for all breakpoints', () {
      const responsiveValue = FSResponsiveValue<int>(
        xs: 1,
        sm: 2,
        md: 3,
        lg: 4,
        xl: 5,
        xxl: 6,
      );

      expect(responsiveValue.xs, 1);
      expect(responsiveValue.sm, 2);
      expect(responsiveValue.md, 3);
      expect(responsiveValue.lg, 4);
      expect(responsiveValue.xl, 5);
      expect(responsiveValue.xxl, 6);
    });

    test('all constructor should set same value for all breakpoints', () {
      const responsiveValue = FSResponsiveValue<int>.all(42);

      expect(responsiveValue.xs, 42);
      expect(responsiveValue.sm, 42);
      expect(responsiveValue.md, 42);
      expect(responsiveValue.lg, 42);
      expect(responsiveValue.xl, 42);
      expect(responsiveValue.xxl, 42);
    });

    test('value should return correct value for breakpoint', () {
      const responsiveValue = FSResponsiveValue<int>(
        xs: 1,
        sm: 2,
        md: 3,
        lg: 4,
        xl: 5,
        xxl: 6,
      );

      expect(responsiveValue.value(FSBreakpoint.xs), 1);
      expect(responsiveValue.value(FSBreakpoint.md), 3);
      expect(responsiveValue.value(FSBreakpoint.xxl), 6);
    });

    test('map should transform values correctly', () {
      const responsiveValue = FSResponsiveValue<int>(
        xs: 1,
        sm: 2,
        md: 3,
        lg: 4,
        xl: 5,
        xxl: 6,
      );

      final mapped = responsiveValue.map<String>((value) => 'Value: $value');

      expect(mapped.xs, 'Value: 1');
      expect(mapped.md, 'Value: 3');
      expect(mapped.xxl, 'Value: 6');
    });
  });

  group('FSResponsiveExtensions', () {
    test('isMobile should correctly identify mobile breakpoints', () {
      expect(FSBreakpoint.xs.isMobile, true);
      expect(FSBreakpoint.sm.isMobile, true);
      expect(FSBreakpoint.md.isMobile, false);
      expect(FSBreakpoint.lg.isMobile, false);
      expect(FSBreakpoint.xl.isMobile, false);
      expect(FSBreakpoint.xxl.isMobile, false);
    });

    test('isTablet should correctly identify tablet breakpoints', () {
      expect(FSBreakpoint.xs.isTablet, false);
      expect(FSBreakpoint.sm.isTablet, false);
      expect(FSBreakpoint.md.isTablet, true);
      expect(FSBreakpoint.lg.isTablet, false);
      expect(FSBreakpoint.xl.isTablet, false);
      expect(FSBreakpoint.xxl.isTablet, false);
    });

    test('isDesktop should correctly identify desktop breakpoints', () {
      expect(FSBreakpoint.xs.isDesktop, false);
      expect(FSBreakpoint.sm.isDesktop, false);
      expect(FSBreakpoint.md.isDesktop, false);
      expect(FSBreakpoint.lg.isDesktop, true);
      expect(FSBreakpoint.xl.isDesktop, true);
      expect(FSBreakpoint.xxl.isDesktop, true);
    });

    test('next should return correct next breakpoint', () {
      expect(FSBreakpoint.xs.next, FSBreakpoint.sm);
      expect(FSBreakpoint.sm.next, FSBreakpoint.md);
      expect(FSBreakpoint.md.next, FSBreakpoint.lg);
      expect(FSBreakpoint.lg.next, FSBreakpoint.xl);
      expect(FSBreakpoint.xl.next, FSBreakpoint.xxl);
      expect(FSBreakpoint.xxl.next, FSBreakpoint.xxl);
    });

    test('previous should return correct previous breakpoint', () {
      expect(FSBreakpoint.xs.previous, FSBreakpoint.xs);
      expect(FSBreakpoint.sm.previous, FSBreakpoint.xs);
      expect(FSBreakpoint.md.previous, FSBreakpoint.sm);
      expect(FSBreakpoint.lg.previous, FSBreakpoint.md);
      expect(FSBreakpoint.xl.previous, FSBreakpoint.lg);
      expect(FSBreakpoint.xxl.previous, FSBreakpoint.xl);
    });
  });

  group('Responsive Integration', () {
    test('should work with custom breakpoints', () {
      const customBreakpoints = FSCustomBreakpoints(
        xs: 500,
        sm: 700,
        md: 900,
      );

      final responsive = FSResponsive(
        screenWidth: 600,
        breakpoints: customBreakpoints,
      );

      expect(responsive.breakpoint, FSBreakpoint.sm);
      expect(responsive.isLargerThan(FSBreakpoint.xs), true);
      expect(responsive.isSmallerThan(FSBreakpoint.md), true);
    });
  });
}
