import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutstrap/flutstrap.dart';

void main() {
  group('FSValidators Tests', () {
    test('isEmpty should return true for null or whitespace', () {
      expect(FSValidators.isEmpty(null), true);
      expect(FSValidators.isEmpty(''), true);
      expect(FSValidators.isEmpty('   '), true);
      expect(FSValidators.isEmpty('text'), false);
      expect(FSValidators.isEmpty(' text '), false);
    });

    test('isNotEmpty should return true for non-empty strings', () {
      expect(FSValidators.isNotEmpty(null), false);
      expect(FSValidators.isNotEmpty(''), false);
      expect(FSValidators.isNotEmpty('   '), false);
      expect(FSValidators.isNotEmpty('text'), true);
      expect(FSValidators.isNotEmpty(' text '), true);
    });

    test('isEmail should validate email formats correctly', () {
      // Valid emails
      expect(FSValidators.isEmail('user@example.com'), true);
      expect(FSValidators.isEmail('user.name@example.com'), true);
      expect(FSValidators.isEmail('user+tag@example.com'), true);
      expect(FSValidators.isEmail('user@example.co.uk'), true);
      expect(FSValidators.isEmail('123@example.com'), true);

      // Invalid emails
      expect(FSValidators.isEmail(null), false);
      expect(FSValidators.isEmail(''), false);
      expect(FSValidators.isEmail(' '), false);
      expect(FSValidators.isEmail('user@'), false);
      expect(FSValidators.isEmail('@example.com'), false);
      expect(FSValidators.isEmail('user@.com'), false);
      expect(FSValidators.isEmail('user@com'), false);
      expect(FSValidators.isEmail('user.example.com'), false);
    });

    test('isPhoneNumber should validate phone numbers correctly', () {
      // Valid phone numbers
      expect(FSValidators.isPhoneNumber('+1 (555) 123-4567'), true);
      expect(FSValidators.isPhoneNumber('555-123-4567'), true);
      expect(FSValidators.isPhoneNumber('555.123.4567'), true);
      expect(FSValidators.isPhoneNumber('555 123 4567'), true);
      expect(FSValidators.isPhoneNumber('+441234567890'), true);
      expect(FSValidators.isPhoneNumber('1234567890'), true);

      // Invalid phone numbers
      expect(FSValidators.isPhoneNumber(null), false);
      expect(FSValidators.isPhoneNumber(''), false);
      expect(FSValidators.isPhoneNumber(' '), false);
      expect(FSValidators.isPhoneNumber('abc'), false);
      expect(FSValidators.isPhoneNumber('123'), false); // Too short
      expect(FSValidators.isPhoneNumber('123-abc-4567'), false);
    });

    test('isUrl should validate URLs correctly', () {
      // Valid URLs
      expect(FSValidators.isUrl('https://example.com'), true);
      expect(FSValidators.isUrl('http://example.com'), true);
      expect(FSValidators.isUrl('https://www.example.com'), true);
      expect(FSValidators.isUrl('example.com'), true);
      expect(FSValidators.isUrl('sub.example.co.uk'), true);
      expect(FSValidators.isUrl('https://example.com/path'), true);
      expect(FSValidators.isUrl('https://example.com/path?query=1'), true);

      // Invalid URLs
      expect(FSValidators.isUrl(null), false);
      expect(FSValidators.isUrl(''), false);
      expect(FSValidators.isUrl(' '), false);
      expect(FSValidators.isUrl('example'), false);
      expect(FSValidators.isUrl('http://'), false);
      expect(FSValidators.isUrl('https://'), false);
    });

    test('checkPasswordStrength should evaluate password strength', () {
      // Weak passwords
      expect(FSValidators.checkPasswordStrength('a'), FSPasswordStrength.weak);
      expect(
          FSValidators.checkPasswordStrength('12345'), FSPasswordStrength.weak);
      expect(FSValidators.checkPasswordStrength('abcdef'),
          FSPasswordStrength.weak);

      // Medium passwords
      expect(FSValidators.checkPasswordStrength('Abc123'),
          FSPasswordStrength.medium);
      expect(FSValidators.checkPasswordStrength('Password1'),
          FSPasswordStrength.medium);
      expect(FSValidators.checkPasswordStrength('Secure123'),
          FSPasswordStrength.medium);

      // Strong passwords
      expect(FSValidators.checkPasswordStrength('SecureP@ss123'),
          FSPasswordStrength.strong);
      expect(FSValidators.checkPasswordStrength('Str0ng!Passw0rd'),
          FSPasswordStrength.strong);
      expect(FSValidators.checkPasswordStrength('VeryLongSecureP@ssw0rd123'),
          FSPasswordStrength.strong);
    });

    test('isNumeric should validate numeric strings', () {
      // Valid numbers
      expect(FSValidators.isNumeric('123'), true);
      expect(FSValidators.isNumeric('123.45'), true);
      expect(FSValidators.isNumeric('0'), true);
      expect(FSValidators.isNumeric('-123'), true);
      expect(FSValidators.isNumeric('123e5'), true);

      // Invalid numbers
      expect(FSValidators.isNumeric(null), false);
      expect(FSValidators.isNumeric(''), false);
      expect(FSValidators.isNumeric(' '), false);
      expect(FSValidators.isNumeric('abc'), false);
      expect(FSValidators.isNumeric('123abc'), false);
    });
  });

  group('FSPasswordStrength Tests', () {
    test('name should return correct display names', () {
      expect(FSPasswordStrength.weak.name, 'Weak');
      expect(FSPasswordStrength.medium.name, 'Medium');
      expect(FSPasswordStrength.strong.name, 'Strong');
    });

    test('color should return correct colors', () {
      expect(FSPasswordStrength.weak.color, Colors.redAccent);
      expect(FSPasswordStrength.medium.color, Colors.orangeAccent);
      expect(FSPasswordStrength.strong.color, Colors.greenAccent);
    });

    test('description should return correct descriptions', () {
      expect(
          FSPasswordStrength.weak.description, contains('Add more characters'));
      expect(FSPasswordStrength.medium.description, contains('Good'));
      expect(FSPasswordStrength.strong.description, contains('Excellent'));
    });
  });

  group('FSUtils Tests', () {
    test('capitalize should capitalize first letter', () {
      expect(FSUtils.capitalize('hello'), 'Hello');
      expect(FSUtils.capitalize('HELLO'), 'Hello');
      expect(FSUtils.capitalize('hello world'), 'Hello world');
      expect(FSUtils.capitalize(''), '');
      expect(FSUtils.capitalize('h'), 'H');
      expect(FSUtils.capitalize('123'), '123');
    });

    test('capitalizeWords should capitalize each word', () {
      expect(FSUtils.capitalizeWords('hello world'), 'Hello World');
      expect(FSUtils.capitalizeWords('HELLO WORLD'), 'Hello World');
      expect(FSUtils.capitalizeWords('hello'), 'Hello');
      expect(FSUtils.capitalizeWords(''), '');
      expect(FSUtils.capitalizeWords('hello  world'), 'Hello  World');
    });

    test('truncate should truncate text with ellipsis', () {
      expect(FSUtils.truncate('Hello world', 5), 'Hello...');
      expect(FSUtils.truncate('Hello', 10), 'Hello');
      expect(FSUtils.truncate('', 5), '');
      expect(FSUtils.truncate('Hello world', 0), '');

      expect(() => FSUtils.truncate('Hello', -1), throwsAssertionError);
    });

    test('generateId should create random IDs', () {
      final id1 = FSUtils.generateId();
      final id2 = FSUtils.generateId();

      expect(id1.length, 8);
      expect(id2.length, 8);
      expect(id1, isNot(id2)); // Should be unique

      final id3 = FSUtils.generateId(length: 12);
      expect(id3.length, 12);

      expect(() => FSUtils.generateId(length: 0), throwsAssertionError);
    });

    test('formatFileSize should format bytes correctly', () {
      expect(FSUtils.formatFileSize(0), '0 B');
      expect(FSUtils.formatFileSize(500), '500 B');
      expect(FSUtils.formatFileSize(1024), '1.0 KB');
      expect(FSUtils.formatFileSize(2048), '2.0 KB');
      expect(FSUtils.formatFileSize(1048576), '1.0 MB');
      expect(FSUtils.formatFileSize(2097152), '2.0 MB');
      expect(FSUtils.formatFileSize(1073741824), '1.0 GB');

      expect(() => FSUtils.formatFileSize(-1), throwsAssertionError);
    });

    test('debounce should delay function execution', () async {
      var callCount = 0;
      final debounced = FSUtils.debounce(
        () => callCount++,
        delay: const Duration(milliseconds: 50),
      );

      debounced();
      debounced();
      debounced();

      expect(callCount, 0);

      await Future.delayed(const Duration(milliseconds: 100));
      expect(callCount, 1);
    });

    test('debounceWith should delay function with value', () async {
      var lastValue = '';
      final debounced = FSUtils.debounceWith<String>(
        (value) => lastValue = value,
        delay: const Duration(milliseconds: 50),
      );

      debounced('first');
      debounced('second');
      debounced('third');

      expect(lastValue, '');

      await Future.delayed(const Duration(milliseconds: 100));
      expect(lastValue, 'third');
    });

    test('throttle should limit function calls', () async {
      var callCount = 0;
      final throttled = FSUtils.throttle(
        () => callCount++,
        delay: const Duration(milliseconds: 50),
      );

      throttled();
      throttled();
      throttled();

      expect(callCount, 1);

      await Future.delayed(const Duration(milliseconds: 100));
      throttled();
      expect(callCount, 2);
    });

    test('safeToString should handle null values', () {
      expect(FSUtils.safeToString(null), '');
      expect(FSUtils.safeToString('text'), 'text');
      expect(FSUtils.safeToString(123), '123');
      expect(FSUtils.safeToString(true), 'true');
      expect(FSUtils.safeToString([1, 2]), '[1, 2]');
    });
  });

  group('FSDates Tests', () {
    test('relativeTime should format relative time correctly', () {
      final now = DateTime.now();

      expect(FSDates.relativeTime(now), 'just now');

      final oneMinuteAgo = now.subtract(const Duration(minutes: 1));
      expect(FSDates.relativeTime(oneMinuteAgo), '1 minute ago');

      final fiveMinutesAgo = now.subtract(const Duration(minutes: 5));
      expect(FSDates.relativeTime(fiveMinutesAgo), '5 minutes ago');

      final oneHourAgo = now.subtract(const Duration(hours: 1));
      expect(FSDates.relativeTime(oneHourAgo), '1 hour ago');

      final threeHoursAgo = now.subtract(const Duration(hours: 3));
      expect(FSDates.relativeTime(threeHoursAgo), '3 hours ago');

      final oneDayAgo = now.subtract(const Duration(days: 1));
      expect(FSDates.relativeTime(oneDayAgo), '1 day ago');

      final threeDaysAgo = now.subtract(const Duration(days: 3));
      expect(FSDates.relativeTime(threeDaysAgo), '3 days ago');

      final oneWeekAgo = now.subtract(const Duration(days: 7));
      expect(FSDates.relativeTime(oneWeekAgo), '1 week ago');

      final threeWeeksAgo = now.subtract(const Duration(days: 21));
      expect(FSDates.relativeTime(threeWeeksAgo), '3 weeks ago');
    });

    test('isSameDay should check if dates are same day', () {
      final date1 = DateTime(2023, 1, 1, 10, 30);
      final date2 = DateTime(2023, 1, 1, 15, 45);
      final date3 = DateTime(2023, 1, 2, 10, 30);

      expect(FSDates.isSameDay(date1, date2), true);
      expect(FSDates.isSameDay(date1, date3), false);
    });

    test('startOfDay should return midnight', () {
      final date = DateTime(2023, 1, 1, 14, 30, 45, 500);
      final start = FSDates.startOfDay(date);

      expect(start.year, 2023);
      expect(start.month, 1);
      expect(start.day, 1);
      expect(start.hour, 0);
      expect(start.minute, 0);
      expect(start.second, 0);
      expect(start.millisecond, 0);
    });

    test('endOfDay should return end of day', () {
      final date = DateTime(2023, 1, 1, 14, 30, 45, 500);
      final end = FSDates.endOfDay(date);

      expect(end.year, 2023);
      expect(end.month, 1);
      expect(end.day, 1);
      expect(end.hour, 23);
      expect(end.minute, 59);
      expect(end.second, 59);
      expect(end.millisecond, 999);
    });

    test('calculateAge should calculate age correctly', () {
      final now = DateTime.now();
      final birthDate = DateTime(now.year - 25, now.month, now.day);
      expect(FSDates.calculateAge(birthDate), 25);

      // Birthday not yet passed this year
      final futureBirth = DateTime(now.year - 30, now.month + 1, now.day);
      expect(FSDates.calculateAge(futureBirth), 29);
    });
  });

  group('FSNumbers Tests', () {
    test('formatNumber should add thousand separators', () {
      expect(FSNumbers.formatNumber(1234), '1,234');
      expect(FSNumbers.formatNumber(1234567), '1,234,567');
      expect(FSNumbers.formatNumber(1234.56), '1,234.56');
      expect(FSNumbers.formatNumber(1234567.89), '1,234,567.89');
      expect(FSNumbers.formatNumber(0), '0');
    });

    test('clamp should clamp values correctly', () {
      expect(FSNumbers.clamp(15, 10, 20), 15);
      expect(FSNumbers.clamp(5, 10, 20), 10);
      expect(FSNumbers.clamp(25, 10, 20), 20);
      expect(FSNumbers.clamp(10.5, 10, 20), 10.5);

      expect(() => FSNumbers.clamp(15, 20, 10), throwsAssertionError);
    });

    test('lerp should interpolate linearly', () {
      expect(FSNumbers.lerp(0, 100, 0), 0);
      expect(FSNumbers.lerp(0, 100, 0.5), 50);
      expect(FSNumbers.lerp(0, 100, 1), 100);
      expect(FSNumbers.lerp(50, 100, 0.5), 75);
      expect(FSNumbers.lerp(-50, 50, 0.5), 0);
    });

    test('formatCurrency should format currency', () {
      expect(FSNumbers.formatCurrency(1234.56), '\$1,234.56');
      expect(FSNumbers.formatCurrency(1234.56, symbol: '€'), '€1,234.56');
      expect(FSNumbers.formatCurrency(1000), '\$1,000.00');
      expect(FSNumbers.formatCurrency(0), '\$0.00');
    });

    test('percentage should calculate percentage', () {
      expect(FSNumbers.percentage(50, 200), 25);
      expect(FSNumbers.percentage(75, 150), 50);
      expect(FSNumbers.percentage(0, 100), 0);
      expect(FSNumbers.percentage(100, 100), 100);

      expect(() => FSNumbers.percentage(50, 0), throwsAssertionError);
    });
  });

  group('FSPlatform Tests', () {
    test('platform properties should return correct values', () {
      // These tests will run on the current platform
      // We can only verify they return the correct type
      expect(FSPlatform.isWeb, isA<bool>());
      expect(FSPlatform.isAndroid, isA<bool>());
      expect(FSPlatform.isIOS, isA<bool>());
      expect(FSPlatform.isMobile, isA<bool>());
      expect(FSPlatform.isDesktop, isA<bool>());
      expect(FSPlatform.platformName, isA<String>());
    });
  });

  group('FSErrors Tests', () {
    test('tryCatch should handle errors gracefully', () {
      // Successful execution
      final result = FSErrors.tryCatch(
        () => 'success',
      );
      expect(result, 'success');

      // Error with fallback
      final fallbackResult = FSErrors.tryCatch(
        () => throw Exception('Error'),
        fallback: 'fallback',
      );
      expect(fallbackResult, 'fallback');

      // Error with callback
      var errorCalled = false;
      final callbackResult = FSErrors.tryCatch(
        () => throw Exception('Error'),
        onError: (error, stack) {
          errorCalled = true;
        },
        fallback: 'fallback',
      );
      expect(callbackResult, 'fallback');
      expect(errorCalled, true);
    });

    test('tryCatchAsync should handle async errors', () async {
      // Successful execution
      final result = await FSErrors.tryCatchAsync(
        () async => 'success',
      );
      expect(result, 'success');

      // Error with fallback
      final fallbackResult = await FSErrors.tryCatchAsync(
        () async => throw Exception('Error'),
        fallback: 'fallback',
      );
      expect(fallbackResult, 'fallback');

      // Error with callback
      var errorCalled = false;
      final callbackResult = await FSErrors.tryCatchAsync(
        () async => throw Exception('Error'),
        onError: (error, stack) {
          errorCalled = true;
        },
        fallback: 'fallback',
      );
      expect(callbackResult, 'fallback');
      expect(errorCalled, true);
    });
  });

  group('Integration Tests', () {
    test('should combine multiple utilities', () {
      // Test a realistic scenario: validate and format user input
      final email = '  USER@EXAMPLE.COM  ';
      final trimmedEmail = email.trim();

      expect(FSValidators.isEmail(trimmedEmail), true);
      expect(
          FSUtils.capitalize(trimmedEmail.toLowerCase()), 'User@example.com');
    });

    test('should handle edge cases across utilities', () {
      // Test with empty/null values across multiple utilities
      expect(FSValidators.isEmpty(null), true);
      expect(FSValidators.isEmail(null), false);
      expect(FSUtils.truncate('', 5), '');
      expect(FSUtils.safeToString(null), '');

      final now = DateTime.now();
      expect(FSDates.relativeTime(now), 'just now');
    });
  });
}
