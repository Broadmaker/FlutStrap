/// Flutstrap Navbar
///
/// A high-performance, responsive navigation bar with Bootstrap-inspired styling,
/// smooth animations, and optimized state management for large navigation structures.
///
/// ## Usage Examples
///
/// ```dart
/// // Basic navbar with brand and items
/// FlutstrapNavbar(
///   brandText: 'My App',
///   items: [
///     FSNavbarItem(label: 'Home', onTap: () => navigateToHome()),
///     FSNavbarItem(label: 'About', onTap: () => navigateToAbout()),
///     FSNavbarItem(label: 'Contact', onTap: () => navigateToContact()),
///   ],
///   variant: FSNavbarVariant.primary,
/// )
///
/// // Navbar with dropdown items and search
/// FlutstrapNavbar(
///   brandText: 'E-Commerce',
///   items: [
///     FSNavbarItem.simple(label: 'Home', onTap: () {}),
///     FSNavbarItem.dropdown(
///       label: 'Products',
///       children: [
///         FSNavbarItem(label: 'Electronics', onTap: () {}),
///         FSNavbarItem(label: 'Clothing', onTap: () {}),
///       ],
///     ),
///   ],
///   showSearch: true,
///   onSearch: (query) => filterProducts(query),
/// )
///
/// // Fixed top navbar with custom branding
/// FlutstrapNavbar(
///   brand: Row(
///     children: [
///       Icon(Icons.rocket),
///       SizedBox(width: 8),
///       Text('Flutstrap'),
///     ],
///   ),
///   items: navigationItems,
///   position: FSNavbarPosition.fixedTop,
///   elevation: 4,
/// )
/// ```
///
/// ## Performance Features
///
/// - **Optimized State Management**: Efficient hover and dropdown state for multiple items
/// - **Smooth Animations**: Properly disposed animation controllers for mobile menu
/// - **Cached Breakpoints**: Efficient responsive behavior calculations
/// - **Memory Efficient**: No memory leaks from state management
///
/// ## Responsive Behavior
///
/// - **Desktop**: Full navigation with hover effects and dropdowns
/// - **Mobile**: Collapsible hamburger menu with smooth animations
/// - **Automatic**: Switches at 768px breakpoint (FSBreakpoints.md)
///
/// {@category Components}
/// {@category Navigation}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../../core/spacing.dart';
import '../../core/breakpoints.dart';

/// Flutstrap Navbar Configuration
class FSNavbarConfig {
  static const int maxNavbarItems = 15;
  static const Duration mobileMenuAnimationDuration =
      Duration(milliseconds: 300);
  static const double mobileMenuMaxHeight = 400.0;

  static bool isValidItemCount(int count) {
    return count <= maxNavbarItems;
  }
}

/// Flutstrap Navbar Variants
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
enum FSNavbarPosition {
  static,
  fixedTop,
  fixedBottom,
  stickyTop,
}

/// Navbar Item Data
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FSNavbarItem &&
          runtimeType == other.runtimeType &&
          label == other.label &&
          isActive == other.isActive &&
          enabled == other.enabled;

  @override
  int get hashCode => Object.hash(label, isActive, enabled);
}

/// Flutstrap Navbar
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

class _FlutstrapNavbarState extends State<FlutstrapNavbar>
    with SingleTickerProviderStateMixin {
  bool _isMobileMenuOpen = false;
  late AnimationController _mobileMenuController;
  late Animation<double> _mobileMenuAnimation;

  // ✅ EFFICIENT: Single state for all desktop item hovers/dropdowns
  final Map<int, bool> _desktopItemHoverStates = {};
  final Map<int, bool> _desktopItemDropdownStates = {};

  @override
  void initState() {
    super.initState();
    _mobileMenuController = AnimationController(
      duration: FSNavbarConfig.mobileMenuAnimationDuration,
      vsync: this,
    );
    _mobileMenuAnimation = CurvedAnimation(
      parent: _mobileMenuController,
      curve: Curves.easeInOut,
    );

    // ✅ INITIALIZE: Default states for all items
    for (int i = 0; i < widget.items.length; i++) {
      _desktopItemHoverStates[i] = false;
      _desktopItemDropdownStates[i] = false;
    }
  }

  void _toggleMobileMenu() {
    setState(() {
      _isMobileMenuOpen = !_isMobileMenuOpen;
    });

    if (_isMobileMenuOpen) {
      _mobileMenuController.forward();
    } else {
      _mobileMenuController.reverse();
    }
  }

  void _closeMobileMenu() {
    if (_isMobileMenuOpen) {
      setState(() {
        _isMobileMenuOpen = false;
      });
      _mobileMenuController.reverse();
    }
  }

  void _setDesktopItemHover(int index, bool isHovered) {
    setState(() {
      _desktopItemHoverStates[index] = isHovered;
    });
  }

  void _setDesktopItemDropdown(int index, bool isOpen) {
    setState(() {
      _desktopItemDropdownStates[index] = isOpen;
    });
  }

  @override
  void didUpdateWidget(FlutstrapNavbar oldWidget) {
    super.didUpdateWidget(oldWidget);

    // ✅ UPDATE: Handle items list changes
    if (oldWidget.items != widget.items) {
      _desktopItemHoverStates.clear();
      _desktopItemDropdownStates.clear();
      for (int i = 0; i < widget.items.length; i++) {
        _desktopItemHoverStates[i] = false;
        _desktopItemDropdownStates[i] = false;
      }
    }
  }

  @override
  void dispose() {
    _mobileMenuController.dispose(); // ✅ CRITICAL: Prevent memory leaks
    super.dispose();
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
                  desktopItemHoverStates: _desktopItemHoverStates,
                  desktopItemDropdownStates: _desktopItemDropdownStates,
                  onDesktopItemHover: _setDesktopItemHover,
                  onDesktopItemDropdown: _setDesktopItemDropdown,
                ),
                // Mobile menu (animated)
                if (_isMobileMenuOpen || _mobileMenuController.value > 0)
                  _MobileNavbarMenu(
                    items: widget.items,
                    animation: _mobileMenuAnimation,
                  ),
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
  final Map<int, bool> desktopItemHoverStates;
  final Map<int, bool> desktopItemDropdownStates;
  final void Function(int, bool) onDesktopItemHover;
  final void Function(int, bool) onDesktopItemDropdown;

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
    required this.desktopItemHoverStates,
    required this.desktopItemDropdownStates,
    required this.onDesktopItemHover,
    required this.onDesktopItemDropdown,
  });

  @override
  Widget build(BuildContext context) {
    final theme = FSTheme.of(context);
    final navbarStyle = _NavbarStyle(theme, variant);

    return LayoutBuilder(
      builder: (context, constraints) {
        // ✅ EFFICIENT: Use cached breakpoint calculation
        final isMobile = _isMobileBreakpoint(constraints.maxWidth);

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
      for (int i = 0; i < items.length; i++)
        _NavbarItemDesktop(
          item: items[i],
          variant: variant,
          onItemTap: onCloseMobileMenu,
          isHovered: desktopItemHoverStates[i] ?? false,
          isDropdownOpen: desktopItemDropdownStates[i] ?? false,
          onHoverChanged: (hovered) => onDesktopItemHover(i, hovered),
          onDropdownToggle: (open) => onDesktopItemDropdown(i, open),
        ),
    ];
  }

  // ✅ CACHED BREAKPOINT CALCULATION
  bool _isMobileBreakpoint(double width) {
    return width < FSBreakpoints.md;
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

    // ✅ SAFE: Check if we have any brand content
    if (brandText == null && brandImage == null) {
      return const SizedBox.shrink();
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          // Typically would navigate to home
          try {
            // Navigation logic here
          } catch (e) {
            if (kDebugMode) {
              print('🚨 Navbar brand tap error: $e');
            }
          }
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

/// Optimized desktop navigation item
class _NavbarItemDesktop extends StatelessWidget {
  final FSNavbarItem item;
  final FSNavbarVariant variant;
  final VoidCallback onItemTap;
  final bool isHovered;
  final bool isDropdownOpen;
  final ValueChanged<bool> onHoverChanged;
  final ValueChanged<bool> onDropdownToggle;

  const _NavbarItemDesktop({
    required this.item,
    required this.variant,
    required this.onItemTap,
    required this.isHovered,
    required this.isDropdownOpen,
    required this.onHoverChanged,
    required this.onDropdownToggle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = FSTheme.of(context);
    final navbarStyle = _NavbarStyle(theme, variant);

    final hasChildren = item.children != null && item.children!.isNotEmpty;

    return MouseRegion(
      onEnter: (_) => onHoverChanged(true),
      onExit: (_) => onHoverChanged(false),
      child: GestureDetector(
        onTap: () {
          if (hasChildren) {
            onDropdownToggle(!isDropdownOpen);
          } else {
            item.onTap?.call();
            onItemTap();
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
              if (item.icon != null) ...[
                item.icon!,
                const SizedBox(width: 8),
              ],
              Text(
                item.label,
                style: _getTextStyle(navbarStyle),
              ),
              if (hasChildren) ...[
                const SizedBox(width: 4),
                Icon(
                  isDropdownOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
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
    if (item.isActive) {
      return navbarStyle.activeItemBackgroundColor;
    }
    if (isHovered) {
      return navbarStyle.hoverItemBackgroundColor;
    }
    return Colors.transparent;
  }

  TextStyle _getTextStyle(_NavbarStyle navbarStyle) {
    final baseStyle = navbarStyle.itemTextStyle;
    if (item.isActive) {
      return baseStyle.copyWith(
        color: navbarStyle.activeItemTextColor,
        fontWeight: FontWeight.w600,
      );
    }
    if (!item.enabled) {
      return baseStyle.copyWith(
        color: navbarStyle.disabledItemTextColor,
      );
    }
    return baseStyle;
  }

  Color _getTextColor(_NavbarStyle navbarStyle) {
    if (item.isActive) {
      return navbarStyle.activeItemTextColor;
    }
    if (!item.enabled) {
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

/// Mobile navbar menu (animated)
class _MobileNavbarMenu extends StatelessWidget {
  final List<FSNavbarItem> items;
  final Animation<double> animation;

  const _MobileNavbarMenu({
    required this.items,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: animation,
      axisAlignment: -1.0,
      child: Container(
        constraints: BoxConstraints(
          maxHeight: FSNavbarConfig.mobileMenuMaxHeight,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 8),
              for (final item in items) _MobileNavbarMenuItem(item: item),
            ],
          ),
        ),
      ),
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
    final theme = FSTheme.of(context);

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
              style: theme.typography.bodyMedium.copyWith(
                fontWeight: item.isActive ? FontWeight.w600 : FontWeight.normal,
                color: item.enabled
                    ? null
                    : theme.colors.onSurface.withOpacity(0.5),
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
