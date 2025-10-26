/// Flutstrap Alert
///
/// A flexible alert component for displaying feedback messages
/// with various types, dismissibility, and custom content.

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
/// A flexible alert component for displaying contextual feedback messages.
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

  const FlutstrapAlert({
    Key? key,
    this.title,
    required this.message,
    this.variant = FSAlertVariant.primary,
    this.dismissible = false,
    this.onDismiss,
    this.leading,
    this.trailing,
    this.autoDismissDuration,
    this.showIcon = true,
  }) : super(key: key);

  @override
  State<FlutstrapAlert> createState() => _FlutstrapAlertState();
}

class _FlutstrapAlertState extends State<FlutstrapAlert> {
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    _setupAutoDismiss();
  }

  void _setupAutoDismiss() {
    if (widget.autoDismissDuration != null) {
      Future.delayed(widget.autoDismissDuration!, _dismiss);
    }
  }

  void _dismiss() {
    if (mounted && _isVisible) {
      setState(() => _isVisible = false);
      widget.onDismiss?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isVisible) return const SizedBox.shrink();

    final theme = FSTheme.of(context);
    final colors = theme.colors;
    final alertStyle = _getAlertStyle(colors);

    return AnimatedContainer(
      duration: theme.animation.duration,
      curve: theme.animation.curve,
      padding: EdgeInsets.all(FSSpacing.md),
      decoration: BoxDecoration(
        color: alertStyle.backgroundColor,
        border: Border.all(
          color: alertStyle.borderColor,
          width: alertStyle.borderWidth,
        ),
        borderRadius: BorderRadius.circular(alertStyle.borderRadius),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.showIcon && widget.leading == null) ...[
            Icon(
              alertStyle.icon,
              color: alertStyle.iconColor,
              size: 20,
            ),
            SizedBox(width: FSSpacing.sm),
          ],
          if (widget.leading != null) ...[
            widget.leading!,
            SizedBox(width: FSSpacing.sm),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.title != null) ...[
                  Text(
                    widget.title!,
                    style: alertStyle.titleStyle,
                  ),
                  SizedBox(height: FSSpacing.xs),
                ],
                Text(
                  widget.message,
                  style: alertStyle.messageStyle,
                ),
              ],
            ),
          ),
          if (widget.trailing != null) ...[
            SizedBox(width: FSSpacing.sm),
            widget.trailing!,
          ],
          if (widget.dismissible) ...[
            SizedBox(width: FSSpacing.sm),
            GestureDetector(
              onTap: _dismiss,
              child: Icon(
                Icons.close,
                size: 16,
                color: alertStyle.iconColor,
              ),
            ),
          ],
        ],
      ),
    );
  }

  _AlertStyle _getAlertStyle(FSColorScheme colors) {
    switch (widget.variant) {
      case FSAlertVariant.primary:
        return _AlertStyle(
          backgroundColor: colors.primary.withOpacity(0.1),
          borderColor: colors.primary,
          iconColor: colors.primary,
          icon: Icons.info_outlined,
          titleStyle: TextStyle(
            fontWeight: FontWeight.w600,
            color: colors.primary,
          ),
          messageStyle: TextStyle(color: colors.primary),
          borderRadius: 8.0,
          borderWidth: 1.0,
        );
      case FSAlertVariant.secondary:
        return _AlertStyle(
          backgroundColor: colors.secondary.withOpacity(0.1),
          borderColor: colors.secondary,
          iconColor: colors.secondary,
          icon: Icons.info_outlined,
          titleStyle: TextStyle(
            fontWeight: FontWeight.w600,
            color: colors.secondary,
          ),
          messageStyle: TextStyle(color: colors.secondary),
          borderRadius: 8.0,
          borderWidth: 1.0,
        );
      case FSAlertVariant.success:
        return _AlertStyle(
          backgroundColor: colors.success.withOpacity(0.1),
          borderColor: colors.success,
          iconColor: colors.success,
          icon: Icons.check_circle_outlined,
          titleStyle: TextStyle(
            fontWeight: FontWeight.w600,
            color: colors.success,
          ),
          messageStyle: TextStyle(color: colors.success),
          borderRadius: 8.0,
          borderWidth: 1.0,
        );
      case FSAlertVariant.danger:
        return _AlertStyle(
          backgroundColor: colors.danger.withOpacity(0.1),
          borderColor: colors.danger,
          iconColor: colors.danger,
          icon: Icons.error_outlined,
          titleStyle: TextStyle(
            fontWeight: FontWeight.w600,
            color: colors.danger,
          ),
          messageStyle: TextStyle(color: colors.danger),
          borderRadius: 8.0,
          borderWidth: 1.0,
        );
      case FSAlertVariant.warning:
        return _AlertStyle(
          backgroundColor: colors.warning.withOpacity(0.1),
          borderColor: colors.warning,
          iconColor: colors.warning,
          icon: Icons.warning_amber_outlined,
          titleStyle: TextStyle(
            fontWeight: FontWeight.w600,
            color: colors.warning,
          ),
          messageStyle: TextStyle(color: colors.warning),
          borderRadius: 8.0,
          borderWidth: 1.0,
        );
      case FSAlertVariant.info:
        return _AlertStyle(
          backgroundColor: colors.info.withOpacity(0.1),
          borderColor: colors.info,
          iconColor: colors.info,
          icon: Icons.info_outlined,
          titleStyle: TextStyle(
            fontWeight: FontWeight.w600,
            color: colors.info,
          ),
          messageStyle: TextStyle(color: colors.info),
          borderRadius: 8.0,
          borderWidth: 1.0,
        );
      case FSAlertVariant.light:
        return _AlertStyle(
          backgroundColor: colors.light,
          borderColor: colors.outline,
          iconColor: colors.onBackground,
          icon: Icons.info_outlined,
          titleStyle: TextStyle(
            fontWeight: FontWeight.w600,
            color: colors.onBackground,
          ),
          messageStyle: TextStyle(color: colors.onBackground),
          borderRadius: 8.0,
          borderWidth: 1.0,
        );
      case FSAlertVariant.dark:
        return _AlertStyle(
          backgroundColor: colors.dark,
          borderColor: colors.dark,
          iconColor: colors.onPrimary,
          icon: Icons.info_outlined,
          titleStyle: TextStyle(
            fontWeight: FontWeight.w600,
            color: colors.onPrimary,
          ),
          messageStyle: TextStyle(color: colors.onPrimary),
          borderRadius: 8.0,
          borderWidth: 1.0,
        );
    }
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
  final double borderRadius;
  final double borderWidth;

  const _AlertStyle({
    required this.backgroundColor,
    required this.borderColor,
    required this.iconColor,
    required this.icon,
    required this.titleStyle,
    required this.messageStyle,
    required this.borderRadius,
    required this.borderWidth,
  });
}

// Convenience factory methods for common alert types
extension FSAlertFactories on FlutstrapAlert {
  static Widget success({
    required String message,
    String? title,
    bool dismissible = true,
  }) {
    return FlutstrapAlert(
      title: title ?? 'Success',
      message: message,
      variant: FSAlertVariant.success,
      dismissible: dismissible,
    );
  }

  static Widget error({
    required String message,
    String? title,
    bool dismissible = true,
  }) {
    return FlutstrapAlert(
      title: title ?? 'Error',
      message: message,
      variant: FSAlertVariant.danger,
      dismissible: dismissible,
    );
  }

  static Widget warning({
    required String message,
    String? title,
    bool dismissible = true,
  }) {
    return FlutstrapAlert(
      title: title ?? 'Warning',
      message: message,
      variant: FSAlertVariant.warning,
      dismissible: dismissible,
    );
  }

  static Widget info({
    required String message,
    String? title,
    bool dismissible = true,
  }) {
    return FlutstrapAlert(
      title: title ?? 'Information',
      message: message,
      variant: FSAlertVariant.info,
      dismissible: dismissible,
    );
  }
}
