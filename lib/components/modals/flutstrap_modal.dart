/// Flutstrap Modal
///
/// A customizable modal dialog with Bootstrap-inspired styling,
/// multiple variants, sizes, and built-in service methods for
/// common modal patterns.
///
/// ## Usage Examples
///
/// ```dart
/// // Basic modal
/// FlutstrapModal(
///   title: Text('Modal Title'),
///   content: Text('Modal content goes here...'),
///   actions: [
///     TextButton(
///       onPressed: () => Navigator.pop(context),
///       child: Text('Cancel'),
///     ),
///     FilledButton(
///       onPressed: () => Navigator.pop(context),
///       child: Text('Save'),
///     ),
///   ],
/// )
///
/// // Using modal service
/// FlutstrapModalService.showConfirmModal(
///   context: context,
///   title: 'Confirm Action',
///   content: 'Are you sure you want to proceed?',
///   confirmText: 'Yes, proceed',
///   cancelText: 'Cancel',
/// ).then((confirmed) {
///   if (confirmed) {
///     // Handle confirmation
///   }
/// });
/// ```
///
/// {@category Components}
/// {@category Overlays}

import 'package:flutter/material.dart';
import '../../core/theme.dart';

/// Flutstrap Modal Variants
///
/// Defines the visual style variants for modals
enum FSModalVariant {
  primary,
  secondary,
  success,
  danger,
  warning,
  info,
  light,
  dark,
}

/// Flutstrap Modal Sizes
///
/// Defines the size variants for modals
enum FSModalSize {
  sm,
  md,
  lg,
  xl,
}

/// Flutstrap Modal
///
/// A customizable modal dialog with Bootstrap-inspired styling.
class FlutstrapModal extends StatelessWidget {
  final Widget? title;
  final Widget? content;
  final List<Widget>? actions;
  final bool dismissible;
  final bool showCloseButton;
  final VoidCallback? onDismiss;
  final FSModalVariant variant;
  final FSModalSize size;
  final Color? backgroundColor;
  final double? elevation;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;

  const FlutstrapModal({
    super.key,
    this.title,
    this.content,
    this.actions,
    this.dismissible = true,
    this.showCloseButton = true,
    this.onDismiss,
    this.variant = FSModalVariant.primary,
    this.size = FSModalSize.md,
    this.backgroundColor,
    this.elevation,
    this.borderRadius,
    this.padding,
  }) : assert(content != null || title != null,
            'Modal must have either title or content');

  @override
  Widget build(BuildContext context) {
    final theme = FSTheme.of(context);
    final modalStyle = _ModalStyle(theme, variant, size);

    return Semantics(
      label: 'Dialog',
      hint: 'Double tap to dismiss', // Optional: Add helpful hint
      child: Dialog(
        backgroundColor: backgroundColor ?? modalStyle.backgroundColor,
        elevation: elevation ?? modalStyle.elevation,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? modalStyle.borderRadius,
        ),
        insetPadding: _resolveEdgeInsets(modalStyle.insetPadding),
        child: Container(
          constraints: modalStyle.constraints,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              if (title != null || showCloseButton)
                _buildHeader(context, modalStyle),

              // Content
              if (content != null) _buildContent(modalStyle),

              // Actions
              if (actions != null && actions!.isNotEmpty)
                _buildActions(modalStyle),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, _ModalStyle modalStyle) {
    return Container(
      padding: _resolveEdgeInsets(modalStyle.headerPadding),
      decoration: BoxDecoration(
        color: modalStyle.headerBackgroundColor,
        borderRadius: modalStyle.headerBorderRadius,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: DefaultTextStyle(
              style: modalStyle.titleStyle,
              child: title ?? const SizedBox.shrink(),
            ),
          ),
          if (showCloseButton)
            IconButton(
              icon: Icon(
                Icons.close,
                size: 20,
                color: modalStyle.closeIconColor,
              ),
              onPressed: () {
                if (dismissible) {
                  Navigator.of(context).pop();
                  onDismiss?.call();
                }
              },
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
              tooltip: 'Close',
            ),
        ],
      ),
    );
  }

  Widget _buildContent(_ModalStyle modalStyle) {
    return Flexible(
      child: Container(
        padding: _resolveEdgeInsets(padding ?? modalStyle.contentPadding),
        child: DefaultTextStyle(
          style: modalStyle.contentStyle,
          child: content!,
        ),
      ),
    );
  }

  Widget _buildActions(_ModalStyle modalStyle) {
    return Container(
      padding: _resolveEdgeInsets(modalStyle.actionsPadding),
      decoration: BoxDecoration(
        color: modalStyle.actionsBackgroundColor,
        borderRadius: modalStyle.actionsBorderRadius,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: _buildActionChildren(),
      ),
    );
  }

  List<Widget> _buildActionChildren() {
    if (actions == null || actions!.isEmpty) return [];

    return List.generate(
      actions!.length,
      (index) => Padding(
        padding: EdgeInsets.only(left: index > 0 ? 8.0 : 0.0),
        child: actions![index],
      ),
    );
  }

  // ✅ SAFE: Resolve EdgeInsetsGeometry to EdgeInsets
  EdgeInsets _resolveEdgeInsets(EdgeInsetsGeometry geometry) {
    return geometry.resolve(TextDirection.ltr);
  }

  // ✅ CONSISTENT: Add copyWith method
  FlutstrapModal copyWith({
    Key? key,
    Widget? title,
    Widget? content,
    List<Widget>? actions,
    bool? dismissible,
    bool? showCloseButton,
    VoidCallback? onDismiss,
    FSModalVariant? variant,
    FSModalSize? size,
    Color? backgroundColor,
    double? elevation,
    BorderRadiusGeometry? borderRadius,
    EdgeInsetsGeometry? padding,
  }) {
    return FlutstrapModal(
      key: key ?? this.key,
      title: title ?? this.title,
      content: content ?? this.content,
      actions: actions ?? this.actions,
      dismissible: dismissible ?? this.dismissible,
      showCloseButton: showCloseButton ?? this.showCloseButton,
      onDismiss: onDismiss ?? this.onDismiss,
      variant: variant ?? this.variant,
      size: size ?? this.size,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      elevation: elevation ?? this.elevation,
      borderRadius: borderRadius ?? this.borderRadius,
      padding: padding ?? this.padding,
    );
  }

  // ✅ CONVENIENCE: Builder methods
  FlutstrapModal primary() => copyWith(variant: FSModalVariant.primary);
  FlutstrapModal success() => copyWith(variant: FSModalVariant.success);
  FlutstrapModal danger() => copyWith(variant: FSModalVariant.danger);
  FlutstrapModal small() => copyWith(size: FSModalSize.sm);
  FlutstrapModal large() => copyWith(size: FSModalSize.lg);
  FlutstrapModal withTitle(Widget title) => copyWith(title: title);
  FlutstrapModal withContent(Widget content) => copyWith(content: content);
}

/// Internal style configuration for modals
class _ModalStyle {
  final FSThemeData theme;
  final FSModalVariant variant;
  final FSModalSize size;

  _ModalStyle(this.theme, this.variant, this.size);

  // ✅ OPTIMIZED: Memoize expensive calculations
  late final Color _headerColor = _getHeaderColor();
  late final Color _titleColor = _getTitleColor();

  Color get backgroundColor => theme.colors.background;
  Color get headerBackgroundColor => _headerColor;
  Color get actionsBackgroundColor => theme.colors.surface.withOpacity(0.05);
  Color get closeIconColor => theme.colors.onBackground.withOpacity(0.6);

  double get elevation => 24.0;

  BorderRadiusGeometry get borderRadius => BorderRadius.circular(12.0);
  BorderRadiusGeometry get headerBorderRadius => const BorderRadius.only(
        topLeft: Radius.circular(12.0),
        topRight: Radius.circular(12.0),
      );
  BorderRadiusGeometry get actionsBorderRadius => const BorderRadius.only(
        bottomLeft: Radius.circular(12.0),
        bottomRight: Radius.circular(12.0),
      );

  EdgeInsetsGeometry get insetPadding => const EdgeInsets.all(24.0);
  EdgeInsetsGeometry get headerPadding => EdgeInsets.symmetric(
        horizontal: _getContentPadding(),
        vertical: 16.0,
      );
  EdgeInsetsGeometry get contentPadding => EdgeInsets.all(_getContentPadding());
  EdgeInsetsGeometry get actionsPadding => EdgeInsets.all(_getContentPadding());

  BoxConstraints get constraints {
    switch (size) {
      case FSModalSize.sm:
        return const BoxConstraints(maxWidth: 300);
      case FSModalSize.md:
        return const BoxConstraints(maxWidth: 500);
      case FSModalSize.lg:
        return const BoxConstraints(maxWidth: 800);
      case FSModalSize.xl:
        return const BoxConstraints(maxWidth: 1140);
    }
  }

  TextStyle get titleStyle => theme.typography.headlineSmall.copyWith(
        color: _titleColor,
        fontWeight: FontWeight.w600,
      );

  TextStyle get contentStyle => theme.typography.bodyMedium;

  double _getContentPadding() {
    switch (size) {
      case FSModalSize.sm:
        return 16.0;
      case FSModalSize.md:
      case FSModalSize.lg:
      case FSModalSize.xl:
        return 24.0;
    }
  }

  Color _getHeaderColor() {
    final colors = theme.colors;
    switch (variant) {
      case FSModalVariant.primary:
        return colors.primary;
      case FSModalVariant.secondary:
        return colors.secondary;
      case FSModalVariant.success:
        return colors.success;
      case FSModalVariant.danger:
        return colors.danger;
      case FSModalVariant.warning:
        return colors.warning;
      case FSModalVariant.info:
        return colors.info;
      case FSModalVariant.light:
        return colors.surface;
      case FSModalVariant.dark:
        return colors.onBackground;
    }
  }

  Color _getTitleColor() {
    switch (variant) {
      case FSModalVariant.light:
        return theme.colors.onBackground;
      case FSModalVariant.dark:
        return theme.colors.background;
      default:
        return theme.colors.onPrimary;
    }
  }
}

/// Service for showing Flutstrap modals
class FlutstrapModalService {
  /// Shows a basic modal with title and content
  static void showModal({
    required BuildContext context,
    required String title,
    required String content,
    List<Widget>? actions,
    FSModalVariant variant = FSModalVariant.primary,
    FSModalSize size = FSModalSize.md,
    bool dismissible = true,
  }) {
    showDialog(
      context: context,
      barrierDismissible: dismissible,
      builder: (context) => FlutstrapModal(
        title: Text(title),
        content: Text(content),
        actions: actions ?? _getDefaultActions(context),
        variant: variant,
        size: size,
        dismissible: dismissible,
      ),
    );
  }

  /// Shows a confirmation modal
  static Future<bool> showConfirmModal({
    required BuildContext context,
    required String title,
    required String content,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    FSModalVariant variant = FSModalVariant.primary,
    FSModalSize size = FSModalSize.md,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => FlutstrapModal(
        title: Text(title),
        content: Text(content),
        variant: variant,
        size: size,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(cancelText),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(confirmText),
          ),
        ],
      ),
    );

    return result ?? false;
  }

  /// Shows an alert modal
  static void showAlert({
    required BuildContext context,
    required String title,
    required String content,
    FSModalVariant variant = FSModalVariant.warning,
    FSModalSize size = FSModalSize.md,
  }) {
    showModal(
      context: context,
      title: title,
      content: content,
      variant: variant,
      size: size,
      actions: [
        FilledButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    );
  }

  /// Shows a success modal
  static void showSuccess({
    required BuildContext context,
    required String title,
    required String content,
    FSModalSize size = FSModalSize.md,
  }) {
    showModal(
      context: context,
      title: title,
      content: content,
      variant: FSModalVariant.success,
      size: size,
      actions: [
        FilledButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    );
  }

  /// Shows an error modal
  static void showError({
    required BuildContext context,
    required String title,
    required String content,
    FSModalSize size = FSModalSize.md,
  }) {
    showModal(
      context: context,
      title: title,
      content: content,
      variant: FSModalVariant.danger,
      size: size,
      actions: [
        FilledButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    );
  }

  /// Shows a custom modal with any content
  static void showCustomModal({
    required BuildContext context,
    required Widget content,
    Widget? title,
    List<Widget>? actions,
    FSModalVariant variant = FSModalVariant.primary,
    FSModalSize size = FSModalSize.md,
    bool dismissible = true,
  }) {
    showDialog(
      context: context,
      barrierDismissible: dismissible,
      builder: (context) => FlutstrapModal(
        title: title,
        content: content,
        actions: actions,
        variant: variant,
        size: size,
        dismissible: dismissible,
      ),
    );
  }

  // ✅ HELPER: Default actions for modal
  static List<Widget> _getDefaultActions(BuildContext context) {
    return [
      TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: const Text('Close'),
      ),
    ];
  }
}

/// A button that triggers a modal when pressed
class FlutstrapModalTrigger extends StatelessWidget {
  final Widget child;
  final Widget? modalTitle;
  final Widget? modalContent;
  final List<Widget>? modalActions;
  final FSModalVariant modalVariant;
  final FSModalSize modalSize;
  final bool dismissible;

  const FlutstrapModalTrigger({
    super.key,
    required this.child,
    this.modalTitle,
    this.modalContent,
    this.modalActions,
    this.modalVariant = FSModalVariant.primary,
    this.modalSize = FSModalSize.md,
    this.dismissible = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showModal(context),
      child: child,
    );
  }

  void _showModal(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: dismissible,
      builder: (context) => FlutstrapModal(
        title: modalTitle,
        content: modalContent,
        actions: modalActions,
        variant: modalVariant,
        size: modalSize,
        dismissible: dismissible,
      ),
    );
  }
}
