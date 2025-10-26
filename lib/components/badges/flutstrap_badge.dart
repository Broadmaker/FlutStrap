import 'package:flutter/material.dart';
import '../../core/theme.dart';
//import '../../core/spacing.dart';

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
  final int? maxCount; // Changed from double to int

  const FlutstrapBadge({
    Key? key,
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
        super(key: key);

  /// Creates a badge with just a count (no text)
  const FlutstrapBadge.count({
    Key? key,
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
        super(key: key);

  /// Creates a dot badge (small circle indicator)
  const FlutstrapBadge.dot({
    Key? key,
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
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = FSTheme.of(context);
    final badgeStyle = _BadgeStyle(theme, variant, size);

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
            top: -4,
            right: -4,
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
              text, // Show the original text
              style: badgeStyle.textStyle.copyWith(
                color: textColor ?? badgeStyle.textColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(width: 4),
            Text(
              displayText, // Show the count
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
      if (maxCount != null && count! > maxCount!) {
        return '$maxCount+'; // Fixed: using maxCount directly
      }
      return count!.toString();
    }

    return text;
  }
}

/// Badge that can be positioned relative to another widget
class FlutstrapBadgePositioned extends StatelessWidget {
  final Widget child;
  final FlutstrapBadge badge;
  final Alignment alignment;

  const FlutstrapBadgePositioned({
    Key? key,
    required this.child,
    required this.badge,
    this.alignment = Alignment.topRight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          top: alignment.y > 0 ? null : -4,
          bottom: alignment.y < 0 ? null : -4,
          left: alignment.x > 0 ? null : -4,
          right: alignment.x < 0 ? null : -4,
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
        return 6.0;
      case FSBadgeSize.md:
        return 8.0;
      case FSBadgeSize.lg:
        return 10.0;
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
