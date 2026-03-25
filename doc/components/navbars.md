# Flutstrap Navbar Component Guide

## Introduction

The **FlutstrapNavbar** is a high-performance, responsive navigation bar with Bootstrap-inspired styling, smooth animations, and optimized state management for large navigation structures. It provides a comprehensive navigation solution with mobile-first responsive design and accessibility features.

### What the Component Does

FlutstrapNavbar offers:

- Responsive design with mobile hamburger menu
- Multiple visual variants (8 color options)
- Four positioning options (static, fixed, sticky)
- Dropdown menu support
- Built-in search functionality
- Custom branding options
- Smooth animations and transitions
- Comprehensive accessibility support

### When and Why to Use It

Use FlutstrapNavbar when you need:

- Main website navigation
- App header with navigation items
- Responsive navigation that works on all devices
- Accessible navigation with keyboard support
- Branded navigation with custom logos
- Navigation with dropdown menus

### Prerequisites

- Flutter 3.0 or higher
- Flutstrap theme package
- Material Design Icons

## Installation & Setup

### Required Import

```dart
import 'package:flutstrap/flutstrap.dart';
```

### Theme Configuration

```dart
void main() {
  runApp(
    FSTheme(
      data: FSThemeData.light(), // or FSThemeData.dark()
      child: MyApp(),
    ),
  );
}
```

## Basic Usage

### Basic Navbar with Text Items

```dart
FlutstrapNavbar(
  brandText: 'My App',
  items: [
    FSNavbarItem(label: 'Home', onTap: () {}, isActive: true),
    FSNavbarItem(label: 'About', onTap: () {}),
    FSNavbarItem(label: 'Services', onTap: () {}),
    FSNavbarItem(label: 'Contact', onTap: () {}),
  ],
  variant: FSNavbarVariant.primary,
)
```

### Navbar with Custom Branding

```dart
FlutstrapNavbar(
  brand: Row(
    children: [
      Icon(Icons.rocket, color: Colors.white),
      SizedBox(width: 8),
      Text('Flutstrap', style: TextStyle(color: Colors.white)),
    ],
  ),
  items: [
    FSNavbarItem.simple(label: 'Home', onTap: () {}),
    FSNavbarItem.simple(label: 'Features', onTap: () {}),
    FSNavbarItem.simple(label: 'Pricing', onTap: () {}),
  ],
  variant: FSNavbarVariant.dark,
)
```

## Component Variants

FlutstrapNavbar offers 8 visual variants:

### Light

```dart
FlutstrapNavbar(
  brandText: 'Light Navbar',
  items: items,
  variant: FSNavbarVariant.light,
)
```

### Dark

```dart
FlutstrapNavbar(
  brandText: 'Dark Navbar',
  items: items,
  variant: FSNavbarVariant.dark,
)
```

### Primary

```dart
FlutstrapNavbar(
  brandText: 'Primary Navbar',
  items: items,
  variant: FSNavbarVariant.primary,
)
```

### Secondary

```dart
FlutstrapNavbar(
  brandText: 'Secondary Navbar',
  items: items,
  variant: FSNavbarVariant.secondary,
)
```

### Success

```dart
FlutstrapNavbar(
  brandText: 'Success Navbar',
  items: items,
  variant: FSNavbarVariant.success,
)
```

### Danger

```dart
FlutstrapNavbar(
  brandText: 'Danger Navbar',
  items: items,
  variant: FSNavbarVariant.danger,
)
```

### Warning

```dart
FlutstrapNavbar(
  brandText: 'Warning Navbar',
  items: items,
  variant: FSNavbarVariant.warning,
)
```

### Info

```dart
FlutstrapNavbar(
  brandText: 'Info Navbar',
  items: items,
  variant: FSNavbarVariant.info,
)
```

## Navbar Positions

### Static (Default)

```dart
FlutstrapNavbar(
  brandText: 'Static Navbar',
  items: items,
  position: FSNavbarPosition.static,
)
```

### Fixed Top

```dart
FlutstrapNavbar(
  brandText: 'Fixed Top Navbar',
  items: items,
  position: FSNavbarPosition.fixedTop,
)
```

### Fixed Bottom

```dart
FlutstrapNavbar(
  brandText: 'Fixed Bottom Navbar',
  items: items,
  position: FSNavbarPosition.fixedBottom,
)
```

### Sticky Top

```dart
FlutstrapNavbar(
  brandText: 'Sticky Top Navbar',
  items: items,
  position: FSNavbarPosition.stickyTop,
)
```

## Properties & Parameters

### Parameter Reference Table

| Parameter           | Type                    | Default                                | Description                          |
| ------------------- | ----------------------- | -------------------------------------- | ------------------------------------ |
| `brand`             | `Widget?`               | `null`                                 | Custom brand widget                  |
| `brandText`         | `String?`               | `null`                                 | Brand text                           |
| `brandImage`        | `Widget?`               | `null`                                 | Brand image widget                   |
| `items`             | `List<FSNavbarItem>`    | **Required**                           | Navigation items                     |
| `customItems`       | `List<Widget>?`         | `null`                                 | Additional custom items              |
| `variant`           | `FSNavbarVariant`       | `light`                                | Visual style variant                 |
| `position`          | `FSNavbarPosition`      | `static`                               | Navbar positioning                   |
| `expand`            | `bool`                  | `false`                                | Whether navbar expands to fill space |
| `searchPlaceholder` | `String?`               | `null`                                 | Search field placeholder             |
| `onSearch`          | `ValueChanged<String>?` | `null`                                 | Search callback                      |
| `showSearch`        | `bool`                  | `false`                                | Whether to show search field         |
| `backgroundColor`   | `Color?`                | `null`                                 | Custom background color              |
| `foregroundColor`   | `Color?`                | `null`                                 | Custom foreground color              |
| `elevation`         | `double`                | `0`                                    | Navbar elevation                     |
| `padding`           | `EdgeInsetsGeometry`    | `EdgeInsets.symmetric(horizontal: 16)` | Navbar padding                       |
| `fluid`             | `bool`                  | `false`                                | Whether navbar is fluid width        |

### FSNavbarVariant Enum

```dart
enum FSNavbarVariant {
  light, dark, primary, secondary, success, danger, warning, info
}
```

### FSNavbarPosition Enum

```dart
enum FSNavbarPosition {
  static, fixedTop, fixedBottom, stickyTop
}
```

### FSNavbarItem Class

```dart
FSNavbarItem(
  label: String,              // Item display text
  onTap: VoidCallback?,       // Tap handler
  icon: Widget?,              // Optional icon
  children: List<FSNavbarItem>?, // Dropdown children
  isActive: bool,             // Active state
  enabled: bool,              // Enabled state
)
```

## Advanced Features

### Dropdown Navigation Items

```dart
FlutstrapNavbar(
  brandText: 'My App',
  items: [
    FSNavbarItem.simple(label: 'Home', onTap: () {}),
    FSNavbarItem.dropdown(
      label: 'Products',
      children: [
        FSNavbarItem(label: 'Web Apps', onTap: () {}),
        FSNavbarItem(label: 'Mobile Apps', onTap: () {}),
        FSNavbarItem(label: 'Desktop Apps', onTap: () {}),
      ],
    ),
    FSNavbarItem.dropdown(
      label: 'Services',
      children: [
        FSNavbarItem(label: 'Consulting', onTap: () {}),
        FSNavbarItem(label: 'Development', onTap: () {}),
        FSNavbarItem(label: 'Support', onTap: () {}),
      ],
    ),
    FSNavbarItem.simple(label: 'About', onTap: () {}),
  ],
  variant: FSNavbarVariant.primary,
)
```

### Search Functionality

```dart
FlutstrapNavbar(
  brandText: 'Searchable Navbar',
  items: items,
  showSearch: true,
  searchPlaceholder: 'Search products...',
  onSearch: (query) {
    print('Search query: $query');
    // Implement search logic
  },
  variant: FSNavbarVariant.light,
)
```

### Custom Items and Icons

```dart
FlutstrapNavbar(
  brandText: 'Custom Navbar',
  items: [
    FSNavbarItem(
      label: 'Home',
      onTap: () {},
      icon: Icon(Icons.home, size: 20),
      isActive: true,
    ),
    FSNavbarItem(
      label: 'Notifications',
      onTap: () {},
      icon: Icon(Icons.notifications, size: 20),
    ),
    FSNavbarItem(
      label: 'Profile',
      onTap: () {},
      icon: Icon(Icons.person, size: 20),
    ),
  ],
  customItems: [
    IconButton(
      icon: Icon(Icons.settings),
      onPressed: () {},
    ),
    SizedBox(width: 8),
    CircleAvatar(
      radius: 16,
      backgroundImage: NetworkImage('https://picsum.photos/100'),
    ),
  ],
  variant: FSNavbarVariant.dark,
)
```

### Active State Management

```dart
class MyNavbar extends StatefulWidget {
  @override
  _MyNavbarState createState() => _MyNavbarState();
}

class _MyNavbarState extends State<MyNavbar> {
  int _activeIndex = 0;

  final List<FSNavbarItem> _navItems = [
    FSNavbarItem(label: 'Home', onTap: () {}),
    FSNavbarItem(label: 'Features', onTap: () {}),
    FSNavbarItem(label: 'Pricing', onTap: () {}),
    FSNavbarItem(label: 'About', onTap: () {}),
  ];

  void _setActiveIndex(int index) {
    setState(() {
      _activeIndex = index;
    });
  }

  List<FSNavbarItem> _getActiveItems() {
    return List.generate(_navItems.length, (index) {
      return _navItems[index].copyWith(
        isActive: index == _activeIndex,
        onTap: () {
          _setActiveIndex(index);
          _navItems[index].onTap?.call();
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutstrapNavbar(
      brandText: 'My App',
      items: _getActiveItems(),
      variant: FSNavbarVariant.primary,
    );
  }
}
```

## Integration Examples

### Complete Website Header

```dart
class WebsiteHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FlutstrapNavbar(
          brand: Row(
            children: [
              Image.asset('assets/logo.png', height: 32),
              SizedBox(width: 12),
              Text('Company Name', style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )),
            ],
          ),
          items: [
            FSNavbarItem.simple(label: 'Home', onTap: () {}),
            FSNavbarItem.dropdown(
              label: 'Products',
              children: [
                FSNavbarItem(label: 'Product A', onTap: () {}),
                FSNavbarItem(label: 'Product B', onTap: () {}),
                FSNavbarItem(label: 'Product C', onTap: () {}),
              ],
            ),
            FSNavbarItem.dropdown(
              label: 'Services',
              children: [
                FSNavbarItem(label: 'Consulting', onTap: () {}),
                FSNavbarItem(label: 'Development', onTap: () {}),
                FSNavbarItem(label: 'Support', onTap: () {}),
              ],
            ),
            FSNavbarItem.simple(label: 'About', onTap: () {}),
            FSNavbarItem.simple(label: 'Contact', onTap: () {}),
          ],
          showSearch: true,
          searchPlaceholder: 'Search our site...',
          customItems: [
            FilledButton(
              onPressed: () {},
              child: Text('Get Started'),
            ),
          ],
          variant: FSNavbarVariant.primary,
          position: FSNavbarPosition.fixedTop,
        ),
        // Page content would go here
        Expanded(
          child: Container(
            // Your page content
          ),
        ),
      ],
    );
  }
}
```

### E-commerce Navigation

```dart
FlutstrapNavbar(
  brandText: 'ShopName',
  items: [
    FSNavbarItem.simple(label: 'Home', onTap: () {}),
    FSNavbarItem.dropdown(
      label: 'Categories',
      children: [
        FSNavbarItem(label: 'Electronics', onTap: () {}),
        FSNavbarItem(label: 'Clothing', onTap: () {}),
        FSNavbarItem(label: 'Home & Garden', onTap: () {}),
        FSNavbarItem(label: 'Sports', onTap: () {}),
      ],
    ),
    FSNavbarItem.simple(label: 'Deals', onTap: () {}),
    FSNavbarItem.simple(label: 'New Arrivals', onTap: () {}),
  ],
  showSearch: true,
  searchPlaceholder: 'Search products...',
  customItems: [
    IconButton(
      icon: Badge(
        label: Text('3'),
        child: Icon(Icons.shopping_cart),
      ),
      onPressed: () {},
    ),
    SizedBox(width: 8),
    CircleAvatar(
      radius: 16,
      child: Icon(Icons.person),
    ),
  ],
  variant: FSNavbarVariant.light,
  position: FSNavbarPosition.stickyTop,
)
```

### Admin Dashboard Navigation

```dart
FlutstrapNavbar(
  brand: Row(
    children: [
      Icon(Icons.admin_panel_settings, color: Colors.white),
      SizedBox(width: 8),
      Text('Admin Panel', style: TextStyle(color: Colors.white)),
    ],
  ),
  items: [
    FSNavbarItem(
      label: 'Dashboard',
      onTap: () {},
      icon: Icon(Icons.dashboard, size: 18, color: Colors.white70),
      isActive: true,
    ),
    FSNavbarItem(
      label: 'Users',
      onTap: () {},
      icon: Icon(Icons.people, size: 18, color: Colors.white70),
    ),
    FSNavbarItem(
      label: 'Products',
      onTap: () {},
      icon: Icon(Icons.inventory, size: 18, color: Colors.white70),
    ),
    FSNavbarItem(
      label: 'Orders',
      onTap: () {},
      icon: Icon(Icons.shopping_cart, size: 18, color: Colors.white70),
    ),
    FSNavbarItem(
      label: 'Analytics',
      onTap: () {},
      icon: Icon(Icons.analytics, size: 18, color: Colors.white70),
    ),
  ],
  customItems: [
    IconButton(
      icon: Icon(Icons.notifications, color: Colors.white),
      onPressed: () {},
    ),
    IconButton(
      icon: Icon(Icons.settings, color: Colors.white),
      onPressed: () {},
    ),
    SizedBox(width: 8),
    PopupMenuButton(
      icon: CircleAvatar(
        radius: 16,
        backgroundImage: NetworkImage('https://picsum.photos/100'),
      ),
      itemBuilder: (context) => [
        PopupMenuItem(child: Text('Profile')),
        PopupMenuItem(child: Text('Settings')),
        PopupMenuDivider(),
        PopupMenuItem(child: Text('Logout')),
      ],
    ),
  ],
  variant: FSNavbarVariant.dark,
  position: FSNavbarPosition.fixedTop,
)
```

## Accessibility Notes

FlutstrapNavbar includes comprehensive accessibility features:

- **Screen Reader Support**: Uses proper semantic labels and landmarks
- **Keyboard Navigation**: Full support for Tab, Enter, Escape keys
- **Focus Management**: Proper focus handling for dropdowns and mobile menu
- **ARIA Attributes**: Announces navigation state to screen readers
- **High Contrast**: All variants support high contrast modes

```dart
FlutstrapNavbar(
  brandText: 'Accessible App', // Used for semantic label
  items: items,
  // Automatically handles keyboard navigation and screen reader announcements
)
```

## Responsive Behavior

### Mobile Breakpoints

The navbar automatically switches to mobile view below 768px (md breakpoint). In mobile view:

- Navigation items move to hamburger menu
- Search field is hidden (can be shown in mobile menu if needed)
- Brand remains visible
- Custom items may be hidden or moved to menu

### Custom Responsive Behavior

```dart
LayoutBuilder(
  builder: (context, constraints) {
    final isMobile = constraints.maxWidth < 600;

    return FlutstrapNavbar(
      brandText: 'Responsive App',
      items: isMobile ? mobileItems : desktopItems,
      showSearch: !isMobile, // Hide search on mobile
      customItems: isMobile ? null : desktopCustomItems,
      variant: FSNavbarVariant.primary,
    );
  },
)
```

## Performance Features

### Optimized State Management

- **Efficient Hover States**: Single state map for all desktop item hovers
- **Dropdown State Management**: Optimized dropdown open/close states
- **Mobile Menu Animation**: Smooth animations with proper controller disposal

### Item Count Limits

```dart
// Navbar automatically validates item count
FlutstrapNavbar(
  items: items, // Maximum 15 items allowed
  // Throws assertion error if more than 15 items provided
)
```

## Best Practices

### Navigation Structure

```dart
// ✅ Good - Clear hierarchy with dropdowns
FlutstrapNavbar(
  items: [
    FSNavbarItem.simple(label: 'Home', onTap: () {}),
    FSNavbarItem.dropdown(
      label: 'Products',
      children: [
        FSNavbarItem(label: 'Category A', onTap: () {}),
        FSNavbarItem(label: 'Category B', onTap: () {}),
      ],
    ),
  ],
)

// ❌ Avoid - Too many top-level items
FlutstrapNavbar(
  items: List.generate(10, (i) =>
    FSNavbarItem.simple(label: 'Item $i', onTap: () {})
  ), // Too many items - consider using dropdowns
)
```

### Branding Guidelines

```dart
// ✅ Good - Clear, recognizable branding
FlutstrapNavbar(
  brand: Row(
    children: [
      Image.asset('assets/logo.png', height: 32),
      SizedBox(width: 8),
      Text('My App', style: TextStyle(fontWeight: FontWeight.bold)),
    ],
  ),
  items: items,
)

// ❌ Avoid - Unclear or missing branding
FlutstrapNavbar(
  brandText: '', // Empty brand text
  items: items,
)
```

## Troubleshooting

### Common Issues and Solutions

**Navbar Not Responding to Taps**

```dart
// Ensure items have proper onTap handlers
FlutstrapNavbar(
  items: [
    FSNavbarItem(
      label: 'Home',
      onTap: () => print('Home tapped'), // Must not be null
      enabled: true, // Must be true for item to be tappable
    ),
  ],
)
```

**Dropdown Not Working**

```dart
// Ensure dropdown items have children
FlutstrapNavbar(
  items: [
    FSNavbarItem.dropdown(
      label: 'Products',
      children: [ // Must not be empty
        FSNavbarItem(label: 'Product A', onTap: () {}),
        FSNavbarItem(label: 'Product B', onTap: () {}),
      ],
    ),
  ],
)
```

**Mobile Menu Not Opening**

```dart
// Check if you're within item count limits
FlutstrapNavbar(
  items: items, // Maximum 15 items
  // If you have more than 15 items, consider restructuring
)
```

**Fixed Position Issues**

```dart
// Ensure proper parent structure for fixed positioning
Scaffold(
  body: Column(
    children: [
      FlutstrapNavbar(
        position: FSNavbarPosition.fixedTop,
        // ... other properties
      ),
      Expanded(
        child: YourContent(), // Content should be in Expanded
      ),
    ],
  ),
)
```

This comprehensive guide covers all aspects of using the FlutstrapNavbar component. The navbar system is designed to be highly flexible, responsive, and accessible while providing a robust navigation solution for various application types and screen sizes.
