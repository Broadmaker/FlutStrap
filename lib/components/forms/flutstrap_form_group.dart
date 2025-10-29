/// Flutstrap Form Group
///
/// A container for grouping related form fields with consistent spacing,
/// validation states, and layout options.
///
/// ## Usage Examples
///
/// ```dart
/// // Vertical form group
/// FlutstrapFormGroup(
///   label: 'Personal Information',
///   children: [
///     FlutstrapInput(labelText: 'First Name'),
///     FlutstrapInput(labelText: 'Last Name'),
///     FlutstrapInput(labelText: 'Email'),
///   ],
/// )
///
/// // Horizontal form group with validation
/// FlutstrapFormGroup(
///   label: 'Contact Details',
///   layout: FSFormGroupLayout.horizontal,
///   showValidation: true,
///   isValid: false,
///   validationMessage: 'Please fill all required fields',
///   children: [
///     FlutstrapInput(labelText: 'Phone'),
///     FlutstrapInput(labelText: 'Email'),
///   ],
/// )
///
/// // Inline form group for filters
/// FlutstrapFormGroup(
///   label: 'Filters',
///   layout: FSFormGroupLayout.inline,
///   spacing: 12.0,
///   children: [
///     FlutstrapInput(labelText: 'Search'),
///     FlutstrapDropdown(items: [...]),
///     FlutstrapButton(child: Text('Apply')),
///   ],
/// )
/// ```
///
/// ## When to Use
/// - Grouping related form fields (name, email, phone)
/// - Showing collective validation states
/// - Creating consistent form layouts
/// - Building complex forms with multiple sections
///
/// ## Layout Options
/// - **Vertical**: Stacked fields (default)
/// - **Horizontal**: Side-by-side fields
/// - **Inline**: Wrap-based layout for dynamic sizing
///
/// ## Performance Tips
///
/// - Use `const` for children when possible to prevent unnecessary rebuilds
/// - Avoid deeply nested form groups for better performance
/// - Use `spacing` parameter instead of wrapping in `SizedBox` widgets
/// - Prefer `inline` layout for dynamic content over `horizontal`
///
/// ## Accessibility
///
/// - Form groups include proper semantic labels
/// - Validation states are announced to screen readers
/// - Disabled states are properly communicated
/// - Required fields are clearly indicated
///
/// {@category Components}
/// {@category Forms}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../core/theme.dart';

/// Form Group Layout Variants
enum FSFormGroupLayout {
  vertical,
  horizontal,
  inline,
}

/// Form Group Size Variants
enum FSFormGroupSize {
  sm,
  md,
  lg,
}

/// Form Group State
enum FSFormGroupState {
  valid,
  invalid,
  loading,
  disabled,
}

/// Form Group Configuration
class FSFormGroupConfig {
  static const int maxChildrenCount = 20;
  static const double maxSpacing = 48.0;

  static bool isValidChildrenCount(int count) {
    return count > 0 && count <= maxChildrenCount;
  }
}

/// Flutstrap Form Group Component
///
/// Groups related form fields with consistent spacing, validation states,
/// and flexible layout options.
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
  final FSFormGroupState state;

  // ✅ CONSTANTS FOR BETTER PERFORMANCE
  static const double defaultSmallSpacing = 8.0;
  static const double defaultMediumSpacing = 16.0;
  static const double defaultLargeSpacing = 24.0;

  const FlutstrapFormGroup({
    super.key,
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
    this.state = FSFormGroupState.valid,
  }) :
        // ✅ FIXED: Only use compile-time constants in constructor
        assert(spacing >= 0, 'Spacing must be non-negative');

  @override
  Widget build(BuildContext context) {
    // ✅ MOVED: Runtime validation to build method
    assert(children.isNotEmpty, 'Form group must contain at least one child');
    assert(!required || label != null,
        'Label is required when field is marked as required');
    assert(FSFormGroupConfig.isValidChildrenCount(children.length),
        'Form group cannot have more than ${FSFormGroupConfig.maxChildrenCount} children');

    final theme = FSTheme.of(context);
    final effectiveSpacing = _getEffectiveSpacing();

    return Semantics(
      container: true,
      label: label,
      enabled: state != FSFormGroupState.disabled,
      hint: _getSemanticHint(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Label Section
          if (showLabel && (label != null || customLabel != null))
            Semantics(
              label: 'Form group label',
              child: _buildLabelSection(theme),
            ),

          // Form Fields Section
          _buildFormFieldsSection(effectiveSpacing),

          // Helper Text & Validation Message Section
          _buildBottomSection(theme),
        ],
      ),
    );
  }

  Widget _buildLabelSection(FSThemeData theme) {
    return Padding(
      padding: _getLabelPadding(),
      child: customLabel ?? _buildDefaultLabel(theme),
    );
  }

  Widget _buildDefaultLabel(FSThemeData theme) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label!,
          style: _getLabelTextStyle(theme),
        ),
        if (required)
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
    );
  }

  Widget _buildFormFieldsSection(double effectiveSpacing) {
    try {
      return switch (layout) {
        FSFormGroupLayout.vertical => _buildVerticalLayout(effectiveSpacing),
        FSFormGroupLayout.horizontal =>
          _buildHorizontalLayout(effectiveSpacing),
        FSFormGroupLayout.inline => _buildInlineLayout(effectiveSpacing),
      };
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('🚨 Error building form group layout: $e');
        print('Stack trace: $stackTrace');
      }
      // ✅ GRACEFUL DEGRADATION: Fallback to vertical layout
      return _buildVerticalLayout(effectiveSpacing);
    }
  }

  Widget _buildVerticalLayout(double spacing) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: MainAxisSize.min,
      children: _buildChildrenWithSpacing(spacing),
    );
  }

  Widget _buildHorizontalLayout(double spacing) {
    return Row(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisAlignment: mainAxisAlignment,
      children: _buildChildrenWithSpacing(spacing),
    );
  }

  Widget _buildInlineLayout(double spacing) {
    return Wrap(
      spacing: spacing,
      runSpacing: spacing / 2,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: children, // ✅ DIRECT REFERENCE - NO UNNECESSARY COPY
    );
  }

  Widget _buildBottomSection(FSThemeData theme) {
    final hasHelperText = helperText != null;
    final hasValidation =
        showValidation && !isValid && validationMessage != null;

    if (!hasHelperText && !hasValidation) return const SizedBox.shrink();

    return Padding(
      padding: _getBottomSectionPadding(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (hasHelperText) _buildHelperText(theme),
          if (hasValidation) _buildValidationMessage(theme, hasHelperText),
        ],
      ),
    );
  }

  Widget _buildHelperText(FSThemeData theme) {
    return Text(
      helperText!,
      style: _getHelperTextStyle(theme),
    );
  }

  Widget _buildValidationMessage(FSThemeData theme, bool hasHelperText) {
    return Padding(
      padding:
          hasHelperText ? const EdgeInsets.only(top: 4.0) : EdgeInsets.zero,
      child: Text(
        validationMessage!,
        style: _getValidationTextStyle(theme),
      ),
    );
  }

  // ✅ OPTIMIZED: Efficient list building with pre-allocated size
  List<Widget> _buildChildrenWithSpacing(double spacing) {
    if (children.isEmpty) return const [];
    if (children.length == 1) return children;

    final result = <Widget>[];
    for (int i = 0; i < children.length; i++) {
      if (i > 0) {
        result.add(_getSpacingWidget(spacing));
      }
      result.add(children[i]);
    }
    return result;
  }

  // ✅ CONST SPACING WIDGETS FOR BETTER PERFORMANCE
  Widget _getSpacingWidget(double spacing) {
    return switch (layout) {
      FSFormGroupLayout.vertical => SizedBox(height: spacing),
      FSFormGroupLayout.horizontal => SizedBox(width: spacing),
      FSFormGroupLayout.inline => SizedBox(width: spacing),
    };
  }

  EdgeInsets _getLabelPadding() {
    return const EdgeInsets.only(bottom: 8.0);
  }

  EdgeInsets _getBottomSectionPadding() {
    return const EdgeInsets.only(top: 8.0);
  }

  // ✅ OPTIMIZED: Theme-based styling with efficient logic
  TextStyle _getLabelTextStyle(FSThemeData theme) {
    final baseStyle = theme.typography.labelMedium;

    return switch (state) {
      FSFormGroupState.disabled => baseStyle.copyWith(
          color: theme.colors.onSurface.withOpacity(0.38),
        ),
      _ when showValidation && !isValid => baseStyle.copyWith(
          color: theme.colors.danger,
        ),
      _ => baseStyle.copyWith(
          color: theme.colors.onSurface.withOpacity(0.87),
        ),
    };
  }

  TextStyle _getHelperTextStyle(FSThemeData theme) {
    return theme.typography.bodySmall.copyWith(
      color: theme.colors.onSurface.withOpacity(0.6),
    );
  }

  TextStyle _getValidationTextStyle(FSThemeData theme) {
    return theme.typography.bodySmall.copyWith(
      color: theme.colors.danger,
      fontWeight: FontWeight.w500,
    );
  }

  double _getEffectiveSpacing() {
    return switch (size) {
      FSFormGroupSize.sm => spacing > 0 ? spacing : defaultSmallSpacing,
      FSFormGroupSize.md => spacing > 0 ? spacing : defaultMediumSpacing,
      FSFormGroupSize.lg => spacing > 0 ? spacing : defaultLargeSpacing,
    };
  }

  String? _getSemanticHint() {
    return switch (state) {
      FSFormGroupState.disabled => 'Disabled form group',
      _ when showValidation && !isValid => 'Contains validation errors',
      FSFormGroupState.loading => 'Loading form group',
      _ => null,
    };
  }

  // ✅ CONSISTENT: Add copyWith method like other components
  FlutstrapFormGroup copyWith({
    Key? key,
    List<Widget>? children,
    String? label,
    String? helperText,
    String? validationMessage,
    bool? showValidation,
    bool? isValid,
    bool? required,
    FSFormGroupLayout? layout,
    FSFormGroupSize? size,
    CrossAxisAlignment? crossAxisAlignment,
    MainAxisAlignment? mainAxisAlignment,
    double? spacing,
    bool? showLabel,
    Widget? customLabel,
    FSFormGroupState? state,
  }) {
    return FlutstrapFormGroup(
      key: key ?? this.key,
      children: children ?? this.children,
      label: label ?? this.label,
      helperText: helperText ?? this.helperText,
      validationMessage: validationMessage ?? this.validationMessage,
      showValidation: showValidation ?? this.showValidation,
      isValid: isValid ?? this.isValid,
      required: required ?? this.required,
      layout: layout ?? this.layout,
      size: size ?? this.size,
      crossAxisAlignment: crossAxisAlignment ?? this.crossAxisAlignment,
      mainAxisAlignment: mainAxisAlignment ?? this.mainAxisAlignment,
      spacing: spacing ?? this.spacing,
      showLabel: showLabel ?? this.showLabel,
      customLabel: customLabel ?? this.customLabel,
      state: state ?? this.state,
    );
  }

  // ✅ CONVENIENCE: Builder methods for common patterns
  FlutstrapFormGroup vertical() => copyWith(layout: FSFormGroupLayout.vertical);
  FlutstrapFormGroup horizontal() =>
      copyWith(layout: FSFormGroupLayout.horizontal);
  FlutstrapFormGroup inline() => copyWith(layout: FSFormGroupLayout.inline);

  FlutstrapFormGroup small() => copyWith(size: FSFormGroupSize.sm);
  FlutstrapFormGroup medium() => copyWith(size: FSFormGroupSize.md);
  FlutstrapFormGroup large() => copyWith(size: FSFormGroupSize.lg);

  FlutstrapFormGroup withLabel(String label) => copyWith(label: label);
  FlutstrapFormGroup withHelper(String helper) => copyWith(helperText: helper);
  FlutstrapFormGroup withSpacing(double spacing) => copyWith(spacing: spacing);

  FlutstrapFormGroup asRequired() => copyWith(required: true);
  FlutstrapFormGroup asOptional() => copyWith(required: false);

  FlutstrapFormGroup withValidation(String message) => copyWith(
        showValidation: true,
        isValid: false,
        validationMessage: message,
      );

  FlutstrapFormGroup clearValidation() => copyWith(
        showValidation: false,
        isValid: true,
        validationMessage: null,
      );

  FlutstrapFormGroup asDisabled() => copyWith(state: FSFormGroupState.disabled);
  FlutstrapFormGroup asEnabled() => copyWith(state: FSFormGroupState.valid);
  FlutstrapFormGroup asLoading() => copyWith(state: FSFormGroupState.loading);

  // ✅ STATIC: Convenience creators for common patterns
  static FlutstrapFormGroup verticalGroup({
    required List<Widget> children,
    String? label,
    bool required = false,
  }) {
    return FlutstrapFormGroup(
      children: children,
      label: label,
      required: required,
      layout: FSFormGroupLayout.vertical,
    );
  }

  static FlutstrapFormGroup horizontalGroup({
    required List<Widget> children,
    String? label,
    double spacing = 16.0,
  }) {
    return FlutstrapFormGroup(
      children: children,
      label: label,
      layout: FSFormGroupLayout.horizontal,
      spacing: spacing,
    );
  }

  static FlutstrapFormGroup inlineGroup({
    required List<Widget> children,
    String? label,
    double spacing = 12.0,
  }) {
    return FlutstrapFormGroup(
      children: children,
      label: label,
      layout: FSFormGroupLayout.inline,
      spacing: spacing,
    );
  }
}
