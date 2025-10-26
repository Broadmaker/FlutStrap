/// Flutstrap Input
///
/// A customizable text input field with various styles, validation,
/// and Bootstrap-inspired variants.

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme.dart';
import '../../core/spacing.dart';

/// Flutstrap Input Variants
///
/// Defines the visual style variants for input fields
enum FSInputVariant {
  primary,
  secondary,
  success,
  danger,
  warning,
  info,
}

/// Flutstrap Input Sizes
///
/// Defines the size variants for input fields
enum FSInputSize {
  sm,
  md,
  lg,
}

/// Flutstrap Input Component
///
/// A customizable text input field with validation, icons, and various styles.
class FlutstrapInput extends StatefulWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final FocusNode? focusNode;
  final InputDecoration? decoration;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextDirection? textDirection;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final bool autofocus;
  final bool readOnly;
  final bool? showCursor;
  final String obscuringCharacter;
  final bool obscureText;
  final bool autocorrect;
  final SmartDashesType? smartDashesType;
  final SmartQuotesType? smartQuotesType;
  final bool enableSuggestions;
  final int? maxLines;
  final int? minLines;
  final bool expands;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final void Function()? onEditingComplete;
  final void Function(String)? onFieldSubmitted;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final Iterable<String>? autofillHints;
  final bool enabled;
  final double cursorWidth;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final Color? cursorColor;
  final BoxHeightStyle selectionHeightStyle;
  final BoxWidthStyle selectionWidthStyle;
  final Brightness? keyboardAppearance;
  final EdgeInsets scrollPadding;
  final bool enableInteractiveSelection;
  final TextSelectionControls? selectionControls;
  final void Function(PointerDownEvent)? onTapOutside; // Updated type
  final InputCounterWidgetBuilder? buildCounter;
  final ScrollPhysics? scrollPhysics;
  final String? restorationId; // Changed from Iterable<String>? to String?
  final bool enableIMEPersonalizedLearning;
  final MouseCursor? mouseCursor;
  final Widget? prefixIcon;
  final String? prefixText;
  final Widget? suffixIcon;
  final String? suffixText;
  final String? labelText;
  final String? hintText;
  final String? errorText;
  final String? helperText;
  final FSInputVariant variant;
  final FSInputSize size;
  final bool filled;
  final Color? fillColor;

  const FlutstrapInput({
    Key? key,
    this.controller,
    this.initialValue,
    this.focusNode,
    this.decoration,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.style,
    this.strutStyle,
    this.textDirection,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.autofocus = false,
    this.readOnly = false,
    this.showCursor,
    this.obscuringCharacter = '•',
    this.obscureText = false,
    this.autocorrect = true,
    this.smartDashesType,
    this.smartQuotesType,
    this.enableSuggestions = true,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.maxLength,
    this.maxLengthEnforcement,
    this.onChanged,
    this.onTap,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.validator,
    this.autofillHints,
    this.enabled = true,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorColor,
    this.selectionHeightStyle = BoxHeightStyle.tight,
    this.selectionWidthStyle = BoxWidthStyle.tight,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.enableInteractiveSelection = true,
    this.selectionControls,
    this.onTapOutside, // Updated parameter
    this.buildCounter,
    this.scrollPhysics,
    this.restorationId, // Updated parameter
    this.enableIMEPersonalizedLearning = true,
    this.mouseCursor,
    this.prefixIcon,
    this.prefixText,
    this.suffixIcon,
    this.suffixText,
    this.labelText,
    this.hintText,
    this.errorText,
    this.helperText,
    this.variant = FSInputVariant.primary,
    this.size = FSInputSize.md,
    this.filled = false,
    this.fillColor,
  }) : super(key: key);

  @override
  State<FlutstrapInput> createState() => FlutstrapInputState();
}

class FlutstrapInputState extends State<FlutstrapInput> {
  late TextEditingController _controller;
  FSInputVariant _currentVariant = FSInputVariant.primary;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _currentVariant = widget.variant;
    if (widget.initialValue != null) {
      _controller.text = widget.initialValue!;
    }
  }

  @override
  void didUpdateWidget(FlutstrapInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      _controller = widget.controller ?? TextEditingController();
    }
    _currentVariant = widget.variant;
  }

  @override
  Widget build(BuildContext context) {
    final theme = FSTheme.of(context);
    final inputStyle = _getInputStyle(theme);

    return TextFormField(
      controller: _controller,
      focusNode: widget.focusNode,
      decoration: _buildDecoration(theme, inputStyle),
      keyboardType: widget.keyboardType,
      textCapitalization: widget.textCapitalization,
      textInputAction: widget.textInputAction,
      style: widget.style ?? theme.typography.bodyMedium,
      strutStyle: widget.strutStyle,
      textDirection: widget.textDirection,
      textAlign: widget.textAlign,
      textAlignVertical: widget.textAlignVertical,
      autofocus: widget.autofocus,
      readOnly: widget.readOnly,
      showCursor: widget.showCursor,
      obscuringCharacter: widget.obscuringCharacter,
      obscureText: widget.obscureText,
      autocorrect: widget.autocorrect,
      smartDashesType: widget.smartDashesType,
      smartQuotesType: widget.smartQuotesType,
      enableSuggestions: widget.enableSuggestions,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      expands: widget.expands,
      maxLength: widget.maxLength,
      maxLengthEnforcement: widget.maxLengthEnforcement,
      onChanged: _onChanged,
      onTap: widget.onTap,
      onEditingComplete: widget.onEditingComplete,
      onFieldSubmitted: widget.onFieldSubmitted,
      onSaved: widget.onSaved,
      validator: _validator,
      autofillHints: widget.autofillHints,
      enabled: widget.enabled,
      cursorWidth: widget.cursorWidth,
      cursorHeight: widget.cursorHeight,
      cursorRadius: widget.cursorRadius,
      cursorColor: widget.cursorColor ?? theme.colors.primary,
      selectionHeightStyle: widget.selectionHeightStyle,
      selectionWidthStyle: widget.selectionWidthStyle,
      keyboardAppearance: widget.keyboardAppearance,
      scrollPadding: widget.scrollPadding,
      enableInteractiveSelection: widget.enableInteractiveSelection,
      selectionControls: widget.selectionControls,
      onTapOutside: widget.onTapOutside, // Now compatible
      buildCounter: widget.buildCounter,
      scrollPhysics: widget.scrollPhysics,
      restorationId: widget.restorationId, // Now compatible
      enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
      mouseCursor: widget.mouseCursor,
    );
  }

  void _onChanged(String value) {
    // Clear error when user starts typing
    if (_errorText != null) {
      setState(() {
        _errorText = null;
        _currentVariant = widget.variant;
      });
    }
    widget.onChanged?.call(value);
  }

  String? _validator(String? value) {
    final error = widget.validator?.call(value);
    if (error != null) {
      setState(() {
        _errorText = error;
        _currentVariant = FSInputVariant.danger;
      });
    } else {
      setState(() {
        _errorText = null;
        _currentVariant = widget.variant;
      });
    }
    return error;
  }

  InputDecoration _buildDecoration(FSThemeData theme, _InputStyle inputStyle) {
    final baseDecoration = widget.decoration ?? const InputDecoration();
    final hasError = _errorText != null || widget.errorText != null;

    return baseDecoration.copyWith(
      prefixIcon: widget.prefixIcon,
      prefixText: widget.prefixText,
      suffixIcon: widget.suffixIcon,
      suffixText: widget.suffixText,
      labelText: widget.labelText,
      hintText: widget.hintText,
      errorText: hasError ? (_errorText ?? widget.errorText) : null,
      helperText: widget.helperText,
      filled: widget.filled,
      fillColor: widget.fillColor ?? inputStyle.backgroundColor,
      contentPadding: inputStyle.padding,
      border: inputStyle.border,
      enabledBorder: inputStyle.border,
      focusedBorder: inputStyle.focusedBorder,
      errorBorder: inputStyle.errorBorder,
      focusedErrorBorder: inputStyle.errorBorder,
      disabledBorder: inputStyle.border,
      labelStyle: inputStyle.labelStyle,
      hintStyle: inputStyle.hintStyle,
      errorStyle: inputStyle.errorStyle,
      helperStyle: inputStyle.helperStyle,
      prefixStyle: inputStyle.prefixStyle,
      suffixStyle: inputStyle.suffixStyle,
      isDense: true,
    );
  }

  _InputStyle _getInputStyle(FSThemeData theme) {
    final colors = theme.colors;
    final hasError = _errorText != null || widget.errorText != null;
    final currentVariant = hasError ? FSInputVariant.danger : _currentVariant;

    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(
        color: _getBorderColor(colors, currentVariant),
        width: 1.0,
      ),
    );

    final focusedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(
        color: _getFocusColor(colors, currentVariant),
        width: 2.0,
      ),
    );

    final errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(
        color: colors.danger,
        width: 2.0,
      ),
    );

    return _InputStyle(
      backgroundColor: _getBackgroundColor(colors, currentVariant),
      border: border,
      focusedBorder: focusedBorder,
      errorBorder: errorBorder,
      padding: _getPadding(),
      labelStyle: theme.typography.bodyMedium.copyWith(
        color: _getTextColor(colors, currentVariant),
      ),
      hintStyle: theme.typography.bodyMedium.copyWith(
        color: colors.onSurface.withOpacity(0.5),
      ),
      errorStyle: theme.typography.bodySmall.copyWith(
        color: colors.danger,
      ),
      helperStyle: theme.typography.bodySmall.copyWith(
        color: colors.onSurface.withOpacity(0.7),
      ),
      prefixStyle: theme.typography.bodyMedium,
      suffixStyle: theme.typography.bodyMedium,
    );
  }

  Color _getBorderColor(FSColorScheme colors, FSInputVariant variant) {
    switch (variant) {
      case FSInputVariant.primary:
        return colors.outline;
      case FSInputVariant.secondary:
        return colors.secondary.withOpacity(0.5);
      case FSInputVariant.success:
        return colors.success;
      case FSInputVariant.danger:
        return colors.danger;
      case FSInputVariant.warning:
        return colors.warning;
      case FSInputVariant.info:
        return colors.info;
    }
  }

  Color _getFocusColor(FSColorScheme colors, FSInputVariant variant) {
    switch (variant) {
      case FSInputVariant.primary:
        return colors.primary;
      case FSInputVariant.secondary:
        return colors.secondary;
      case FSInputVariant.success:
        return colors.success;
      case FSInputVariant.danger:
        return colors.danger;
      case FSInputVariant.warning:
        return colors.warning;
      case FSInputVariant.info:
        return colors.info;
    }
  }

  Color _getBackgroundColor(FSColorScheme colors, FSInputVariant variant) {
    if (!widget.filled) return Colors.transparent;

    switch (variant) {
      case FSInputVariant.primary:
        return colors.primary.withOpacity(0.05);
      case FSInputVariant.secondary:
        return colors.secondary.withOpacity(0.05);
      case FSInputVariant.success:
        return colors.success.withOpacity(0.05);
      case FSInputVariant.danger:
        return colors.danger.withOpacity(0.05);
      case FSInputVariant.warning:
        return colors.warning.withOpacity(0.05);
      case FSInputVariant.info:
        return colors.info.withOpacity(0.05);
    }
  }

  Color _getTextColor(FSColorScheme colors, FSInputVariant variant) {
    switch (variant) {
      case FSInputVariant.primary:
        return colors.onSurface;
      case FSInputVariant.secondary:
        return colors.secondary;
      case FSInputVariant.success:
        return colors.success;
      case FSInputVariant.danger:
        return colors.danger;
      case FSInputVariant.warning:
        return colors.warning;
      case FSInputVariant.info:
        return colors.info;
    }
  }

  EdgeInsets _getPadding() {
    switch (widget.size) {
      case FSInputSize.sm:
        return EdgeInsets.symmetric(
          horizontal: FSSpacing.sm,
          vertical: FSSpacing.xs,
        );
      case FSInputSize.md:
        return EdgeInsets.symmetric(
          horizontal: FSSpacing.md,
          vertical: FSSpacing.sm,
        );
      case FSInputSize.lg:
        return EdgeInsets.symmetric(
          horizontal: FSSpacing.lg,
          vertical: FSSpacing.md,
        );
    }
  }

  // Public methods
  void clear() {
    _controller.clear();
    setState(() {
      _errorText = null;
      _currentVariant = widget.variant;
    });
  }

  void setError(String error) {
    setState(() {
      _errorText = error;
      _currentVariant = FSInputVariant.danger;
    });
  }

  void clearError() {
    setState(() {
      _errorText = null;
      _currentVariant = widget.variant;
    });
  }
}

/// Internal style configuration for inputs
class _InputStyle {
  final Color backgroundColor;
  final InputBorder border;
  final InputBorder focusedBorder;
  final InputBorder errorBorder;
  final EdgeInsets padding;
  final TextStyle labelStyle;
  final TextStyle hintStyle;
  final TextStyle errorStyle;
  final TextStyle helperStyle;
  final TextStyle prefixStyle;
  final TextStyle suffixStyle;

  const _InputStyle({
    required this.backgroundColor,
    required this.border,
    required this.focusedBorder,
    required this.errorBorder,
    required this.padding,
    required this.labelStyle,
    required this.hintStyle,
    required this.errorStyle,
    required this.helperStyle,
    required this.prefixStyle,
    required this.suffixStyle,
  });
}
