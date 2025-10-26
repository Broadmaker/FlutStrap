import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../../core/spacing.dart';

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
    Key? key,
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = FSTheme.of(context);
    final modalStyle = _ModalStyle(theme, variant, size);

    return Dialog(
      backgroundColor: backgroundColor ?? modalStyle.backgroundColor,
      elevation: elevation ?? modalStyle.elevation,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? modalStyle.borderRadius,
      ),
      insetPadding: modalStyle.insetPadding as EdgeInsets, // Fixed: Added cast
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
    );
  }

  Widget _buildHeader(BuildContext context, _ModalStyle modalStyle) {
    return Container(
      padding: modalStyle.headerPadding as EdgeInsets, // Fixed: Added cast
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
              icon:
                  Icon(Icons.close, size: 20, color: modalStyle.closeIconColor),
              onPressed: () {
                if (dismissible) {
                  Navigator.of(context).pop();
                  onDismiss?.call();
                }
              },
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
            ),
        ],
      ),
    );
  }

  Widget _buildContent(_ModalStyle modalStyle) {
    return Flexible(
      child: Container(
        padding: (padding ?? modalStyle.contentPadding)
            as EdgeInsets, // Fixed: Added cast
        child: DefaultTextStyle(
          style: modalStyle.contentStyle,
          child: content!,
        ),
      ),
    );
  }

  Widget _buildActions(_ModalStyle modalStyle) {
    return Container(
      padding: modalStyle.actionsPadding as EdgeInsets, // Fixed: Added cast
      decoration: BoxDecoration(
        color: modalStyle.actionsBackgroundColor,
        borderRadius: modalStyle.actionsBorderRadius,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: actions!
            .map((action) => Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0), // Fixed: Using constant
                  child: action,
                ))
            .toList(),
      ),
    );
  }
}

/// Internal style configuration for modals
class _ModalStyle {
  final FSThemeData theme;
  final FSModalVariant variant;
  final FSModalSize size;

  _ModalStyle(this.theme, this.variant, this.size);

  Color get backgroundColor => theme.colors.background;
  Color get headerBackgroundColor => _getHeaderColor();
  Color get actionsBackgroundColor =>
      theme.colors.surface.withOpacity(0.1); // Fixed: Replaced surfaceVariant
  Color get closeIconColor =>
      theme.colors.onBackground.withOpacity(0.6); // Fixed: Replaced onSurface

  double get elevation => 24.0;

  BorderRadiusGeometry get borderRadius => BorderRadius.circular(12.0);
  BorderRadiusGeometry get headerBorderRadius => BorderRadius.only(
        topLeft: Radius.circular(12.0),
        topRight: Radius.circular(12.0),
      );
  BorderRadiusGeometry get actionsBorderRadius => BorderRadius.only(
        bottomLeft: Radius.circular(12.0),
        bottomRight: Radius.circular(12.0),
      );

  EdgeInsetsGeometry get insetPadding => EdgeInsets.all(FSSpacing.lg);
  EdgeInsetsGeometry get headerPadding => EdgeInsets.symmetric(
        horizontal: _getContentPadding(),
        vertical: FSSpacing.md,
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

  TextStyle get titleStyle => theme.typography.headlineSmall!.copyWith(
        color: _getTitleColor(),
        fontWeight: FontWeight.w600,
      );

  TextStyle get contentStyle => theme.typography.bodyMedium!;

  double _getContentPadding() {
    switch (size) {
      case FSModalSize.sm:
        return FSSpacing.md;
      case FSModalSize.md:
      case FSModalSize.lg:
      case FSModalSize.xl:
        return FSSpacing.lg;
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
        return colors.surface; // Fixed: Replaced surfaceVariant
      case FSModalVariant.dark:
        return colors.onBackground; // Fixed: Replaced onSurface
    }
  }

  Color _getTitleColor() {
    switch (variant) {
      case FSModalVariant.light:
        return theme.colors.onBackground; // Fixed: Replaced onSurface
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
        actions: actions ??
            [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ],
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
    Key? key,
    required this.child,
    this.modalTitle,
    this.modalContent,
    this.modalActions,
    this.modalVariant = FSModalVariant.primary,
    this.modalSize = FSModalSize.md,
    this.dismissible = true,
  }) : super(key: key);

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
