/// Flutstrap Button
///
/// A versatile button component with multiple variants, sizes, and states
/// inspired by Bootstrap's button system.

import 'package:flutter/material.dart';
import '../../../core/theme.dart';
import '../../../core/spacing.dart';

/// Flutstrap Button Variants
///
/// Defines the visual style variants for buttons
enum FSButtonVariant {
  primary,
  secondary,
  success,
  danger,
  warning,
  info,
  light,
  dark,
  link,
  outlinePrimary,
  outlineSecondary,
  outlineSuccess,
  outlineDanger,
  outlineWarning,
  outlineInfo,
  outlineLight,
  outlineDark,
}

/// Flutstrap Button Sizes
///
/// Defines the size variants for buttons
enum FSButtonSize {
  sm,
  md,
  lg,
}

/// Flutstrap Button Component
///
/// A customizable button with Bootstrap-inspired variants, sizes, and states.
class FlutstrapButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final ButtonStyle? style;
  final FocusNode? focusNode;
  final bool autofocus;
  final Clip clipBehavior;
  final FSButtonVariant variant;
  final FSButtonSize size;
  final bool disabled;
  final bool loading;
  final Widget? child;
  final String? text;
  final Widget? leading;
  final Widget? trailing;
  final bool expanded;

  const FlutstrapButton({
    Key? key,
    this.onPressed,
    this.onLongPress,
    this.style,
    this.focusNode,
    this.autofocus = false,
    this.clipBehavior = Clip.none,
    this.variant = FSButtonVariant.primary,
    this.size = FSButtonSize.md,
    this.disabled = false,
    this.loading = false,
    this.child,
    this.text,
    this.leading,
    this.trailing,
    this.expanded = false,
  })  : assert(child != null || text != null,
            'Either child or text must be provided'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = FSTheme.of(context);
    final isEnabled = !disabled && !loading && onPressed != null;

    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: expanded ? double.infinity : 0,
      ),
      child: TextButton(
        onPressed: isEnabled ? onPressed : null,
        onLongPress: isEnabled ? onLongPress : null,
        style: _buildButtonStyle(theme, context),
        focusNode: focusNode,
        autofocus: autofocus,
        clipBehavior: clipBehavior,
        child: _buildButtonContent(theme),
      ),
    );
  }

  ButtonStyle _buildButtonStyle(FSThemeData theme, BuildContext context) {
    final baseStyle = style ?? Theme.of(context).textButtonTheme.style;
    final variantStyle = _getVariantStyle(theme);
    final sizeStyle = _getSizeStyle();

    return baseStyle?.merge(variantStyle.merge(sizeStyle)) ??
        variantStyle.merge(sizeStyle);
  }

  ButtonStyle _getVariantStyle(FSThemeData theme) {
    final colors = theme.colors;

    switch (variant) {
      case FSButtonVariant.primary:
        return ButtonStyle(
          backgroundColor: MaterialStateProperty.all(colors.primary),
          foregroundColor: MaterialStateProperty.all(colors.onPrimary),
          overlayColor: MaterialStateProperty.all(
            colors.onPrimary.withOpacity(0.1),
          ),
        );
      case FSButtonVariant.secondary:
        return ButtonStyle(
          backgroundColor: MaterialStateProperty.all(colors.secondary),
          foregroundColor: MaterialStateProperty.all(colors.onSecondary),
          overlayColor: MaterialStateProperty.all(
            colors.onSecondary.withOpacity(0.1),
          ),
        );
      case FSButtonVariant.success:
        return ButtonStyle(
          backgroundColor: MaterialStateProperty.all(colors.success),
          foregroundColor: MaterialStateProperty.all(colors.onPrimary),
          overlayColor: MaterialStateProperty.all(
            colors.onPrimary.withOpacity(0.1),
          ),
        );
      case FSButtonVariant.danger:
        return ButtonStyle(
          backgroundColor: MaterialStateProperty.all(colors.danger),
          foregroundColor: MaterialStateProperty.all(colors.onPrimary),
          overlayColor: MaterialStateProperty.all(
            colors.onPrimary.withOpacity(0.1),
          ),
        );
      case FSButtonVariant.warning:
        return ButtonStyle(
          backgroundColor: MaterialStateProperty.all(colors.warning),
          foregroundColor: MaterialStateProperty.all(colors.onBackground),
          overlayColor: MaterialStateProperty.all(
            colors.onBackground.withOpacity(0.1),
          ),
        );
      case FSButtonVariant.info:
        return ButtonStyle(
          backgroundColor: MaterialStateProperty.all(colors.info),
          foregroundColor: MaterialStateProperty.all(colors.onPrimary),
          overlayColor: MaterialStateProperty.all(
            colors.onPrimary.withOpacity(0.1),
          ),
        );
      case FSButtonVariant.light:
        return ButtonStyle(
          backgroundColor: MaterialStateProperty.all(colors.light),
          foregroundColor: MaterialStateProperty.all(colors.onBackground),
          overlayColor: MaterialStateProperty.all(
            colors.onBackground.withOpacity(0.1),
          ),
        );
      case FSButtonVariant.dark:
        return ButtonStyle(
          backgroundColor: MaterialStateProperty.all(colors.dark),
          foregroundColor: MaterialStateProperty.all(colors.onPrimary),
          overlayColor: MaterialStateProperty.all(
            colors.onPrimary.withOpacity(0.1),
          ),
        );
      case FSButtonVariant.link:
        return ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          foregroundColor: MaterialStateProperty.all(colors.primary),
          overlayColor: MaterialStateProperty.all(
            colors.primary.withOpacity(0.1),
          ),
          elevation: MaterialStateProperty.all(0),
        );
      case FSButtonVariant.outlinePrimary:
        return ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          foregroundColor: MaterialStateProperty.all(colors.primary),
          side: MaterialStateProperty.all(
            BorderSide(color: colors.primary, width: 1),
          ),
          overlayColor: MaterialStateProperty.all(
            colors.primary.withOpacity(0.1),
          ),
        );
      case FSButtonVariant.outlineSecondary:
        return ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          foregroundColor: MaterialStateProperty.all(colors.secondary),
          side: MaterialStateProperty.all(
            BorderSide(color: colors.secondary, width: 1),
          ),
          overlayColor: MaterialStateProperty.all(
            colors.secondary.withOpacity(0.1),
          ),
        );
      // Add other outline variants similarly...
      default:
        return ButtonStyle(
          backgroundColor: MaterialStateProperty.all(colors.primary),
          foregroundColor: MaterialStateProperty.all(colors.onPrimary),
        );
    }
  }

  ButtonStyle _getSizeStyle() {
    switch (size) {
      case FSButtonSize.sm:
        return ButtonStyle(
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(
              horizontal: FSSpacing.sm,
              vertical: FSSpacing.xs,
            ),
          ),
          textStyle: MaterialStateProperty.all(
            const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        );
      case FSButtonSize.md:
        return ButtonStyle(
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(
              horizontal: FSSpacing.md,
              vertical: FSSpacing.sm,
            ),
          ),
          textStyle: MaterialStateProperty.all(
            const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        );
      case FSButtonSize.lg:
        return ButtonStyle(
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(
              horizontal: FSSpacing.lg,
              vertical: FSSpacing.md,
            ),
          ),
          textStyle: MaterialStateProperty.all(
            const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        );
    }
  }

  Widget _buildButtonContent(FSThemeData theme) {
    if (loading) {
      return SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            _getLoadingColor(theme),
          ),
        ),
      );
    }

    final content = child ?? Text(text!);

    if (leading != null || trailing != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leading != null) ...[
            leading!,
            SizedBox(width: FSSpacing.xs),
          ],
          content,
          if (trailing != null) ...[
            SizedBox(width: FSSpacing.xs),
            trailing!,
          ],
        ],
      );
    }

    return content;
  }

  Color _getLoadingColor(FSThemeData theme) {
    if (variant.toString().contains('outline')) {
      switch (variant) {
        case FSButtonVariant.outlinePrimary:
          return theme.colors.primary;
        case FSButtonVariant.outlineSecondary:
          return theme.colors.secondary;
        // Add other outline variants...
        default:
          return theme.colors.primary;
      }
    }

    switch (variant) {
      case FSButtonVariant.primary:
      case FSButtonVariant.secondary:
      case FSButtonVariant.success:
      case FSButtonVariant.danger:
      case FSButtonVariant.info:
      case FSButtonVariant.dark:
        return theme.colors.onPrimary;
      case FSButtonVariant.warning:
      case FSButtonVariant.light:
        return theme.colors.onBackground;
      case FSButtonVariant.link:
      case FSButtonVariant.outlinePrimary:
      case FSButtonVariant.outlineSecondary:
      case FSButtonVariant.outlineSuccess:
      case FSButtonVariant.outlineDanger:
      case FSButtonVariant.outlineWarning:
      case FSButtonVariant.outlineInfo:
      case FSButtonVariant.outlineLight:
      case FSButtonVariant.outlineDark:
        return theme.colors.primary;
    }
  }

  // Builder methods for common variants
  FlutstrapButton primary() {
    return FlutstrapButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      style: style,
      focusNode: focusNode,
      autofocus: autofocus,
      clipBehavior: clipBehavior,
      variant: FSButtonVariant.primary,
      size: size,
      disabled: disabled,
      loading: loading,
      child: child,
      text: text,
      leading: leading,
      trailing: trailing,
      expanded: expanded,
    );
  }

  FlutstrapButton danger() {
    return FlutstrapButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      style: style,
      focusNode: focusNode,
      autofocus: autofocus,
      clipBehavior: clipBehavior,
      variant: FSButtonVariant.danger,
      size: size,
      disabled: disabled,
      loading: loading,
      child: child,
      text: text,
      leading: leading,
      trailing: trailing,
      expanded: expanded,
    );
  }

  FlutstrapButton outline() {
    return FlutstrapButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      style: style,
      focusNode: focusNode,
      autofocus: autofocus,
      clipBehavior: clipBehavior,
      variant: FSButtonVariant.outlinePrimary,
      size: size,
      disabled: disabled,
      loading: loading,
      child: child,
      text: text,
      leading: leading,
      trailing: trailing,
      expanded: expanded,
    );
  }

  FlutstrapButton large() {
    return FlutstrapButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      style: style,
      focusNode: focusNode,
      autofocus: autofocus,
      clipBehavior: clipBehavior,
      variant: variant,
      size: FSButtonSize.lg,
      disabled: disabled,
      loading: loading,
      child: child,
      text: text,
      leading: leading,
      trailing: trailing,
      expanded: expanded,
    );
  }

  FlutstrapButton small() {
    return FlutstrapButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      style: style,
      focusNode: focusNode,
      autofocus: autofocus,
      clipBehavior: clipBehavior,
      variant: variant,
      size: FSButtonSize.sm,
      disabled: disabled,
      loading: loading,
      child: child,
      text: text,
      leading: leading,
      trailing: trailing,
      expanded: expanded,
    );
  }

  // Renamed from disabled() to asDisabled()
  FlutstrapButton asDisabled() {
    return FlutstrapButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      style: style,
      focusNode: focusNode,
      autofocus: autofocus,
      clipBehavior: clipBehavior,
      variant: variant,
      size: size,
      disabled: true,
      loading: loading,
      child: child,
      text: text,
      leading: leading,
      trailing: trailing,
      expanded: expanded,
    );
  }

  FlutstrapButton withLoading(bool isLoading) {
    return FlutstrapButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      style: style,
      focusNode: focusNode,
      autofocus: autofocus,
      clipBehavior: clipBehavior,
      variant: variant,
      size: size,
      disabled: disabled,
      loading: isLoading,
      child: child,
      text: text,
      leading: leading,
      trailing: trailing,
      expanded: expanded,
    );
  }

  FlutstrapButton expand() {
    return FlutstrapButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      style: style,
      focusNode: focusNode,
      autofocus: autofocus,
      clipBehavior: clipBehavior,
      variant: variant,
      size: size,
      disabled: disabled,
      loading: loading,
      child: child,
      text: text,
      leading: leading,
      trailing: trailing,
      expanded: true,
    );
  }
}
