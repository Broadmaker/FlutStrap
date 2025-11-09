# Flutstrap Visibility Component Guide

## Introduction

Flutstrap Visibility is a powerful responsive utility component that conditionally shows or hides content based on screen breakpoints. It enables developers to create adaptive layouts that respond seamlessly to different device sizes and orientations.

### What It Does

- Conditionally displays content based on screen breakpoints
- Provides factory methods for common visibility patterns
- Supports fallback content for hidden states
- Uses efficient breakpoint detection with minimal rebuilds

### When to Use

- Showing/hiding navigation elements on different screen sizes
- Displaying alternative content for mobile vs desktop
- Creating responsive layouts that adapt to screen size
- Optimizing user experience across devices

### Prerequisites

- Flutter 3.0 or higher
- Flutstrap breakpoint system (`FSBreakpoint`)
- Flutstrap responsive utilities (`FSResponsive`)

## Installation & Setup

### Required Dependencies

```dart
import 'package:flutter/material.dart';
import 'package:flutstrap/flutstrap.dart';
```

### Breakpoint Configuration

The component uses Flutstrap's default breakpoints:

```dart
enum FSBreakpoint {
  xs,   // < 576px  - Mobile portrait
  sm,   // ≥ 576px  - Mobile landscape
  md,   // ≥ 768px  - Tablets
  lg,   // ≥ 992px  - Small desktops
  xl,   // ≥ 1200px - Medium desktops
  xxl,  // ≥ 1400px - Large desktops
}
```

## Basic Usage

### Basic Conditional Visibility

```dart
FlutstrapVisibility(
  child: Text('This text appears on all screen sizes'),
  showOnXs: true,
  showOnSm: true,
  showOnMd: true,
  showOnLg: true,
  showOnXl: true,
  showOnXxl: true,
)
```

### With Fallback Content

```dart
FlutstrapVisibility(
  child: DesktopNavigation(),
  showOnXs: false,
  showOnSm: false,
  showOnMd: false,
  showOnLg: true,
  showOnXl: true,
  showOnXxl: true,
  fallback: MobileNavigation(), // Shows on mobile/tablet
)
```

## Component Variants

### Breakpoint-Specific Visibility

#### Mobile Only (XS & SM)

```dart
FlutstrapVisibility.mobileOnly(
  child: MobileMenuButton(),
  fallback: DesktopMenu(), // Shows on tablet/desktop
)
```

#### Tablet Only (MD)

```dart
FlutstrapVisibility.tabletOnly(
  child: TabletOptimizedView(),
  fallback: Container(), // Shows empty on mobile/desktop
)
```

#### Desktop Only (LG, XL, XXL)

```dart
FlutstrapVisibility.desktopOnly(
  child: SidebarNavigation(),
  fallback: BottomNavigation(), // Shows on mobile/tablet
)
```

### Individual Breakpoint Methods

#### Extra Small Screens Only

```dart
FlutstrapVisibility.xsOnly(
  child: Text('Only visible on mobile portrait'),
)
```

#### Small Screens Only

```dart
FlutstrapVisibility.smOnly(
  child: Text('Only visible on mobile landscape'),
)
```

#### Medium Screens Only

```dart
FlutstrapVisibility.mdOnly(
  child: Text('Only visible on tablets'),
)
```

#### Large Screens Only

```dart
FlutstrapVisibility.lgOnly(
  child: Text('Only visible on small desktops'),
)
```

#### Extra Large Screens Only

```dart
FlutstrapVisibility.xlOnly(
  child: Text('Only visible on medium desktops'),
)
```

#### Double Extra Large Screens Only

```dart
FlutstrapVisibility.xxlOnly(
  child: Text('Only visible on large desktops'),
)
```

### Hide Methods

#### Hide on Mobile

```dart
FlutstrapVisibility.hideOnMobile(
  child: DesktopSidebar(),
  fallback: MobileDrawer(),
)
```

#### Hide on Desktop

```dart
FlutstrapVisibility.hideOnDesktop(
  child: MobileBottomNav(),
  fallback: DesktopSideNav(),
)
```

#### Hide on Specific Breakpoints

```dart
FlutstrapVisibility.hideOnXs(
  child: Text('Hidden on mobile portrait only'),
)

FlutstrapVisibility.hideOnSm(
  child: Text('Hidden on mobile landscape only'),
)
```

## Properties & Parameters

### Parameter Reference Table

| Parameter   | Type      | Default             | Description                                              |
| ----------- | --------- | ------------------- | -------------------------------------------------------- |
| `child`     | `Widget`  | **required**        | The widget to display when visibility conditions are met |
| `showOnXs`  | `bool`    | `true`              | Show on extra small screens (< 576px)                    |
| `showOnSm`  | `bool`    | `true`              | Show on small screens (≥ 576px)                          |
| `showOnMd`  | `bool`    | `true`              | Show on medium screens (≥ 768px)                         |
| `showOnLg`  | `bool`    | `true`              | Show on large screens (≥ 992px)                          |
| `showOnXl`  | `bool`    | `true`              | Show on extra large screens (≥ 1200px)                   |
| `showOnXxl` | `bool`    | `true`              | Show on double extra large screens (≥ 1400px)            |
| `fallback`  | `Widget?` | `SizedBox.shrink()` | Widget to show when child is hidden                      |

### FSBreakpoint Reference

```dart
// Default breakpoint values:
enum FSBreakpoint {
  xs,   // 0 - 575px
  sm,   // 576px - 767px
  md,   // 768px - 991px
  lg,   // 992px - 1199px
  xl,   // 1200px - 1399px
  xxl,  // 1400px+
}
```

## Customization

### Custom Breakpoint Logic

```dart
FlutstrapVisibility(
  child: CustomWidget(),
  showOnXs: true,  // Mobile portrait
  showOnSm: false, // Hide on mobile landscape
  showOnMd: true,  // Show on tablets
  showOnLg: false, // Hide on small desktops
  showOnXl: true,  // Show on medium desktops
  showOnXxl: true, // Show on large desktops
)
```

### Using copyWith for Modifications

```dart
final baseVisibility = FlutstrapVisibility.mobileOnly(
  child: MobileComponent(),
);

// Create variations
final tabletVersion = baseVisibility.copyWith(
  showOnMd: true, // Also show on tablets
);

final withFallback = baseVisibility.copyWith(
  fallback: LoadingIndicator(),
);
```

### Complex Conditional Logic

```dart
// Show on mobile and large desktops, hide on tablets and small desktops
FlutstrapVisibility(
  child: AdaptiveComponent(),
  showOnXs: true,  // Mobile portrait
  showOnSm: true,  // Mobile landscape
  showOnMd: false, // Hide on tablets
  showOnLg: false, // Hide on small desktops
  showOnXl: true,  // Show on medium desktops
  showOnXxl: true, // Show on large desktops
)
```

## Interactivity & Behavior

### Dynamic Visibility with State

```dart
class ResponsiveLayout extends StatefulWidget {
  @override
  _ResponsiveLayoutState createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  bool _showAdvancedFeatures = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FlutstrapVisibility.desktopOnly(
          child: SwitchListTile(
            title: Text('Advanced Features'),
            value: _showAdvancedFeatures,
            onChanged: (value) {
              setState(() {
                _showAdvancedFeatures = value;
              });
            },
          ),
        ),

        if (_showAdvancedFeatures)
          FlutstrapVisibility(
            child: AdvancedPanel(),
            showOnXs: false, // Hide on mobile
            showOnSm: false, // Hide on mobile landscape
            showOnMd: true,  // Show on tablets
            showOnLg: true,  // Show on desktop
            showOnXl: true,
            showOnXxl: true,
          ),
      ],
    );
  }
}
```

### Conditional Rendering with Animation

```dart
FlutstrapVisibility(
  child: AnimatedContainer(
    duration: Duration(milliseconds: 300),
    height: 200,
    color: Colors.blue,
    child: Center(child: Text('Responsive Content')),
  ),
  showOnMd: true,
  showOnLg: true,
  showOnXl: true,
  fallback: SizedBox.shrink(), // Smoothly collapses on mobile
)
```

## Accessibility Notes

Flutstrap Visibility maintains accessibility by:

- **Semantic Preservation**: Hidden content is properly removed from semantic tree
- **Screen Readers**: Content not shown on current breakpoint is not announced
- **Focus Management**: Automatically handles focus for interactive elements
- **Performance**: Efficient rebuilds prevent accessibility tree lag

```dart
// Screen readers will only announce content visible on current breakpoint
FlutstrapVisibility.mobileOnly(
  child: Semantics(
    label: 'Mobile navigation menu',
    child: MobileNav(),
  ),
)
```

## Integration Examples

### Responsive Navigation Pattern

```dart
Scaffold(
  appBar: FlutstrapAppBar(
    title: Text('My App'),
    actions: [
      // Show on desktop, hide on mobile
      FlutstrapVisibility.desktopOnly(
        child: Row(
          children: [
            FlutstrapButton.text('Home'),
            FlutstrapButton.text('About'),
            FlutstrapButton.text('Contact'),
          ],
        ),
        fallback: FlutstrapButton(
          onPressed: _openMobileMenu,
          child: Icon(Icons.menu),
        ),
      ),
    ],
  ),
  drawer: FlutstrapVisibility.mobileOnly(
    child: Drawer(
      child: MobileNavigation(),
    ),
  ),
  body: Row(
    children: [
      // Sidebar only on desktop
      FlutstrapVisibility.desktopOnly(
        child: Container(
          width: 250,
          child: Sidebar(),
        ),
      ),

      // Main content
      Expanded(
        child: Padding(
          padding: EdgeInsets.all(FSSpacing.md),
          child: MainContent(),
        ),
      ),
    ],
  ),
)
```

### Adaptive Form Layout

```dart
Column(
  children: [
    // Single column on mobile, two columns on desktop
    FlutstrapVisibility.mobileOnly(
      child: Column(
        children: [
          FlutstrapTextField(label: 'First Name'),
          FlutstrapTextField(label: 'Last Name'),
        ],
      ),
      fallback: Row(
        children: [
          Expanded(
            child: FlutstrapTextField(label: 'First Name'),
          ),
          SizedBox(width: FSSpacing.md),
          Expanded(
            child: FlutstrapTextField(label: 'Last Name'),
          ),
        ],
      ),
    ),

    SizedBox(height: FSSpacing.lg),

    // Additional fields only on larger screens
    FlutstrapVisibility(
      child: FlutstrapTextField(label: 'Company Name'),
      showOnXs: false,
      showOnSm: false,
      showOnMd: true,
      showOnLg: true,
      showOnXl: true,
    ),
  ],
)
```

### E-commerce Product Grid

```dart
GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: _getColumnCount(context),
    crossAxisSpacing: FSSpacing.md,
    mainAxisSpacing: FSSpacing.md,
  ),
  itemCount: products.length,
  itemBuilder: (context, index) {
    return ProductCard(product: products[index]);
  },
)

int _getColumnCount(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final responsive = FSResponsive.of(screenWidth);

  switch (responsive.breakpoint) {
    case FSBreakpoint.xs:
      return 1; // 1 column on mobile portrait
    case FSBreakpoint.sm:
      return 2; // 2 columns on mobile landscape
    case FSBreakpoint.md:
      return 3; // 3 columns on tablets
    case FSBreakpoint.lg:
      return 4; // 4 columns on small desktops
    case FSBreakpoint.xl:
    case FSBreakpoint.xxl:
      return 5; // 5 columns on larger desktops
  }
}
```

## Best Practices

### Performance Recommendations

- **Minimal Rebuilds**: The component only rebuilds when breakpoint changes
- **Efficient Detection**: Uses optimized breakpoint detection
- **Const Constructors**: Use `const` where possible for better performance

```dart
// GOOD: Use const constructors when possible
FlutstrapVisibility.xsOnly(
  child: const MobileWidget(),
)

// Use fallback for smooth transitions
FlutstrapVisibility(
  child: MainContent(),
  showOnXs: false,
  showOnSm: false,
  fallback: const LoadingIndicator(), // Better than empty space
)
```

### UX Design Tips

```dart
// Provide appropriate fallbacks
FlutstrapVisibility.desktopOnly(
  child: DetailedDataTable(),
  fallback: SimpleDataList(), // Mobile-friendly alternative
)

// Use for progressive enhancement
FlutstrapVisibility(
  child: AdvancedFeatures(),
  showOnXs: false, // Basic experience on mobile
  showOnSm: false,
  showOnMd: true,  // Enhanced on tablet
  showOnLg: true,  // Full experience on desktop
)

// Maintain consistent information architecture
Column(
  children: [
    FlutstrapVisibility.mobileOnly(
      child: MobileHeader(),
    ),
    FlutstrapVisibility.desktopOnly(
      child: DesktopHeader(),
    ),

    // Core content always visible
    MainContent(),
  ],
)
```

### Breakpoint Strategy

- **Mobile First**: Design for mobile then enhance for larger screens
- **Consistent Behavior**: Maintain similar functionality across breakpoints
- **Progressive Enhancement**: Add features as screen size increases
- **Content Priority**: Ensure critical content is always accessible

## Troubleshooting

### Common Issues and Solutions

**Component not hiding/showing correctly**

```dart
// ❌ Breakpoint logic might be inverted
FlutstrapVisibility(
  child: Widget(),
  showOnXs: false, // Intended for mobile but hiding it
)

// ✅ Check your breakpoint intentions
FlutstrapVisibility.mobileOnly(
  child: MobileWidget(), // Clearly shows intent
)
```

**Fallback content not appearing**

```dart
// ❌ Fallback might be in wrong breakpoint range
FlutstrapVisibility.desktopOnly(
  child: DesktopWidget(),
  fallback: MobileWidget(), // This shows on mobile/tablet
)

// ✅ Ensure fallback covers intended ranges
FlutstrapVisibility(
  child: DesktopWidget(),
  showOnXs: false,
  showOnSm: false,
  showOnMd: false,
  showOnLg: true,
  showOnXl: true,
  showOnXxl: true,
  fallback: MobileTabletWidget(), // Shows on xs, sm, md
)
```

**Performance issues with complex layouts**

```dart
// ❌ Heavy widgets rebuilding frequently
// ✅ Use const constructors and memoization
FlutstrapVisibility(
  child: const HeavyWidget(), // Won't rebuild unnecessarily
  showOnXs: true,
  showOnSm: true,
)

// Consider conditional instantiation for very heavy widgets
bool get shouldShowHeavyWidget => // your breakpoint logic
shouldShowHeavyWidget ? const HeavyWidget() : const SizedBox.shrink()
```

**Breakpoint detection not updating**

```dart
// ❌ If breakpoints aren't updating on orientation change
// ✅ Ensure proper MediaQuery context
Widget build(BuildContext context) {
  // This will properly update on screen size changes
  return FlutstrapVisibility.mobileOnly(
    child: Text('Mobile content'),
  );
}
```

This comprehensive guide covers all aspects of using the Flutstrap Visibility component to create responsive, adaptive layouts that provide optimal user experiences across all device sizes and orientations.
