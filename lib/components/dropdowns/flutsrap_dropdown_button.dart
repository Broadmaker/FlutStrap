/* import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../../core/spacing.dart';
import 'flutstrap_dropdown_variant.dart';

/// Flutstrap Dropdown Button
///
/// A button that triggers a dropdown menu when pressed.
class FlutstrapDropdownButton<T> extends StatefulWidget {
  final List<FSDropdownItem<T>> items;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final String? placeholder;
  final Widget? child;
  final bool enabled;
  final FSDropdownVariant variant;
  final FSDropdownSize size;
  final bool isExpanded;
  final AlignmentGeometry alignment;
  final EdgeInsetsGeometry padding;
  final double menuMaxHeight;
  final BorderRadiusGeometry? borderRadius;

  const FlutstrapDropdownButton({
    Key? key,
    required this.items,
    this.value,
    this.onChanged,
    this.placeholder,
    this.child,
    this.enabled = true,
    this.variant = FSDropdownVariant.primary,
    this.size = FSDropdownSize.md,
    this.isExpanded = false,
    this.alignment = AlignmentDirectional.centerStart,
    this.padding = EdgeInsets.zero,
    this.menuMaxHeight = 200,
    this.borderRadius,
  }) : super(key: key);

  @override
  State<FlutstrapDropdownButton<T>> createState() =>
      _FlutstrapDropdownButtonState<T>();
}

class _FlutstrapDropdownButtonState<T>
    extends State<FlutstrapDropdownButton<T>> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;

  void _toggleDropdown() {
    if (!widget.enabled) return;

    if (_isOpen) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy + size.height + 4,
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height + 4),
          child: _DropdownButtonMenu<T>(
            items: widget.items,
            onItemSelected: _onItemSelected,
            maxHeight: widget.menuMaxHeight,
            variant: widget.variant,
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    setState(() {
      _isOpen = true;
    });
  }

  void _closeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() {
      _isOpen = false;
    });
  }

  void _onItemSelected(FSDropdownItem<T> item) {
    if (item.enabled) {
      widget.onChanged?.call(item.value);
      _closeDropdown();
    }
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = FSTheme.of(context);
    final buttonStyle =
        _DropdownButtonStyle(theme, widget.variant, widget.size);

    final selectedItem = widget.items.firstWhere(
      (item) => item.value == widget.value,
      orElse: () => FSDropdownItem<T>(
        value: null as T,
        label: widget.placeholder ?? 'Select an option',
        enabled: false,
      ),
    );

    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _toggleDropdown,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius ?? buttonStyle.borderRadius,
            color: widget.enabled
                ? buttonStyle.backgroundColor
                : buttonStyle.disabledBackgroundColor,
            border: Border.all(
              color: _isOpen
                  ? buttonStyle.focusBorderColor
                  : buttonStyle.borderColor,
              width: _isOpen ? 2.0 : 1.0,
            ),
          ),
          padding: widget.padding,
          child: Row(
            mainAxisSize:
                widget.isExpanded ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Align(
                  alignment: widget.alignment,
                  child: widget.child ??
                      Text(
                        selectedItem.label,
                        style: widget.enabled
                            ? buttonStyle.textStyle
                            : buttonStyle.disabledTextStyle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                ),
              ),
              Padding(
                padding: buttonStyle.iconPadding,
                child: Icon(
                  _isOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  color: widget.enabled
                      ? buttonStyle.iconColor
                      : buttonStyle.disabledIconColor,
                  size: buttonStyle.iconSize,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Dropdown Button Menu Overlay
class _DropdownButtonMenu<T> extends StatelessWidget {
  final List<FSDropdownItem<T>> items;
  final ValueChanged<FSDropdownItem<T>> onItemSelected;
  final double maxHeight;
  final FSDropdownVariant variant;

  const _DropdownButtonMenu({
    required this.items,
    required this.onItemSelected,
    required this.maxHeight,
    required this.variant,
  });

  @override
  Widget build(BuildContext context) {
    final theme = FSTheme.of(context);
    final buttonStyle = _DropdownButtonStyle(theme, variant, FSDropdownSize.md);

    return Material(
      elevation: 8,
      borderRadius: buttonStyle.menuBorderRadius,
      child: Container(
        constraints: BoxConstraints(maxHeight: maxHeight),
        decoration: BoxDecoration(
          color: buttonStyle.menuBackgroundColor,
          borderRadius: buttonStyle.menuBorderRadius,
          border: Border.all(
            color: buttonStyle.menuBorderColor,
            width: 1,
          ),
        ),
        child: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return _DropdownButtonMenuItem<T>(
              item: item,
              onSelected: onItemSelected,
              variant: variant,
            );
          },
        ),
      ),
    );
  }
}

/// Individual Dropdown Button Menu Item
class _DropdownButtonMenuItem<T> extends StatelessWidget {
  final FSDropdownItem<T> item;
  final ValueChanged<FSDropdownItem<T>> onSelected;
  final FSDropdownVariant variant;

  const _DropdownButtonMenuItem({
    required this.item,
    required this.onSelected,
    required this.variant,
  });

  @override
  Widget build(BuildContext context) {
    final theme = FSTheme.of(context);
    final buttonStyle = _DropdownButtonStyle(theme, variant, FSDropdownSize.md);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: item.enabled ? () => onSelected(item) : null,
        child: Opacity(
          opacity: item.enabled ? 1.0 : 0.5,
          child: Container(
            padding: buttonStyle.menuItemPadding,
            child: Row(
              children: [
                if (item.leading != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: item.leading!,
                  ),
                Expanded(
                  child: Text(
                    item.label,
                    style: item.enabled
                        ? buttonStyle.menuItemTextStyle
                        : buttonStyle.disabledMenuItemTextStyle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (item.trailing != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: item.trailing!,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Internal style configuration for dropdown buttons
class _DropdownButtonStyle {
  final FSThemeData theme;
  final FSDropdownVariant variant;
  final FSDropdownSize size;

  _DropdownButtonStyle(this.theme, this.variant, this.size);

  Color get backgroundColor => _getBackgroundColor();
  Color get disabledBackgroundColor => theme.colors.surface.withOpacity(0.5);
  Color get borderColor => _getBorderColor();
  Color get focusBorderColor => _getFocusColor();
  Color get iconColor => _getIconColor();
  Color get disabledIconColor => theme.colors.onBackground.withOpacity(0.3);
  Color get menuBackgroundColor => theme.colors.background;
  Color get menuBorderColor => theme.colors.outline;

  double get iconSize {
    switch (size) {
      case FSDropdownSize.sm:
        return 16;
      case FSDropdownSize.md:
        return 20;
      case FSDropdownSize.lg:
        return 24;
    }
  }

  EdgeInsetsGeometry get iconPadding {
    switch (size) {
      case FSDropdownSize.sm:
        return EdgeInsets.only(left: 8);
      case FSDropdownSize.md:
        return EdgeInsets.only(left: 12);
      case FSDropdownSize.lg:
        return EdgeInsets.only(left: 16);
    }
  }

  BorderRadiusGeometry get borderRadius => BorderRadius.circular(8);
  BorderRadiusGeometry get menuBorderRadius => BorderRadius.circular(8);

  EdgeInsetsGeometry get menuItemPadding {
    switch (size) {
      case FSDropdownSize.sm:
        return EdgeInsets.symmetric(horizontal: 12, vertical: 8);
      case FSDropdownSize.md:
        return EdgeInsets.symmetric(horizontal: 16, vertical: 12);
      case FSDropdownSize.lg:
        return EdgeInsets.symmetric(horizontal: 20, vertical: 16);
    }
  }

  TextStyle get textStyle => theme.typography.bodyMedium!.copyWith(
        color: _getTextColor(),
      );
  TextStyle get disabledTextStyle => theme.typography.bodyMedium!.copyWith(
        color: theme.colors.onBackground.withOpacity(0.5),
      );
  TextStyle get menuItemTextStyle => theme.typography.bodyMedium!;
  TextStyle get disabledMenuItemTextStyle =>
      theme.typography.bodyMedium!.copyWith(
        color: theme.colors.onBackground.withOpacity(0.5),
      );

  Color _getBackgroundColor() {
    final colors = theme.colors;
    switch (variant) {
      case FSDropdownVariant.primary:
        return colors.primary;
      case FSDropdownVariant.secondary:
        return colors.secondary;
      case FSDropdownVariant.success:
        return colors.success;
      case FSDropdownVariant.danger:
        return colors.danger;
      case FSDropdownVariant.warning:
        return colors.warning;
      case FSDropdownVariant.info:
        return colors.info;
      case FSDropdownVariant.light:
        return colors.surface;
      case FSDropdownVariant.dark:
        return colors.onBackground;
    }
  }

  Color _getBorderColor() {
    final colors = theme.colors;
    switch (variant) {
      case FSDropdownVariant.primary:
        return colors.primary;
      case FSDropdownVariant.secondary:
        return colors.secondary;
      case FSDropdownVariant.success:
        return colors.success;
      case FSDropdownVariant.danger:
        return colors.danger;
      case FSDropdownVariant.warning:
        return colors.warning;
      case FSDropdownVariant.info:
        return colors.info;
      case FSDropdownVariant.light:
        return colors.outline;
      case FSDropdownVariant.dark:
        return colors.onBackground;
    }
  }

  Color _getFocusColor() {
    final colors = theme.colors;
    switch (variant) {
      case FSDropdownVariant.primary:
        return colors.primary.withOpacity(0.8);
      case FSDropdownVariant.secondary:
        return colors.secondary.withOpacity(0.8);
      case FSDropdownVariant.success:
        return colors.success.withOpacity(0.8);
      case FSDropdownVariant.danger:
        return colors.danger.withOpacity(0.8);
      case FSDropdownVariant.warning:
        return colors.warning.withOpacity(0.8);
      case FSDropdownVariant.info:
        return colors.info.withOpacity(0.8);
      case FSDropdownVariant.light:
        return colors.outline;
      case FSDropdownVariant.dark:
        return colors.onBackground.withOpacity(0.8);
    }
  }

  Color _getIconColor() {
    switch (variant) {
      case FSDropdownVariant.light:
        return theme.colors.onBackground;
      case FSDropdownVariant.dark:
        return theme.colors.background;
      default:
        return theme.colors.onPrimary;
    }
  }

  Color _getTextColor() {
    switch (variant) {
      case FSDropdownVariant.light:
        return theme.colors.onBackground;
      case FSDropdownVariant.dark:
        return theme.colors.background;
      default:
        return theme.colors.onPrimary;
    }
  }
}
 */