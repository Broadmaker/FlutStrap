import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart'; // Add this import
import 'package:master_flutstrap/core/utils.dart';

void main() {
  group('FSValidators', () {
    test('isEmpty should correctly check empty strings', () {
      expect(FSValidators.isEmpty(null), true);
      expect(FSValidators.isEmpty(''), true);
      expect(FSValidators.isEmpty('   '), true);
      expect(FSValidators.isEmpty('text'), false);
    });

    test('isNotEmpty should correctly check non-empty strings', () {
      expect(FSValidators.isNotEmpty(null), false);
      expect(FSValidators.isNotEmpty(''), false);
      expect(FSValidators.isNotEmpty('text'), true);
    });

    test('isEmail should validate email addresses', () {
      expect(FSValidators.isEmail(null), false);
      expect(FSValidators.isEmail(''), false);
      expect(FSValidators.isEmail('invalid'), false);
      expect(FSValidators.isEmail('test@example.com'), true);
      expect(FSValidators.isEmail('user.name@domain.co.uk'), true);
    });

    test('isPhoneNumber should validate phone numbers', () {
      // Debug: Check what happens with the test case
      final testNumber = '(555) 123-4567';
      final digitsOnly = testNumber.replaceAll(RegExp(r'[^\d]'), '');
      print(
          'Debug: "$testNumber" -> "$digitsOnly" (length: ${digitsOnly.length})');

      expect(FSValidators.isPhoneNumber(null), false);
      expect(FSValidators.isPhoneNumber(''), false);
      expect(FSValidators.isPhoneNumber('abc'), false);
      expect(FSValidators.isPhoneNumber('1234567890'), true);
      expect(FSValidators.isPhoneNumber('(555) 123-4567'), true);
      expect(FSValidators.isPhoneNumber('555-123-4567'), true);
      expect(FSValidators.isPhoneNumber('555.123.4567'), true);
      expect(FSValidators.isPhoneNumber('+1 555 123 4567'), true);
      expect(FSValidators.isPhoneNumber('+44 20 1234 5678'), true);
    });
    test('isUrl should validate URLs', () {
      expect(FSValidators.isUrl(null), false);
      expect(FSValidators.isUrl(''), false);
      expect(FSValidators.isUrl('invalid'), false);
      expect(FSValidators.isUrl('https://example.com'), true);
      expect(FSValidators.isUrl('http://www.example.com/path'), true);
    });

    test('checkPasswordStrength should assess password strength', () {
      expect(
          FSValidators.checkPasswordStrength('short'), FSPasswordStrength.weak);
      expect(FSValidators.checkPasswordStrength('password'),
          FSPasswordStrength.weak);
      expect(FSValidators.checkPasswordStrength('Password1'),
          FSPasswordStrength.medium);
      expect(FSValidators.checkPasswordStrength('StrongPass123!'),
          FSPasswordStrength.strong);
    });
  });

  group('FSPasswordStrengthExtensions', () {
    test('name should return correct display name', () {
      expect(FSPasswordStrength.weak.name, 'Weak');
      expect(FSPasswordStrength.medium.name, 'Medium');
      expect(FSPasswordStrength.strong.name, 'Strong');
    });

    test('color should return correct color', () {
      expect(FSPasswordStrength.weak.color, Colors.red);
      expect(FSPasswordStrength.medium.color, Colors.orange);
      expect(FSPasswordStrength.strong.color, Colors.green);
    });
  });

  group('FSUtils', () {
    test('capitalize should capitalize first letter', () {
      expect(FSUtils.capitalize(''), '');
      expect(FSUtils.capitalize('hello'), 'Hello');
      expect(FSUtils.capitalize('HELLO'), 'Hello');
    });

    test('capitalizeWords should capitalize each word', () {
      expect(FSUtils.capitalizeWords(''), '');
      expect(FSUtils.capitalizeWords('hello world'), 'Hello World');
      expect(FSUtils.capitalizeWords('HELLO WORLD'), 'Hello World');
    });

    test('truncate should shorten long text', () {
      expect(FSUtils.truncate('Hello World', 5), 'Hello...');
      expect(FSUtils.truncate('Hi', 5), 'Hi');
      expect(FSUtils.truncate('', 5), '');
    });

    test('generateId should generate IDs of correct length', () {
      final id1 = FSUtils.generateId(length: 8);
      final id2 = FSUtils.generateId(length: 12);

      expect(id1.length, 8);
      expect(id2.length, 12);
      expect(RegExp(r'^[a-z0-9]+$').hasMatch(id1), true);
    });

    test('formatFileSize should format bytes correctly', () {
      expect(FSUtils.formatFileSize(500), '500 B');
      expect(FSUtils.formatFileSize(1500), '1.5 KB');
      expect(FSUtils.formatFileSize(1500000), '1.4 MB');
    });
  });

  group('FSDates', () {
    test('isSameDay should check if dates are same day', () {
      final date1 = DateTime(2023, 1, 1, 10, 30);
      final date2 = DateTime(2023, 1, 1, 15, 45);
      final date3 = DateTime(2023, 1, 2, 10, 30);

      expect(FSDates.isSameDay(date1, date2), true);
      expect(FSDates.isSameDay(date1, date3), false);
    });

    test('startOfDay should return beginning of day', () {
      final date = DateTime(2023, 1, 1, 10, 30, 45);
      final start = FSDates.startOfDay(date);

      expect(start.year, 2023);
      expect(start.month, 1);
      expect(start.day, 1);
      expect(start.hour, 0);
      expect(start.minute, 0);
      expect(start.second, 0);
    });

    test('endOfDay should return end of day', () {
      final date = DateTime(2023, 1, 1, 10, 30, 45);
      final end = FSDates.endOfDay(date);

      expect(end.year, 2023);
      expect(end.month, 1);
      expect(end.day, 1);
      expect(end.hour, 23);
      expect(end.minute, 59);
      expect(end.second, 59);
    });
  });

  group('FSNumbers', () {
    test('formatNumber should add commas', () {
      expect(FSNumbers.formatNumber(1000), '1,000');
      expect(FSNumbers.formatNumber(1000000), '1,000,000');
      expect(FSNumbers.formatNumber(123), '123');
    });

    test('clamp should limit values', () {
      expect(FSNumbers.clamp(5, 0, 10), 5);
      expect(FSNumbers.clamp(-5, 0, 10), 0);
      expect(FSNumbers.clamp(15, 0, 10), 10);
    });

    test('lerp should interpolate between values', () {
      expect(FSNumbers.lerp(0, 10, 0.5), 5.0);
      expect(FSNumbers.lerp(10, 20, 0.25), 12.5);
      expect(FSNumbers.lerp(5, 15, 1.0), 15.0);
    });

    test('isNumeric should check if string is numeric', () {
      expect(FSNumbers.isNumeric(null), false);
      expect(FSNumbers.isNumeric(''), false);
      expect(FSNumbers.isNumeric('abc'), false);
      expect(FSNumbers.isNumeric('123'), true);
      expect(FSNumbers.isNumeric('123.45'), true);
    });
  });

  group('FSPlatform', () {
    test('isWeb should return a boolean value', () {
      // Just test that it returns a boolean, not a specific value
      // since the result depends on the environment
      final result = FSPlatform.isWeb;
      expect(result, isA<bool>());
    });

    test('isMobile should return the opposite of isWeb', () {
      final isWeb = FSPlatform.isWeb;
      final isMobile = FSPlatform.isMobile;
      expect(isMobile, !isWeb);
    });
  });
}
