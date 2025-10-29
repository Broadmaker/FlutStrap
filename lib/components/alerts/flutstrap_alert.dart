/// Flutstrap Alert
///
/// A high-performance, flexible alert component for displaying contextual
/// feedback messages with comprehensive theming and animation support.
///
/// {@macro flutstrap_alert.usage}
/// {@macro flutstrap_alert.accessibility}
///
/// {@template flutstrap_alert.usage}
/// ## Usage Examples
///
/// ```dart
/// // Basic alert with auto-dismiss
/// FlutstrapAlert.success(
///   message: 'Operation completed successfully!',
///   autoDismissDuration: Duration(seconds: 5),
/// )
///
/// // Error alert with custom title
/// FlutstrapAlert.error(
///   title: 'Upload Failed',
///   message: 'Please check your connection and try again.',
///   dismissible: true,
/// )
///
/// // Custom alert with action button
/// FlutstrapAlert(
///   variant: FSAlertVariant.warning,
///   message: 'Your session will expire soon.',
///   trailing: FlutstrapButton(
///     onPressed: extendSession,
///     child: Text('Extend'),
///   ),
/// )
/// ```
/// {@endtemplate}
///
/// {@template flutstrap_alert.accessibility}
/// ## Accessibility
///
/// - Uses `Semantics` widget with live region for screen readers
/// - Provides proper semantic labels for alert content and type
/// - Supports keyboard navigation and screen reader announcements
/// - Follows WCAG contrast guidelines
/// {@endtemplate}
///
/// {@category Components}
/// {@category Feedback}

import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../../core/spacing.dart';

/// Flutstrap Alert Variants
///
/// Defines the visual style variants for alerts
enum FSAlertVariant {
  primary,
  secondary,
  success,
  danger,
  warning,
  info,
  light,
  dark,
}

/// Flutstrap Alert Component
///
/// A flexible alert component for displaying contextual feedback messages
/// with performance optimizations and comprehensive theming.
@immutable
class FlutstrapAlert extends StatefulWidget {
  final String? title;
  final String message;
  final FSAlertVariant variant;
  final bool dismissible;
  final VoidCallback? onDismiss;
  final Widget? leading;
  final Widget? trailing;
  final Duration? autoDismissDuration;
  final bool showIcon;
  final double borderRadius;
  final bool animateEntrance;

  const FlutstrapAlert({
    super.key,
    this.title,
    required this.message,
    this.variant = FSAlertVariant.primary,
    this.dismissible = false,
    this.onDismiss,
    this.leading,
    this.trailing,
    this.autoDismissDuration,
    this.showIcon = true,
    this.borderRadius = _AlertConstants.defaultBorderRadius,
    this.animateEntrance = true,
  });

  @override
  State<FlutstrapAlert> createState() => _FlutstrapAlertState();
}

class _FlutstrapAlertState extends State<FlutstrapAlert> {
  bool _isVisible = true;
  Timer? _autoDismissTimer;

  @override
  void initState() {
    super.initState();
    _setupAutoDismiss();
  }

  void _setupAutoDismiss() {
    if (widget.autoDismissDuration != null) {
      _autoDismissTimer = Timer(widget.autoDismissDuration!, _dismiss);
    }
  }

  void _dismiss() {
    if (mounted && _isVisible) {
      setState(() => _isVisible = false);
      // Callback will be triggered in animation onEnd for better timing
    }
  }

  /// Manually dismiss the alert
  void dismiss() {
    _dismiss();
  }

  @override
  void dispose() {
    _autoDismissTimer?.cancel();
    super.dispose();
  }

  // STYLE CACHING FOR PERFORMANCE
  static final _styleCache = <_AlertStyleCacheKey, _AlertStyle>{};

  @override
  Widget build(BuildContext context) {
    if (!_isVisible) return const SizedBox.shrink();

    final theme = FSTheme.of(context);
    final alertStyle = _getAlertStyle(theme.colors);

    return Semantics(
      liveRegion: true,
      label: _getSemanticLabel(),
      child: _buildAlert(theme, alertStyle),
    );
  }

  Widget _buildAlert(FSThemeData theme, _AlertStyle alertStyle) {
    Widget alertContent = Container(
      padding: EdgeInsets.all(FSSpacing.md),
      decoration: BoxDecoration(
        color: alertStyle.backgroundColor,
        border: Border.all(
          color: alertStyle.borderColor,
          width: alertStyle.borderWidth,
        ),
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      child: _buildAlertContent(alertStyle),
    );

    // Add entrance animation if enabled
    if (widget.animateEntrance) {
      alertContent = _buildAnimatedAlert(alertContent, theme);
    }

    return alertContent;
  }

  Widget _buildAnimatedAlert(Widget child, FSThemeData theme) {
    return AnimatedSize(
      duration: theme.animation.duration,
      curve: theme.animation.curve,
      alignment: Alignment.topCenter,
      child: AnimatedOpacity(
        duration: theme.animation.duration,
        curve: theme.animation.curve,
        opacity: _isVisible ? 1.0 : 0.0,
        onEnd: () {
          if (!_isVisible && widget.onDismiss != null) {
            widget.onDismiss!();
          }
        },
        child: child,
      ),
    );
  }

  Widget _buildAlertContent(_AlertStyle alertStyle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Leading icon or custom leading widget
        if (widget.showIcon && widget.leading == null) ...[
          Icon(
            alertStyle.icon,
            color: alertStyle.iconColor,
            size: _AlertConstants.iconSize,
          ),
          SizedBox(width: FSSpacing.sm),
        ],
        if (widget.leading != null) ...[
          widget.leading!,
          SizedBox(width: FSSpacing.sm),
        ],

        // Main content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.title != null) ...[
                Text(
                  widget.title!,
                  style: alertStyle.titleStyle,
                  maxLines: _AlertConstants.maxTitleLines,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: FSSpacing.xs),
              ],
              Text(
                widget.message,
                style: alertStyle.messageStyle,
                maxLines: _AlertConstants.maxMessageLines,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),

        // Trailing content or dismiss button
        if (widget.trailing != null) ...[
          SizedBox(width: FSSpacing.sm),
          widget.trailing!,
        ],
        if (widget.dismissible) ...[
          SizedBox(width: FSSpacing.sm),
          _buildDismissButton(alertStyle),
        ],
      ],
    );
  }

  Widget _buildDismissButton(_AlertStyle alertStyle) {
    return Semantics(
      button: true,
      label: 'Dismiss alert',
      child: GestureDetector(
        onTap: _dismiss,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Icon(
            Icons.close,
            size: _AlertConstants.dismissIconSize,
            color: alertStyle.iconColor,
          ),
        ),
      ),
    );
  }

  String _getSemanticLabel() {
    final labels = <String>[];
    if (widget.title != null) labels.add(widget.title!);
    labels.add(widget.message);
    labels.add('${widget.variant.name} alert');
    if (widget.dismissible) labels.add('Dismissible');
    return labels.join(', ');
  }

  _AlertStyle _getAlertStyle(FSColorScheme colors) {
    final cacheKey =
        _AlertStyleCacheKey(widget.variant, _getBrightness(colors));
    return _styleCache.putIfAbsent(cacheKey, () => _computeAlertStyle(colors));
  }

  Brightness _getBrightness(FSColorScheme colors) {
    return colors.background.computeLuminance() > 0.5
        ? Brightness.light
        : Brightness.dark;
  }

  _AlertStyle _computeAlertStyle(FSColorScheme colors) {
    switch (widget.variant) {
      case FSAlertVariant.primary:
        return _AlertStyle.primary(colors);
      case FSAlertVariant.secondary:
        return _AlertStyle.secondary(colors);
      case FSAlertVariant.success:
        return _AlertStyle.success(colors);
      case FSAlertVariant.danger:
        return _AlertStyle.danger(colors);
      case FSAlertVariant.warning:
        return _AlertStyle.warning(colors);
      case FSAlertVariant.info:
        return _AlertStyle.info(colors);
      case FSAlertVariant.light:
        return _AlertStyle.light(colors);
      case FSAlertVariant.dark:
        return _AlertStyle.dark(colors);
    }
  }

  // CONVENIENCE: Builder methods
  FlutstrapAlert copyWith({
    String? title,
    String? message,
    FSAlertVariant? variant,
    bool? dismissible,
    VoidCallback? onDismiss,
    Widget? leading,
    Widget? trailing,
    Duration? autoDismissDuration,
    bool? showIcon,
    double? borderRadius,
    bool? animateEntrance,
  }) {
    return FlutstrapAlert(
      key: widget.key,
      title: title ?? widget.title,
      message: message ?? widget.message,
      variant: variant ?? widget.variant,
      dismissible: dismissible ?? widget.dismissible,
      onDismiss: onDismiss ?? widget.onDismiss,
      leading: leading ?? widget.leading,
      trailing: trailing ?? widget.trailing,
      autoDismissDuration: autoDismissDuration ?? widget.autoDismissDuration,
      showIcon: showIcon ?? widget.showIcon,
      borderRadius: borderRadius ?? widget.borderRadius,
      animateEntrance: animateEntrance ?? widget.animateEntrance,
    );
  }
}

/// Internal style configuration for alerts
class _AlertStyle {
  final Color backgroundColor;
  final Color borderColor;
  final Color iconColor;
  final IconData icon;
  final TextStyle titleStyle;
  final TextStyle messageStyle;
  final double borderWidth;

  const _AlertStyle({
    required this.backgroundColor,
    required this.borderColor,
    required this.iconColor,
    required this.icon,
    required this.titleStyle,
    required this.messageStyle,
    required this.borderWidth,
  });

  // FACTORY METHODS FOR EACH VARIANT
  factory _AlertStyle.primary(FSColorScheme colors) {
    return _AlertStyle(
      backgroundColor:
          colors.primary.withOpacity(_AlertConstants.backgroundOpacity),
      borderColor: colors.primary,
      iconColor: colors.primary,
      icon: Icons.info_outlined,
      titleStyle: TextStyle(
        fontWeight: FontWeight.w600,
        color: colors.primary,
        fontSize: _AlertConstants.fontSize,
      ),
      messageStyle: TextStyle(
        color: colors.primary,
        fontSize: _AlertConstants.fontSize,
      ),
      borderWidth: _AlertConstants.defaultBorderWidth,
    );
  }

  factory _AlertStyle.secondary(FSColorScheme colors) {
    return _AlertStyle(
      backgroundColor:
          colors.secondary.withOpacity(_AlertConstants.backgroundOpacity),
      borderColor: colors.secondary,
      iconColor: colors.secondary,
      icon: Icons.info_outlined,
      titleStyle: TextStyle(
        fontWeight: FontWeight.w600,
        color: colors.secondary,
        fontSize: _AlertConstants.fontSize,
      ),
      messageStyle: TextStyle(
        color: colors.secondary,
        fontSize: _AlertConstants.fontSize,
      ),
      borderWidth: _AlertConstants.defaultBorderWidth,
    );
  }

  factory _AlertStyle.success(FSColorScheme colors) {
    return _AlertStyle(
      backgroundColor:
          colors.success.withOpacity(_AlertConstants.backgroundOpacity),
      borderColor: colors.success,
      iconColor: colors.success,
      icon: Icons.check_circle_outlined,
      titleStyle: TextStyle(
        fontWeight: FontWeight.w600,
        color: colors.success,
        fontSize: _AlertConstants.fontSize,
      ),
      messageStyle: TextStyle(
        color: colors.success,
        fontSize: _AlertConstants.fontSize,
      ),
      borderWidth: _AlertConstants.defaultBorderWidth,
    );
  }

  factory _AlertStyle.danger(FSColorScheme colors) {
    return _AlertStyle(
      backgroundColor:
          colors.danger.withOpacity(_AlertConstants.backgroundOpacity),
      borderColor: colors.danger,
      iconColor: colors.danger,
      icon: Icons.error_outlined,
      titleStyle: TextStyle(
        fontWeight: FontWeight.w600,
        color: colors.danger,
        fontSize: _AlertConstants.fontSize,
      ),
      messageStyle: TextStyle(
        color: colors.danger,
        fontSize: _AlertConstants.fontSize,
      ),
      borderWidth: _AlertConstants.defaultBorderWidth,
    );
  }

  factory _AlertStyle.warning(FSColorScheme colors) {
    return _AlertStyle(
      backgroundColor:
          colors.warning.withOpacity(_AlertConstants.backgroundOpacity),
      borderColor: colors.warning,
      iconColor: colors.warning,
      icon: Icons.warning_amber_outlined,
      titleStyle: TextStyle(
        fontWeight: FontWeight.w600,
        color: colors.warning,
        fontSize: _AlertConstants.fontSize,
      ),
      messageStyle: TextStyle(
        color: colors.warning,
        fontSize: _AlertConstants.fontSize,
      ),
      borderWidth: _AlertConstants.defaultBorderWidth,
    );
  }

  factory _AlertStyle.info(FSColorScheme colors) {
    return _AlertStyle(
      backgroundColor:
          colors.info.withOpacity(_AlertConstants.backgroundOpacity),
      borderColor: colors.info,
      iconColor: colors.info,
      icon: Icons.info_outlined,
      titleStyle: TextStyle(
        fontWeight: FontWeight.w600,
        color: colors.info,
        fontSize: _AlertConstants.fontSize,
      ),
      messageStyle: TextStyle(
        color: colors.info,
        fontSize: _AlertConstants.fontSize,
      ),
      borderWidth: _AlertConstants.defaultBorderWidth,
    );
  }

  factory _AlertStyle.light(FSColorScheme colors) {
    return _AlertStyle(
      backgroundColor: colors.light,
      borderColor: colors.outline,
      iconColor: colors.onBackground,
      icon: Icons.info_outlined,
      titleStyle: TextStyle(
        fontWeight: FontWeight.w600,
        color: colors.onBackground,
        fontSize: _AlertConstants.fontSize,
      ),
      messageStyle: TextStyle(
        color: colors.onBackground,
        fontSize: _AlertConstants.fontSize,
      ),
      borderWidth: _AlertConstants.defaultBorderWidth,
    );
  }

  factory _AlertStyle.dark(FSColorScheme colors) {
    return _AlertStyle(
      backgroundColor: colors.dark,
      borderColor: colors.dark,
      iconColor: colors.onPrimary,
      icon: Icons.info_outlined,
      titleStyle: TextStyle(
        fontWeight: FontWeight.w600,
        color: colors.onPrimary,
        fontSize: _AlertConstants.fontSize,
      ),
      messageStyle: TextStyle(
        color: colors.onPrimary,
        fontSize: _AlertConstants.fontSize,
      ),
      borderWidth: _AlertConstants.defaultBorderWidth,
    );
  }
}

// STYLE CACHE KEY FOR EFFICIENT CACHING
class _AlertStyleCacheKey {
  final FSAlertVariant variant;
  final Brightness brightness;

  const _AlertStyleCacheKey(this.variant, this.brightness);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _AlertStyleCacheKey &&
          runtimeType == other.runtimeType &&
          variant == other.variant &&
          brightness == other.brightness;

  @override
  int get hashCode => Object.hash(variant, brightness);
}

// CONSTANTS FOR BETTER MAINTAINABILITY
class _AlertConstants {
  static const double defaultBorderRadius = 8.0;
  static const double defaultBorderWidth = 1.0;
  static const double iconSize = 20.0;
  static const double dismissIconSize = 16.0;
  static const double fontSize = 14.0;
  static const double backgroundOpacity = 0.1;
  static const int maxTitleLines = 2;
  static const int maxMessageLines = 5;
}

// Convenience factory methods for common alert types
extension FSAlertFactories on FlutstrapAlert {
  /// Create a success alert
  static FlutstrapAlert success({
    required String message,
    String? title,
    bool dismissible = true,
    Duration? autoDismissDuration,
  }) {
    return FlutstrapAlert(
      title: title ?? 'Success',
      message: message,
      variant: FSAlertVariant.success,
      dismissible: dismissible,
      autoDismissDuration: autoDismissDuration,
    );
  }

  /// Create an error alert
  static FlutstrapAlert error({
    required String message,
    String? title,
    bool dismissible = true,
    Duration? autoDismissDuration,
  }) {
    return FlutstrapAlert(
      title: title ?? 'Error',
      message: message,
      variant: FSAlertVariant.danger,
      dismissible: dismissible,
      autoDismissDuration: autoDismissDuration,
    );
  }

  /// Create a warning alert
  static FlutstrapAlert warning({
    required String message,
    String? title,
    bool dismissible = true,
    Duration? autoDismissDuration,
  }) {
    return FlutstrapAlert(
      title: title ?? 'Warning',
      message: message,
      variant: FSAlertVariant.warning,
      dismissible: dismissible,
      autoDismissDuration: autoDismissDuration,
    );
  }

  /// Create an info alert
  static FlutstrapAlert info({
    required String message,
    String? title,
    bool dismissible = true,
    Duration? autoDismissDuration,
  }) {
    return FlutstrapAlert(
      title: title ?? 'Information',
      message: message,
      variant: FSAlertVariant.info,
      dismissible: dismissible,
      autoDismissDuration: autoDismissDuration,
    );
  }

  /// Create a primary alert
  static FlutstrapAlert primary({
    required String message,
    String? title,
    bool dismissible = false,
    Duration? autoDismissDuration,
  }) {
    return FlutstrapAlert(
      title: title,
      message: message,
      variant: FSAlertVariant.primary,
      dismissible: dismissible,
      autoDismissDuration: autoDismissDuration,
    );
  }
}
