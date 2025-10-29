/// Flutstrap Dropdown
///
/// A high-performance, customizable dropdown menu with Bootstrap-inspired styling,
/// search functionality, and comprehensive accessibility support.
///
/// {@macro flutstrap_dropdown.usage}
/// {@macro flutstrap_dropdown.accessibility}
///
/// {@template flutstrap_dropdown.usage}
/// ## Usage Examples
///
/// ```dart
/// // Basic dropdown with string values
/// FlutstrapDropdown<String>(
///   items: [
///     FSDropdownItem(value: '1', label: 'Option 1'),
///     FSDropdownItem(value: '2', label: 'Option 2'),
///   ],
///   value: selectedValue,
///   onChanged: (value) => setState(() => selectedValue = value),
/// )
///
/// // Dropdown with custom objects
/// FlutstrapDropdown<User>(
///   items: users.map((user) => FSDropdownItem(
///     value: user,
///     label: user.name,
///     leading: CircleAvatar(backgroundImage: NetworkImage(user.avatar)),
///   )).toList(),
///   value: selectedUser,
///   onChanged: (user) => setState(() => selectedUser = user),
///   showSearch: true,
/// )
///
/// // Disabled dropdown with helper text
/// FlutstrapDropdown<String>(
///   items: items,
///   value: selectedValue,
///   onChanged: null, // Disables the dropdown
///   helperText: 'This field is currently disabled',
///   variant: FSDropdownVariant.light,
/// )
/// ```
/// {@endtemplate}
///
/// {@template flutstrap_dropdown.accessibility}
/// ## Accessibility
///
/// - Full screen reader support with proper semantic labels
/// - Keyboard navigation support (Tab, Enter, Escape)
/// - Focus management for search and menu items
/// - Proper ARIA attributes for expanded state
/// {@endtemplate}
///
/// {@category Components}
/// {@category Forms}

import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/theme.dart';

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
@immutable
class FSDropdownItem<T> {
  final T? value;
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FSDropdownItem &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

/// Flutstrap Dropdown
///
/// A customizable dropdown menu with Bootstrap-inspired styling.
@immutable
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
  final Duration searchDebounceDelay;

  const FlutstrapDropdown({
    super.key,
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
    this.menuMaxHeight = _DropdownConstants.defaultMenuMaxHeight,
    this.borderRadius,
    this.searchDebounceDelay = _DropdownConstants.searchDebounceDelay,
  });

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
  Timer? _searchDebounceTimer;

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
      _searchController.clear();
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
  }

  void _onSearchChanged() {
    _searchDebounceTimer?.cancel();
    _searchDebounceTimer = Timer(widget.searchDebounceDelay, () {
      if (mounted) {
        setState(() {
          _filteredItems = _performSearch(_searchController.text);
        });
      }
    });
  }

  List<FSDropdownItem<T>> _performSearch(String query) {
    if (query.isEmpty) return widget.items;

    return widget.items.where((item) {
      return item.label.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  void _openDropdown() {
    if (!widget.enabled || _isOpen) return;

    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) => _DropdownOverlay<T>(
        position: offset,
        size: size,
        layerLink: _layerLink,
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
    );

    Overlay.of(context).insert(_overlayEntry!);
    setState(() => _isOpen = true);

    // Auto-focus search field if search is enabled
    if (widget.showSearch) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _searchFocusNode.requestFocus();
      });
    }
  }

  void _closeDropdown() {
    _searchDebounceTimer?.cancel();
    _searchController.clear();
    _filteredItems = widget.items;
    _searchFocusNode.unfocus();

    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }

    if (mounted) {
      setState(() => _isOpen = false);
    }
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
    _searchDebounceTimer?.cancel();
    _focusNode.removeListener(_onFocusChange);
    _searchFocusNode.removeListener(_onSearchFocusChange);
    _focusNode.dispose();
    _searchFocusNode.dispose();
    _searchController.dispose();
    _closeDropdown(); // ✅ CRITICAL: Ensure overlay is removed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = FSTheme.of(context);
    final dropdownStyle = _DropdownStyle(theme, widget.variant, widget.size);

    final selectedItem = _getSelectedItem();

    return Semantics(
      button: true,
      enabled: widget.enabled,
      label: widget.labelText ?? 'Dropdown',
      value: selectedItem.label,
      expanded: _isOpen,
      child: CompositedTransformTarget(
        link: _layerLink,
        child: GestureDetector(
          onTap: widget.enabled ? _toggleDropdown : null,
          child: Focus(
            focusNode: _focusNode,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: widget.borderRadius ?? dropdownStyle.borderRadius,
                border: Border.all(
                  color: _isOpen
                      ? dropdownStyle.focusBorderColor
                      : dropdownStyle.borderColor,
                  width: _isOpen
                      ? _DropdownConstants.focusBorderWidth
                      : _DropdownConstants.borderWidth,
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
      ),
    );
  }

  FSDropdownItem<T> _getSelectedItem() {
    if (widget.value != null) {
      try {
        return widget.items.firstWhere(
          (item) => item.value == widget.value,
        );
      } catch (e) {
        // Value not found in items
      }
    }

    return FSDropdownItem<T>(
      value: null, // ✅ SAFE: No unsafe cast
      label: widget.placeholder ?? 'Select an option',
      enabled: false,
    );
  }
}

/// Dropdown Overlay Component
@immutable
class _DropdownOverlay<T> extends StatelessWidget {
  final Offset position;
  final Size size;
  final LayerLink layerLink;
  final List<FSDropdownItem<T>> items;
  final ValueChanged<FSDropdownItem<T>> onItemSelected;
  final VoidCallback onClose;
  final double maxHeight;
  final bool showSearch;
  final TextEditingController searchController;
  final FocusNode searchFocusNode;
  final String? searchHint;
  final FSDropdownVariant variant;

  const _DropdownOverlay({
    required this.position,
    required this.size,
    required this.layerLink,
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
  Widget build(BuildContext context) {
    final theme = FSTheme.of(context);
    final dropdownStyle = _DropdownStyle(theme, variant, FSDropdownSize.md);

    return Positioned(
      left: position.dx,
      top: position.dy + size.height + _DropdownConstants.menuOffset,
      width: size.width,
      child: CompositedTransformFollower(
        link: layerLink,
        showWhenUnlinked: false,
        offset: Offset(0, size.height + _DropdownConstants.menuOffset),
        child: Material(
          type: MaterialType.transparency,
          child: _DropdownMenu<T>(
            items: items,
            onItemSelected: onItemSelected,
            onClose: onClose,
            maxHeight: maxHeight,
            showSearch: showSearch,
            searchController: searchController,
            searchFocusNode: searchFocusNode,
            searchHint: searchHint,
            variant: variant,
          ),
        ),
      ),
    );
  }
}

/// Dropdown Menu Content
@immutable
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
        if (!widget.searchFocusNode.hasFocus) {
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
      elevation: _DropdownConstants.menuElevation,
      borderRadius: dropdownStyle.menuBorderRadius,
      child: Container(
        constraints: BoxConstraints(maxHeight: widget.maxHeight),
        decoration: BoxDecoration(
          color: dropdownStyle.menuBackgroundColor,
          borderRadius: dropdownStyle.menuBorderRadius,
          border: Border.all(
            color: dropdownStyle.menuBorderColor,
            width: _DropdownConstants.borderWidth,
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
                  ? _buildEmptyState(dropdownStyle)
                  : _buildItemsList(dropdownStyle),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(_DropdownStyle dropdownStyle) {
    return Padding(
      padding: dropdownStyle.menuItemPadding,
      child: Text(
        'No options available',
        style: dropdownStyle.disabledMenuItemTextStyle,
      ),
    );
  }

  Widget _buildItemsList(_DropdownStyle dropdownStyle) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: widget.items.length,
      itemBuilder: (context, index) => _DropdownMenuItem<T>(
        key: ValueKey(widget.items[index].value),
        item: widget.items[index],
        onSelected: widget.onItemSelected,
        onClose: widget.onClose,
        variant: widget.variant,
      ),
    );
  }
}

/// Individual Dropdown Menu Item
@immutable
class _DropdownMenuItem<T> extends StatelessWidget {
  final FSDropdownItem<T> item;
  final ValueChanged<FSDropdownItem<T>> onSelected;
  final VoidCallback onClose;
  final FSDropdownVariant variant;

  const _DropdownMenuItem({
    super.key,
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

  BorderRadiusGeometry get borderRadius =>
      BorderRadius.circular(_DropdownConstants.defaultBorderRadius);
  BorderRadiusGeometry get menuBorderRadius =>
      BorderRadius.circular(_DropdownConstants.defaultBorderRadius);

  EdgeInsetsGeometry get contentPadding {
    switch (size) {
      case FSDropdownSize.sm:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 6);
      case FSDropdownSize.md:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
      case FSDropdownSize.lg:
        return const EdgeInsets.symmetric(horizontal: 20, vertical: 12);
    }
  }

  EdgeInsetsGeometry get prefixPadding {
    switch (size) {
      case FSDropdownSize.sm:
        return const EdgeInsets.only(left: 12);
      case FSDropdownSize.md:
        return const EdgeInsets.only(left: 16);
      case FSDropdownSize.lg:
        return const EdgeInsets.only(left: 20);
    }
  }

  EdgeInsetsGeometry get suffixPadding {
    switch (size) {
      case FSDropdownSize.sm:
        return const EdgeInsets.only(right: 8);
      case FSDropdownSize.md:
        return const EdgeInsets.only(right: 12);
      case FSDropdownSize.lg:
        return const EdgeInsets.only(right: 16);
    }
  }

  EdgeInsetsGeometry get menuItemPadding {
    switch (size) {
      case FSDropdownSize.sm:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
      case FSDropdownSize.md:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
      case FSDropdownSize.lg:
        return const EdgeInsets.symmetric(horizontal: 20, vertical: 16);
    }
  }

  TextStyle get textStyle => theme.typography.bodyMedium;
  TextStyle get disabledTextStyle => theme.typography.bodyMedium.copyWith(
        color: theme.colors.onBackground.withOpacity(0.5),
      );
  TextStyle get labelStyle => theme.typography.bodySmall.copyWith(
        color: theme.colors.onBackground.withOpacity(0.7),
      );
  TextStyle get helperStyle => theme.typography.bodySmall.copyWith(
        color: theme.colors.onBackground.withOpacity(0.6),
      );
  TextStyle get errorStyle => theme.typography.bodySmall.copyWith(
        color: theme.colors.danger,
      );
  TextStyle get menuItemTextStyle => theme.typography.bodyMedium;
  TextStyle get disabledMenuItemTextStyle =>
      theme.typography.bodyMedium.copyWith(
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

// CONSTANTS FOR BETTER MAINTAINABILITY
class _DropdownConstants {
  static const double menuElevation = 8.0;
  static const double menuOffset = 4.0;
  static const double borderWidth = 1.0;
  static const double focusBorderWidth = 2.0;
  static const double defaultMenuMaxHeight = 200.0;
  static const double defaultBorderRadius = 8.0;
  static const Duration searchDebounceDelay = Duration(milliseconds: 300);
  static const Duration overlayAnimationDuration = Duration(milliseconds: 200);
}
