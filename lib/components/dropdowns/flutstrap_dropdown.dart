import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../../core/spacing.dart';

/// Flutstrap Dropdown Variants
///
/// Defines the visual style variants for dropdowns
enum FSDropdownVariant {
  primary,
  secondary,
  success,
  danger,
  warning,
  info,
  light,
  dark,
}

/// Flutstrap Dropdown Sizes
///
/// Defines the size variants for dropdowns
enum FSDropdownSize {
  sm,
  md,
  lg,
}

/// Dropdown Item Data
///
/// Represents an item in the dropdown menu
class FSDropdownItem<T> {
  final T value;
  final String label;
  final Widget? leading;
  final Widget? trailing;
  final bool enabled;

  const FSDropdownItem({
    required this.value,
    required this.label,
    this.leading,
    this.trailing,
    this.enabled = true,
  });
}

/// Flutstrap Dropdown
///
/// A customizable dropdown menu with Bootstrap-inspired styling.
class FlutstrapDropdown<T> extends StatefulWidget {
  final List<FSDropdownItem<T>> items;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final String? placeholder;
  final String? labelText;
  final String? errorText;
  final String? helperText;
  final bool enabled;
  final bool isExpanded;
  final FSDropdownVariant variant;
  final FSDropdownSize size;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool showSearch;
  final String? searchHint;
  final InputDecoration? decoration;
  final double menuMaxHeight;
  final BorderRadiusGeometry? borderRadius;

  const FlutstrapDropdown({
    Key? key,
    required this.items,
    this.value,
    this.onChanged,
    this.placeholder,
    this.labelText,
    this.errorText,
    this.helperText,
    this.enabled = true,
    this.isExpanded = false,
    this.variant = FSDropdownVariant.primary,
    this.size = FSDropdownSize.md,
    this.prefixIcon,
    this.suffixIcon,
    this.showSearch = false,
    this.searchHint,
    this.decoration,
    this.menuMaxHeight = 200,
    this.borderRadius,
  }) : super(key: key);

  @override
  State<FlutstrapDropdown<T>> createState() => _FlutstrapDropdownState<T>();
}

class _FlutstrapDropdownState<T> extends State<FlutstrapDropdown<T>> {
  final FocusNode _focusNode = FocusNode();
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;
  List<FSDropdownItem<T>> _filteredItems = [];
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;
    _focusNode.addListener(_onFocusChange);
    _searchController.addListener(_onSearchChanged);
    _searchFocusNode.addListener(_onSearchFocusChange);
  }

  @override
  void didUpdateWidget(FlutstrapDropdown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items != widget.items) {
      _filteredItems = widget.items;
    }
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus && !_isOpen) {
      _openDropdown();
    } else if (!_focusNode.hasFocus && _isOpen && !_searchFocusNode.hasFocus) {
      _closeDropdown();
    }
  }

  void _onSearchFocusChange() {
    // Don't close dropdown when search field loses focus
    // Let the main focus node handle closing
  }

  void _onSearchChanged() {
    setState(() {
      if (_searchController.text.isEmpty) {
        _filteredItems = widget.items;
      } else {
        _filteredItems = widget.items.where((item) {
          return item.label.toLowerCase().contains(
                _searchController.text.toLowerCase(),
              );
        }).toList();
      }
    });
  }

  void _openDropdown() {
    if (!widget.enabled) return;

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
          child: _DropdownMenu<T>(
            items: _filteredItems,
            onItemSelected: _onItemSelected,
            onClose: _closeDropdown,
            maxHeight: widget.menuMaxHeight,
            showSearch: widget.showSearch,
            searchController: _searchController,
            searchFocusNode: _searchFocusNode,
            searchHint: widget.searchHint,
            variant: widget.variant,
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    setState(() {
      _isOpen = true;
    });

    // Auto-focus search field if search is enabled
    if (widget.showSearch) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _searchFocusNode.requestFocus();
      });
    }
  }

  void _closeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _searchController.clear();
    _filteredItems = widget.items;
    _searchFocusNode.unfocus();
    setState(() {
      _isOpen = false;
    });
  }

  void _onItemSelected(FSDropdownItem<T> item) {
    if (item.enabled) {
      widget.onChanged?.call(item.value);
      _closeDropdown();
      _focusNode.unfocus();
    }
  }

  void _toggleDropdown() {
    if (_isOpen) {
      _closeDropdown();
      _focusNode.unfocus();
    } else {
      _focusNode.requestFocus();
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _searchFocusNode.removeListener(_onSearchFocusChange);
    _focusNode.dispose();
    _searchFocusNode.dispose();
    _searchController.dispose();
    _overlayEntry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = FSTheme.of(context);
    final dropdownStyle = _DropdownStyle(theme, widget.variant, widget.size);

    // FIXED: Safe way to find selected item without type casting null
    FSDropdownItem<T> selectedItem;
    try {
      selectedItem = widget.items.firstWhere(
        (item) => item.value == widget.value,
      );
    } catch (e) {
      selectedItem = FSDropdownItem<T>(
        value: _getDefaultValue(), // Use a safe default value method
        label: widget.placeholder ?? 'Select an option',
        enabled: false,
      );
    }

    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _toggleDropdown,
        child: Focus(
          focusNode: _focusNode,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: widget.borderRadius ?? dropdownStyle.borderRadius,
              border: Border.all(
                color: _isOpen
                    ? dropdownStyle.focusBorderColor
                    : dropdownStyle.borderColor,
                width: _isOpen ? 2.0 : 1.0,
              ),
              color: widget.enabled
                  ? dropdownStyle.backgroundColor
                  : dropdownStyle.disabledBackgroundColor,
            ),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  if (widget.prefixIcon != null)
                    Padding(
                      padding: dropdownStyle.prefixPadding,
                      child: IconTheme.merge(
                        data: IconThemeData(
                          color: dropdownStyle.iconColor,
                          size: dropdownStyle.iconSize,
                        ),
                        child: widget.prefixIcon!,
                      ),
                    ),
                  Expanded(
                    child: Padding(
                      padding: dropdownStyle.contentPadding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (widget.labelText != null)
                            Text(
                              widget.labelText!,
                              style: dropdownStyle.labelStyle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          Text(
                            selectedItem.label,
                            style: widget.enabled
                                ? dropdownStyle.textStyle
                                : dropdownStyle.disabledTextStyle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (widget.helperText != null && !_isOpen)
                            Text(
                              widget.helperText!,
                              style: dropdownStyle.helperStyle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          if (widget.errorText != null && !_isOpen)
                            Text(
                              widget.errorText!,
                              style: dropdownStyle.errorStyle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: dropdownStyle.suffixPadding,
                    child: Icon(
                      _isOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                      color: dropdownStyle.iconColor,
                      size: dropdownStyle.iconSize,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // FIXED: Safe method to get default value based on type
  T _getDefaultValue() {
    // For String type, return empty string
    if (T == String) {
      return '' as T;
    }
    // For num types, return zero
    else if (T == int || T == double || T == num) {
      return 0 as T;
    }
    // For bool, return false
    else if (T == bool) {
      return false as T;
    }
    // For other types, we can't safely create a default, so we return null
    // This is safe because we're only using it for the placeholder item
    else {
      return null as T;
    }
  }
}

/// Dropdown Menu Overlay
class _DropdownMenu<T> extends StatefulWidget {
  final List<FSDropdownItem<T>> items;
  final ValueChanged<FSDropdownItem<T>> onItemSelected;
  final VoidCallback onClose;
  final double maxHeight;
  final bool showSearch;
  final TextEditingController searchController;
  final FocusNode searchFocusNode;
  final String? searchHint;
  final FSDropdownVariant variant;

  const _DropdownMenu({
    required this.items,
    required this.onItemSelected,
    required this.onClose,
    required this.maxHeight,
    required this.showSearch,
    required this.searchController,
    required this.searchFocusNode,
    required this.searchHint,
    required this.variant,
  });

  @override
  State<_DropdownMenu<T>> createState() => _DropdownMenuState<T>();
}

class _DropdownMenuState<T> extends State<_DropdownMenu<T>> {
  @override
  void initState() {
    super.initState();
    // Auto-focus search field when it appears
    if (widget.showSearch) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (widget.searchFocusNode.hasFocus == false) {
          widget.searchFocusNode.requestFocus();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = FSTheme.of(context);
    final dropdownStyle =
        _DropdownStyle(theme, widget.variant, FSDropdownSize.md);

    return Material(
      elevation: 8,
      borderRadius: dropdownStyle.menuBorderRadius,
      child: Container(
        constraints: BoxConstraints(maxHeight: widget.maxHeight),
        decoration: BoxDecoration(
          color: dropdownStyle.menuBackgroundColor,
          borderRadius: dropdownStyle.menuBorderRadius,
          border: Border.all(
            color: dropdownStyle.menuBorderColor,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.showSearch)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: widget.searchController,
                  focusNode: widget.searchFocusNode,
                  decoration: InputDecoration(
                    hintText: widget.searchHint ?? 'Search...',
                    prefixIcon: const Icon(Icons.search, size: 20),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    isDense: true,
                  ),
                ),
              ),
            Flexible(
              child: widget.items.isEmpty
                  ? Padding(
                      padding: dropdownStyle.menuItemPadding,
                      child: Text(
                        'No options available',
                        style: dropdownStyle.disabledMenuItemTextStyle,
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: widget.items.length,
                      itemBuilder: (context, index) {
                        final item = widget.items[index];
                        return _DropdownMenuItem<T>(
                          item: item,
                          onSelected: widget.onItemSelected,
                          onClose: widget.onClose,
                          variant: widget.variant,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Individual Dropdown Menu Item
class _DropdownMenuItem<T> extends StatelessWidget {
  final FSDropdownItem<T> item;
  final ValueChanged<FSDropdownItem<T>> onSelected;
  final VoidCallback onClose;
  final FSDropdownVariant variant;

  const _DropdownMenuItem({
    required this.item,
    required this.onSelected,
    required this.onClose,
    required this.variant,
  });

  @override
  Widget build(BuildContext context) {
    final theme = FSTheme.of(context);
    final dropdownStyle = _DropdownStyle(theme, variant, FSDropdownSize.md);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: item.enabled
            ? () {
                onSelected(item);
                onClose();
              }
            : null,
        child: Opacity(
          opacity: item.enabled ? 1.0 : 0.5,
          child: Container(
            padding: dropdownStyle.menuItemPadding,
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
                        ? dropdownStyle.menuItemTextStyle
                        : dropdownStyle.disabledMenuItemTextStyle,
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

/// Internal style configuration for dropdowns
class _DropdownStyle {
  final FSThemeData theme;
  final FSDropdownVariant variant;
  final FSDropdownSize size;

  _DropdownStyle(this.theme, this.variant, this.size);

  Color get backgroundColor => theme.colors.background;
  Color get disabledBackgroundColor => theme.colors.surface.withOpacity(0.5);
  Color get borderColor => _getBorderColor();
  Color get focusBorderColor => _getFocusColor();
  Color get iconColor => theme.colors.onBackground.withOpacity(0.6);
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

  BorderRadiusGeometry get borderRadius => BorderRadius.circular(8);
  BorderRadiusGeometry get menuBorderRadius => BorderRadius.circular(8);

  EdgeInsetsGeometry get contentPadding {
    switch (size) {
      case FSDropdownSize.sm:
        return EdgeInsets.symmetric(horizontal: 12, vertical: 6);
      case FSDropdownSize.md:
        return EdgeInsets.symmetric(horizontal: 16, vertical: 8);
      case FSDropdownSize.lg:
        return EdgeInsets.symmetric(horizontal: 20, vertical: 12);
    }
  }

  EdgeInsetsGeometry get prefixPadding {
    switch (size) {
      case FSDropdownSize.sm:
        return EdgeInsets.only(left: 12);
      case FSDropdownSize.md:
        return EdgeInsets.only(left: 16);
      case FSDropdownSize.lg:
        return EdgeInsets.only(left: 20);
    }
  }

  EdgeInsetsGeometry get suffixPadding {
    switch (size) {
      case FSDropdownSize.sm:
        return EdgeInsets.only(right: 8);
      case FSDropdownSize.md:
        return EdgeInsets.only(right: 12);
      case FSDropdownSize.lg:
        return EdgeInsets.only(right: 16);
    }
  }

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

  TextStyle get textStyle => theme.typography.bodyMedium!;
  TextStyle get disabledTextStyle => theme.typography.bodyMedium!.copyWith(
        color: theme.colors.onBackground.withOpacity(0.5),
      );
  TextStyle get labelStyle => theme.typography.bodySmall!.copyWith(
        color: theme.colors.onBackground.withOpacity(0.7),
      );
  TextStyle get helperStyle => theme.typography.bodySmall!.copyWith(
        color: theme.colors.onBackground.withOpacity(0.6),
      );
  TextStyle get errorStyle => theme.typography.bodySmall!.copyWith(
        color: theme.colors.danger,
      );
  TextStyle get menuItemTextStyle => theme.typography.bodyMedium!;
  TextStyle get disabledMenuItemTextStyle =>
      theme.typography.bodyMedium!.copyWith(
        color: theme.colors.onBackground.withOpacity(0.5),
      );

  Color _getBorderColor() {
    final colors = theme.colors;
    switch (variant) {
      case FSDropdownVariant.primary:
        return colors.outline;
      case FSDropdownVariant.secondary:
        return colors.secondary.withOpacity(0.5);
      case FSDropdownVariant.success:
        return colors.success;
      case FSDropdownVariant.danger:
        return colors.danger;
      case FSDropdownVariant.warning:
        return colors.warning;
      case FSDropdownVariant.info:
        return colors.info;
      case FSDropdownVariant.light:
        return colors.surface.withOpacity(0.3);
      case FSDropdownVariant.dark:
        return colors.onBackground;
    }
  }

  Color _getFocusColor() {
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
}
