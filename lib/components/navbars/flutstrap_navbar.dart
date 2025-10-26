import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../../core/spacing.dart';
import '../../core/breakpoints.dart';

/// Flutstrap Navbar Variants
///
/// Defines the visual style variants for navbars
enum FSNavbarVariant {
  light,
  dark,
  primary,
  secondary,
  success,
  danger,
  warning,
  info,
}

/// Flutstrap Navbar Positions
///
/// Defines the positioning behavior for navbars
enum FSNavbarPosition {
  static,
  fixedTop,
  fixedBottom,
  stickyTop,
}

/// Navbar Item Data
///
/// Represents an item in the navbar navigation
class FSNavbarItem {
  final String label;
  final VoidCallback? onTap;
  final Widget? icon;
  final List<FSNavbarItem>? children;
  final bool isActive;
  final bool enabled;

  const FSNavbarItem({
    required this.label,
    this.onTap,
    this.icon,
    this.children,
    this.isActive = false,
    this.enabled = true,
  });

  /// Creates a simple navbar item with just a label and tap handler
  const FSNavbarItem.simple({
    required this.label,
    required this.onTap,
  })  : icon = null,
        children = null,
        isActive = false,
        enabled = true;

  /// Creates a dropdown navbar item with children
  const FSNavbarItem.dropdown({
    required this.label,
    this.icon,
    required this.children,
  })  : onTap = null,
        isActive = false,
        enabled = true;
}

/// Flutstrap Navbar
///
/// A responsive navigation bar with Bootstrap-inspired styling.
class FlutstrapNavbar extends StatefulWidget {
  final Widget? brand;
  final String? brandText;
  final Widget? brandImage;
  final List<FSNavbarItem> items;
  final List<Widget>? customItems;
  final FSNavbarVariant variant;
  final FSNavbarPosition position;
  final bool expand;
  final String? searchPlaceholder;
  final ValueChanged<String>? onSearch;
  final bool showSearch;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double elevation;
  final EdgeInsetsGeometry padding;
  final bool fluid;

  const FlutstrapNavbar({
    Key? key,
    this.brand,
    this.brandText,
    this.brandImage,
    required this.items,
    this.customItems,
    this.variant = FSNavbarVariant.light,
    this.position = FSNavbarPosition.static,
    this.expand = false,
    this.searchPlaceholder,
    this.onSearch,
    this.showSearch = false,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0),
    this.fluid = false,
  }) : super(key: key);

  @override
  State<FlutstrapNavbar> createState() => _FlutstrapNavbarState();
}

class _FlutstrapNavbarState extends State<FlutstrapNavbar> {
  bool _isMobileMenuOpen = false;

  void _toggleMobileMenu() {
    setState(() {
      _isMobileMenuOpen = !_isMobileMenuOpen;
    });
  }

  void _closeMobileMenu() {
    setState(() {
      _isMobileMenuOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = FSTheme.of(context);
    final navbarStyle = _NavbarStyle(theme, widget.variant);

    return _NavbarWrapper(
      position: widget.position,
      child: Material(
        elevation: widget.elevation,
        color: widget.backgroundColor ?? navbarStyle.backgroundColor,
        child: Container(
          padding: widget.padding,
          child: ConstrainedBox(
            constraints: widget.fluid
                ? const BoxConstraints()
                : const BoxConstraints(maxWidth: 1140),
            child: Column(
              children: [
                // Main navbar row
                _NavbarMainRow(
                  brand: widget.brand,
                  brandText: widget.brandText,
                  brandImage: widget.brandImage,
                  items: widget.items,
                  customItems: widget.customItems,
                  variant: widget.variant,
                  expand: widget.expand,
                  searchPlaceholder: widget.searchPlaceholder,
                  onSearch: widget.onSearch,
                  showSearch: widget.showSearch,
                  isMobileMenuOpen: _isMobileMenuOpen,
                  onToggleMobileMenu: _toggleMobileMenu,
                  onCloseMobileMenu: _closeMobileMenu,
                ),
                // Mobile menu (collapsible)
                if (_isMobileMenuOpen) _MobileNavbarMenu(items: widget.items),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Wrapper for navbar positioning
class _NavbarWrapper extends StatelessWidget {
  final FSNavbarPosition position;
  final Widget child;

  const _NavbarWrapper({
    required this.position,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    switch (position) {
      case FSNavbarPosition.fixedTop:
        return Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: child,
        );
      case FSNavbarPosition.fixedBottom:
        return Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: child,
        );
      case FSNavbarPosition.stickyTop:
        return child;
      case FSNavbarPosition.static:
      default:
        return child;
    }
  }
}

/// Main navbar row with brand, navigation, and mobile menu button
class _NavbarMainRow extends StatelessWidget {
  final Widget? brand;
  final String? brandText;
  final Widget? brandImage;
  final List<FSNavbarItem> items;
  final List<Widget>? customItems;
  final FSNavbarVariant variant;
  final bool expand;
  final String? searchPlaceholder;
  final ValueChanged<String>? onSearch;
  final bool showSearch;
  final bool isMobileMenuOpen;
  final VoidCallback onToggleMobileMenu;
  final VoidCallback onCloseMobileMenu;

  const _NavbarMainRow({
    required this.brand,
    required this.brandText,
    required this.brandImage,
    required this.items,
    required this.customItems,
    required this.variant,
    required this.expand,
    required this.searchPlaceholder,
    required this.onSearch,
    required this.showSearch,
    required this.isMobileMenuOpen,
    required this.onToggleMobileMenu,
    required this.onCloseMobileMenu,
  });

  @override
  Widget build(BuildContext context) {
    final theme = FSTheme.of(context);
    final navbarStyle = _NavbarStyle(theme, variant);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < FSBreakpoints.md;

        return Row(
          children: [
            // Brand section
            _NavbarBrand(
              brand: brand,
              brandText: brandText,
              brandImage: brandImage,
              variant: variant,
            ),
            // Spacer
            if (expand) const Expanded(child: SizedBox()),
            // Desktop navigation (hidden on mobile)
            if (!isMobile) ..._buildDesktopNavigation(navbarStyle),
            // Custom items
            if (!isMobile && customItems != null) ...customItems!,
            // Search (hidden on mobile when there are many items)
            if (!isMobile && showSearch)
              _NavbarSearch(
                placeholder: searchPlaceholder,
                onSearch: onSearch,
                variant: variant,
              ),
            // Mobile menu button (only on mobile)
            if (isMobile)
              _MobileMenuButton(
                isOpen: isMobileMenuOpen,
                onTap: onToggleMobileMenu,
                variant: variant,
              ),
          ],
        );
      },
    );
  }

  List<Widget> _buildDesktopNavigation(_NavbarStyle navbarStyle) {
    return [
      for (final item in items)
        _NavbarItemDesktop(
          item: item,
          variant: variant,
          onItemTap: onCloseMobileMenu,
        ),
    ];
  }
}

/// Navbar brand/logo section
class _NavbarBrand extends StatelessWidget {
  final Widget? brand;
  final String? brandText;
  final Widget? brandImage;
  final FSNavbarVariant variant;

  const _NavbarBrand({
    required this.brand,
    required this.brandText,
    required this.brandImage,
    required this.variant,
  });

  @override
  Widget build(BuildContext context) {
    final theme = FSTheme.of(context);
    final navbarStyle = _NavbarStyle(theme, variant);

    if (brand != null) {
      return brand!;
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          // Typically would navigate to home
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (brandImage != null) ...[
              brandImage!,
              const SizedBox(width: 8),
            ],
            if (brandText != null)
              Text(
                brandText!,
                style: navbarStyle.brandTextStyle,
              ),
          ],
        ),
      ),
    );
  }
}

/// Desktop navigation item
class _NavbarItemDesktop extends StatefulWidget {
  final FSNavbarItem item;
  final FSNavbarVariant variant;
  final VoidCallback onItemTap;

  const _NavbarItemDesktop({
    required this.item,
    required this.variant,
    required this.onItemTap,
  });

  @override
  State<_NavbarItemDesktop> createState() => _NavbarItemDesktopState();
}

class _NavbarItemDesktopState extends State<_NavbarItemDesktop> {
  bool _isHovered = false;
  bool _isDropdownOpen = false;

  @override
  Widget build(BuildContext context) {
    final theme = FSTheme.of(context);
    final navbarStyle = _NavbarStyle(theme, widget.variant);

    final hasChildren =
        widget.item.children != null && widget.item.children!.isNotEmpty;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {
          if (hasChildren) {
            setState(() => _isDropdownOpen = !_isDropdownOpen);
          } else {
            widget.item.onTap?.call();
            widget.onItemTap();
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: _getBackgroundColor(navbarStyle),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.item.icon != null) ...[
                widget.item.icon!,
                const SizedBox(width: 8),
              ],
              Text(
                widget.item.label,
                style: _getTextStyle(navbarStyle),
              ),
              if (hasChildren) ...[
                const SizedBox(width: 4),
                Icon(
                  _isDropdownOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  size: 16,
                  color: _getTextColor(navbarStyle),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Color? _getBackgroundColor(_NavbarStyle navbarStyle) {
    if (widget.item.isActive) {
      return navbarStyle.activeItemBackgroundColor;
    }
    if (_isHovered) {
      return navbarStyle.hoverItemBackgroundColor;
    }
    return Colors.transparent;
  }

  TextStyle _getTextStyle(_NavbarStyle navbarStyle) {
    final baseStyle = navbarStyle.itemTextStyle;
    if (widget.item.isActive) {
      return baseStyle.copyWith(
        color: navbarStyle.activeItemTextColor,
        fontWeight: FontWeight.w600,
      );
    }
    if (!widget.item.enabled) {
      return baseStyle.copyWith(
        color: navbarStyle.disabledItemTextColor,
      );
    }
    return baseStyle;
  }

  Color _getTextColor(_NavbarStyle navbarStyle) {
    if (widget.item.isActive) {
      return navbarStyle.activeItemTextColor;
    }
    if (!widget.item.enabled) {
      return navbarStyle.disabledItemTextColor;
    }
    return navbarStyle.itemTextColor;
  }
}

/// Navbar search component
class _NavbarSearch extends StatelessWidget {
  final String? placeholder;
  final ValueChanged<String>? onSearch;
  final FSNavbarVariant variant;

  const _NavbarSearch({
    required this.placeholder,
    required this.onSearch,
    required this.variant,
  });

  @override
  Widget build(BuildContext context) {
    final theme = FSTheme.of(context);
    final navbarStyle = _NavbarStyle(theme, variant);

    return Container(
      width: 200,
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: navbarStyle.searchBackgroundColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: navbarStyle.searchBorderColor,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            size: 16,
            color: navbarStyle.searchIconColor,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              onChanged: onSearch,
              decoration: InputDecoration(
                hintText: placeholder ?? 'Search...',
                hintStyle: navbarStyle.searchHintStyle,
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              style: navbarStyle.searchTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}

/// Mobile menu button (hamburger)
class _MobileMenuButton extends StatelessWidget {
  final bool isOpen;
  final VoidCallback onTap;
  final FSNavbarVariant variant;

  const _MobileMenuButton({
    required this.isOpen,
    required this.onTap,
    required this.variant,
  });

  @override
  Widget build(BuildContext context) {
    final theme = FSTheme.of(context);
    final navbarStyle = _NavbarStyle(theme, variant);

    return IconButton(
      onPressed: onTap,
      icon: Icon(
        isOpen ? Icons.close : Icons.menu,
        color: navbarStyle.mobileMenuIconColor,
      ),
    );
  }
}

/// Mobile navbar menu (collapsible)
class _MobileNavbarMenu extends StatelessWidget {
  final List<FSNavbarItem> items;

  const _MobileNavbarMenu({
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        for (final item in items) _MobileNavbarMenuItem(item: item),
      ],
    );
  }
}

/// Individual mobile navbar menu item
class _MobileNavbarMenuItem extends StatelessWidget {
  final FSNavbarItem item;

  const _MobileNavbarMenuItem({
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        children: [
          if (item.icon != null) ...[
            item.icon!,
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Text(
              item.label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: item.isActive ? FontWeight.w600 : FontWeight.normal,
                color: item.enabled ? null : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Internal style configuration for navbars
class _NavbarStyle {
  final FSThemeData theme;
  final FSNavbarVariant variant;

  _NavbarStyle(this.theme, this.variant);

  Color get backgroundColor => _getBackgroundColor();
  Color get brandTextColor => _getBrandTextColor();
  Color get itemTextColor => _getItemTextColor();
  Color get activeItemTextColor => _getActiveItemTextColor();
  Color get disabledItemTextColor => _getDisabledItemTextColor();
  Color get activeItemBackgroundColor => _getActiveItemBackgroundColor();
  Color get hoverItemBackgroundColor => _getHoverItemBackgroundColor();
  Color get searchBackgroundColor => _getSearchBackgroundColor();
  Color get searchBorderColor => _getSearchBorderColor();
  Color get searchIconColor => _getSearchIconColor();
  Color get mobileMenuIconColor => _getMobileMenuIconColor();

  TextStyle get brandTextStyle => theme.typography.headlineSmall.copyWith(
        color: brandTextColor,
        fontWeight: FontWeight.w600,
      );

  TextStyle get itemTextStyle => theme.typography.bodyMedium.copyWith(
        color: itemTextColor,
      );

  TextStyle get searchTextStyle => theme.typography.bodyMedium.copyWith(
        color: itemTextColor,
      );

  TextStyle get searchHintStyle => theme.typography.bodyMedium.copyWith(
        color: itemTextColor.withOpacity(0.6),
      );

  Color _getBackgroundColor() {
    final colors = theme.colors;
    switch (variant) {
      case FSNavbarVariant.light:
        return colors.background;
      case FSNavbarVariant.dark:
        return colors.onBackground;
      case FSNavbarVariant.primary:
        return colors.primary;
      case FSNavbarVariant.secondary:
        return colors.secondary;
      case FSNavbarVariant.success:
        return colors.success;
      case FSNavbarVariant.danger:
        return colors.danger;
      case FSNavbarVariant.warning:
        return colors.warning;
      case FSNavbarVariant.info:
        return colors.info;
    }
  }

  Color _getBrandTextColor() {
    switch (variant) {
      case FSNavbarVariant.dark:
      case FSNavbarVariant.primary:
      case FSNavbarVariant.secondary:
      case FSNavbarVariant.success:
      case FSNavbarVariant.danger:
      case FSNavbarVariant.warning:
      case FSNavbarVariant.info:
        return theme.colors.background;
      case FSNavbarVariant.light:
      default:
        return theme.colors.onBackground;
    }
  }

  Color _getItemTextColor() {
    switch (variant) {
      case FSNavbarVariant.dark:
      case FSNavbarVariant.primary:
      case FSNavbarVariant.secondary:
      case FSNavbarVariant.success:
      case FSNavbarVariant.danger:
      case FSNavbarVariant.warning:
      case FSNavbarVariant.info:
        return theme.colors.background;
      case FSNavbarVariant.light:
      default:
        return theme.colors.onBackground;
    }
  }

  Color _getActiveItemTextColor() {
    switch (variant) {
      case FSNavbarVariant.light:
        return theme.colors.primary;
      case FSNavbarVariant.dark:
        return theme.colors.primary;
      case FSNavbarVariant.primary:
      case FSNavbarVariant.secondary:
      case FSNavbarVariant.success:
      case FSNavbarVariant.danger:
      case FSNavbarVariant.warning:
      case FSNavbarVariant.info:
        return theme.colors.background;
    }
  }

  Color _getDisabledItemTextColor() {
    return _getItemTextColor().withOpacity(0.5);
  }

  Color _getActiveItemBackgroundColor() {
    switch (variant) {
      case FSNavbarVariant.light:
        return theme.colors.primary.withOpacity(0.1);
      case FSNavbarVariant.dark:
        return theme.colors.primary.withOpacity(0.2);
      case FSNavbarVariant.primary:
      case FSNavbarVariant.secondary:
      case FSNavbarVariant.success:
      case FSNavbarVariant.danger:
      case FSNavbarVariant.warning:
      case FSNavbarVariant.info:
        return theme.colors.background.withOpacity(0.2);
    }
  }

  Color _getHoverItemBackgroundColor() {
    switch (variant) {
      case FSNavbarVariant.light:
        return theme.colors.surface.withOpacity(0.5);
      case FSNavbarVariant.dark:
        return theme.colors.background.withOpacity(0.1);
      case FSNavbarVariant.primary:
      case FSNavbarVariant.secondary:
      case FSNavbarVariant.success:
      case FSNavbarVariant.danger:
      case FSNavbarVariant.warning:
      case FSNavbarVariant.info:
        return theme.colors.background.withOpacity(0.1);
    }
  }

  Color _getSearchBackgroundColor() {
    switch (variant) {
      case FSNavbarVariant.light:
        return theme.colors.surface;
      case FSNavbarVariant.dark:
        return theme.colors.background.withOpacity(0.1);
      case FSNavbarVariant.primary:
      case FSNavbarVariant.secondary:
      case FSNavbarVariant.success:
      case FSNavbarVariant.danger:
      case FSNavbarVariant.warning:
      case FSNavbarVariant.info:
        return theme.colors.background.withOpacity(0.1);
    }
  }

  Color _getSearchBorderColor() {
    switch (variant) {
      case FSNavbarVariant.light:
        return theme.colors.outline;
      case FSNavbarVariant.dark:
        return theme.colors.background.withOpacity(0.3);
      case FSNavbarVariant.primary:
      case FSNavbarVariant.secondary:
      case FSNavbarVariant.success:
      case FSNavbarVariant.danger:
      case FSNavbarVariant.warning:
      case FSNavbarVariant.info:
        return theme.colors.background.withOpacity(0.3);
    }
  }

  Color _getSearchIconColor() {
    return _getItemTextColor().withOpacity(0.6);
  }

  Color _getMobileMenuIconColor() {
    return _getItemTextColor();
  }
}
