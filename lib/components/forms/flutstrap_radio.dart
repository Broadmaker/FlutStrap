import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../../core/spacing.dart';

/// Flutstrap Radio Variants
///
/// Defines the visual style variants for radio buttons
enum FSRadioVariant {
  primary,
  secondary,
  success,
  danger,
  warning,
  info,
  light,
  dark,
}

/// Flutstrap Radio Size
///
/// Defines the size variants for radio buttons
enum FSRadioSize {
  sm,
  md,
  lg,
}

/// Flutstrap Radio
///
/// A customizable radio button component with Bootstrap-inspired styling.
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

  const FlutstrapRadio({
    Key? key,
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
  }) : super(key: key);

  @override
  State<FlutstrapRadio<T>> createState() => _FlutstrapRadioState<T>();
}

class _FlutstrapRadioState<T> extends State<FlutstrapRadio<T>> {
  bool _isHovered = false;
  bool _isFocused = false;

  bool get _isSelected => widget.value == widget.groupValue;

  void _handleTap() {
    if (!widget.disabled && widget.onChanged != null && !_isSelected) {
      widget.onChanged!(widget.value);
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
    final radioStyle = _RadioStyle(theme, widget.variant, widget.size);

    final radio = _buildRadio(radioStyle);
    final hasLabel = widget.label != null || widget.customLabel != null;

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
            checked: _isSelected,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.inline && hasLabel)
                  _buildInlineLayout(radio, radioStyle)
                else
                  _buildBlockLayout(radio, radioStyle, hasLabel),
                if (widget.showValidation &&
                    !widget.isValid &&
                    widget.validationMessage != null)
                  _buildValidationMessage(radioStyle),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInlineLayout(Widget radio, _RadioStyle style) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        radio,
        if (widget.label != null || widget.customLabel != null)
          SizedBox(width: style.labelSpacing),
        if (widget.label != null || widget.customLabel != null)
          _buildLabel(style),
      ],
    );
  }

  Widget _buildBlockLayout(Widget radio, _RadioStyle style, bool hasLabel) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasLabel) ...[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              radio,
              SizedBox(width: style.labelSpacing),
              _buildLabel(style),
            ],
          ),
        ] else ...[
          radio,
        ],
      ],
    );
  }

  Widget _buildRadio(_RadioStyle style) {
    return Container(
      width: style.radioSize,
      height: style.radioSize,
      decoration: BoxDecoration(
        color: _getBackgroundColor(style),
        borderRadius:
            BorderRadius.circular(style.radioSize / 2), // Circular for radio
        border: Border.all(
          color: _getBorderColor(style),
          width: style.borderWidth,
        ),
        boxShadow: _getBoxShadow(style),
      ),
      child: _isSelected ? _buildDot(style) : null,
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
      return style.activeBackgroundColor;
    }

    if (_isHovered) {
      return style.hoverBackgroundColor;
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

    if (_isFocused) {
      return style.focusBorderColor;
    }

    if (_isHovered) {
      return style.hoverBorderColor;
    }

    if (_isSelected) {
      return style.activeBorderColor;
    }

    return style.borderColor;
  }

  Color _getDotColor(_RadioStyle style) {
    if (widget.disabled) {
      return style.disabledDotColor;
    }
    return style.dotColor;
  }

  List<BoxShadow>? _getBoxShadow(_RadioStyle style) {
    if (_isFocused && !widget.disabled) {
      return style.focusShadow;
    }
    return null;
  }
}

/// Internal style configuration for radio buttons
class _RadioStyle {
  final FSThemeData theme;
  final FSRadioVariant variant;
  final FSRadioSize size;

  _RadioStyle(this.theme, this.variant, this.size);

  // Sizes
  double get radioSize => _getRadioSize();
  double get dotSize => _getDotSize();
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

  Color get dotColor => _getDotColor();
  Color get disabledDotColor => theme.colors.onSurface.withOpacity(0.5);

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

  // Shadows
  List<BoxShadow> get focusShadow => [
        BoxShadow(
          color: _getActiveBackgroundColor().withOpacity(0.3),
          blurRadius: 4,
          spreadRadius: 2,
        ),
      ];

  double _getRadioSize() {
    switch (size) {
      case FSRadioSize.sm:
        return 16.0;
      case FSRadioSize.md:
        return 20.0;
      case FSRadioSize.lg:
        return 24.0;
    }
  }

  double _getDotSize() {
    switch (size) {
      case FSRadioSize.sm:
        return 6.0;
      case FSRadioSize.md:
        return 8.0;
      case FSRadioSize.lg:
        return 10.0;
    }
  }

  Color _getActiveBackgroundColor() {
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
      case FSRadioVariant.light:
        return colors.surface;
      case FSRadioVariant.dark:
        return colors.onBackground;
    }
  }

  Color _getHoverBackgroundColor() {
    return _getActiveBackgroundColor().withOpacity(0.1);
  }

  Color _getDotColor() {
    switch (variant) {
      case FSRadioVariant.light:
        return theme.colors.onSurface;
      default:
        return theme.colors.onPrimary;
    }
  }
}
