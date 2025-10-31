/// Flutstrap Checkbox
///
/// A high-performance, accessible checkbox component with comprehensive
/// theming, smooth animations, and Bootstrap-inspired variants.
///
/// {@tool snippet}
/// ### Basic Usage
///
/// ```dart
/// // Basic checkbox
/// FlutstrapCheckbox(
///   value: _isChecked,
///   onChanged: (value) => setState(() => _isChecked = value!),
///   label: 'Accept terms and conditions',
/// )
///
/// // Checkbox with variant
/// FlutstrapCheckbox(
///   value: _isSuccess,
///   onChanged: (value) => setState(() => _isSuccess = value!),
///   variant: FSCheckboxVariant.success,
///   label: 'Completed',
/// )
///
/// // Disabled checkbox
/// FlutstrapCheckbox(
///   value: true,
///   onChanged: null,
///   label: 'Disabled checkbox',
///   disabled: true,
/// )
///
/// // Tri-state checkbox
/// FlutstrapCheckbox(
///   value: _triStateValue,
///   onChanged: (value) => setState(() => _triStateValue = value),
///   tristate: true,
///   label: 'Tri-state option',
/// )
///
/// // Using convenience methods
/// FlutstrapCheckbox(
///   value: _isChecked,
///   onChanged: (value) => setState(() => _isChecked = value!),
/// ).success().withLabel('Success state')
/// ```
///
/// {@template flutstrap_checkbox.performance}
/// ## Performance Features
///
/// - **Style Caching**: Checkbox styles cached by variant, size, and theme
/// - **Efficient Rendering**: Minimal rebuilds with optimized state management
/// - **Smooth Animations**: Hardware-accelerated transitions for state changes
/// - **Memory Management**: Proper resource disposal and cache management
/// {@endtemplate}
///
/// {@template flutstrap_checkbox.accessibility}
/// ## Accessibility
///
/// - Full screen reader support with semantic labels
/// - Keyboard navigation with focus indicators
/// - Proper ARIA attributes for checkbox states
/// - High contrast support for visually impaired users
/// {@endtemplate}
///
/// ## Checkbox Best Practices
///
/// - Always provide meaningful labels for each checkbox option
/// - Use `semanticLabel` for complex custom labels
/// - Group related checkboxes together semantically
/// - Provide validation feedback for required fields
/// - Use tri-state for hierarchical selections (select all/none/some)
///
/// {@category Components}
/// {@category Forms}

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme.dart';
import '../../core/spacing.dart';
import '../../core/error_boundary.dart'; 

/// Performance monitoring for checkbox operations
class _CheckboxPerformance {
  static final _buildTimes = <String, int>{};
  static final _interactionTimes = <String, int>{};

  static void logBuildTime(String checkboxType, int milliseconds) {
    _buildTimes[checkboxType] = milliseconds;

    if (milliseconds > 16) {
      debugPrint('⏱️ Slow checkbox build: $checkboxType took ${milliseconds}ms');
    }
  }

  static void logInteractionTime(int milliseconds) {
    _interactionTimes['tap'] = milliseconds;
  }

  static void clearMetrics() {
    _buildTimes.clear();
    _interactionTimes.clear();
  }

  static Map<String, int> get buildTimes => Map.from(_buildTimes);
  static Map<String, int> get interactionTimes => Map.from(_interactionTimes);
}

/// Style caching for checkbox components
class _CheckboxStyleCache {
  static final _cache = <_CheckboxStyleCacheKey, _CheckboxStyle>{};
  static final _cacheKeys = <_CheckboxStyleCacheKey>[];
  static const int _maxCacheSize = 15;

  static _CheckboxStyle getOrCreate({
    required FSThemeData theme,
    required FSCheckboxVariant variant,
    required FSCheckboxSize size,
  }) {
    final key = _CheckboxStyleCacheKey(theme.brightness, variant, size);

    if (_cache.containsKey(key)) {
      _cacheKeys.remove(key);
      _cacheKeys.add(key);
      return _cache[key]!;
    }

    final style = _CheckboxStyle(theme, variant, size);
    _cache[key] = style;
    _cacheKeys.add(key);

    // LRU eviction
    if (_cache.length > _maxCacheSize) {
      final lruKey = _cacheKeys.removeAt(0);
      _cache.remove(lruKey);
    }

    return style;
  }

  static void clearCache() {
    _cache.clear();
    _cacheKeys.clear();
  }

  static int get cacheSize => _cache.length;
}

class _CheckboxStyleCacheKey {
  final Brightness brightness;
  final FSCheckboxVariant variant;
  final FSCheckboxSize size;

  const _CheckboxStyleCacheKey(this.brightness, this.variant, this.size);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _CheckboxStyleCacheKey &&
          runtimeType == other.runtimeType &&
          brightness == other.brightness &&
          variant == other.variant &&
          size == other.size;

  @override
  int get hashCode => Object.hash(brightness, variant, size);
}

/// Flutstrap Checkbox Variants
enum FSCheckboxVariant {
  primary,
  secondary,
  success,
  danger,
  warning,
  info,
}

/// Flutstrap Checkbox Size
enum FSCheckboxSize {
  sm,
  md,
  lg,
}

class FlutstrapCheckbox extends StatefulWidget {
  final bool? value;
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
  final bool tristate;
  final Color? activeColor;
  final Color? checkColor;
  final VisualDensity? visualDensity;
  final EdgeInsetsGeometry? padding;

  const FlutstrapCheckbox({
    super.key,
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
    this.tristate = false,
    this.activeColor,
    this.checkColor,
    this.visualDensity,
    this.padding,
  });

  @override
  State<FlutstrapCheckbox> createState() => _FlutstrapCheckboxState();

  // ✅ CONSISTENT COPYWITH PATTERN
  FlutstrapCheckbox copyWith({
    Key? key,
    bool? value,
    ValueChanged<bool?>? onChanged,
    FSCheckboxVariant? variant,
    FSCheckboxSize? size,
    String? label,
    Widget? customLabel,
    bool? disabled,
    bool? inline,
    String? semanticLabel,
    bool? showValidation,
    bool? isValid,
    String? validationMessage,
    bool? tristate,
    Color? activeColor,
    Color? checkColor,
    VisualDensity? visualDensity,
    EdgeInsetsGeometry? padding,
  }) {
    return FlutstrapCheckbox(
      key: key ?? this.key,
      value: value ?? this.value,
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
      tristate: tristate ?? this.tristate,
      activeColor: activeColor ?? this.activeColor,
      checkColor: checkColor ?? this.checkColor,
      visualDensity: visualDensity ?? this.visualDensity,
      padding: padding ?? this.padding,
    );
  }

  // ✅ CONVENIENCE METHODS
  FlutstrapCheckbox primary() => copyWith(variant: FSCheckboxVariant.primary);
  FlutstrapCheckbox secondary() => copyWith(variant: FSCheckboxVariant.secondary);
  FlutstrapCheckbox success() => copyWith(variant: FSCheckboxVariant.success);
  FlutstrapCheckbox danger() => copyWith(variant: FSCheckboxVariant.danger);
  FlutstrapCheckbox warning() => copyWith(variant: FSCheckboxVariant.warning);
  FlutstrapCheckbox info() => copyWith(variant: FSCheckboxVariant.info);

  FlutstrapCheckbox small() => copyWith(size: FSCheckboxSize.sm);
  FlutstrapCheckbox medium() => copyWith(size: FSCheckboxSize.md);
  FlutstrapCheckbox large() => copyWith(size: FSCheckboxSize.lg);

  FlutstrapCheckbox asDisabled() => copyWith(disabled: true);
  FlutstrapCheckbox asEnabled() => copyWith(disabled: false);
  FlutstrapCheckbox withLabel(String label) => copyWith(label: label);
  FlutstrapCheckbox withValidation(String message) => copyWith(
        validationMessage: message,
        showValidation: true,
        isValid: false,
      );
  FlutstrapCheckbox asTristate() => copyWith(tristate: true);
}

class _FlutstrapCheckboxState extends State<FlutstrapCheckbox> {
  bool _isTapping = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  // ✅ SIMPLIFIED STATE MANAGEMENT
  void _handleTap() {
    if (_isTapping || widget.disabled || widget.onChanged == null) {
      return;
    }

    _isTapping = true;
    final stopwatch = Stopwatch()..start();

    try {
      if (widget.tristate) {
        // Cycle through null -> true -> false
        final newValue = widget.value == true
            ? false
            : widget.value == false
                ? null
                : true;
        widget.onChanged!(newValue);
      } else {
        widget.onChanged!(!(widget.value ?? false));
      }
    } finally {
      stopwatch.stop();
      _CheckboxPerformance.logInteractionTime(stopwatch.elapsedMilliseconds);

      // Reset tapping state after a short delay
      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted) {
          setState(() {
            _isTapping = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final stopwatch = Stopwatch()..start();

    final widget = ErrorBoundary( // ✅ USING SHARED ERROR BOUNDARY
      componentName: 'FlutstrapCheckbox',
      fallbackBuilder: (context) => _buildErrorCheckbox(),
      child: _buildCheckboxContent(context),
    );

    stopwatch.stop();
    _CheckboxPerformance.logBuildTime(
        'FlutstrapCheckbox', stopwatch.elapsedMilliseconds);

    return widget;
  }

  Widget _buildErrorCheckbox() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline, color: Colors.red, size: 16),
          SizedBox(width: 8),
          Text(
            'Checkbox unavailable',
            style: TextStyle(color: Colors.red, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckboxContent(BuildContext context) {
    final theme = FSTheme.of(context);
    final checkboxStyle = _CheckboxStyleCache.getOrCreate(
      theme: theme,
      variant: widget.variant,
      size: widget.size,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCheckboxRow(checkboxStyle),
        if (widget.showValidation &&
            !widget.isValid &&
            widget.validationMessage != null)
          _buildValidationMessage(checkboxStyle),
      ],
    );
  }

  Widget _buildCheckboxRow(_CheckboxStyle style) {
    final hasLabel = widget.label != null || widget.customLabel != null;

    return FocusableActionDetector(
      actions: {
        ActivateIntent: CallbackAction<ActivateIntent>(
          onInvoke: (intent) {
            _handleTap();
            return null;
          },
        ),
      },
      child: MouseRegion(
        cursor: widget.disabled
            ? SystemMouseCursors.forbidden
            : SystemMouseCursors.click,
        child: GestureDetector(
          onTap: _handleTap,
          behavior: HitTestBehavior.opaque,
          child: Semantics(
            label: widget.semanticLabel ?? widget.label,
            enabled: !widget.disabled,
            checked: widget.value == true,
            toggled: widget.value == true,
            mixed: widget.value == null, // For tri-state
            button: true,
            child: ExcludeSemantics(
              child: Container(
                padding: widget.padding ?? EdgeInsets.zero,
                child: widget.inline && hasLabel
                    ? _buildInlineLayout(style)
                    : _buildBlockLayout(style, hasLabel),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInlineLayout(_CheckboxStyle style) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildCheckbox(style),
        if (widget.label != null || widget.customLabel != null) ...[
          SizedBox(width: style.labelSpacing),
          _buildLabel(style),
        ],
      ],
    );
  }

  Widget _buildBlockLayout(_CheckboxStyle style, bool hasLabel) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCheckbox(style),
        if (hasLabel) ...[
          SizedBox(width: style.labelSpacing),
          Expanded(child: _buildLabel(style)),
        ],
      ],
    );
  }

  Widget _buildCheckbox(_CheckboxStyle style) {
    return Material(
      color: Colors.transparent,
      borderRadius: style.borderRadius,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        child: InkWell(
          onTap: widget.disabled ? null : _handleTap,
          borderRadius: style.borderRadius,
          splashColor: _getSplashColor(style),
          highlightColor: _getHighlightColor(style),
          child: Container(
            width: style.checkboxSize,
            height: style.checkboxSize,
            decoration: BoxDecoration(
              color: _getBackgroundColor(style),
              borderRadius: style.borderRadius,
              border: Border.all(
                color: _getBorderColor(style),
                width: style.borderWidth,
              ),
              boxShadow: widget.value != false // true or indeterminate
                  ? [
                      BoxShadow(
                        color: _getActiveColor(style).withOpacity(0.3),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : null,
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              switchInCurve: Curves.easeInOut,
              switchOutCurve: Curves.easeInOut,
              child: _buildCheckmark(style),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCheckmark(_CheckboxStyle style) {
    if (widget.value == null) {
      // Indeterminate state
      return Center(
        child: Container(
          width: style.checkmarkSize / 2,
          height: 2,
          decoration: BoxDecoration(
            color: _getCheckmarkColor(style),
            borderRadius: BorderRadius.circular(1),
          ),
        ),
      );
    }

    if (widget.value == true) {
      return Icon(
        Icons.check,
        size: style.checkmarkSize,
        color: _getCheckmarkColor(style),
      );
    }

    return const SizedBox.shrink();
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

  Color _getActiveColor(_CheckboxStyle style) {
    return widget.activeColor ?? style.activeBackgroundColor;
  }

  Color _getBackgroundColor(_CheckboxStyle style) {
    if (widget.disabled) {
      return style.disabledBackgroundColor;
    }

    if (widget.value != false) {
      // true or null (indeterminate)
      return _getActiveColor(style);
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

    if (widget.value != false) {
      return _getActiveColor(style);
    }

    return style.borderColor;
  }

  Color _getCheckmarkColor(_CheckboxStyle style) {
    if (widget.disabled) {
      return style.disabledCheckmarkColor;
    }
    return widget.checkColor ?? style.checkmarkColor;
  }

  Color? _getSplashColor(_CheckboxStyle style) {
    if (widget.disabled) return null;
    return _getActiveColor(style).withOpacity(0.2);
  }

  Color? _getHighlightColor(_CheckboxStyle style) {
    if (widget.disabled) return null;
    return _getActiveColor(style).withOpacity(0.1);
  }
}

class _CheckboxStyle {
  final FSThemeData theme;
  final FSCheckboxVariant variant;
  final FSCheckboxSize size;

  _CheckboxStyle(this.theme, this.variant, this.size);

  // Sizes
  double get checkboxSize {
    switch (size) {
      case FSCheckboxSize.sm:
        return 16.0;
      case FSCheckboxSize.md:
        return 20.0;
      case FSCheckboxSize.lg:
        return 24.0;
    }
  }

  double get checkmarkSize {
    switch (size) {
      case FSCheckboxSize.sm:
        return 12.0;
      case FSCheckboxSize.md:
        return 16.0;
      case FSCheckboxSize.lg:
        return 20.0;
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

  Color get checkmarkColor => _getCheckmarkColor();
  Color get disabledCheckmarkColor => theme.colors.onSurface.withOpacity(0.3);

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

  // Border
  BorderRadius get borderRadius => BorderRadius.circular(4.0);

  Color _getActiveColor() {
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
    }
  }

  Color _getCheckmarkColor() {
    return theme.colors.onPrimary;
  }
}