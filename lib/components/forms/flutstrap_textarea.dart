/// Flutstrap TextArea
///
/// A multi-line text input field with various styles, validation,
/// and Bootstrap-inspired variants.
///
/// ## Usage Examples
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
/// // Using state methods
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
///
/// {@category Components}
/// {@category Forms}

import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../../core/spacing.dart';

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

  // ✅ SIMPLIFIED STATE MANAGEMENT
  bool get _isInvalid => widget.showValidation && !widget.isValid;
  bool get _hasFocus => _focusNode.hasFocus;

  Color get _variantColor {
    final theme = FSTheme.of(context);
    if (_isInvalid) return theme.colors.danger;

    final colors = theme.colors;
    switch (widget.variant) {
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

    // ✅ OPTIMIZED CONTROLLER UPDATE
    if (widget.controller != oldWidget.controller) {
      _controller.removeListener(_handleControllerChange);
      _controller.dispose();
      _controller = widget.controller ?? TextEditingController();
      if (widget.initialValue != null) {
        _controller.text = widget.initialValue!;
      }
      _controller.addListener(_handleControllerChange);
    }
  }

  void _handleControllerChange() {
    // ✅ DEBOUNCED AUTO-RESIZE FOR PERFORMANCE
    if (widget.autoResize) {
      _resizeTimer?.cancel();
      _resizeTimer = Timer(widget.resizeDelay, () {
        if (mounted) setState(() {});
      });
    }

    // ✅ ONLY UPDATE COUNTER WHEN NEEDED
    if (widget.showCharacterCounter && widget.maxLength != null && mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _resizeTimer?.cancel();
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
    final theme = FSTheme.of(context);

    return Semantics(
      label: widget.semanticLabel ?? widget.label,
      value: _controller.text,
      enabled: !widget.disabled && !widget.readonly,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Label
          if (widget.showLabel && widget.label != null) _buildLabel(theme),

          // TextArea
          _buildTextArea(theme),

          // Helper Text & Character Counter
          _buildBottomRow(theme),

          // Validation Message
          if (widget.showValidation &&
              _isInvalid &&
              widget.validationMessage != null)
            _buildValidationMessage(theme),
        ],
      ),
    );
  }

  Widget _buildLabel(FSThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.label!,
            style: theme.typography.labelMedium.copyWith(
              color: widget.disabled
                  ? theme.colors.onSurface.withOpacity(0.38)
                  : theme.colors.onSurface,
            ),
          ),
          if (widget.required)
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Text(
                '*',
                style: theme.typography.labelMedium.copyWith(
                  color: theme.colors.danger,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTextArea(FSThemeData theme) {
    final colors = theme.colors;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: _getBorderColor(theme),
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
          contentPadding: _getPadding(),
          isCollapsed: true,
          counterText: '', // We handle counter separately
          filled: widget.disabled,
          fillColor: widget.disabled ? colors.outline.withOpacity(0.1) : null,
        ),
        style: _getTextStyle(theme),
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmitted,
        onEditingComplete: widget.onEditingComplete,
      ),
    );
  }

  Widget _buildBottomRow(FSThemeData theme) {
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
                style: theme.typography.bodySmall.copyWith(
                  color: theme.colors.onSurface.withOpacity(0.6),
                ),
              ),
            ),

          // Character Counter
          if (hasCounter)
            Text(
              '${_controller.text.length}/${widget.maxLength}',
              style: theme.typography.bodySmall.copyWith(
                color: _getCounterColor(theme),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildValidationMessage(FSThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Text(
        widget.validationMessage!,
        style: theme.typography.bodySmall.copyWith(
          color: theme.colors.danger,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Color _getBorderColor(FSThemeData theme) {
    if (_isInvalid) return theme.colors.danger;
    if (_hasFocus) return _variantColor;
    return theme.colors.outline;
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
      // ✅ CONVERT EdgeInsetsGeometry to EdgeInsets
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

  TextStyle _getTextStyle(FSThemeData theme) {
    final baseStyle = theme.typography.bodyMedium.copyWith(
      color: widget.disabled ? theme.colors.onSurface.withOpacity(0.38) : null,
    );

    switch (widget.size) {
      case FSTextAreaSize.sm:
        return baseStyle.copyWith(fontSize: 14);
      case FSTextAreaSize.md:
        return baseStyle.copyWith(fontSize: 16);
      case FSTextAreaSize.lg:
        return baseStyle.copyWith(fontSize: 18);
    }
  }

  // ✅ PUBLIC METHODS FOR PROGRAMMATIC CONTROL
  void clear() {
    _controller.clear();
    if (mounted) setState(() {});
    widget.onChanged?.call('');
  }

  void setError(String error) {
    if (mounted) {
      setState(() {
        // Error state is managed through widget properties
      });
    }
  }

  void clearError() {
    if (mounted) {
      setState(() {
        // Error state is managed through widget properties
      });
    }
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
    if (mounted) setState(() {});
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
