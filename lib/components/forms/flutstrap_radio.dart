/// Flutstrap Radio
///
/// A customizable radio button component with Bootstrap-inspired styling.
///
/// ## Usage Examples
///
/// ```dart
/// // Basic radio group
/// Column(
///   children: [
///     FlutstrapRadio<String>(
///       value: 'option1',
///       groupValue: _selectedOption,
///       onChanged: (value) => setState(() => _selectedOption = value),
///       label: 'Option 1',
///     ),
///     FlutstrapRadio<String>(
///       value: 'option2',
///       groupValue: _selectedOption,
///       onChanged: (value) => setState(() => _selectedOption = value),
///       label: 'Option 2',
///     ),
///   ],
/// )
///
/// // Radio with variant
/// FlutstrapRadio<String>(
///   value: 'success',
///   groupValue: _status,
///   onChanged: (value) => setState(() => _status = value),
///   variant: FSRadioVariant.success,
///   label: 'Success Status',
/// )
///
/// // Disabled radio
/// FlutstrapRadio<String>(
///   value: 'disabled',
///   groupValue: _selected,
///   onChanged: null,
///   label: 'Disabled option',
///   disabled: true,
/// )
///
/// // Using convenience methods
/// FlutstrapRadio<String>(
///   value: 'custom',
///   groupValue: _selected,
///   onChanged: (value) => setState(() => _selected = value),
/// ).success().withLabel('Custom styled')
/// ```
///
/// {@category Components}
/// {@category Forms}

import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../../core/spacing.dart';

/// Flutstrap Radio Variants
enum FSRadioVariant {
  primary,
  secondary,
  success,
  danger,
  warning,
  info,
}

/// Flutstrap Radio Size
enum FSRadioSize {
  sm,
  md,
  lg,
}

class FlutstrapRadio<T> extends StatefulWidget {
  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;
  final FSRadioVariant variant;
  final FSRadioSize size;
  final String? label;
  final Widget? customLabel;
  final bool disabled;
  final bool inline;
  final String? semanticLabel;
  final bool showValidation;
  final bool isValid;
  final String? validationMessage;
  final Color? activeColor;
  final Color? dotColor;
  final VisualDensity? visualDensity;
  final EdgeInsetsGeometry? padding;

  const FlutstrapRadio({
    super.key,
    required this.value,
    required this.groupValue,
    this.onChanged,
    this.variant = FSRadioVariant.primary,
    this.size = FSRadioSize.md,
    this.label,
    this.customLabel,
    this.disabled = false,
    this.inline = false,
    this.semanticLabel,
    this.showValidation = false,
    this.isValid = true,
    this.validationMessage,
    this.activeColor,
    this.dotColor,
    this.visualDensity,
    this.padding,
  });

  @override
  State<FlutstrapRadio<T>> createState() => _FlutstrapRadioState<T>();

  // ✅ CONSISTENT COPYWITH PATTERN
  FlutstrapRadio<T> copyWith({
    Key? key,
    T? value,
    T? groupValue,
    ValueChanged<T?>? onChanged,
    FSRadioVariant? variant,
    FSRadioSize? size,
    String? label,
    Widget? customLabel,
    bool? disabled,
    bool? inline,
    String? semanticLabel,
    bool? showValidation,
    bool? isValid,
    String? validationMessage,
    Color? activeColor,
    Color? dotColor,
    VisualDensity? visualDensity,
    EdgeInsetsGeometry? padding,
  }) {
    return FlutstrapRadio<T>(
      key: key ?? this.key,
      value: value ?? this.value,
      groupValue: groupValue ?? this.groupValue,
      onChanged: onChanged ?? this.onChanged,
      variant: variant ?? this.variant,
      size: size ?? this.size,
      label: label ?? this.label,
      customLabel: customLabel ?? this.customLabel,
      disabled: disabled ?? this.disabled,
      inline: inline ?? this.inline,
      semanticLabel: semanticLabel ?? this.semanticLabel,
      showValidation: showValidation ?? this.showValidation,
      isValid: isValid ?? this.isValid,
      validationMessage: validationMessage ?? this.validationMessage,
      activeColor: activeColor ?? this.activeColor,
      dotColor: dotColor ?? this.dotColor,
      visualDensity: visualDensity ?? this.visualDensity,
      padding: padding ?? this.padding,
    );
  }

  // ✅ CONVENIENCE METHODS
  FlutstrapRadio<T> primary() => copyWith(variant: FSRadioVariant.primary);
  FlutstrapRadio<T> secondary() => copyWith(variant: FSRadioVariant.secondary);
  FlutstrapRadio<T> success() => copyWith(variant: FSRadioVariant.success);
  FlutstrapRadio<T> danger() => copyWith(variant: FSRadioVariant.danger);
  FlutstrapRadio<T> warning() => copyWith(variant: FSRadioVariant.warning);
  FlutstrapRadio<T> info() => copyWith(variant: FSRadioVariant.info);

  FlutstrapRadio<T> small() => copyWith(size: FSRadioSize.sm);
  FlutstrapRadio<T> medium() => copyWith(size: FSRadioSize.md);
  FlutstrapRadio<T> large() => copyWith(size: FSRadioSize.lg);

  FlutstrapRadio<T> asDisabled() => copyWith(disabled: true);
  FlutstrapRadio<T> asEnabled() => copyWith(disabled: false);
  FlutstrapRadio<T> withLabel(String label) => copyWith(label: label);
  FlutstrapRadio<T> withValidation(String message) => copyWith(
        validationMessage: message,
        showValidation: true,
        isValid: false,
      );
}

class _FlutstrapRadioState<T> extends State<FlutstrapRadio<T>> {
  // ✅ SIMPLIFIED STATE MANAGEMENT - NO INTERACTION STATES
  bool get _isSelected => widget.value == widget.groupValue;

  void _handleTap() {
    if (!widget.disabled && widget.onChanged != null && !_isSelected) {
      widget.onChanged!(widget.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = FSTheme.of(context);
    final radioStyle = _RadioStyle(theme, widget.variant, widget.size);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Radio and Label Row
        _buildRadioRow(radioStyle),

        // Validation Message
        if (widget.showValidation &&
            !widget.isValid &&
            widget.validationMessage != null)
          _buildValidationMessage(radioStyle),
      ],
    );
  }

  Widget _buildRadioRow(_RadioStyle style) {
    final hasLabel = widget.label != null || widget.customLabel != null;

    return MouseRegion(
      cursor: widget.disabled
          ? SystemMouseCursors.forbidden
          : SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _handleTap,
        child: Semantics(
          label: widget.semanticLabel ?? widget.label,
          enabled: !widget.disabled,
          checked: _isSelected,
          child: Container(
            padding: widget.padding ?? EdgeInsets.zero,
            child: widget.inline && hasLabel
                ? _buildInlineLayout(style)
                : _buildBlockLayout(style, hasLabel),
          ),
        ),
      ),
    );
  }

  Widget _buildInlineLayout(_RadioStyle style) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildRadio(style),
        if (widget.label != null || widget.customLabel != null) ...[
          SizedBox(width: style.labelSpacing),
          _buildLabel(style),
        ],
      ],
    );
  }

  Widget _buildBlockLayout(_RadioStyle style, bool hasLabel) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildRadio(style),
        if (hasLabel) ...[
          SizedBox(width: style.labelSpacing),
          Expanded(child: _buildLabel(style)),
        ],
      ],
    );
  }

  Widget _buildRadio(_RadioStyle style) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(style.radioSize / 2),
      child: InkWell(
        onTap: widget.disabled ? null : _handleTap,
        borderRadius: BorderRadius.circular(style.radioSize / 2),
        splashColor: _getSplashColor(style),
        highlightColor: _getHighlightColor(style),
        child: Container(
          width: style.radioSize,
          height: style.radioSize,
          decoration: BoxDecoration(
            color: _getBackgroundColor(style),
            borderRadius: BorderRadius.circular(style.radioSize / 2),
            border: Border.all(
              color: _getBorderColor(style),
              width: style.borderWidth,
            ),
          ),
          child: _isSelected ? _buildDot(style) : null,
        ),
      ),
    );
  }

  Widget _buildDot(_RadioStyle style) {
    return Center(
      child: Container(
        width: style.dotSize,
        height: style.dotSize,
        decoration: BoxDecoration(
          color: _getDotColor(style),
          borderRadius: BorderRadius.circular(style.dotSize / 2),
        ),
      ),
    );
  }

  Widget _buildLabel(_RadioStyle style) {
    if (widget.customLabel != null) {
      return widget.customLabel!;
    }

    if (widget.label != null) {
      return Text(
        widget.label!,
        style: style.labelTextStyle.copyWith(
          color: widget.disabled
              ? style.disabledTextColor
              : style.labelTextStyle.color,
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildValidationMessage(_RadioStyle style) {
    return Padding(
      padding: style.validationMessagePadding,
      child: Text(
        widget.validationMessage!,
        style: style.validationTextStyle,
      ),
    );
  }

  Color _getBackgroundColor(_RadioStyle style) {
    if (widget.disabled) {
      return style.disabledBackgroundColor;
    }

    if (_isSelected) {
      return widget.activeColor ?? style.activeBackgroundColor;
    }

    return style.backgroundColor;
  }

  Color _getBorderColor(_RadioStyle style) {
    if (!widget.isValid && widget.showValidation) {
      return style.errorColor;
    }

    if (widget.disabled) {
      return style.disabledBorderColor;
    }

    if (_isSelected) {
      return widget.activeColor ?? style.activeBorderColor;
    }

    return style.borderColor;
  }

  Color _getDotColor(_RadioStyle style) {
    if (widget.disabled) {
      return style.disabledDotColor;
    }
    return widget.dotColor ?? style.dotColor;
  }

  Color? _getSplashColor(_RadioStyle style) {
    if (widget.disabled) return null;
    return (widget.activeColor ?? style.activeBackgroundColor).withOpacity(0.2);
  }

  Color? _getHighlightColor(_RadioStyle style) {
    if (widget.disabled) return null;
    return (widget.activeColor ?? style.activeBackgroundColor).withOpacity(0.1);
  }
}

class _RadioStyle {
  final FSThemeData theme;
  final FSRadioVariant variant;
  final FSRadioSize size;

  _RadioStyle(this.theme, this.variant, this.size);

  // Sizes
  double get radioSize {
    switch (size) {
      case FSRadioSize.sm:
        return 16.0;
      case FSRadioSize.md:
        return 20.0;
      case FSRadioSize.lg:
        return 24.0;
    }
  }

  double get dotSize {
    switch (size) {
      case FSRadioSize.sm:
        return 6.0;
      case FSRadioSize.md:
        return 8.0;
      case FSRadioSize.lg:
        return 10.0;
    }
  }

  double get borderWidth => 2.0;
  double get labelSpacing => 8.0;

  // Colors
  Color get backgroundColor => theme.colors.surface;
  Color get activeBackgroundColor => _getActiveColor();
  Color get disabledBackgroundColor => theme.colors.outline.withOpacity(0.1);

  Color get borderColor => theme.colors.outline;
  Color get activeBorderColor => _getActiveColor();
  Color get disabledBorderColor => theme.colors.outline.withOpacity(0.3);

  Color get dotColor => _getDotColor();
  Color get disabledDotColor => theme.colors.onSurface.withOpacity(0.3);

  Color get errorColor => theme.colors.danger;
  Color get disabledTextColor => theme.colors.onSurface.withOpacity(0.38);

  // Text styles
  TextStyle get labelTextStyle => theme.typography.bodyMedium.copyWith(
        color: theme.colors.onBackground,
      );

  TextStyle get validationTextStyle => theme.typography.bodySmall.copyWith(
        color: theme.colors.danger,
        fontWeight: FontWeight.w500,
      );

  // Layout
  EdgeInsets get validationMessagePadding => const EdgeInsets.only(top: 4.0);

  Color _getActiveColor() {
    final colors = theme.colors;
    switch (variant) {
      case FSRadioVariant.primary:
        return colors.primary;
      case FSRadioVariant.secondary:
        return colors.secondary;
      case FSRadioVariant.success:
        return colors.success;
      case FSRadioVariant.danger:
        return colors.danger;
      case FSRadioVariant.warning:
        return colors.warning;
      case FSRadioVariant.info:
        return colors.info;
    }
  }

  Color _getDotColor() {
    return theme.colors.onPrimary;
  }
}
