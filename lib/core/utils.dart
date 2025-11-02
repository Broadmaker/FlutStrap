/// Flutstrap Core Utilities
///
/// Shared helper functions, validators, and common utilities used throughout
/// the Flutstrap framework.
///
/// {@category Core}
/// {@category Utilities}

import 'dart:math';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Common validation utilities
///
/// Provides static methods for common input validation scenarios including
/// email, phone, URL, and password strength validation.
class FSValidators {
  // Pre-compiled regex patterns for better performance
  static final _emailRegex = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  static final _urlRegex = RegExp(
    r'^(https?://)?([\da-z.-]+)\.([a-z.]{2,6})([/\w .-]*)*\/?$',
    caseSensitive: false,
  );

  static final _phoneRegex =
      RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');

  /// Check if string is empty or contains only whitespace
  ///
  /// Example:
  /// ```dart
  /// if (FSValidators.isEmpty(null)) // true
  /// if (FSValidators.isEmpty('  ')) // true
  /// if (FSValidators.isEmpty('text')) // false
  /// ```
  static bool isEmpty(String? value) {
    return value == null || value.trim().isEmpty;
  }

  /// Check if string is not empty and contains non-whitespace characters
  ///
  /// Example:
  /// ```dart
  /// if (FSValidators.isNotEmpty('text')) // true
  /// ```
  static bool isNotEmpty(String? value) {
    return !isEmpty(value);
  }

  /// Email validation with comprehensive regex pattern
  ///
  /// Validates standard email format. Returns `false` for null, empty, or invalid emails.
  ///
  /// Example:
  /// ```dart
  /// if (FSValidators.isEmail('user@example.com')) {
  ///   print('Valid email');
  /// }
  /// ```
  static bool isEmail(String? value) {
    final cleanValue = value?.trim();
    if (cleanValue == null || cleanValue.isEmpty) return false;
    return _emailRegex.hasMatch(cleanValue);
  }

  /// Phone number validation with international support
  ///
  /// Supports various formats including international numbers with country codes.
  /// Minimum 10 digits required after cleaning.
  ///
  /// Example:
  /// ```dart
  /// FSValidators.isPhoneNumber('+1 (555) 123-4567'); // true
  /// ```
  static bool isPhoneNumber(String? value) {
    final cleanValue = value?.trim();
    if (cleanValue == null || cleanValue.isEmpty) return false;

    // Basic format check
    if (!_phoneRegex.hasMatch(cleanValue)) return false;

    // Digit count check (minimum 10 digits for most countries)
    final digitsOnly = cleanValue.replaceAll(RegExp(r'[^\d]'), '');
    return digitsOnly.length >= 10;
  }

  /// URL validation supporting http, https, and protocol-relative URLs
  ///
  /// Example:
  /// ```dart
  /// FSValidators.isUrl('https://example.com'); // true
  /// FSValidators.isUrl('example.com'); // true (protocol-relative)
  /// ```
  static bool isUrl(String? value) {
    final cleanValue = value?.trim();
    if (cleanValue == null || cleanValue.isEmpty) return false;
    return _urlRegex.hasMatch(cleanValue);
  }

  /// Password strength validation with comprehensive scoring
  ///
  /// Evaluates password strength based on length, character variety, and complexity.
  ///
  /// Performance: O(n) where n is password length
  ///
  /// Example:
  /// ```dart
  /// final strength = FSValidators.checkPasswordStrength('SecurePass123!');
  /// print(strength.name); // 'Strong'
  /// ```
  static FSPasswordStrength checkPasswordStrength(String password) {
    if (password.length < 6) return FSPasswordStrength.weak;

    final checks = [
      RegExp(r'[A-Z]').hasMatch(password), // Uppercase letters
      RegExp(r'[a-z]').hasMatch(password), // Lowercase letters
      RegExp(r'[0-9]').hasMatch(password), // Numbers
      RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password), // Special chars
      password.length >= 12, // Length bonus
      password.length >= 16, // Extra length bonus
    ];

    final score = checks.where((check) => check).length;

    // Enhanced scoring logic
    if (score >= 5) return FSPasswordStrength.strong;
    if (score >= 3) return FSPasswordStrength.medium;
    return FSPasswordStrength.weak;
  }

  /// Numeric validation for string input
  ///
  /// Checks if the string can be parsed as a number (int or double).
  ///
  /// Example:
  /// ```dart
  /// FSValidators.isNumeric('123.45'); // true
  /// FSValidators.isNumeric('abc');    // false
  /// ```
  static bool isNumeric(String? value) {
    if (value == null || value.isEmpty) return false;
    return double.tryParse(value) != null;
  }
}

/// Password strength levels with color coding and display names
///
/// Used by [FSValidators.checkPasswordStrength] to represent password security levels.
enum FSPasswordStrength {
  weak,
  medium,
  strong;

  /// Constant constructor for better performance
  const FSPasswordStrength();

  /// Get display name for the strength level
  String get name {
    switch (this) {
      case FSPasswordStrength.weak:
        return 'Weak';
      case FSPasswordStrength.medium:
        return 'Medium';
      case FSPasswordStrength.strong:
        return 'Strong';
    }
  }

  /// Get color representation for UI indicators
  Color get color {
    switch (this) {
      case FSPasswordStrength.weak:
        return Colors.redAccent;
      case FSPasswordStrength.medium:
        return Colors.orangeAccent;
      case FSPasswordStrength.strong:
        return Colors.greenAccent;
    }
  }

  /// Get descriptive text for the strength level
  String get description {
    switch (this) {
      case FSPasswordStrength.weak:
        return 'Add more characters and variety';
      case FSPasswordStrength.medium:
        return 'Good, but could be stronger';
      case FSPasswordStrength.strong:
        return 'Excellent password security';
    }
  }
}

/// String manipulation and text processing utilities
class FSUtils {
  /// Capitalize first letter of a string
  ///
  /// Example:
  /// ```dart
  /// FSUtils.capitalize('hello world'); // 'Hello world'
  /// ```
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    if (text.length == 1) return text.toUpperCase();
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  /// Capitalize each word in a string (Title Case)
  ///
  /// Example:
  /// ```dart
  /// FSUtils.capitalizeWords('hello world'); // 'Hello World'
  /// ```
  static String capitalizeWords(String text) {
    if (text.isEmpty) return text;
    return text.split(' ').map(capitalize).join(' ');
  }

  /// Truncate text with ellipsis and bounds checking
  ///
  /// Throws [AssertionError] if maxLength is negative.
  /// Returns empty string if maxLength is 0.
  ///
  /// Example:
  /// ```dart
  /// FSUtils.truncate('Very long text here', 10); // 'Very long...'
  /// ```
  static String truncate(String text, int maxLength) {
    assert(maxLength >= 0, 'maxLength must be non-negative');
    if (maxLength == 0) return '';
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }

  /// Generate a random alphanumeric ID
  ///
  /// Useful for generating unique identifiers for temporary elements.
  ///
  /// Example:
  /// ```dart
  /// final id = FSUtils.generateId(length: 12);
  /// ```
  static String generateId({int length = 8}) {
    assert(length > 0, 'Length must be positive');
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random.secure();
    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => chars.codeUnitAt(random.nextInt(chars.length)),
      ),
    );
  }

  /// Format file size in human-readable format
  ///
  /// Example:
  /// ```dart
  /// FSUtils.formatFileSize(1024); // '1.0 KB'
  /// FSUtils.formatFileSize(1048576); // '1.0 MB'
  /// ```
  static String formatFileSize(int bytes) {
    assert(bytes >= 0, 'Bytes cannot be negative');

    if (bytes < 1024) return '$bytes B';
    if (bytes < 1048576) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1073741824) return '${(bytes / 1048576).toStringAsFixed(1)} MB';
    return '${(bytes / 1073741824).toStringAsFixed(1)} GB';
  }

  /// Debounce function for limiting frequent function calls
  ///
  /// Delays function execution until after wait time has elapsed since last call.
  /// Useful for search inputs, resize events, etc.
  ///
  /// Example:
  /// ```dart
  /// final debouncedSearch = FSUtils.debounce(() => performSearch());
  /// searchController.addListener(debouncedSearch);
  /// ```
  static VoidCallback debounce(
    VoidCallback func, {
    Duration delay = const Duration(milliseconds: 300),
  }) {
    Timer? timer;
    return () {
      timer?.cancel();
      timer = Timer(delay, func);
    };
  }

  /// Generic debounce function that passes value to callback
  ///
  /// Example:
  /// ```dart
  /// final debouncedSave = FSUtils.debounceWith<String>((value) => save(value));
  /// textField.onChanged = debouncedSave;
  /// ```
  static Function(T) debounceWith<T>(
    void Function(T) func, {
    Duration delay = const Duration(milliseconds: 300),
  }) {
    Timer? timer;
    return (T value) {
      timer?.cancel();
      timer = Timer(delay, () => func(value));
    };
  }

  /// Throttle function for limiting call frequency
  ///
  /// Ensures function is called at most once per specified duration.
  /// Useful for scroll events, button clicks, etc.
  ///
  /// Example:
  /// ```dart
  /// final throttledScroll = FSUtils.throttle(() => handleScroll());
  /// scrollController.addListener(throttledScroll);
  /// ```
  static VoidCallback throttle(
    VoidCallback func, {
    Duration delay = const Duration(milliseconds: 300),
  }) {
    Timer? timer;
    return () {
      if (timer == null) {
        func();
        timer = Timer(delay, () => timer = null);
      }
    };
  }

  /// Safe string conversion with null handling
  ///
  /// Converts any value to string, handling nulls gracefully.
  ///
  /// Example:
  /// ```dart
  /// FSUtils.safeToString(null); // ''
  /// FSUtils.safeToString(123); // '123'
  /// ```
  static String safeToString(dynamic value) {
    return value?.toString() ?? '';
  }
}

/// Date and time manipulation utilities
class FSDates {
  /// Format DateTime to relative time string
  ///
  /// Provides human-readable relative time (e.g., "2 hours ago", "3 days ago").
  ///
  /// Example:
  /// ```dart
  /// final twoHoursAgo = DateTime.now().subtract(Duration(hours: 2));
  /// FSDates.relativeTime(twoHoursAgo); // '2 hours ago'
  /// ```
  static String relativeTime(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inSeconds < 60) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      final minutes = difference.inMinutes;
      return '$minutes ${minutes == 1 ? 'minute' : 'minutes'} ago';
    } else if (difference.inHours < 24) {
      final hours = difference.inHours;
      return '$hours ${hours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inDays < 7) {
      final days = difference.inDays;
      return '$days ${days == 1 ? 'day' : 'days'} ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
    } else {
      return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    }
  }

  /// Check if two dates are the same day
  ///
  /// Example:
  /// ```dart
  /// final date1 = DateTime(2023, 1, 1, 10, 30);
  /// final date2 = DateTime(2023, 1, 1, 15, 45);
  /// FSDates.isSameDay(date1, date2); // true
  /// ```
  static bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  /// Get start of day (00:00:00.000)
  ///
  /// Example:
  /// ```dart
  /// FSDates.startOfDay(DateTime(2023, 1, 1, 14, 30));
  /// // Returns DateTime(2023, 1, 1, 0, 0, 0, 0)
  /// ```
  static DateTime startOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  /// Get end of day (23:59:59.999)
  ///
  /// Example:
  /// ```dart
  /// FSDates.endOfDay(DateTime(2023, 1, 1, 14, 30));
  /// // Returns DateTime(2023, 1, 1, 23, 59, 59, 999)
  /// ```
  static DateTime endOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59, 999);
  }

  /// Calculate age from birth date
  ///
  /// Example:
  /// ```dart
  /// final birthDate = DateTime(1990, 1, 1);
  /// FSDates.calculateAge(birthDate); // 33 (as of 2023)
  /// ```
  static int calculateAge(DateTime birthDate) {
    final now = DateTime.now();
    int age = now.year - birthDate.year;
    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    return age;
  }
}

/// Number formatting and mathematical utilities
class FSNumbers {
  /// Format number with thousand separators
  ///
  /// Example:
  /// ```dart
  /// FSNumbers.formatNumber(1234567); // '1,234,567'
  /// FSNumbers.formatNumber(1234.56); // '1,234.56'
  /// ```
  static String formatNumber(num number) {
    final parts = number.toString().split('.');
    final integerPart = parts[0].replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );

    if (parts.length > 1) {
      return '$integerPart.${parts[1]}';
    }
    return integerPart;
  }

  /// Clamp a number between min and max values
  ///
  /// Example:
  /// ```dart
  /// FSNumbers.clamp(15, 10, 20); // 15
  /// FSNumbers.clamp(5, 10, 20); // 10
  /// FSNumbers.clamp(25, 10, 20); // 20
  /// ```
  static num clamp(num value, num min, num max) {
    assert(min <= max, 'Min must be less than or equal to max');
    if (value < min) return min;
    if (value > max) return max;
    return value;
  }

  /// Linear interpolation between two numbers
  ///
  /// Example:
  /// ```dart
  /// FSNumbers.lerp(0, 100, 0.5); // 50.0
  /// ```
  static double lerp(double a, double b, double t) {
    return a + (b - a) * t;
  }

  /// Format number as currency (simplified)
  ///
  /// Example:
  /// ```dart
  /// FSNumbers.formatCurrency(1234.56); // '\$1,234.56'
  /// ```
  static String formatCurrency(double amount, {String symbol = '\$'}) {
    return '$symbol${formatNumber(double.parse(amount.toStringAsFixed(2)))}';
  }

  /// Calculate percentage of a value
  ///
  /// Example:
  /// ```dart
  /// FSNumbers.percentage(50, 200); // 25.0 (50 is 25% of 200)
  /// ```
  static double percentage(double part, double whole) {
    assert(whole != 0, 'Whole cannot be zero');
    return (part / whole) * 100;
  }
}

/// Platform and environment detection utilities
class FSPlatform {
  /// Check if current platform is web
  ///
  /// Uses [kIsWeb] from flutter/foundation for reliable detection.
  static bool get isWeb => kIsWeb;

  /// Check if current platform is Android
  static bool get isAndroid =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

  /// Check if current platform is iOS
  static bool get isIOS =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.iOS;

  /// Check if current platform is mobile (Android or iOS)
  static bool get isMobile => isAndroid || isIOS;

  /// Check if current platform is desktop
  static bool get isDesktop =>
      !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.windows ||
          defaultTargetPlatform == TargetPlatform.macOS ||
          defaultTargetPlatform == TargetPlatform.linux);

  /// Get current platform name
  static String get platformName {
    if (kIsWeb) return 'web';
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return 'android';
      case TargetPlatform.iOS:
        return 'ios';
      case TargetPlatform.windows:
        return 'windows';
      case TargetPlatform.macOS:
        return 'macos';
      case TargetPlatform.linux:
        return 'linux';
      case TargetPlatform.fuchsia:
        return 'fuchsia';
    }
  }
}

/// Error handling and validation utilities
class FSErrors {
  /// Execute function with try-catch and optional error callback
  ///
  /// Example:
  /// ```dart
  /// final result = FSErrors.tryCatch(
  ///   () => riskyOperation(),
  ///   onError: (e, stack) => print('Error: $e'),
  ///   fallback: 'default',
  /// );
  /// ```
  static T? tryCatch<T>(
    T Function() action, {
    Function(dynamic error, StackTrace stack)? onError,
    T? fallback,
  }) {
    try {
      return action();
    } catch (error, stack) {
      onError?.call(error, stack);
      return fallback;
    }
  }

  /// Async version of try-catch for Future operations
  static Future<T?> tryCatchAsync<T>(
    Future<T> Function() action, {
    Function(dynamic error, StackTrace stack)? onError,
    T? fallback,
  }) async {
    try {
      return await action();
    } catch (error, stack) {
      onError?.call(error, stack);
      return fallback;
    }
  }
}
