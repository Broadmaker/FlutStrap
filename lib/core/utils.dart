/// Flutstrap Core Utilities
///
/// Shared helper functions, validators, and common utilities used throughout
/// the Flutstrap framework.

import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';

/// Common validation utilities
class FSValidators {
  /// Check if string is empty or null
  static bool isEmpty(String? value) {
    return value == null || value.trim().isEmpty;
  }

  /// Check if string is not empty
  static bool isNotEmpty(String? value) {
    return !isEmpty(value);
  }

  /// Email validation
  static bool isEmail(String? value) {
    if (isEmpty(value)) return false;
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
    );
    return emailRegex.hasMatch(value!);
  }

  /// Phone number validation (basic)
  static bool isPhoneNumber(String? value) {
    if (isEmpty(value)) return false;

    // Remove all non-digit characters and check if we have at least 10 digits
    final digitsOnly = value!.replaceAll(RegExp(r'[^\d]'), '');
    return digitsOnly.length >= 10;
  }

  /// URL validation
  static bool isUrl(String? value) {
    if (isEmpty(value)) return false;
    final urlRegex = RegExp(
      r'^(https?://)?([\da-z\.-]+)\.([a-z\.]{2,6})([/\w \.-]*)*\/?$',
    );
    return urlRegex.hasMatch(value!);
  }

  /// Password strength validation
  static FSPasswordStrength checkPasswordStrength(String password) {
    if (password.length < 6) return FSPasswordStrength.weak;

    final hasUppercase = RegExp(r'[A-Z]').hasMatch(password);
    final hasLowercase = RegExp(r'[a-z]').hasMatch(password);
    final hasNumbers = RegExp(r'[0-9]').hasMatch(password);
    final hasSpecial = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);

    final criteriaMet = [hasUppercase, hasLowercase, hasNumbers, hasSpecial]
        .where((met) => met)
        .length;

    if (criteriaMet >= 4 && password.length >= 12) {
      return FSPasswordStrength.strong;
    } else if (criteriaMet >= 3 && password.length >= 8) {
      return FSPasswordStrength.medium;
    } else {
      return FSPasswordStrength.weak;
    }
  }
}

/// Password strength levels
enum FSPasswordStrength {
  weak,
  medium,
  strong,
}

/// Extension for password strength
extension FSPasswordStrengthExtensions on FSPasswordStrength {
  /// Get display name
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

  /// Get color representation
  Color get color {
    switch (this) {
      case FSPasswordStrength.weak:
        return Colors.red;
      case FSPasswordStrength.medium:
        return Colors.orange;
      case FSPasswordStrength.strong:
        return Colors.green;
    }
  }
}

/// String utilities
class FSUtils {
  /// Capitalize first letter of a string
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  /// Capitalize each word in a string
  static String capitalizeWords(String text) {
    if (text.isEmpty) return text;
    return text.split(' ').map(capitalize).join(' ');
  }

  /// Truncate text with ellipsis
  static String truncate(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }

  /// Generate a random ID
  static String generateId({int length = 8}) {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();
    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => chars.codeUnitAt(random.nextInt(chars.length)),
      ),
    );
  }

  /// Format file size
  static String formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1048576) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1073741824) return '${(bytes / 1048576).toStringAsFixed(1)} MB';
    return '${(bytes / 1073741824).toStringAsFixed(1)} GB';
  }

  /// Debounce function for limiting frequent calls
  static Function() debounce(
    Function func, [
    Duration delay = const Duration(milliseconds: 300),
  ]) {
    Timer? timer;
    return () {
      timer?.cancel();
      timer = Timer(delay, () => func());
    };
  }

  /// Throttle function for limiting call frequency
  static Function() throttle(
    Function func, [
    Duration delay = const Duration(milliseconds: 300),
  ]) {
    Timer? timer;
    return () {
      if (timer == null) {
        func();
        timer = Timer(delay, () => timer = null);
      }
    };
  }
}

/// Date and time utilities
class FSDates {
  /// Format DateTime to relative time string
  static String relativeTime(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inSeconds < 60) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.year}-${date.month}-${date.day}';
    }
  }

  /// Check if two dates are the same day
  static bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  /// Get start of day
  static DateTime startOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  /// Get end of day
  static DateTime endOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59, 999);
  }
}

/// Number utilities
class FSNumbers {
  /// Format number with commas
  static String formatNumber(num number) {
    return number.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }

  /// Clamp a number between min and max
  static num clamp(num value, num min, num max) {
    if (value < min) return min;
    if (value > max) return max;
    return value;
  }

  /// Linear interpolation between two numbers
  static double lerp(double a, double b, double t) {
    return a + (b - a) * t;
  }

  /// Check if string is numeric
  static bool isNumeric(String? value) {
    if (value == null) return false;
    return double.tryParse(value) != null;
  }
}

/// Basic platform utilities (simplified - use extensions for precise detection)
class FSPlatform {
  /// Check if current platform is web
  static bool get isWeb => identical(0, 0.0);

  /// Check if current platform is mobile (simplified)
  static bool get isMobile => !isWeb;
}
