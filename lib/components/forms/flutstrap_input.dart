/// Flutstrap Input
///
/// A customizable text input field with various styles, validation,
/// and Bootstrap-inspired variants.
///
/// ## Usage Examples
///
/// ```dart
/// // Basic input
/// FlutstrapInput(
///   labelText: 'Email',
///   hintText: 'Enter your email',
///   validator: (value) {
///     if (value?.isEmpty ?? true) return 'Email is required';
///     if (!value!.contains('@')) return 'Enter a valid email';
///     return null;
///   },
/// )
///
/// // Input with icons and variant
/// FlutstrapInput(
///   labelText: 'Password',
///   obscureText: true,
///   prefixIcon: Icon(Icons.lock),
///   suffixIcon: Icon(Icons.visibility),
///   variant: FSInputVariant.success,
/// )
///
/// // Disabled input
/// FlutstrapInput(
///   labelText: 'Read-only field',
///   initialValue: 'Cannot edit this',
///   enabled: false,
///   filled: true,
/// )
///
/// // Using state methods
/// final inputKey = GlobalKey<FlutstrapInputState>();
/// FlutstrapInput(
///   key: inputKey,
///   labelText: 'Controlled input',
/// )
///
/// // Later...
/// inputKey.currentState?.clear();
/// inputKey.currentState?.focus();
/// ```
///
/// {@category Components}
/// {@category Forms}

import 'dart:async';
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
  // ✅ REMOVED: BoxHeightStyle and BoxWidthStyle - not available in older Flutter versions
  final Brightness? keyboardAppearance;
  final EdgeInsets scrollPadding;
  final bool enableInteractiveSelection;
  final TextSelectionControls? selectionControls;
  final void Function(PointerDownEvent)? onTapOutside;
  final InputCounterWidgetBuilder? buildCounter;
  final ScrollPhysics? scrollPhysics;
  final String? restorationId;
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
  final String? semanticLabel;
  final bool enableFeedback;
  final Duration validationDelay;

  const FlutstrapInput({
    super.key,
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
    // ✅ REMOVED: BoxHeightStyle and BoxWidthStyle parameters
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.enableInteractiveSelection = true,
    this.selectionControls,
    this.onTapOutside,
    this.buildCounter,
    this.scrollPhysics,
    this.restorationId,
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
    this.semanticLabel,
    this.enableFeedback = true,
    this.validationDelay = const Duration(milliseconds: 300),
  });

  @override
  State<FlutstrapInput> createState() => FlutstrapInputState();

  // ✅ CONSISTENT COPYWITH PATTERN
  FlutstrapInput copyWith({
    Key? key,
    TextEditingController? controller,
    String? initialValue,
    FocusNode? focusNode,
    InputDecoration? decoration,
    TextInputType? keyboardType,
    TextCapitalization? textCapitalization,
    TextInputAction? textInputAction,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextDirection? textDirection,
    TextAlign? textAlign,
    TextAlignVertical? textAlignVertical,
    bool? autofocus,
    bool? readOnly,
    bool? showCursor,
    String? obscuringCharacter,
    bool? obscureText,
    bool? autocorrect,
    SmartDashesType? smartDashesType,
    SmartQuotesType? smartQuotesType,
    bool? enableSuggestions,
    int? maxLines,
    int? minLines,
    bool? expands,
    int? maxLength,
    MaxLengthEnforcement? maxLengthEnforcement,
    void Function(String)? onChanged,
    void Function()? onTap,
    void Function()? onEditingComplete,
    void Function(String)? onFieldSubmitted,
    void Function(String?)? onSaved,
    String? Function(String?)? validator,
    Iterable<String>? autofillHints,
    bool? enabled,
    double? cursorWidth,
    double? cursorHeight,
    Radius? cursorRadius,
    Color? cursorColor,
    Brightness? keyboardAppearance,
    EdgeInsets? scrollPadding,
    bool? enableInteractiveSelection,
    TextSelectionControls? selectionControls,
    void Function(PointerDownEvent)? onTapOutside,
    InputCounterWidgetBuilder? buildCounter,
    ScrollPhysics? scrollPhysics,
    String? restorationId,
    bool? enableIMEPersonalizedLearning,
    MouseCursor? mouseCursor,
    Widget? prefixIcon,
    String? prefixText,
    Widget? suffixIcon,
    String? suffixText,
    String? labelText,
    String? hintText,
    String? errorText,
    String? helperText,
    FSInputVariant? variant,
    FSInputSize? size,
    bool? filled,
    Color? fillColor,
    String? semanticLabel,
    bool? enableFeedback,
    Duration? validationDelay,
  }) {
    return FlutstrapInput(
      key: key ?? this.key,
      controller: controller ?? this.controller,
      initialValue: initialValue ?? this.initialValue,
      focusNode: focusNode ?? this.focusNode,
      decoration: decoration ?? this.decoration,
      keyboardType: keyboardType ?? this.keyboardType,
      textCapitalization: textCapitalization ?? this.textCapitalization,
      textInputAction: textInputAction ?? this.textInputAction,
      style: style ?? this.style,
      strutStyle: strutStyle ?? this.strutStyle,
      textDirection: textDirection ?? this.textDirection,
      textAlign: textAlign ?? this.textAlign,
      textAlignVertical: textAlignVertical ?? this.textAlignVertical,
      autofocus: autofocus ?? this.autofocus,
      readOnly: readOnly ?? this.readOnly,
      showCursor: showCursor ?? this.showCursor,
      obscuringCharacter: obscuringCharacter ?? this.obscuringCharacter,
      obscureText: obscureText ?? this.obscureText,
      autocorrect: autocorrect ?? this.autocorrect,
      smartDashesType: smartDashesType ?? this.smartDashesType,
      smartQuotesType: smartQuotesType ?? this.smartQuotesType,
      enableSuggestions: enableSuggestions ?? this.enableSuggestions,
      maxLines: maxLines ?? this.maxLines,
      minLines: minLines ?? this.minLines,
      expands: expands ?? this.expands,
      maxLength: maxLength ?? this.maxLength,
      maxLengthEnforcement: maxLengthEnforcement ?? this.maxLengthEnforcement,
      onChanged: onChanged ?? this.onChanged,
      onTap: onTap ?? this.onTap,
      onEditingComplete: onEditingComplete ?? this.onEditingComplete,
      onFieldSubmitted: onFieldSubmitted ?? this.onFieldSubmitted,
      onSaved: onSaved ?? this.onSaved,
      validator: validator ?? this.validator,
      autofillHints: autofillHints ?? this.autofillHints,
      enabled: enabled ?? this.enabled,
      cursorWidth: cursorWidth ?? this.cursorWidth,
      cursorHeight: cursorHeight ?? this.cursorHeight,
      cursorRadius: cursorRadius ?? this.cursorRadius,
      cursorColor: cursorColor ?? this.cursorColor,
      keyboardAppearance: keyboardAppearance ?? this.keyboardAppearance,
      scrollPadding: scrollPadding ?? this.scrollPadding,
      enableInteractiveSelection:
          enableInteractiveSelection ?? this.enableInteractiveSelection,
      selectionControls: selectionControls ?? this.selectionControls,
      onTapOutside: onTapOutside ?? this.onTapOutside,
      buildCounter: buildCounter ?? this.buildCounter,
      scrollPhysics: scrollPhysics ?? this.scrollPhysics,
      restorationId: restorationId ?? this.restorationId,
      enableIMEPersonalizedLearning:
          enableIMEPersonalizedLearning ?? this.enableIMEPersonalizedLearning,
      mouseCursor: mouseCursor ?? this.mouseCursor,
      prefixIcon: prefixIcon ?? this.prefixIcon,
      prefixText: prefixText ?? this.prefixText,
      suffixIcon: suffixIcon ?? this.suffixIcon,
      suffixText: suffixText ?? this.suffixText,
      labelText: labelText ?? this.labelText,
      hintText: hintText ?? this.hintText,
      errorText: errorText ?? this.errorText,
      helperText: helperText ?? this.helperText,
      variant: variant ?? this.variant,
      size: size ?? this.size,
      filled: filled ?? this.filled,
      fillColor: fillColor ?? this.fillColor,
      semanticLabel: semanticLabel ?? this.semanticLabel,
      enableFeedback: enableFeedback ?? this.enableFeedback,
      validationDelay: validationDelay ?? this.validationDelay,
    );
  }

  // ✅ CONVENIENCE METHODS
  FlutstrapInput primary() => copyWith(variant: FSInputVariant.primary);
  FlutstrapInput success() => copyWith(variant: FSInputVariant.success);
  FlutstrapInput danger() => copyWith(variant: FSInputVariant.danger);
  FlutstrapInput warning() => copyWith(variant: FSInputVariant.warning);
  FlutstrapInput info() => copyWith(variant: FSInputVariant.info);

  FlutstrapInput small() => copyWith(size: FSInputSize.sm);
  FlutstrapInput medium() => copyWith(size: FSInputSize.md);
  FlutstrapInput large() => copyWith(size: FSInputSize.lg);

  FlutstrapInput asDisabled() => copyWith(enabled: false);
  FlutstrapInput asEnabled() => copyWith(enabled: true);
  FlutstrapInput withLabel(String label) => copyWith(labelText: label);
  FlutstrapInput withHint(String hint) => copyWith(hintText: hint);
  FlutstrapInput withError(String error) => copyWith(errorText: error);
}

class FlutstrapInputState extends State<FlutstrapInput> {
  late TextEditingController _controller;
  String? _validationError;
  Timer? _validationTimer;

  // ✅ SIMPLIFIED STATE MANAGEMENT
  String? get _errorText => _validationError ?? widget.errorText;
  bool get _hasError => _errorText != null;
  FSInputVariant get _currentVariant =>
      _hasError ? FSInputVariant.danger : widget.variant;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    if (widget.initialValue != null) {
      _controller.text = widget.initialValue!;
    }

    // ✅ INITIAL VALIDATION
    if (widget.initialValue != null && widget.validator != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _runValidation(widget.initialValue!);
      });
    }
  }

  @override
  void didUpdateWidget(FlutstrapInput oldWidget) {
    super.didUpdateWidget(oldWidget);

    // ✅ OPTIMIZED CONTROLLER UPDATE
    if (widget.controller != oldWidget.controller) {
      if (widget.controller == null) {
        // Create new controller if external controller was removed
        _controller = TextEditingController();
      } else {
        // Use new external controller
        _controller = widget.controller!;
      }
    }

    // ✅ VALIDATE ON VALIDATOR CHANGE
    if (widget.validator != oldWidget.validator &&
        _controller.text.isNotEmpty) {
      _runValidation(_controller.text);
    }
  }

  @override
  void dispose() {
    _validationTimer?.cancel();
    // ✅ PROPER CONTROLLER DISPOSAL - only dispose if we created it
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = FSTheme.of(context);
    final inputStyle = _getInputStyle(theme);

    return Semantics(
      label: widget.semanticLabel ?? widget.labelText,
      value: _controller.text,
      enabled: widget.enabled,
      child: TextFormField(
        controller: _controller,
        focusNode: widget.focusNode,
        decoration: _buildDecoration(theme, inputStyle),
        keyboardType: widget.keyboardType,
        textCapitalization: widget.textCapitalization,
        textInputAction: widget.textInputAction,
        style: _getTextStyle(theme),
        strutStyle: widget.strutStyle,
        textDirection: widget.textDirection,
        textAlign: widget.textAlign,
        textAlignVertical: widget.textAlignVertical ?? TextAlignVertical.center,
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
        // ✅ REMOVED: selectionHeightStyle and selectionWidthStyle
        keyboardAppearance: widget.keyboardAppearance,
        scrollPadding: widget.scrollPadding,
        enableInteractiveSelection: widget.enableInteractiveSelection,
        selectionControls: widget.selectionControls,
        onTapOutside: widget.onTapOutside,
        buildCounter: widget.buildCounter,
        scrollPhysics: widget.scrollPhysics,
        restorationId: widget.restorationId,
        enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
        mouseCursor: widget.mouseCursor,
      ),
    );
  }

  TextStyle _getTextStyle(FSThemeData theme) {
    return (widget.style ?? theme.typography.bodyMedium).copyWith(
      color: widget.enabled ? null : theme.colors.onSurface.withOpacity(0.5),
    );
  }

  void _onChanged(String value) {
    widget.onChanged?.call(value);

    // ✅ DEBOUNCED VALIDATION FOR BETTER UX
    _validationTimer?.cancel();
    if (widget.validator != null) {
      _validationTimer = Timer(widget.validationDelay, () {
        if (mounted) {
          _runValidation(value);
        }
      });
    } else {
      // Clear validation error if no validator
      if (_validationError != null && mounted) {
        setState(() {
          _validationError = null;
        });
      }
    }
  }

  String? _validator(String? value) {
    final error = widget.validator?.call(value);
    if (mounted) {
      setState(() {
        _validationError = error;
      });
    }
    return error;
  }

  void _runValidation(String value) {
    final error = widget.validator?.call(value);
    if (mounted) {
      setState(() {
        _validationError = error;
      });
    }
  }

  InputDecoration _buildDecoration(FSThemeData theme, _InputStyle inputStyle) {
    final baseDecoration = widget.decoration ?? const InputDecoration();
    final hasError = _hasError;

    return baseDecoration.copyWith(
      prefixIcon: widget.prefixIcon,
      prefixText: widget.prefixText,
      suffixIcon: widget.suffixIcon,
      suffixText: widget.suffixText,
      labelText: widget.labelText,
      hintText: widget.hintText,
      errorText: hasError ? _errorText : null,
      helperText: widget.helperText,
      filled: widget.filled,
      fillColor: widget.fillColor ?? inputStyle.backgroundColor,
      contentPadding: inputStyle.padding,
      border: inputStyle.border,
      enabledBorder: inputStyle.border,
      focusedBorder: inputStyle.focusedBorder,
      errorBorder: inputStyle.errorBorder,
      focusedErrorBorder: inputStyle.errorBorder,
      disabledBorder: inputStyle.disabledBorder,
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

    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(
        color: _getBorderColor(colors, _currentVariant),
        width: 1.0,
      ),
    );

    final focusedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(
        color: _getFocusColor(colors, _currentVariant),
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

    final disabledBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(
        color: colors.outline.withOpacity(0.3),
        width: 1.0,
      ),
    );

    return _InputStyle(
      backgroundColor: _getBackgroundColor(colors, _currentVariant),
      border: border,
      focusedBorder: focusedBorder,
      errorBorder: errorBorder,
      disabledBorder: disabledBorder,
      padding: _getPadding(),
      labelStyle: theme.typography.bodyMedium.copyWith(
        color: _getTextColor(colors, _currentVariant),
      ),
      hintStyle: theme.typography.bodyMedium.copyWith(
        color: colors.onSurface.withOpacity(0.5),
      ),
      errorStyle: theme.typography.bodySmall.copyWith(
        color: colors.danger,
        fontWeight: FontWeight.w500,
      ),
      helperStyle: theme.typography.bodySmall.copyWith(
        color: colors.onSurface.withOpacity(0.7),
      ),
      prefixStyle: theme.typography.bodyMedium,
      suffixStyle: theme.typography.bodyMedium,
    );
  }

  Color _getBorderColor(FSColorScheme colors, FSInputVariant variant) {
    if (!widget.enabled) return colors.outline.withOpacity(0.3);

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
    if (!widget.enabled) return colors.outline.withOpacity(0.3);

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
    if (!widget.enabled) return colors.outline.withOpacity(0.1);

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
    if (!widget.enabled) return colors.onSurface.withOpacity(0.5);

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

  // ✅ PUBLIC METHODS FOR PROGRAMMATIC CONTROL
  void clear() {
    _controller.clear();
    if (mounted) {
      setState(() {
        _validationError = null;
      });
    }
    widget.onChanged?.call('');
  }

  void setError(String error) {
    if (mounted) {
      setState(() {
        _validationError = error;
      });
    }
  }

  void clearError() {
    if (mounted) {
      setState(() {
        _validationError = null;
      });
    }
  }

  void focus() {
    if (widget.focusNode != null) {
      widget.focusNode!.requestFocus();
    } else {
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }

  void unfocus() {
    if (widget.focusNode != null) {
      widget.focusNode!.unfocus();
    } else {
      FocusScope.of(context).unfocus();
    }
  }

  // ✅ VALUE MANAGEMENT
  String get value => _controller.text;

  set value(String newValue) {
    _controller.text = newValue;
    if (mounted) {
      setState(() {
        _validationError = null;
      });
    }
    widget.onChanged?.call(newValue);
  }

  // ✅ VALIDATION STATUS
  bool get isValid => _validationError == null && widget.errorText == null;
  bool get hasError => _hasError;
  String? get error => _errorText;
}

/// Internal style configuration for inputs
class _InputStyle {
  final Color backgroundColor;
  final InputBorder border;
  final InputBorder focusedBorder;
  final InputBorder errorBorder;
  final InputBorder disabledBorder;
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
    required this.disabledBorder,
    required this.padding,
    required this.labelStyle,
    required this.hintStyle,
    required this.errorStyle,
    required this.helperStyle,
    required this.prefixStyle,
    required this.suffixStyle,
  });
}
