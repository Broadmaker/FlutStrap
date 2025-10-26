import 'package:flutter/material.dart';
import '../../core/theme.dart';

// TextArea Size Variants
enum FSTextAreaSize {
  sm,
  md,
  lg,
}

// TextArea Variants (colors)
enum FSTextAreaVariant {
  primary,
  secondary,
  success,
  danger,
  warning,
  info,
  light,
  dark,
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

  const FlutstrapTextArea({
    Key? key,
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
  }) : super(key: key);

  @override
  State<FlutstrapTextArea> createState() => _FlutstrapTextAreaState();
}

class _FlutstrapTextAreaState extends State<FlutstrapTextArea> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();

    if (widget.initialValue != null) {
      _controller.text = widget.initialValue!;
    }

    // Listen to controller changes to update character counter and auto-resize
    _controller.addListener(_handleControllerChange);

    if (widget.autoResize) {
      _controller.addListener(_autoResize);
    }
  }

  @override
  void didUpdateWidget(FlutstrapTextArea oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.autoResize != oldWidget.autoResize) {
      if (widget.autoResize) {
        _controller.addListener(_autoResize);
      } else {
        _controller.removeListener(_autoResize);
      }
    }
  }

  void _handleControllerChange() {
    if (mounted) {
      setState(() {
        // This will trigger a rebuild and update both character counter and auto-resize
      });
    }
  }

  void _autoResize() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_handleControllerChange);
    if (widget.autoResize) {
      _controller.removeListener(_autoResize);
    }
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
    final colors = theme.colors;

    return Column(
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
            !widget.isValid &&
            widget.validationMessage != null)
          _buildValidationMessage(theme),
      ],
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
            style: theme.typography.labelMedium?.copyWith(
              color: widget.disabled
                  ? _getGrayColor(theme, 600)
                  : _getGrayColor(theme, 800),
            ),
          ),
          if (widget.required)
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Text(
                '*',
                style: theme.typography.labelMedium?.copyWith(
                  color: theme.colors.danger,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTextArea(FSThemeData theme) {
    final isInvalid = widget.showValidation && !widget.isValid;
    final variantColor = _getVariantColor(theme, isInvalid);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0), // Using fixed border radius
        border: Border.all(
          color: _getBorderColor(theme, variantColor, isInvalid),
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
          fillColor: widget.disabled ? _getGrayColor(theme, 200) : null,
        ),
        style: _getTextStyle(theme),
        onChanged: (value) {
          // This will be called when user types, but we also listen to controller changes
          // for programmatic text changes
          if (widget.autoResize) {
            setState(() {});
          }
          widget.onChanged?.call(value);
        },
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
                style: theme.typography.bodySmall?.copyWith(
                  color: _getGrayColor(theme, 600),
                ),
              ),
            ),

          // Character Counter
          if (hasCounter)
            Text(
              '${_controller.text.length}/${widget.maxLength}',
              style: theme.typography.bodySmall?.copyWith(
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
        style: theme.typography.bodySmall?.copyWith(
          color: theme.colors.danger,
        ),
      ),
    );
  }

  Color _getVariantColor(FSThemeData theme, bool isInvalid) {
    if (isInvalid) return theme.colors.danger;

    switch (widget.variant) {
      case FSTextAreaVariant.primary:
        return theme.colors.primary;
      case FSTextAreaVariant.secondary:
        return theme.colors.secondary;
      case FSTextAreaVariant.success:
        return theme.colors.success;
      case FSTextAreaVariant.danger:
        return theme.colors.danger;
      case FSTextAreaVariant.warning:
        return theme.colors.warning;
      case FSTextAreaVariant.info:
        return theme.colors.info;
      case FSTextAreaVariant.light:
        return theme.colors.light;
      case FSTextAreaVariant.dark:
        return theme.colors.dark;
    }
  }

  Color _getBorderColor(FSThemeData theme, Color variantColor, bool isInvalid) {
    if (isInvalid) return theme.colors.danger;
    if (_focusNode.hasFocus) return variantColor;
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
      return _getGrayColor(theme, 600);
    }
  }

  EdgeInsets _getPadding() {
    if (widget.padding != null)
      return widget.padding!.resolve(TextDirection.ltr);

    switch (widget.size) {
      case FSTextAreaSize.sm:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
      case FSTextAreaSize.md:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
      case FSTextAreaSize.lg:
        return const EdgeInsets.symmetric(horizontal: 20, vertical: 16);
    }
  }

  TextStyle? _getTextStyle(FSThemeData theme) {
    final baseStyle = theme.typography.bodyMedium;

    switch (widget.size) {
      case FSTextAreaSize.sm:
        return baseStyle?.copyWith(fontSize: 14);
      case FSTextAreaSize.md:
        return baseStyle?.copyWith(fontSize: 16);
      case FSTextAreaSize.lg:
        return baseStyle?.copyWith(fontSize: 18);
    }
  }

  // Helper method to get gray colors since they're not in FSColorScheme
  Color _getGrayColor(FSThemeData theme, int shade) {
    final isDark = theme.brightness == Brightness.dark;

    // Bootstrap-like gray shades
    switch (shade) {
      case 100:
        return isDark ? const Color(0xFF2D333B) : const Color(0xFFF8F9FA);
      case 200:
        return isDark ? const Color(0xFF3D444D) : const Color(0xFFE9ECEF);
      case 300:
        return isDark ? const Color(0xFF545962) : const Color(0xFFDEE2E6);
      case 400:
        return isDark ? const Color(0xFF6C757D) : const Color(0xFFCED4DA);
      case 500:
        return isDark ? const Color(0xFF868E96) : const Color(0xFFADB5BD);
      case 600:
        return isDark ? const Color(0xFFADB5BD) : const Color(0xFF6C757D);
      case 700:
        return isDark ? const Color(0xFFCED4DA) : const Color(0xFF495057);
      case 800:
        return isDark ? const Color(0xFFE9ECEF) : const Color(0xFF343A40);
      case 900:
        return isDark ? const Color(0xFFF8F9FA) : const Color(0xFF212529);
      default:
        return isDark ? const Color(0xFF6C757D) : const Color(0xFF6C757D);
    }
  }
}
