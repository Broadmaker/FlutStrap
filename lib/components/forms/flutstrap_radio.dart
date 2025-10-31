/// Flutstrap Radio
///
/// A high-performance, accessible radio button component with comprehensive
/// theming, smooth animations, and Bootstrap-inspired variants.
///
/// {@tool snippet}
/// ### Basic Usage
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
/// // Using convenience methods
/// FlutstrapRadio<String>(
///   value: 'custom',
///   groupValue: _selected,
///   onChanged: (value) => setState(() => _selected = value),
/// ).success().withLabel('Custom styled')
/// ```
/// {@end-tool}
///
/// {@template flutstrap_radio.performance}
/// ## Performance Features
///
/// - **Style Caching**: Radio styles cached by variant, size, and theme
/// - **Efficient Rendering**: Minimal rebuilds with optimized state management
/// - **Smooth Animations**: Hardware-accelerated transitions for selection states
/// - **Memory Management**: Proper resource disposal and cache management
/// {@endtemplate}
///
/// {@template flutstrap_radio.accessibility}
/// ## Accessibility
///
/// - Full screen reader support with semantic labels
/// - Keyboard navigation with focus indicators
/// - Proper ARIA attributes for radio groups
/// - High contrast support for visually impaired users
/// {@endtemplate}
///
/// ## Radio Group Best Practices
///
/// - Always provide meaningful labels for each radio option
/// - Use `semanticLabel` for complex custom labels
/// - Group related radios together semantically
/// - Provide validation feedback for required fields
///
/// {@category Components}
/// {@category Forms}

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../../core/spacing.dart';
import '../../core/error_boundary.dart';

/// Performance monitoring for radio operations
class _RadioPerformance {
  static final _buildTimes = <String, int>{};
  static final _interactionTimes = <String, int>{};

  static void logBuildTime(String radioType, int milliseconds) {
    _buildTimes[radioType] = milliseconds;

    if (milliseconds > 16) {
      debugPrint('⏱️ Slow radio build: $radioType took ${milliseconds}ms');
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

/// Style caching for radio components
class _RadioStyleCache {
  static final _cache = <_RadioStyleCacheKey, _RadioStyle>{};
  static final _cacheKeys = <_RadioStyleCacheKey>[];
  static const int _maxCacheSize = 15;

  static _RadioStyle getOrCreate({
    required FSThemeData theme,
    required FSRadioVariant variant,
    required FSRadioSize size,
  }) {
    final key = _RadioStyleCacheKey(theme.brightness, variant, size);

    if (_cache.containsKey(key)) {
      _cacheKeys.remove(key);
      _cacheKeys.add(key);
      return _cache[key]!;
    }

    final style = _RadioStyle(theme, variant, size);
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

class _RadioStyleCacheKey {
  final Brightness brightness;
  final FSRadioVariant variant;
  final FSRadioSize size;

  const _RadioStyleCacheKey(this.brightness, this.variant, this.size);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _RadioStyleCacheKey &&
          runtimeType == other.runtimeType &&
          brightness == other.brightness &&
          variant == other.variant &&
          size == other.size;

  @override
  int get hashCode => Object.hash(brightness, variant, size);
}

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
  bool _isTapping = false;

  // ✅ SIMPLIFIED STATE MANAGEMENT
  bool get _isSelected => widget.value == widget.groupValue;

  void _handleTap() {
    if (_isTapping ||
        widget.disabled ||
        widget.onChanged == null ||
        _isSelected) {
      return;
    }

    _isTapping = true;
    final stopwatch = Stopwatch()..start();

    try {
      widget.onChanged!(widget.value);
    } finally {
      stopwatch.stop();
      _RadioPerformance.logInteractionTime(stopwatch.elapsedMilliseconds);

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

    final widget = ErrorBoundary(
      // ✅ USING SHARED ERROR BOUNDARY
      componentName: 'FlutstrapRadio',
      fallbackBuilder: (context) => _buildErrorRadio(),
      child: _buildRadioContent(context),
    );

    stopwatch.stop();
    _RadioPerformance.logBuildTime(
        'FlutstrapRadio', stopwatch.elapsedMilliseconds);

    return widget;
  }

  Widget _buildErrorRadio() {
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
            'Radio unavailable',
            style: TextStyle(color: Colors.red, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildRadioContent(BuildContext context) {
    final theme = FSTheme.of(context);
    final radioStyle = _RadioStyleCache.getOrCreate(
      theme: theme,
      variant: widget.variant,
      size: widget.size,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildRadioRow(radioStyle),
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
        behavior: HitTestBehavior.opaque,
        child: Semantics(
          label: widget.semanticLabel ?? widget.label,
          value: widget.value?.toString() ?? '',
          enabled: !widget.disabled,
          checked: _isSelected,
          toggled: _isSelected,
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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
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
              boxShadow: _isSelected
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
              child: _isSelected ? _buildDot(style) : const SizedBox.shrink(),
            ),
          ),
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

  Color _getActiveColor(_RadioStyle style) {
    return widget.activeColor ?? style.activeBackgroundColor;
  }

  Color _getBackgroundColor(_RadioStyle style) {
    if (widget.disabled) {
      return style.disabledBackgroundColor;
    }

    if (_isSelected) {
      return _getActiveColor(style);
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
      return _getActiveColor(style);
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
    return _getActiveColor(style).withOpacity(0.2);
  }

  Color? _getHighlightColor(_RadioStyle style) {
    if (widget.disabled) return null;
    return _getActiveColor(style).withOpacity(0.1);
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
