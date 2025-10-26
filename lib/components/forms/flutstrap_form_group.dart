import 'package:flutter/material.dart';
import '../../core/theme.dart';

// Form Group Layout Variants
enum FSFormGroupLayout {
  vertical,
  horizontal,
  inline,
}

// Form Group Size Variants
enum FSFormGroupSize {
  sm,
  md,
  lg,
}

class FlutstrapFormGroup extends StatelessWidget {
  final List<Widget> children;
  final String? label;
  final String? helperText;
  final String? validationMessage;
  final bool showValidation;
  final bool isValid;
  final bool required;
  final FSFormGroupLayout layout;
  final FSFormGroupSize size;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  final double spacing;
  final bool showLabel;
  final Widget? customLabel;

  const FlutstrapFormGroup({
    Key? key,
    required this.children,
    this.label,
    this.helperText,
    this.validationMessage,
    this.showValidation = false,
    this.isValid = true,
    this.required = false,
    this.layout = FSFormGroupLayout.vertical,
    this.size = FSFormGroupSize.md,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.spacing = 16.0,
    this.showLabel = true,
    this.customLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = FSTheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Label
        if (showLabel && (label != null || customLabel != null))
          _buildLabel(theme),

        // Form Fields
        _buildFormFields(theme),

        // Helper Text & Validation Message
        _buildBottomContent(theme),
      ],
    );
  }

  Widget _buildLabel(FSThemeData theme) {
    if (customLabel != null) {
      return Padding(
        padding: _getLabelPadding(),
        child: customLabel!,
      );
    }

    return Padding(
      padding: _getLabelPadding(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label!,
            style: theme.typography.labelMedium?.copyWith(
              color: _getLabelColor(theme),
            ),
          ),
          if (required)
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

  Widget _buildFormFields(FSThemeData theme) {
    switch (layout) {
      case FSFormGroupLayout.vertical:
        return Column(
          crossAxisAlignment: crossAxisAlignment,
          mainAxisSize: MainAxisSize.min,
          children: _buildChildrenWithSpacing(),
        );
      case FSFormGroupLayout.horizontal:
        return Row(
          crossAxisAlignment: _getCrossAxisAlignmentForRow(),
          mainAxisAlignment: mainAxisAlignment,
          children: _buildChildrenWithSpacing(),
        );
      case FSFormGroupLayout.inline:
        return Wrap(
          spacing: spacing,
          runSpacing: spacing / 2,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: children,
        );
    }
  }

  Widget _buildBottomContent(FSThemeData theme) {
    final hasHelperText = helperText != null;
    final hasValidation =
        showValidation && !isValid && validationMessage != null;

    if (!hasHelperText && !hasValidation) return const SizedBox.shrink();

    return Padding(
      padding: _getBottomContentPadding(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (hasHelperText)
            Text(
              helperText!,
              style: theme.typography.bodySmall?.copyWith(
                color: _getGrayColor(theme, 600),
              ),
            ),
          if (hasValidation)
            Padding(
              padding: hasHelperText
                  ? const EdgeInsets.only(top: 4.0)
                  : EdgeInsets.zero,
              child: Text(
                validationMessage!,
                style: theme.typography.bodySmall?.copyWith(
                  color: theme.colors.danger,
                ),
              ),
            ),
        ],
      ),
    );
  }

  List<Widget> _buildChildrenWithSpacing() {
    if (children.isEmpty) return [];
    if (children.length == 1) return children;

    final List<Widget> childrenWithSpacing = [];

    for (int i = 0; i < children.length; i++) {
      childrenWithSpacing.add(children[i]);

      // Add spacing between children, but not after the last one
      if (i < children.length - 1) {
        childrenWithSpacing.add(_getSpacingWidget());
      }
    }

    return childrenWithSpacing;
  }

  Widget _getSpacingWidget() {
    switch (layout) {
      case FSFormGroupLayout.vertical:
        return SizedBox(height: spacing);
      case FSFormGroupLayout.horizontal:
        return SizedBox(width: spacing);
      case FSFormGroupLayout.inline:
        return SizedBox(width: spacing);
    }
  }

  CrossAxisAlignment _getCrossAxisAlignmentForRow() {
    if (crossAxisAlignment == CrossAxisAlignment.start)
      return CrossAxisAlignment.start;
    if (crossAxisAlignment == CrossAxisAlignment.end)
      return CrossAxisAlignment.end;
    if (crossAxisAlignment == CrossAxisAlignment.center)
      return CrossAxisAlignment.center;
    return CrossAxisAlignment.center;
  }

  EdgeInsets _getLabelPadding() {
    switch (layout) {
      case FSFormGroupLayout.vertical:
        return const EdgeInsets.only(bottom: 8.0);
      case FSFormGroupLayout.horizontal:
        return const EdgeInsets.only(bottom: 8.0);
      case FSFormGroupLayout.inline:
        return const EdgeInsets.only(bottom: 8.0);
    }
  }

  EdgeInsets _getBottomContentPadding() {
    switch (layout) {
      case FSFormGroupLayout.vertical:
        return const EdgeInsets.only(top: 8.0);
      case FSFormGroupLayout.horizontal:
        return const EdgeInsets.only(top: 8.0);
      case FSFormGroupLayout.inline:
        return const EdgeInsets.only(top: 8.0);
    }
  }

  Color _getLabelColor(FSThemeData theme) {
    if (showValidation && !isValid) {
      return theme.colors.danger;
    }
    return _getGrayColor(theme, 800);
  }

  // Helper method to get gray colors
  Color _getGrayColor(FSThemeData theme, int shade) {
    final isDark = theme.brightness == Brightness.dark;

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
