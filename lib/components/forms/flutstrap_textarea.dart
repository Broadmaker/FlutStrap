/// Flutstrap TextArea
///
/// A high-performance, accessible multi-line text input field with
/// comprehensive validation, auto-resize, and optimized rendering patterns.
///
/// {@tool snippet}
/// ### Basic Usage
///
/// ```dart
/// // Basic textarea
/// FlutstrapTextArea(
///   label: 'Description',
///   placeholder: 'Enter your description...',
///   rows: 4,
/// )
///
/// // Textarea with character counter
/// FlutstrapTextArea(
///   label: 'Bio',
///   maxLength: 500,
///   showCharacterCounter: true,
///   rows: 3,
/// )
///
/// // Auto-resizing textarea
/// FlutstrapTextArea(
///   label: 'Notes',
///   autoResize: true,
///   placeholder: 'Start typing...',
/// )
///
/// // Programmatic control
/// final textareaKey = GlobalKey<FlutstrapTextAreaState>();
/// FlutstrapTextArea(
///   key: textareaKey,
///   label: 'Controlled textarea',
/// )
///
/// // Later...
/// textareaKey.currentState?.clear();
/// textareaKey.currentState?.focus();
/// ```
/// {@end-tool}
///
/// {@template flutstrap_textarea.performance}
/// ## Performance Features
///
/// - **Debounced Auto-Resize**: Optimized resizing with configurable delays
/// - **Style Caching**: Textarea styles cached by size, variant, and state
/// - **Memory Management**: Proper timer and controller disposal
/// - **Efficient Rebuilds**: Minimal setState calls during typing
/// {@endtemplate}
///
/// {@template flutstrap_textarea.accessibility}
/// ## Accessibility
///
/// - Full screen reader support with semantic labels
/// - Keyboard navigation with focus management
/// - Proper ARIA attributes for validation states
/// - High contrast support for visually impaired users
/// {@endtemplate}
///
/// ## Auto-Resize Behavior
///
/// When `autoResize: true`, the textarea will automatically adjust its height
/// based on content. Use `resizeDelay` to control the debounce timing for
/// optimal performance during rapid typing.
///
/// {@category Components}
/// {@category Forms}

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../../core/spacing.dart';
import '../../core/error_boundary.dart';

/// Performance monitoring for textarea operations
class _TextAreaPerformance {
  static final _buildTimes = <String, int>{};
  static final _resizeTimes = <String, int>{};

  static void logBuildTime(String textAreaType, int milliseconds) {
    _buildTimes[textAreaType] = milliseconds;

    if (milliseconds > 16) {
      debugPrint(
          '⏱️ Slow textarea build: $textAreaType took ${milliseconds}ms');
    }
  }

  static void logResizeTime(int milliseconds) {
    _resizeTimes['resize'] = milliseconds;
  }

  static void clearMetrics() {
    _buildTimes.clear();
    _resizeTimes.clear();
  }

  static Map<String, int> get buildTimes => Map.from(_buildTimes);
  static Map<String, int> get resizeTimes => Map.from(_resizeTimes);
}

/// Style caching for textarea components
class _TextAreaStyleCache {
  static final _cache = <_TextAreaStyleCacheKey, _TextAreaStyle>{};
  static final _cacheKeys = <_TextAreaStyleCacheKey>[];
  static const int _maxCacheSize = 15;

  static _TextAreaStyle getOrCreate({
    required FSThemeData theme,
    required FSTextAreaSize size,
    required FSTextAreaVariant variant,
    required bool hasError,
    required bool hasFocus,
    required bool disabled,
  }) {
    final key = _TextAreaStyleCacheKey(
        theme.brightness, size, variant, hasError, hasFocus, disabled);

    if (_cache.containsKey(key)) {
      _cacheKeys.remove(key);
      _cacheKeys.add(key);
      return _cache[key]!;
    }

    final style = _createTextAreaStyle(
        theme, size, variant, hasError, hasFocus, disabled);
    _cache[key] = style;
    _cacheKeys.add(key);

    // LRU eviction
    if (_cache.length > _maxCacheSize) {
      final lruKey = _cacheKeys.removeAt(0);
      _cache.remove(lruKey);
    }

    return style;
  }

  static _TextAreaStyle _createTextAreaStyle(
    FSThemeData theme,
    FSTextAreaSize size,
    FSTextAreaVariant variant,
    bool hasError,
    bool hasFocus,
    bool disabled,
  ) {
    final colors = theme.colors;
    final effectiveVariant = hasError ? FSTextAreaVariant.danger : variant;

    final borderColor =
        _getBorderColor(colors, effectiveVariant, hasFocus, disabled, hasError);
    final backgroundColor = _getBackgroundColor(colors, disabled);
    final textStyle = _getTextStyle(theme, size, disabled);
    final padding = _getPadding(size);

    return _TextAreaStyle(
      borderColor: borderColor,
      backgroundColor: backgroundColor,
      textStyle: textStyle,
      padding: padding,
      labelStyle: theme.typography.labelMedium.copyWith(
        color: disabled ? colors.onSurface.withOpacity(0.38) : colors.onSurface,
      ),
      helperStyle: theme.typography.bodySmall.copyWith(
        color: colors.onSurface.withOpacity(0.6),
      ),
      validationStyle: theme.typography.bodySmall.copyWith(
        color: colors.danger,
        fontWeight: FontWeight.w500,
      ),
      counterStyle: theme.typography.bodySmall.copyWith(
        color: colors.onSurface.withOpacity(0.6),
      ),
    );
  }

  static Color _getBorderColor(FSColorScheme colors, FSTextAreaVariant variant,
      bool hasFocus, bool disabled, bool hasError) {
    if (hasError) return colors.danger;
    if (disabled) return colors.outline.withOpacity(0.3);
    if (hasFocus) return _getVariantColor(colors, variant);

    return colors.outline;
  }

  static Color _getVariantColor(
      FSColorScheme colors, FSTextAreaVariant variant) {
    switch (variant) {
      case FSTextAreaVariant.primary:
        return colors.primary;
      case FSTextAreaVariant.secondary:
        return colors.secondary;
      case FSTextAreaVariant.success:
        return colors.success;
      case FSTextAreaVariant.danger:
        return colors.danger;
      case FSTextAreaVariant.warning:
        return colors.warning;
      case FSTextAreaVariant.info:
        return colors.info;
    }
  }

  static Color _getBackgroundColor(FSColorScheme colors, bool disabled) {
    return disabled ? colors.outline.withOpacity(0.1) : Colors.transparent;
  }

  static TextStyle _getTextStyle(
      FSThemeData theme, FSTextAreaSize size, bool disabled) {
    final baseStyle = theme.typography.bodyMedium.copyWith(
      color: disabled ? theme.colors.onSurface.withOpacity(0.38) : null,
    );

    switch (size) {
      case FSTextAreaSize.sm:
        return baseStyle.copyWith(fontSize: 14);
      case FSTextAreaSize.md:
        return baseStyle.copyWith(fontSize: 16);
      case FSTextAreaSize.lg:
        return baseStyle.copyWith(fontSize: 18);
    }
  }

  static EdgeInsets _getPadding(FSTextAreaSize size) {
    switch (size) {
      case FSTextAreaSize.sm:
        return const EdgeInsets.symmetric(
          horizontal: FSSpacing.sm,
          vertical: FSSpacing.xs,
        );
      case FSTextAreaSize.md:
        return const EdgeInsets.symmetric(
          horizontal: FSSpacing.md,
          vertical: FSSpacing.sm,
        );
      case FSTextAreaSize.lg:
        return const EdgeInsets.symmetric(
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

class _TextAreaStyleCacheKey {
  final Brightness brightness;
  final FSTextAreaSize size;
  final FSTextAreaVariant variant;
  final bool hasError;
  final bool hasFocus;
  final bool disabled;

  const _TextAreaStyleCacheKey(
    this.brightness,
    this.size,
    this.variant,
    this.hasError,
    this.hasFocus,
    this.disabled,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _TextAreaStyleCacheKey &&
          runtimeType == other.runtimeType &&
          brightness == other.brightness &&
          size == other.size &&
          variant == other.variant &&
          hasError == other.hasError &&
          hasFocus == other.hasFocus &&
          disabled == other.disabled;

  @override
  int get hashCode =>
      Object.hash(brightness, size, variant, hasError, hasFocus, disabled);
}

class _TextAreaStyle {
  final Color borderColor;
  final Color backgroundColor;
  final TextStyle textStyle;
  final EdgeInsets padding;
  final TextStyle labelStyle;
  final TextStyle helperStyle;
  final TextStyle validationStyle;
  final TextStyle counterStyle;

  const _TextAreaStyle({
    required this.borderColor,
    required this.backgroundColor,
    required this.textStyle,
    required this.padding,
    required this.labelStyle,
    required this.helperStyle,
    required this.validationStyle,
    required this.counterStyle,
  });
}

/// TextArea Size Variants
enum FSTextAreaSize {
  sm,
  md,
  lg,
}

/// TextArea Variants (colors)
enum FSTextAreaVariant {
  primary,
  secondary,
  success,
  danger,
  warning,
  info,
}

class FlutstrapTextArea extends StatefulWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final String? label;
  final String? placeholder;
  final String? helperText;
  final bool disabled;
  final bool readonly;
  final bool required;
  final bool showValidation;
  final bool isValid;
  final String? validationMessage;
  final int? maxLength;
  final bool showCharacterCounter;
  final int rows;
  final bool autoResize;
  final FSTextAreaSize size;
  final FSTextAreaVariant variant;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onEditingComplete;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final EdgeInsetsGeometry? padding;
  final bool showLabel;
  final String? semanticLabel;
  final Duration resizeDelay;

  const FlutstrapTextArea({
    super.key,
    this.controller,
    this.initialValue,
    this.label,
    this.placeholder,
    this.helperText,
    this.disabled = false,
    this.readonly = false,
    this.required = false,
    this.showValidation = false,
    this.isValid = true,
    this.validationMessage,
    this.maxLength,
    this.showCharacterCounter = false,
    this.rows = 3,
    this.autoResize = false,
    this.size = FSTextAreaSize.md,
    this.variant = FSTextAreaVariant.primary,
    this.onChanged,
    this.onSubmitted,
    this.onEditingComplete,
    this.focusNode,
    this.textInputAction,
    this.padding,
    this.showLabel = true,
    this.semanticLabel,
    this.resizeDelay = const Duration(milliseconds: 100),
  });

  @override
  State<FlutstrapTextArea> createState() => _FlutstrapTextAreaState();

  // ✅ CONSISTENT COPYWITH PATTERN
  FlutstrapTextArea copyWith({
    Key? key,
    TextEditingController? controller,
    String? initialValue,
    String? label,
    String? placeholder,
    String? helperText,
    bool? disabled,
    bool? readonly,
    bool? required,
    bool? showValidation,
    bool? isValid,
    String? validationMessage,
    int? maxLength,
    bool? showCharacterCounter,
    int? rows,
    bool? autoResize,
    FSTextAreaSize? size,
    FSTextAreaVariant? variant,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    VoidCallback? onEditingComplete,
    FocusNode? focusNode,
    TextInputAction? textInputAction,
    EdgeInsetsGeometry? padding,
    bool? showLabel,
    String? semanticLabel,
    Duration? resizeDelay,
  }) {
    return FlutstrapTextArea(
      key: key ?? this.key,
      controller: controller ?? this.controller,
      initialValue: initialValue ?? this.initialValue,
      label: label ?? this.label,
      placeholder: placeholder ?? this.placeholder,
      helperText: helperText ?? this.helperText,
      disabled: disabled ?? this.disabled,
      readonly: readonly ?? this.readonly,
      required: required ?? this.required,
      showValidation: showValidation ?? this.showValidation,
      isValid: isValid ?? this.isValid,
      validationMessage: validationMessage ?? this.validationMessage,
      maxLength: maxLength ?? this.maxLength,
      showCharacterCounter: showCharacterCounter ?? this.showCharacterCounter,
      rows: rows ?? this.rows,
      autoResize: autoResize ?? this.autoResize,
      size: size ?? this.size,
      variant: variant ?? this.variant,
      onChanged: onChanged ?? this.onChanged,
      onSubmitted: onSubmitted ?? this.onSubmitted,
      onEditingComplete: onEditingComplete ?? this.onEditingComplete,
      focusNode: focusNode ?? this.focusNode,
      textInputAction: textInputAction ?? this.textInputAction,
      padding: padding ?? this.padding,
      showLabel: showLabel ?? this.showLabel,
      semanticLabel: semanticLabel ?? this.semanticLabel,
      resizeDelay: resizeDelay ?? this.resizeDelay,
    );
  }

  // ✅ CONVENIENCE METHODS
  FlutstrapTextArea primary() => copyWith(variant: FSTextAreaVariant.primary);
  FlutstrapTextArea secondary() =>
      copyWith(variant: FSTextAreaVariant.secondary);
  FlutstrapTextArea success() => copyWith(variant: FSTextAreaVariant.success);
  FlutstrapTextArea danger() => copyWith(variant: FSTextAreaVariant.danger);
  FlutstrapTextArea warning() => copyWith(variant: FSTextAreaVariant.warning);
  FlutstrapTextArea info() => copyWith(variant: FSTextAreaVariant.info);

  FlutstrapTextArea small() => copyWith(size: FSTextAreaSize.sm);
  FlutstrapTextArea medium() => copyWith(size: FSTextAreaSize.md);
  FlutstrapTextArea large() => copyWith(size: FSTextAreaSize.lg);

  FlutstrapTextArea asDisabled() => copyWith(disabled: true);
  FlutstrapTextArea asEnabled() => copyWith(disabled: false);
  FlutstrapTextArea withLabel(String label) => copyWith(label: label);
  FlutstrapTextArea withHint(String hint) => copyWith(placeholder: hint);
  FlutstrapTextArea withHelper(String helper) => copyWith(helperText: helper);
  FlutstrapTextArea withValidation(String message) => copyWith(
        validationMessage: message,
        showValidation: true,
        isValid: false,
      );
}

class _FlutstrapTextAreaState extends State<FlutstrapTextArea> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  Timer? _resizeTimer;
  bool _isDisposed = false;

  // ✅ SIMPLIFIED STATE MANAGEMENT
  bool get _isInvalid => widget.showValidation && !widget.isValid;
  bool get _hasFocus => _focusNode.hasFocus;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();

    if (widget.initialValue != null) {
      _controller.text = widget.initialValue!;
    }

    // ✅ SINGLE CONTROLLER LISTENER FOR ALL FUNCTIONALITY
    _controller.addListener(_handleControllerChange);
  }

  @override
  void didUpdateWidget(FlutstrapTextArea oldWidget) {
    super.didUpdateWidget(oldWidget);

    // ✅ OPTIMIZED CONTROLLER UPDATE WITH SAFETY
    if (widget.controller != oldWidget.controller) {
      _controller.removeListener(_handleControllerChange);

      // Only dispose if we created the controller
      if (oldWidget.controller == null) {
        _controller.dispose();
      }

      _controller = widget.controller ?? TextEditingController();
      if (widget.initialValue != null) {
        _controller.text = widget.initialValue!;
      }
      _controller.addListener(_handleControllerChange);
    }

    // ✅ UPDATE FOCUS NODE SAFELY
    if (widget.focusNode != oldWidget.focusNode) {
      if (oldWidget.focusNode == null) {
        _focusNode.dispose();
      }
      _focusNode = widget.focusNode ?? FocusNode();
    }
  }

  void _handleControllerChange() {
    if (_isDisposed) return;

    // ✅ DEBOUNCED AUTO-RESIZE FOR PERFORMANCE
    if (widget.autoResize) {
      _resizeTimer?.cancel();
      _resizeTimer = Timer(widget.resizeDelay, () {
        if (mounted && !_isDisposed) setState(() {});
      });
    }

    // ✅ ONLY UPDATE COUNTER WHEN NEEDED
    if (widget.showCharacterCounter &&
        widget.maxLength != null &&
        mounted &&
        !_isDisposed) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    _resizeTimer?.cancel();
    _resizeTimer = null;
    _controller.removeListener(_handleControllerChange);
    // ✅ PROPER DISPOSAL - only dispose if we created it
    if (widget.controller == null) {
      _controller.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stopwatch = Stopwatch()..start();

    final widget = ErrorBoundary(
      // ✅ USING SHARED ERROR BOUNDARY
      componentName: 'FlutstrapTextArea',
      fallbackBuilder: (context) => _buildErrorTextArea(),
      child: _buildTextAreaContent(context),
    );

    stopwatch.stop();
    _TextAreaPerformance.logBuildTime(
        'FlutstrapTextArea', stopwatch.elapsedMilliseconds);

    return widget;
  }

  Widget _buildErrorTextArea() {
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
              'Text area unavailable',
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextAreaContent(BuildContext context) {
    final theme = FSTheme.of(context);
    final textAreaStyle = _TextAreaStyleCache.getOrCreate(
      theme: theme,
      size: widget.size,
      variant: widget.variant,
      hasError: _isInvalid,
      hasFocus: _hasFocus,
      disabled: widget.disabled,
    );

    // ✅ ENHANCED: Create semantic description that includes error state
    String semanticDescription = _controller.text;
    if (_isInvalid && widget.validationMessage != null) {
      semanticDescription += '. Error: ${widget.validationMessage}';
    }
    if (widget.helperText != null) {
      semanticDescription += '. ${widget.helperText}';
    }

    return Semantics(
      label: widget.semanticLabel ?? widget.label,
      value: _controller.text,
      enabled: !widget.disabled && !widget.readonly,
      readOnly: widget.readonly,
      hint: widget.placeholder,
      // ✅ ADDED: Use hint for placeholder and value for current content
      child: ExcludeSemantics(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.showLabel && widget.label != null)
              _buildLabel(theme, textAreaStyle),
            _buildTextArea(theme, textAreaStyle),
            _buildBottomRow(theme, textAreaStyle),
            if (widget.showValidation &&
                _isInvalid &&
                widget.validationMessage != null)
              Semantics(
                // ✅ ADDED: Separate semantics for error message
                label: 'Error: ${widget.validationMessage}',
                child: _buildValidationMessage(theme, textAreaStyle),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(FSThemeData theme, _TextAreaStyle style) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.label!,
            style: style.labelStyle,
          ),
          if (widget.required)
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Text(
                '*',
                style: style.labelStyle.copyWith(
                  color: theme.colors.danger,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTextArea(FSThemeData theme, _TextAreaStyle style) {
    return Focus(
      canRequestFocus: !widget.disabled && !widget.readonly,
      onFocusChange: (hasFocus) {
        if (mounted && !_isDisposed) setState(() {});
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: style.borderColor,
            width: 1.5,
          ),
        ),
        child: TextField(
          controller: _controller,
          focusNode: _focusNode,
          enabled: !widget.disabled && !widget.readonly,
          readOnly: widget.readonly,
          maxLines: widget.autoResize ? null : widget.rows,
          minLines: widget.autoResize ? null : widget.rows,
          maxLength: widget.maxLength,
          textInputAction: widget.textInputAction,
          decoration: InputDecoration(
            hintText: widget.placeholder,
            border: InputBorder.none,
            contentPadding: style.padding,
            isCollapsed: true,
            counterText: '', // We handle counter separately
            filled: widget.disabled,
            fillColor: style.backgroundColor,
          ),
          style: style.textStyle,
          onChanged: widget.onChanged,
          onSubmitted: widget.onSubmitted,
          onEditingComplete: widget.onEditingComplete,
        ),
      ),
    );
  }

  Widget _buildBottomRow(FSThemeData theme, _TextAreaStyle style) {
    final hasHelperText = widget.helperText != null;
    final hasCounter = widget.showCharacterCounter && widget.maxLength != null;

    if (!hasHelperText && !hasCounter) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Helper Text
          if (hasHelperText)
            Expanded(
              child: Text(
                widget.helperText!,
                style: style.helperStyle,
              ),
            ),

          // Character Counter
          if (hasCounter)
            Text(
              '${_controller.text.length}/${widget.maxLength}',
              style: style.counterStyle.copyWith(
                color: _getCounterColor(theme),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildValidationMessage(FSThemeData theme, _TextAreaStyle style) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Text(
        widget.validationMessage!,
        style: style.validationStyle,
      ),
    );
  }

  Color _getCounterColor(FSThemeData theme) {
    final currentLength = _controller.text.length;
    final maxLength = widget.maxLength!;

    if (currentLength > maxLength) {
      return theme.colors.danger;
    } else if (currentLength > maxLength * 0.9) {
      return theme.colors.warning;
    } else {
      return theme.colors.onSurface.withOpacity(0.6);
    }
  }

  EdgeInsets _getPadding() {
    if (widget.padding != null) {
      return widget.padding!.resolve(TextDirection.ltr);
    }

    switch (widget.size) {
      case FSTextAreaSize.sm:
        return const EdgeInsets.symmetric(
          horizontal: FSSpacing.sm,
          vertical: FSSpacing.xs,
        );
      case FSTextAreaSize.md:
        return const EdgeInsets.symmetric(
          horizontal: FSSpacing.md,
          vertical: FSSpacing.sm,
        );
      case FSTextAreaSize.lg:
        return const EdgeInsets.symmetric(
          horizontal: FSSpacing.lg,
          vertical: FSSpacing.md,
        );
    }
  }

  // ✅ PUBLIC METHODS FOR PROGRAMMATIC CONTROL
  void clear() {
    _controller.clear();
    if (mounted && !_isDisposed) setState(() {});
    widget.onChanged?.call('');
  }

  void focus() {
    if (widget.focusNode != null) {
      widget.focusNode!.requestFocus();
    } else {
      _focusNode.requestFocus();
    }
  }

  void unfocus() {
    if (widget.focusNode != null) {
      widget.focusNode!.unfocus();
    } else {
      _focusNode.unfocus();
    }
  }

  // ✅ VALUE MANAGEMENT
  String get value => _controller.text;

  set value(String newValue) {
    _controller.text = newValue;
    if (mounted && !_isDisposed) setState(() {});
    widget.onChanged?.call(newValue);
  }

  // ✅ VALIDATION STATUS
  bool get isValid => !_isInvalid;
  bool get hasError => _isInvalid;
  String? get error => widget.validationMessage;

  // ✅ CHARACTER COUNTER INFO
  int get characterCount => _controller.text.length;
  int? get maxCharacters => widget.maxLength;
  double get characterUsage => widget.maxLength != null
      ? _controller.text.length / widget.maxLength!
      : 0.0;
}
