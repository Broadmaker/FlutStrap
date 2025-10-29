/// Flutstrap Badge
///
/// A small label and counting component with Bootstrap-inspired styling.
///
/// {@macro flutstrap_badge.usage}
/// {@macro flutstrap_badge.accessibility}
///
/// {@template flutstrap_badge.usage}
/// ## Usage Examples
///
/// ```dart
/// // Basic badge
/// FlutstrapBadge(
///   text: 'New',
///   variant: FSBadgeVariant.primary,
/// )
///
/// // Count badge with max limit
/// FlutstrapBadge.count(
///   count: 150,
///   maxCount: 99,
///   variant: FSBadgeVariant.danger,
/// )
///
/// // Dot indicator
/// FlutstrapBadge.dot(
///   variant: FSBadgeVariant.success,
/// )
///
/// // Badge positioned on another widget
/// FlutstrapBadgePositioned(
///   child: Icon(Icons.notifications),
///   badge: FlutstrapBadge.count(count: 5),
///   alignment: Alignment.topRight,
/// )
/// ```
/// {@endtemplate}
///
/// {@template flutstrap_badge.accessibility}
/// ## Accessibility
///
/// - Uses `Semantics` widget for screen readers
/// - Provides proper semantic labels for different badge types
/// - Follows WCAG contrast guidelines for text and background colors
/// {@endtemplate}
///
/// {@category Components}
/// {@category Badges}

import 'package:flutter/material.dart';
import '../../core/theme.dart';

/// Flutstrap Badge Variants
///
/// Defines the visual style variants for badges
enum FSBadgeVariant {
  primary,
  secondary,
  success,
  danger,
  warning,
  info,
  light,
  dark,
}

/// Flutstrap Badge Sizes
///
/// Defines the size variants for badges
enum FSBadgeSize {
  sm,
  md,
  lg,
}

/// Flutstrap Badge
///
/// A small label and counting component with Bootstrap-inspired styling.
@immutable
class FlutstrapBadge extends StatelessWidget {
  final String text;
  final int? count;
  final FSBadgeVariant variant;
  final FSBadgeSize size;
  final bool pill;
  final bool dot;
  final Widget? child;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? textColor;
  final int? maxCount;

  /// Main constructor for FlutstrapBadge
  const FlutstrapBadge({
    super.key,
    required this.text,
    this.count,
    this.variant = FSBadgeVariant.primary,
    this.size = FSBadgeSize.md,
    this.pill = false,
    this.dot = false,
    this.child,
    this.onTap,
    this.backgroundColor,
    this.textColor,
    this.maxCount,
  })  : assert(count == null || count >= 0, 'Count must be non-negative'),
        assert(maxCount == null || maxCount > 0, 'Max count must be positive'),
        super();

  /// Creates a badge with just a count (no text)
  const FlutstrapBadge.count({
    super.key,
    required this.count,
    this.variant = FSBadgeVariant.primary,
    this.size = FSBadgeSize.md,
    this.pill = true,
    this.dot = false,
    this.onTap,
    this.backgroundColor,
    this.textColor,
    this.maxCount = 99,
  })  : text = '',
        child = null,
        super();

  /// Creates a dot badge (small circle indicator)
  const FlutstrapBadge.dot({
    super.key,
    this.variant = FSBadgeVariant.danger,
    this.size = FSBadgeSize.sm,
    this.onTap,
    this.backgroundColor,
  })  : text = '',
        count = null,
        pill = true,
        dot = true,
        child = null,
        textColor = null,
        maxCount = null,
        super();

  // STYLE CACHING FOR PERFORMANCE
  static final _styleCache = <_StyleCacheKey, _BadgeStyle>{};

  @override
  Widget build(BuildContext context) {
    final theme = FSTheme.of(context);
    final badgeStyle = _getBadgeStyle(theme);

    return Semantics(
      container: true,
      label: _getSemanticLabel(),
      button: onTap != null,
      child: _buildBadge(badgeStyle),
    );
  }

  Widget _buildBadge(_BadgeStyle badgeStyle) {
    final displayText = _getDisplayText();
    final showCount = count != null && !dot;
    final showText = text.isNotEmpty && !dot;

    Widget badgeContent =
        _buildBadgeContent(badgeStyle, displayText, showCount, showText);

    // Apply tap behavior if provided
    if (onTap != null) {
      badgeContent = MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          child: badgeContent,
        ),
      );
    }

    // Wrap with child if provided
    if (child != null) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          child!,
          Positioned(
            top: -_BadgeConstants.positionOffset,
            right: -_BadgeConstants.positionOffset,
            child: badgeContent,
          ),
        ],
      );
    }

    return badgeContent;
  }

  Widget _buildBadgeContent(_BadgeStyle badgeStyle, String displayText,
      bool showCount, bool showText) {
    if (dot) {
      return Container(
        width: badgeStyle.dotSize,
        height: badgeStyle.dotSize,
        decoration: BoxDecoration(
          color: backgroundColor ?? badgeStyle.backgroundColor,
          borderRadius: BorderRadius.circular(badgeStyle.dotSize / 2),
        ),
      );
    }

    // If we have both text and count, show them together
    if (showText && showCount) {
      return Container(
        padding: badgeStyle.padding,
        decoration: BoxDecoration(
          color: backgroundColor ?? badgeStyle.backgroundColor,
          borderRadius:
              pill ? badgeStyle.pillBorderRadius : badgeStyle.borderRadius,
          border: badgeStyle.border,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: badgeStyle.textStyle.copyWith(
                color: textColor ?? badgeStyle.textColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(width: _BadgeConstants.countSpacing),
            Text(
              '($displayText)',
              style: badgeStyle.textStyle.copyWith(
                color: textColor ?? badgeStyle.textColor,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      );
    }

    // If we only have count or only have text
    return Container(
      padding: badgeStyle.padding,
      decoration: BoxDecoration(
        color: backgroundColor ?? badgeStyle.backgroundColor,
        borderRadius:
            pill ? badgeStyle.pillBorderRadius : badgeStyle.borderRadius,
        border: badgeStyle.border,
      ),
      child: Text(
        displayText,
        style: badgeStyle.textStyle.copyWith(
          color: textColor ?? badgeStyle.textColor,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  String _getDisplayText() {
    if (dot) return '';

    if (count != null) {
      return _formatCount(count!);
    }

    return text;
  }

  String _formatCount(int count) {
    if (maxCount != null && count > maxCount!) {
      return '$maxCount+';
    }
    return count.toString();
  }

  String _getSemanticLabel() {
    if (dot) return 'Indicator';

    final hasCount = count != null;
    final hasText = text.isNotEmpty;

    if (hasCount && hasText) {
      return '$text count: $count';
    }
    if (hasCount) return 'Count: $count';
    return text;
  }

  _BadgeStyle _getBadgeStyle(FSThemeData theme) {
    final cacheKey = _StyleCacheKey(variant, size, theme.brightness);
    return _styleCache.putIfAbsent(
        cacheKey, () => _BadgeStyle(theme, variant, size));
  }

  // CONVENIENCE METHODS
  FlutstrapBadge copyWith({
    Key? key,
    String? text,
    int? count,
    FSBadgeVariant? variant,
    FSBadgeSize? size,
    bool? pill,
    bool? dot,
    Widget? child,
    VoidCallback? onTap,
    Color? backgroundColor,
    Color? textColor,
    int? maxCount,
  }) {
    return FlutstrapBadge(
      key: key ?? this.key,
      text: text ?? this.text,
      count: count ?? this.count,
      variant: variant ?? this.variant,
      size: size ?? this.size,
      pill: pill ?? this.pill,
      dot: dot ?? this.dot,
      child: child ?? this.child,
      onTap: onTap ?? this.onTap,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textColor: textColor ?? this.textColor,
      maxCount: maxCount ?? this.maxCount,
    );
  }
}

/// Badge that can be positioned relative to another widget
@immutable
class FlutstrapBadgePositioned extends StatelessWidget {
  final Widget child;
  final FlutstrapBadge badge;
  final Alignment alignment;

  const FlutstrapBadgePositioned({
    super.key,
    required this.child,
    required this.badge,
    this.alignment = Alignment.topRight,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          top: alignment.y > 0 ? null : -_BadgeConstants.positionOffset,
          bottom: alignment.y < 0 ? null : -_BadgeConstants.positionOffset,
          left: alignment.x > 0 ? null : -_BadgeConstants.positionOffset,
          right: alignment.x < 0 ? null : -_BadgeConstants.positionOffset,
          child: badge,
        ),
      ],
    );
  }
}

/// Internal style configuration for badges
class _BadgeStyle {
  final FSThemeData theme;
  final FSBadgeVariant variant;
  final FSBadgeSize size;

  _BadgeStyle(this.theme, this.variant, this.size);

  Color get backgroundColor => _getBackgroundColor();
  Color get textColor => _getTextColor();
  Border? get border => _getBorder();

  double get dotSize {
    switch (size) {
      case FSBadgeSize.sm:
        return _BadgeConstants.dotSizeSmall;
      case FSBadgeSize.md:
        return _BadgeConstants.dotSizeMedium;
      case FSBadgeSize.lg:
        return _BadgeConstants.dotSizeLarge;
    }
  }

  EdgeInsetsGeometry get padding {
    switch (size) {
      case FSBadgeSize.sm:
        return const EdgeInsets.symmetric(horizontal: 6, vertical: 2);
      case FSBadgeSize.md:
        return const EdgeInsets.symmetric(horizontal: 8, vertical: 4);
      case FSBadgeSize.lg:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 6);
    }
  }

  BorderRadiusGeometry get borderRadius => BorderRadius.circular(4);
  BorderRadiusGeometry get pillBorderRadius => BorderRadius.circular(12);

  TextStyle get textStyle {
    switch (size) {
      case FSBadgeSize.sm:
        return theme.typography.labelSmall.copyWith(
          color: textColor,
          fontWeight: FontWeight.w500,
        );
      case FSBadgeSize.md:
        return theme.typography.bodySmall.copyWith(
          color: textColor,
          fontWeight: FontWeight.w500,
        );
      case FSBadgeSize.lg:
        return theme.typography.bodyMedium.copyWith(
          color: textColor,
          fontWeight: FontWeight.w600,
        );
    }
  }

  Color _getBackgroundColor() {
    final colors = theme.colors;
    switch (variant) {
      case FSBadgeVariant.primary:
        return colors.primary;
      case FSBadgeVariant.secondary:
        return colors.secondary;
      case FSBadgeVariant.success:
        return colors.success;
      case FSBadgeVariant.danger:
        return colors.danger;
      case FSBadgeVariant.warning:
        return colors.warning;
      case FSBadgeVariant.info:
        return colors.info;
      case FSBadgeVariant.light:
        return colors.surface;
      case FSBadgeVariant.dark:
        return colors.onBackground;
    }
  }

  Color _getTextColor() {
    switch (variant) {
      case FSBadgeVariant.light:
        return theme.colors.onBackground;
      case FSBadgeVariant.dark:
        return theme.colors.background;
      default:
        return theme.colors.onPrimary;
    }
  }

  Border? _getBorder() {
    if (variant == FSBadgeVariant.light) {
      return Border.all(
        color: theme.colors.outline.withOpacity(0.3),
        width: 1,
      );
    }
    return null;
  }
}

// STYLE CACHE KEY FOR EFFICIENT CACHING
class _StyleCacheKey {
  final FSBadgeVariant variant;
  final FSBadgeSize size;
  final Brightness brightness;

  const _StyleCacheKey(this.variant, this.size, this.brightness);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _StyleCacheKey &&
          runtimeType == other.runtimeType &&
          variant == other.variant &&
          size == other.size &&
          brightness == other.brightness;

  @override
  int get hashCode => Object.hash(variant, size, brightness);
}

// CONSTANTS FOR BETTER MAINTAINABILITY
class _BadgeConstants {
  static const double positionOffset = 4.0;
  static const double countSpacing = 4.0;
  static const double dotSizeSmall = 6.0;
  static const double dotSizeMedium = 8.0;
  static const double dotSizeLarge = 10.0;
}
