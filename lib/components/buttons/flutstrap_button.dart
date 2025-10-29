/// Flutstrap Button
///
/// A versatile button component with Bootstrap-inspired variants, sizes, and states.
///
/// {@macro flutstrap_button.performance}
/// {@macro flutstrap_button.accessibility}
/// {@macro flutstrap_button.best_practices}
///
/// ## Usage Examples
///
/// ```dart
/// // Basic button
/// FlutstrapButton(
///   onPressed: () {},
///   text: 'Primary Button',
///   variant: FSButtonVariant.primary,
/// )
///
/// // With icon and loading state
/// FlutstrapButton(
///   onPressed: _submitForm,
///   text: 'Submit',
///   variant: FSButtonVariant.success,
///   leading: Icon(Icons.check),
///   loading: _isSubmitting,
///   expanded: true,
/// )
///
/// // Using copyWith for state modifications
/// FlutstrapButton(
///   onPressed: () {},
///   text: 'Button',
/// ).copyWith(variant: FSButtonVariant.danger)
///
/// // Disabled outline button
/// FlutstrapButton(
///   onPressed: null,
///   text: 'Disabled',
///   variant: FSButtonVariant.outlinePrimary,
/// )
///
/// // Using const constructor for common cases
/// const FlutstrapButton.primary(
///   onPressed: _handlePress,
///   text: 'Primary Button',
/// )
/// ```
///
/// {@template flutstrap_button.performance}
/// ## Performance
///
/// Button styles are automatically cached based on variant, size, and theme brightness
/// for optimal performance. Multiple buttons with the same configuration will reuse
/// the same computed styles.
/// {@endtemplate}
///
/// {@template flutstrap_button.accessibility}
/// ## Accessibility
///
/// - Uses `Semantics` widget for screen readers
/// - Provides proper semantic labels for text and loading states
/// - Follows Material Design accessibility guidelines
/// {@endtemplate}
///
/// {@template flutstrap_button.best_practices}
/// ## Best Practices
///
/// - Use `copyWith()` for state modifications to benefit from style caching
/// - Prefer `text` property over `child` for simple text buttons
/// - Use `loading` state to provide feedback for async operations
/// - Consider using convenience methods for common variant changes
/// {@endtemplate}
///
/// {@category Components}
/// {@category Buttons}

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
@immutable
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

  /// Main constructor for FlutstrapButton
  const FlutstrapButton({
    super.key,
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
        super();

  /// Const constructor for primary buttons
  const FlutstrapButton.primary({
    super.key,
    required this.onPressed,
    this.text,
  })  : onLongPress = null,
        style = null,
        focusNode = null,
        autofocus = false,
        clipBehavior = Clip.none,
        variant = FSButtonVariant.primary,
        size = FSButtonSize.md,
        disabled = false,
        loading = false,
        child = null,
        leading = null,
        trailing = null,
        expanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = FSTheme.of(context);
    final isEnabled = !disabled && !loading && onPressed != null;

    // Enhanced validation in debug mode
    assert(() {
      if (loading && isEnabled) {
        debugPrint('FlutstrapButton: Button is loading but still enabled. '
            'Consider disabling the button during loading states.');
      }
      return true;
    }());

    return Semantics(
      button: true,
      enabled: isEnabled,
      label: text ?? _getSemanticLabel(child),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: expanded ? double.infinity : 0,
          maxWidth: expanded ? double.infinity : double.infinity,
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
      ),
    );
  }

  // STYLE CACHING FOR PERFORMANCE
  static final _styleCache = <_StyleCacheKey, ButtonStyle>{};

  /// Gets the current cache size (for debugging and monitoring)
  static int get cacheSize => _styleCache.length;

  /// Clears the style cache (useful for theme changes)
  static void clearCache() => _styleCache.clear();

  ButtonStyle _buildButtonStyle(FSThemeData theme, BuildContext context) {
    final cacheKey = _StyleCacheKey(variant, size, theme.brightness);

    return _styleCache.putIfAbsent(cacheKey, () {
      // Log cache miss in debug mode
      assert(() {
        debugPrint(
            'FlutstrapButton: Cache miss for $cacheKey (Total cached: ${_styleCache.length})');
        return true;
      }());

      final baseStyle = style ?? Theme.of(context).textButtonTheme.style;
      final variantStyle = _getVariantStyle(theme);
      final sizeStyle = _getSizeStyle(theme);

      return _mergeStyles(baseStyle, variantStyle, sizeStyle);
    });
  }

  // EFFICIENT STYLE MERGING
  ButtonStyle _mergeStyles(
      ButtonStyle? base, ButtonStyle variant, ButtonStyle size) {
    return (base ?? const ButtonStyle()).merge(variant).merge(size);
  }

  // ENHANCED VARIANT STYLES WITH MATERIAL STATES
  ButtonStyle _getVariantStyle(FSThemeData theme) {
    final colors = theme.colors; // ✅ FIXED: Now using FSColorScheme

    Color getBackgroundColor(Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return colors.outline.withOpacity(0.12);
      }

      switch (variant) {
        case FSButtonVariant.primary:
          return colors.primary;
        case FSButtonVariant.secondary:
          return colors.secondary;
        case FSButtonVariant.success:
          return colors.success;
        case FSButtonVariant.danger:
          return colors.danger;
        case FSButtonVariant.warning:
          return colors.warning;
        case FSButtonVariant.info:
          return colors.info;
        case FSButtonVariant.light:
          return colors.light;
        case FSButtonVariant.dark:
          return colors.dark;
        case FSButtonVariant.link:
        case FSButtonVariant.outlinePrimary:
        case FSButtonVariant.outlineSecondary:
        case FSButtonVariant.outlineSuccess:
        case FSButtonVariant.outlineDanger:
        case FSButtonVariant.outlineWarning:
        case FSButtonVariant.outlineInfo:
        case FSButtonVariant.outlineLight:
        case FSButtonVariant.outlineDark:
          return Colors.transparent;
      }
    }

    Color getForegroundColor(Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return colors.onBackground.withOpacity(0.38);
      }

      switch (variant) {
        case FSButtonVariant.primary:
        case FSButtonVariant.secondary:
        case FSButtonVariant.success:
        case FSButtonVariant.danger:
        case FSButtonVariant.info:
        case FSButtonVariant.dark:
          return colors.onPrimary;
        case FSButtonVariant.warning:
        case FSButtonVariant.light:
          return colors.onBackground;
        case FSButtonVariant.link:
          return colors.primary;
        case FSButtonVariant.outlinePrimary:
          return colors.primary;
        case FSButtonVariant.outlineSecondary:
          return colors.secondary;
        case FSButtonVariant.outlineSuccess:
          return colors.success;
        case FSButtonVariant.outlineDanger:
          return colors.danger;
        case FSButtonVariant.outlineWarning:
          return colors.warning;
        case FSButtonVariant.outlineInfo:
          return colors.info;
        case FSButtonVariant.outlineLight:
          return colors.light;
        case FSButtonVariant.outlineDark:
          return colors.dark;
      }
    }

    Color getOverlayColor(Set<MaterialState> states) {
      final foregroundColor = getForegroundColor(<MaterialState>{});

      if (states.contains(MaterialState.pressed)) {
        return foregroundColor.withOpacity(0.2);
      }
      if (states.contains(MaterialState.hovered)) {
        return foregroundColor.withOpacity(0.08);
      }
      if (states.contains(MaterialState.focused)) {
        return foregroundColor.withOpacity(0.12);
      }
      return Colors.transparent;
    }

    BorderSide? getBorderSide(Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return BorderSide(color: colors.outline.withOpacity(0.12));
      }

      switch (variant) {
        case FSButtonVariant.outlinePrimary:
          return BorderSide(color: colors.primary);
        case FSButtonVariant.outlineSecondary:
          return BorderSide(color: colors.secondary);
        case FSButtonVariant.outlineSuccess:
          return BorderSide(color: colors.success);
        case FSButtonVariant.outlineDanger:
          return BorderSide(color: colors.danger);
        case FSButtonVariant.outlineWarning:
          return BorderSide(color: colors.warning);
        case FSButtonVariant.outlineInfo:
          return BorderSide(color: colors.info);
        case FSButtonVariant.outlineLight:
          return BorderSide(color: colors.light);
        case FSButtonVariant.outlineDark:
          return BorderSide(color: colors.dark);
        default:
          return null;
      }
    }

    return ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith(getBackgroundColor),
      foregroundColor: MaterialStateProperty.resolveWith(getForegroundColor),
      overlayColor: MaterialStateProperty.resolveWith(getOverlayColor),
      side: MaterialStateProperty.resolveWith(getBorderSide),
      elevation: MaterialStateProperty.all(0),
      shadowColor: MaterialStateProperty.all(Colors.transparent),
    );
  }

  // IMPROVED SIZE SYSTEM WITH THEME TYPOGRAPHY
  ButtonStyle _getSizeStyle(FSThemeData theme) {
    final typography = theme.typography;

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
            typography.labelSmall.copyWith(fontWeight: FontWeight.w500),
          ),
          minimumSize: MaterialStateProperty.all(const Size(64, 32)),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
            typography.labelMedium.copyWith(fontWeight: FontWeight.w500),
          ),
          minimumSize: MaterialStateProperty.all(const Size(76, 40)),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
            typography.labelLarge.copyWith(fontWeight: FontWeight.w500),
          ),
          minimumSize: MaterialStateProperty.all(const Size(88, 48)),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        );
    }
  }

  // ENHANCED BUTTON CONTENT WITH ACCESSIBILITY
  Widget _buildButtonContent(FSThemeData theme) {
    if (loading) {
      return Semantics(
        label: 'Loading',
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(_getLoadingColor(theme)),
          ),
        ),
      );
    }

    final content = child ??
        Text(
          text!,
          semanticsLabel: text,
          overflow: TextOverflow.ellipsis,
        );

    if (leading != null || trailing != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (leading != null) ...[
            leading!,
            SizedBox(width: FSSpacing.xs),
          ],
          Flexible(
            child: content,
          ),
          if (trailing != null) ...[
            SizedBox(width: FSSpacing.xs),
            trailing!,
          ],
        ],
      );
    }

    return content;
  }

  // HELPER METHOD FOR SEMANTIC LABELS
  String? _getSemanticLabel(Widget? child) {
    if (child == null) return null;

    if (child is Text) return child.data;
    if (child is RichText) {
      // Extract text from RichText if possible
      return child.text.toPlainText();
    }

    return null;
  }

  // PERFECT LOADING COLOR CALCULATION
  Color _getLoadingColor(FSThemeData theme) {
    final colors = theme.colors; // ✅ FIXED: Now using FSColorScheme

    // Handle outline variants
    if (_isOutlineVariant(variant)) {
      return _getOutlineVariantColor(variant, colors);
    }

    // Handle filled variants
    return _getFilledVariantColor(variant, colors);
  }

  bool _isOutlineVariant(FSButtonVariant variant) {
    return variant.index >= FSButtonVariant.outlinePrimary.index;
  }

  Color _getOutlineVariantColor(FSButtonVariant variant, FSColorScheme colors) {
    // ✅ FIXED: Parameter type
    switch (variant) {
      case FSButtonVariant.outlinePrimary:
        return colors.primary;
      case FSButtonVariant.outlineSecondary:
        return colors.secondary;
      case FSButtonVariant.outlineSuccess:
        return colors.success;
      case FSButtonVariant.outlineDanger:
        return colors.danger;
      case FSButtonVariant.outlineWarning:
        return colors.warning;
      case FSButtonVariant.outlineInfo:
        return colors.info;
      case FSButtonVariant.outlineLight:
        return colors.light;
      case FSButtonVariant.outlineDark:
        return colors.dark;
      default:
        // This should never happen due to _isOutlineVariant check
        assert(false, 'Unexpected outline variant: $variant');
        return colors.primary;
    }
  }

  Color _getFilledVariantColor(FSButtonVariant variant, FSColorScheme colors) {
    // ✅ FIXED: Parameter type
    switch (variant) {
      case FSButtonVariant.primary:
      case FSButtonVariant.secondary:
      case FSButtonVariant.success:
      case FSButtonVariant.danger:
      case FSButtonVariant.info:
      case FSButtonVariant.dark:
        return colors.onPrimary;
      case FSButtonVariant.warning:
      case FSButtonVariant.light:
        return colors.onBackground;
      case FSButtonVariant.link:
        return colors.primary;
      default:
        // Handle any new variants added in the future
        assert(false, 'Unhandled button variant: $variant');
        return colors.primary;
    }
  }

  // REPLACE BUILDER METHODS WITH SINGLE COPYWITH
  FlutstrapButton copyWith({
    Key? key,
    VoidCallback? onPressed,
    VoidCallback? onLongPress,
    ButtonStyle? style,
    FocusNode? focusNode,
    bool? autofocus,
    Clip? clipBehavior,
    FSButtonVariant? variant,
    FSButtonSize? size,
    bool? disabled,
    bool? loading,
    Widget? child,
    String? text,
    Widget? leading,
    Widget? trailing,
    bool? expanded,
  }) {
    return FlutstrapButton(
      key: key ?? this.key,
      onPressed: onPressed ?? this.onPressed,
      onLongPress: onLongPress ?? this.onLongPress,
      style: style ?? this.style,
      focusNode: focusNode ?? this.focusNode,
      autofocus: autofocus ?? this.autofocus,
      clipBehavior: clipBehavior ?? this.clipBehavior,
      variant: variant ?? this.variant,
      size: size ?? this.size,
      disabled: disabled ?? this.disabled,
      loading: loading ?? this.loading,
      child: child ?? this.child,
      text: text ?? this.text,
      leading: leading ?? this.leading,
      trailing: trailing ?? this.trailing,
      expanded: expanded ?? this.expanded,
    );
  }

  // OPTIMIZED CONVENIENCE METHODS
  FlutstrapButton primary() =>
      _createOptimizedCopy(variant: FSButtonVariant.primary);
  FlutstrapButton secondary() =>
      _createOptimizedCopy(variant: FSButtonVariant.secondary);
  FlutstrapButton success() =>
      _createOptimizedCopy(variant: FSButtonVariant.success);
  FlutstrapButton danger() =>
      _createOptimizedCopy(variant: FSButtonVariant.danger);
  FlutstrapButton warning() =>
      _createOptimizedCopy(variant: FSButtonVariant.warning);
  FlutstrapButton info() => _createOptimizedCopy(variant: FSButtonVariant.info);
  FlutstrapButton light() =>
      _createOptimizedCopy(variant: FSButtonVariant.light);
  FlutstrapButton dark() => _createOptimizedCopy(variant: FSButtonVariant.dark);
  FlutstrapButton link() => _createOptimizedCopy(variant: FSButtonVariant.link);
  FlutstrapButton outlinePrimary() =>
      _createOptimizedCopy(variant: FSButtonVariant.outlinePrimary);
  FlutstrapButton outlineSecondary() =>
      _createOptimizedCopy(variant: FSButtonVariant.outlineSecondary);
  FlutstrapButton outlineSuccess() =>
      _createOptimizedCopy(variant: FSButtonVariant.outlineSuccess);
  FlutstrapButton outlineDanger() =>
      _createOptimizedCopy(variant: FSButtonVariant.outlineDanger);
  FlutstrapButton outlineWarning() =>
      _createOptimizedCopy(variant: FSButtonVariant.outlineWarning);
  FlutstrapButton outlineInfo() =>
      _createOptimizedCopy(variant: FSButtonVariant.outlineInfo);
  FlutstrapButton outlineLight() =>
      _createOptimizedCopy(variant: FSButtonVariant.outlineLight);
  FlutstrapButton outlineDark() =>
      _createOptimizedCopy(variant: FSButtonVariant.outlineDark);

  FlutstrapButton small() => _createOptimizedCopy(size: FSButtonSize.sm);
  FlutstrapButton medium() => _createOptimizedCopy(size: FSButtonSize.md);
  FlutstrapButton large() => _createOptimizedCopy(size: FSButtonSize.lg);

  FlutstrapButton asDisabled() => _createOptimizedCopy(disabled: true);
  FlutstrapButton asEnabled() => _createOptimizedCopy(disabled: false);
  FlutstrapButton withLoading(bool isLoading) =>
      _createOptimizedCopy(loading: isLoading);
  FlutstrapButton expand() => _createOptimizedCopy(expanded: true);
  FlutstrapButton shrink() => _createOptimizedCopy(expanded: false);

  // OPTIMIZED COPY CREATION
  FlutstrapButton _createOptimizedCopy({
    FSButtonVariant? variant,
    FSButtonSize? size,
    bool? disabled,
    bool? loading,
    bool? expanded,
  }) {
    // Return const constructor for common default configurations
    if (variant == FSButtonVariant.primary &&
        this.variant == FSButtonVariant.primary &&
        size == FSButtonSize.md &&
        this.size == FSButtonSize.md &&
        disabled == false &&
        this.disabled == false &&
        loading == false &&
        this.loading == false &&
        expanded == false &&
        this.expanded == false &&
        onPressed != null &&
        text != null &&
        child == null &&
        leading == null &&
        trailing == null) {
      return FlutstrapButton.primary(
        key: key,
        onPressed: onPressed!,
        text: text,
      );
    }

    return copyWith(
      variant: variant,
      size: size,
      disabled: disabled,
      loading: loading,
      expanded: expanded,
    );
  }
}

// STYLE CACHE KEY FOR EFFICIENT CACHING
class _StyleCacheKey {
  final FSButtonVariant variant;
  final FSButtonSize size;
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

  @override
  String toString() =>
      'StyleCacheKey(variant: $variant, size: $size, brightness: $brightness)';
}
