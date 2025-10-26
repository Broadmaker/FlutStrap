// lib/components/forms/flutstrap_checkbox.dart
import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../../core/spacing.dart';

/// Flutstrap Checkbox Variants
///
/// Defines the visual style variants for checkboxes
enum FSCheckboxVariant {
  primary,
  secondary,
  success,
  danger,
  warning,
  info,
  light,
  dark,
}

/// Flutstrap Checkbox Size
///
/// Defines the size variants for checkboxes
enum FSCheckboxSize {
  sm,
  md,
  lg,
}

/// Flutstrap Checkbox
///
/// A customizable checkbox component with Bootstrap-inspired styling.
class FlutstrapCheckbox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;
  final FSCheckboxVariant variant;
  final FSCheckboxSize size;
  final String? label;
  final Widget? customLabel;
  final bool disabled;
  final bool inline;
  final String? semanticLabel;
  final bool showValidation;
  final bool isValid;
  final String? validationMessage;

  const FlutstrapCheckbox({
    Key? key,
    required this.value,
    this.onChanged,
    this.variant = FSCheckboxVariant.primary,
    this.size = FSCheckboxSize.md,
    this.label,
    this.customLabel,
    this.disabled = false,
    this.inline = false,
    this.semanticLabel,
    this.showValidation = false,
    this.isValid = true,
    this.validationMessage,
  }) : super(key: key);

  @override
  State<FlutstrapCheckbox> createState() => _FlutstrapCheckboxState();
}

class _FlutstrapCheckboxState extends State<FlutstrapCheckbox> {
  bool _isHovered = false;
  bool _isFocused = false;

  void _handleTap() {
    if (!widget.disabled && widget.onChanged != null) {
      widget.onChanged!(!widget.value);
    }
  }

  void _handleFocusChange(bool hasFocus) {
    setState(() {
      _isFocused = hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = FSTheme.of(context);
    final checkboxStyle = _CheckboxStyle(theme, widget.variant, widget.size);

    final checkbox = _buildCheckbox(checkboxStyle);
    final hasLabel = widget.label != null || widget.customLabel != null;

    // Wrap the entire content in a GestureDetector to make the whole area tappable
    return GestureDetector(
      onTap: _handleTap,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: FocusableActionDetector(
          onFocusChange: _handleFocusChange,
          child: Semantics(
            label: widget.semanticLabel ?? widget.label,
            enabled: !widget.disabled,
            checked: widget.value,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.inline && hasLabel)
                  _buildInlineLayout(checkbox, checkboxStyle)
                else
                  _buildBlockLayout(checkbox, checkboxStyle, hasLabel),
                if (widget.showValidation &&
                    !widget.isValid &&
                    widget.validationMessage != null)
                  _buildValidationMessage(checkboxStyle),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInlineLayout(Widget checkbox, _CheckboxStyle style) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        checkbox,
        if (widget.label != null || widget.customLabel != null)
          SizedBox(width: style.labelSpacing),
        if (widget.label != null || widget.customLabel != null)
          _buildLabel(style),
      ],
    );
  }

  Widget _buildBlockLayout(
      Widget checkbox, _CheckboxStyle style, bool hasLabel) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasLabel) ...[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              checkbox,
              SizedBox(width: style.labelSpacing),
              _buildLabel(style),
            ],
          ),
        ] else ...[
          checkbox, // Just the checkbox without label spacing
        ],
      ],
    );
  }

  Widget _buildCheckbox(_CheckboxStyle style) {
    return Container(
      width: style.checkboxSize,
      height: style.checkboxSize,
      decoration: BoxDecoration(
        color: _getBackgroundColor(style),
        borderRadius: style.borderRadius,
        border: Border.all(
          color: _getBorderColor(style),
          width: style.borderWidth,
        ),
        boxShadow: _getBoxShadow(style),
      ),
      child: widget.value ? _buildCheckmark(style) : null,
    );
  }

  Widget _buildCheckmark(_CheckboxStyle style) {
    return Icon(
      Icons.check,
      size: style.checkmarkSize,
      color: _getCheckmarkColor(style),
    );
  }

  Widget _buildLabel(_CheckboxStyle style) {
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

  Widget _buildValidationMessage(_CheckboxStyle style) {
    return Padding(
      padding: style.validationMessagePadding,
      child: Text(
        widget.validationMessage!,
        style: style.validationTextStyle,
      ),
    );
  }

  Color _getBackgroundColor(_CheckboxStyle style) {
    if (widget.disabled) {
      return style.disabledBackgroundColor;
    }

    if (widget.value) {
      return style.activeBackgroundColor;
    }

    if (_isHovered) {
      return style.hoverBackgroundColor;
    }

    return style.backgroundColor;
  }

  Color _getBorderColor(_CheckboxStyle style) {
    if (!widget.isValid && widget.showValidation) {
      return style.errorColor;
    }

    if (widget.disabled) {
      return style.disabledBorderColor;
    }

    if (_isFocused) {
      return style.focusBorderColor;
    }

    if (_isHovered) {
      return style.hoverBorderColor;
    }

    if (widget.value) {
      return style.activeBorderColor;
    }

    return style.borderColor;
  }

  Color _getCheckmarkColor(_CheckboxStyle style) {
    if (widget.disabled) {
      return style.disabledCheckmarkColor;
    }
    return style.checkmarkColor;
  }

  List<BoxShadow>? _getBoxShadow(_CheckboxStyle style) {
    if (_isFocused && !widget.disabled) {
      return style.focusShadow;
    }
    return null;
  }
}

/// Internal style configuration for checkboxes
class _CheckboxStyle {
  final FSThemeData theme;
  final FSCheckboxVariant variant;
  final FSCheckboxSize size;

  _CheckboxStyle(this.theme, this.variant, this.size);

  // Sizes
  double get checkboxSize => _getCheckboxSize();
  double get checkmarkSize => _getCheckmarkSize();
  double get borderWidth => 2.0;
  double get labelSpacing => 8.0;

  // Colors
  Color get backgroundColor => theme.colors.surface;
  Color get activeBackgroundColor => _getActiveBackgroundColor();
  Color get hoverBackgroundColor => _getHoverBackgroundColor();
  Color get disabledBackgroundColor => theme.colors.surface.withOpacity(0.5);

  Color get borderColor => theme.colors.outline;
  Color get activeBorderColor => _getActiveBackgroundColor();
  Color get hoverBorderColor => _getActiveBackgroundColor().withOpacity(0.7);
  Color get focusBorderColor => _getActiveBackgroundColor();
  Color get disabledBorderColor => theme.colors.outline.withOpacity(0.5);

  Color get checkmarkColor => _getCheckmarkColor();
  Color get disabledCheckmarkColor => theme.colors.onSurface.withOpacity(0.5);

  Color get errorColor => theme.colors.danger;
  Color get disabledTextColor => theme.colors.onBackground.withOpacity(0.5);

  // Text styles
  TextStyle get labelTextStyle => theme.typography.bodyMedium.copyWith(
        color: theme.colors.onBackground,
      );

  TextStyle get validationTextStyle => theme.typography.bodySmall.copyWith(
        color: theme.colors.danger,
      );

  // Layout
  EdgeInsets get validationMessagePadding => const EdgeInsets.only(top: 4.0);

  // Border
  BorderRadius get borderRadius => BorderRadius.circular(4.0);

  // Shadows
  List<BoxShadow> get focusShadow => [
        BoxShadow(
          color: _getActiveBackgroundColor().withOpacity(0.3),
          blurRadius: 4,
          spreadRadius: 2,
        ),
      ];

  double _getCheckboxSize() {
    switch (size) {
      case FSCheckboxSize.sm:
        return 16.0;
      case FSCheckboxSize.md:
        return 20.0;
      case FSCheckboxSize.lg:
        return 24.0;
    }
  }

  double _getCheckmarkSize() {
    switch (size) {
      case FSCheckboxSize.sm:
        return 12.0;
      case FSCheckboxSize.md:
        return 16.0;
      case FSCheckboxSize.lg:
        return 20.0;
    }
  }

  Color _getActiveBackgroundColor() {
    final colors = theme.colors;
    switch (variant) {
      case FSCheckboxVariant.primary:
        return colors.primary;
      case FSCheckboxVariant.secondary:
        return colors.secondary;
      case FSCheckboxVariant.success:
        return colors.success;
      case FSCheckboxVariant.danger:
        return colors.danger;
      case FSCheckboxVariant.warning:
        return colors.warning;
      case FSCheckboxVariant.info:
        return colors.info;
      case FSCheckboxVariant.light:
        return colors.surface;
      case FSCheckboxVariant.dark:
        return colors.onBackground;
    }
  }

  Color _getHoverBackgroundColor() {
    return _getActiveBackgroundColor().withOpacity(0.1);
  }

  Color _getCheckmarkColor() {
    switch (variant) {
      case FSCheckboxVariant.light:
        return theme.colors.onSurface;
      default:
        return theme.colors.onPrimary;
    }
  }
}
