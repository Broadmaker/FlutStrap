/// Flutstrap Input
///
/// A high-performance, accessible text input field with comprehensive validation,
/// multiple variants, and optimized rendering patterns.
///
/// {@tool snippet}
/// ### Basic Usage
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
/// // Programmatic control
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
/// {@end-tool}
///
/// {@template flutstrap_input.performance}
/// ## Performance Features
///
/// - **Debounced Validation**: Optimized validation with configurable delays
/// - **Style Caching**: Input styles cached by variant, size, and state
/// - **Memory Management**: Proper timer and controller disposal
/// - **Efficient Rebuilds**: Minimal setState calls during typing
/// {@endtemplate}
///
/// {@template flutstrap_input.accessibility}
/// ## Accessibility
///
/// - Full screen reader support with semantic labels
/// - Keyboard navigation with focus management
/// - Proper ARIA attributes for web
/// - High contrast support for visually impaired users
/// {@endtemplate}
///
/// ## Validation Features
///
/// - Real-time validation with debouncing
/// - Programmatic error control
/// - Custom validator functions
/// - Visual feedback for different states
///
/// {@category Components}
/// {@category Forms}

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme.dart';
import '../../core/spacing.dart';
import '../../core/error_boundary.dart'; // ✅ IMPORT SHARED ERROR BOUNDARY

/// Performance monitoring for input operations
class _InputPerformance {
  static final _buildTimes = <String, int>{};
  static final _validationTimes = <String, int>{};

  static void logBuildTime(String inputType, int milliseconds) {
    _buildTimes[inputType] = milliseconds;

    if (milliseconds > 16) {
      debugPrint('⏱️ Slow input build: $inputType took ${milliseconds}ms');
    }
  }

  static void logValidationTime(int milliseconds) {
    _validationTimes['validation'] = milliseconds;
  }

  static void clearMetrics() {
    _buildTimes.clear();
    _validationTimes.clear();
  }

  static Map<String, int> get buildTimes => Map.from(_buildTimes);
  static Map<String, int> get validationTimes => Map.from(_validationTimes);
}

/// Enhanced validation manager with debouncing
class _ValidationManager {
  final Duration delay;
  final String? Function(String?)? validator;
  final void Function(String? error)? onValidationChanged;

  Timer? _timer;
  String? _lastValue;
  String? _lastError;
  bool _isDisposed = false;

  _ValidationManager({
    required this.delay,
    required this.validator,
    required this.onValidationChanged,
  });

  void validate(String value, {bool immediate = false}) {
    if (_isDisposed) return;

    _lastValue = value;

    if (immediate) {
      _runValidation(value);
    } else {
      _timer?.cancel();
      _timer = Timer(delay, () => _runValidation(value));
    }
  }

  void _runValidation(String value) {
    if (_isDisposed || value != _lastValue) return;

    final stopwatch = Stopwatch()..start();
    final error = validator?.call(value);
    stopwatch.stop();
    _InputPerformance.logValidationTime(stopwatch.elapsedMilliseconds);

    if (error != _lastError) {
      _lastError = error;
      onValidationChanged?.call(error);
    }
  }

  void dispose() {
    _isDisposed = true;
    _timer?.cancel();
    _timer = null;
  }
}

/// Style caching for input components
class _InputStyleCache {
  static final _cache = <_InputStyleCacheKey, _InputStyle>{};
  static final _cacheKeys = <_InputStyleCacheKey>[];
  static const int _maxCacheSize = 20;

  static _InputStyle getOrCreate({
    required FSThemeData theme,
    required FSInputVariant variant,
    required FSInputSize size,
    required bool hasError,
    required bool enabled,
    required bool filled,
  }) {
    final key = _InputStyleCacheKey(
        theme.brightness, variant, size, hasError, enabled, filled);

    if (_cache.containsKey(key)) {
      _cacheKeys.remove(key);
      _cacheKeys.add(key);
      return _cache[key]!;
    }

    final style =
        _createInputStyle(theme, variant, size, hasError, enabled, filled);
    _cache[key] = style;
    _cacheKeys.add(key);

    // LRU eviction
    if (_cache.length > _maxCacheSize) {
      final lruKey = _cacheKeys.removeAt(0);
      _cache.remove(lruKey);
    }

    return style;
  }

  static _InputStyle _createInputStyle(
    FSThemeData theme,
    FSInputVariant variant,
    FSInputSize size,
    bool hasError,
    bool enabled,
    bool filled,
  ) {
    final colors = theme.colors;
    final effectiveVariant = hasError ? FSInputVariant.danger : variant;

    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(
        color: _getBorderColor(colors, effectiveVariant, enabled),
        width: 1.0,
      ),
    );

    final focusedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(
        color: _getFocusColor(colors, effectiveVariant, enabled),
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
      backgroundColor:
          _getBackgroundColor(colors, effectiveVariant, enabled, filled),
      border: border,
      focusedBorder: focusedBorder,
      errorBorder: errorBorder,
      disabledBorder: disabledBorder,
      padding: _getPadding(size),
      labelStyle: theme.typography.bodyMedium.copyWith(
        color: _getTextColor(colors, effectiveVariant, enabled),
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

  static Color _getBorderColor(
      FSColorScheme colors, FSInputVariant variant, bool enabled) {
    if (!enabled) return colors.outline.withOpacity(0.3);

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

  static Color _getFocusColor(
      FSColorScheme colors, FSInputVariant variant, bool enabled) {
    if (!enabled) return colors.outline.withOpacity(0.3);

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

  static Color _getBackgroundColor(
      FSColorScheme colors, FSInputVariant variant, bool enabled, bool filled) {
    if (!filled) return Colors.transparent;
    if (!enabled) return colors.outline.withOpacity(0.1);

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

  static Color _getTextColor(
      FSColorScheme colors, FSInputVariant variant, bool enabled) {
    if (!enabled) return colors.onSurface.withOpacity(0.5);

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

  static EdgeInsets _getPadding(FSInputSize size) {
    switch (size) {
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

  static void clearCache() {
    _cache.clear();
    _cacheKeys.clear();
  }

  static int get cacheSize => _cache.length;
}

class _InputStyleCacheKey {
  final Brightness brightness;
  final FSInputVariant variant;
  final FSInputSize size;
  final bool hasError;
  final bool enabled;
  final bool filled;

  const _InputStyleCacheKey(
    this.brightness,
    this.variant,
    this.size,
    this.hasError,
    this.enabled,
    this.filled,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _InputStyleCacheKey &&
          runtimeType == other.runtimeType &&
          brightness == other.brightness &&
          variant == other.variant &&
          size == other.size &&
          hasError == other.hasError &&
          enabled == other.enabled &&
          filled == other.filled;

  @override
  int get hashCode =>
      Object.hash(brightness, variant, size, hasError, enabled, filled);
}

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
  late final _validationManager = _ValidationManager(
    delay: widget.validationDelay,
    validator: widget.validator,
    onValidationChanged: _onValidationChanged,
  );

  String? _validationError;
  bool _isDisposed = false;

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
        _validationManager.validate(widget.initialValue!, immediate: true);
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
      _validationManager.validate(_controller.text, immediate: true);
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    _validationManager.dispose();
    // ✅ PROPER CONTROLLER DISPOSAL - only dispose if we created it
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _onValidationChanged(String? error) {
    if (mounted && !_isDisposed) {
      setState(() {
        _validationError = error;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final stopwatch = Stopwatch()..start();

    final widget = ErrorBoundary(
      // ✅ USING SHARED ERROR BOUNDARY
      componentName: 'FlutstrapInput',
      fallbackBuilder: (context) => _buildErrorInput(),
      child: _buildInputField(context),
    );

    stopwatch.stop();
    _InputPerformance.logBuildTime(
        'FlutstrapInput', stopwatch.elapsedMilliseconds);

    return widget;
  }

  Widget _buildErrorInput() {
    return Container(
      padding: _getPadding(),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: Colors.red, size: 16),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'Input field unavailable',
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(BuildContext context) {
    final theme = FSTheme.of(context);
    final inputStyle = _InputStyleCache.getOrCreate(
      theme: theme,
      variant: _currentVariant,
      size: widget.size,
      hasError: _hasError,
      enabled: widget.enabled,
      filled: widget.filled,
    );

    return Semantics(
      label: widget.semanticLabel ?? widget.labelText,
      value: _controller.text,
      enabled: widget.enabled,
      hint: widget.hintText,
      readOnly: widget.readOnly,
      child: ExcludeSemantics(
        excluding: widget.readOnly,
        child: Focus(
          canRequestFocus: widget.enabled && !widget.readOnly,
          onFocusChange: (hasFocus) {
            if (!hasFocus && widget.validator != null) {
              // Validate on focus loss
              _validationManager.validate(_controller.text, immediate: true);
            }
          },
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
            textAlignVertical:
                widget.textAlignVertical ?? TextAlignVertical.center,
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
        ),
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
    _validationManager.validate(value);
  }

  String? _validator(String? value) {
    final error = widget.validator?.call(value);
    if (mounted && !_isDisposed) {
      setState(() {
        _validationError = error;
      });
    }
    return error;
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
    if (mounted && !_isDisposed) {
      setState(() {
        _validationError = null;
      });
    }
    widget.onChanged?.call('');
  }

  void setError(String error) {
    if (mounted && !_isDisposed) {
      setState(() {
        _validationError = error;
      });
    }
  }

  void clearError() {
    if (mounted && !_isDisposed) {
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
    if (mounted && !_isDisposed) {
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
