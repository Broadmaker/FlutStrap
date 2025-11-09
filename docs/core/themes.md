# Flutstrap Theming System Guide

## Introduction

Flutstrap Theming System provides a comprehensive, flexible theming solution that combines the best of Material Design 3, Bootstrap semantics, and Flutter's powerful theming capabilities. It offers a complete design system with consistent colors, typography, spacing, and animations.

### What It Does

- Provides a unified theming system with color schemes, typography, and spacing
- Supports both light and dark modes with automatic seed color generation
- Offers Material 3 compliance with Bootstrap-inspired semantic naming
- Includes responsive breakpoints and animation configurations
- Ensures accessibility and visual consistency across applications

### When to Use

- Building applications that require consistent design systems
- Implementing dark/light mode support
- Creating branded applications with custom color schemes
- Ensuring accessibility compliance across themes
- Maintaining design consistency across multiple screens and components

### Prerequisites

- Flutter 3.0 or higher
- Flutstrap Breakpoints and Spacing systems
- Basic understanding of Flutter's theming system

## Installation & Setup

### Required Dependencies

```dart
import 'package:flutter/material.dart';
import 'package:flutstrap/flutstrap.dart';
```

### Basic App Configuration

```dart
void main() {
  runApp(
    FSTheme(
      data: FSThemeData.light(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutstrap App',
      theme: ThemeData.light(), // Optional: Material theme sync
      home: HomePage(),
    );
  }
}
```

## Core Theme System

### FSThemeData Overview

The main theme data class that aggregates all theme aspects:

```dart
FSThemeData(
  colors: FSColorScheme,      // Color definitions
  typography: FSTypography,   // Text styles
  spacing: FSSpacing,         // Spacing scale
  animation: FSAnimation,     // Animation configurations
  breakpoints: FSCustomBreakpoints, // Responsive breakpoints
  brightness: Brightness,     // Light/dark mode
)
```

## Basic Usage

### Light and Dark Themes

```dart
// Simple light theme
FSTheme(
  data: FSThemeData.light(),
  child: MyApp(),
)

// Simple dark theme
FSTheme(
  data: FSThemeData.dark(),
  child: MyApp(),
)

// Custom seed color
FSTheme(
  data: FSThemeData.light(seedColor: Colors.blue),
  child: MyApp(),
)

// Material 3 theming
FSTheme(
  data: FSThemeData.material3(
    seedColor: Colors.purple,
    brightness: Brightness.light,
  ),
  child: MyApp(),
)
```

### Theme Access in Widgets

```dart
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Various ways to access theme data
    final theme = FSTheme.of(context);
    final colors = context.fsColors;
    final typography = context.fsTypography;
    final spacing = context.fsSpacing;

    return Container(
      padding: EdgeInsets.all(spacing.md),
      color: colors.primary,
      child: Text(
        'Styled Content',
        style: typography.bodyLarge.copyWith(color: colors.onPrimary),
      ),
    );
  }
}
```

## Color System

### FSColorScheme Structure

```dart
FSColorScheme(
  primary: Color,        // Primary brand color
  secondary: Color,      // Secondary brand color
  success: Color,        // Success state (green)
  danger: Color,         // Error/danger state (red)
  warning: Color,        // Warning state (yellow)
  info: Color,           // Informational state (blue)
  background: Color,     // Background color
  surface: Color,        // Surface color for cards, sheets
  onPrimary: Color,      // Text/icon color on primary
  onBackground: Color,   // Text/icon color on background
  // ... and more
)
```

### Color Usage Examples

```dart
Widget build(BuildContext context) {
  final colors = context.fsColors;

  return Column(
    children: [
      // Primary color usage
      Container(
        color: colors.primary,
        child: Text(
          'Primary Background',
          style: TextStyle(color: colors.onPrimary),
        ),
      ),

      // Semantic colors
      Container(
        color: colors.success.withOpacity(0.1),
        child: Text(
          'Success Message',
          style: TextStyle(color: colors.success),
        ),
      ),

      // Surface colors
      Card(
        color: colors.surface,
        child: ListTile(
          title: Text(
            'Card Title',
            style: TextStyle(color: colors.onSurface),
          ),
        ),
      ),
    ],
  );
}
```

### Custom Color Schemes

```dart
// Create from seed color
final customColors = FSColorScheme.fromSeed(
  seedColor: Color(0xFF6750A4),
  brightness: Brightness.light,
);

// Create Material 3 scheme
final materialColors = FSColorScheme.material3(
  seedColor: Colors.blue,
  brightness: Brightness.dark,
);

// Modify existing scheme
final modifiedColors = defaultColors.copyWith(
  primary: Colors.purple,
  success: Colors.green.shade600,
);
```

## Typography System

### FSTypography Scale

The typography system follows Material 3 guidelines with 15 text styles:

```dart
FSTypography(
  displayLarge: TextStyle,    // 57px - Largest display text
  displayMedium: TextStyle,   // 45px - Large display text
  displaySmall: TextStyle,    // 36px - Medium display text
  headlineLarge: TextStyle,   // 32px - Page headings
  headlineMedium: TextStyle,  // 28px - Section headings
  headlineSmall: TextStyle,   // 24px - Subsection headings
  titleLarge: TextStyle,      // 22px - Large titles
  titleMedium: TextStyle,     // 16px - Medium titles
  titleSmall: TextStyle,      // 14px - Small titles
  bodyLarge: TextStyle,       // 16px - Large body text
  bodyMedium: TextStyle,      // 14px - Standard body text
  bodySmall: TextStyle,       // 12px - Small body text
  labelLarge: TextStyle,      // 14px - Large labels
  labelMedium: TextStyle,     // 12px - Medium labels
  labelSmall: TextStyle,      // 11px - Small labels
)
```

### Typography Usage

```dart
Widget build(BuildContext context) {
  final text = context.fsTypography;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Display Headline', style: text.displayLarge),
      Text('Page Title', style: text.headlineMedium),
      Text('Section Header', style: text.titleLarge),
      Text('Body content goes here...', style: text.bodyMedium),
      Text('Caption text', style: text.bodySmall),
      TextButton(
        onPressed: () {},
        child: Text('Button', style: text.labelLarge),
      ),
    ],
  );
}
```

### Custom Typography

```dart
// Create from base style
final customTypography = FSTypography.fromBaseTextStyle(
  TextStyle(
    fontFamily: 'Inter',
    color: colors.onBackground,
  ),
);

// Modify existing typography
final modifiedTypography = defaultTypography.copyWith(
  bodyLarge: defaultTypography.bodyLarge.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  ),
  bodyMedium: defaultTypography.bodyMedium.copyWith(
    height: 1.6, // Better line spacing for readability
  ),
);
```

## Complete Theme Configuration

### Advanced Theme Setup

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FSTheme(
      data: FSThemeData.light(
        seedColor: Color(0xFF0066CC), // Brand blue
      ).copyWith(
        typography: FSTypography.fromBaseTextStyle(
          TextStyle(
            fontFamily: 'Inter',
            color: context.fsColors.onBackground,
          ),
        ),
        breakpoints: FSCustomBreakpoints(
          md: 900,  // Custom tablet breakpoint
          lg: 1200, // Custom desktop breakpoint
        ),
      ),
      child: MaterialApp(
        title: 'My Branded App',
        theme: _syncMaterialTheme(context),
        home: HomePage(),
      ),
    );
  }

  ThemeData _syncMaterialTheme(BuildContext context) {
    final fsTheme = FSTheme.of(context);
    return ThemeData(
      colorScheme: ColorScheme(
        primary: fsTheme.colors.primary,
        secondary: fsTheme.colors.secondary,
        surface: fsTheme.colors.surface,
        background: fsTheme.colors.background,
        error: fsTheme.colors.danger,
        onPrimary: fsTheme.colors.onPrimary,
        onSecondary: fsTheme.colors.onSecondary,
        onSurface: fsTheme.colors.onSurface,
        onBackground: fsTheme.colors.onBackground,
        onError: fsTheme.colors.onPrimary,
        brightness: fsTheme.brightness,
      ),
      useMaterial3: true,
    );
  }
}
```

## Responsive Theming

### Breakpoint-Aware Themes

```dart
class ResponsiveThemedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final responsive = FSResponsive.fromContext(context);
    final theme = context.fsTheme;

    return Container(
      padding: EdgeInsets.all(
        responsive.value<double>(
          xs: theme.spacing.sm,  // Compact on mobile
          sm: theme.spacing.md,  // Standard on small
          md: theme.spacing.lg,  // Generous on tablet
          lg: theme.spacing.xl,  // Ample on desktop
          fallback: theme.spacing.md,
        ),
      ),
      child: Text(
        'Responsive Content',
        style: context.fsTypography.bodyLarge.copyWith(
          fontSize: responsive.value<double>(
            xs: 14, sm: 16, md: 18, lg: 20, fallback: 16
          ),
        ),
      ),
    );
  }
}
```

## Dark Mode Implementation

### Complete Dark/Light Theme Setup

```dart
class ThemeManager extends StatefulWidget {
  final Widget child;

  const ThemeManager({required this.child});

  @override
  _ThemeManagerState createState() => _ThemeManagerState();
}

class _ThemeManagerState extends State<ThemeManager> {
  bool _isDarkMode = false;

  void toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FSTheme(
      data: _isDarkMode
          ? FSThemeData.dark(seedColor: Colors.blue)
          : FSThemeData.light(seedColor: Colors.blue),
      child: widget.child,
    );
  }
}

// Usage in app
void main() {
  runApp(
    ThemeManager(
      child: MyApp(),
    ),
  );
}
```

### System Theme Detection

```dart
class AdaptiveThemeWrapper extends StatelessWidget {
  final Widget child;

  const AdaptiveThemeWrapper({required this.child});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final platformBrightness = MediaQuery.platformBrightnessOf(context);

        return FSTheme(
          data: platformBrightness == Brightness.dark
              ? FSThemeData.dark()
              : FSThemeData.light(),
          child: child,
        );
      },
    );
  }
}
```

## Practical Usage Examples

### Themed Component Library

```dart
// Themed button component
class FSButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final FSButtonVariant variant;

  const FSButton({
    required this.onPressed,
    required this.text,
    this.variant = FSButtonVariant.primary,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.fsColors;
    final textStyle = context.fsTypography.labelLarge;

    Color getBackgroundColor() {
      switch (variant) {
        case FSButtonVariant.primary:
          return colors.primary;
        case FSButtonVariant.secondary:
          return colors.secondary;
        case FSButtonVariant.success:
          return colors.success;
        case FSButtonVariant.danger:
          return colors.danger;
      }
    }

    Color getTextColor() {
      switch (variant) {
        case FSButtonVariant.primary:
        case FSButtonVariant.secondary:
        case FSButtonVariant.success:
        case FSButtonVariant.danger:
          return colors.onPrimary;
      }
    }

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: getBackgroundColor(),
        foregroundColor: getTextColor(),
      ),
      child: Text(text, style: textStyle),
    );
  }
}

enum FSButtonVariant { primary, secondary, success, danger }
```

### Consistent Card Design

```dart
class FSCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;

  const FSCard({required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    final colors = context.fsColors;
    final spacing = context.fsSpacing;

    return Card(
      color: colors.surface,
      elevation: 2,
      shadowColor: colors.shadow,
      surfaceTintColor: colors.primary.withOpacity(0.05),
      child: Padding(
        padding: padding ?? EdgeInsets.all(spacing.lg),
        child: child,
      ),
    );
  }
}

// Usage
FSCard(
  child: Column(
    children: [
      Text('Card Title', style: context.fsTypography.titleLarge),
      SizedBox(height: context.fsSpacing.md),
      Text('Card content...', style: context.fsTypography.bodyMedium),
    ],
  ),
)
```

### Form Field Styling

```dart
class FSTextField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;

  const FSTextField({required this.label, this.controller});

  @override
  Widget build(BuildContext context) {
    final colors = context.fsColors;
    final text = context.fsTypography;

    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: text.bodyMedium.copyWith(color: colors.onSurface.withOpacity(0.6)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colors.outline),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colors.primary),
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: EdgeInsets.all(context.fsSpacing.md),
      ),
      style: text.bodyMedium.copyWith(color: colors.onBackground),
    );
  }
}
```

## Best Practices

### Theme Organization

```dart
// Centralized theme configuration
class AppThemes {
  static FSThemeData get light => FSThemeData.light(
        seedColor: Color(0xFF0066CC),
      ).copyWith(
        typography: _customTypography,
      );

  static FSThemeData get dark => FSThemeData.dark(
        seedColor: Color(0xFF0066CC),
      ).copyWith(
        typography: _customTypography,
      );

  static FSTypography get _customTypography =>
      FSTypography.fromBaseTextStyle(
        TextStyle(fontFamily: 'Inter'),
      );
}

// Usage
FSTheme(
  data: AppThemes.light,
  child: MyApp(),
)
```

### Performance Optimization

```dart
// ✅ GOOD: Cache theme data in stateful widgets
class _ThemedWidgetState extends State<ThemedWidget> {
  late FSThemeData _theme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _theme = FSTheme.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(color: _theme.colors.primary);
  }
}

// ✅ GOOD: Use const constructors for theme data
static const _brandTheme = FSThemeData.light(seedColor: Colors.blue);
```

### Accessibility Considerations

```dart
// Ensure proper contrast ratios
final accessibleColors = FSColorScheme.fromSeed(
  seedColor: Colors.blue,
  brightness: Brightness.light,
).copyWith(
  // Enhance contrast if needed
  onPrimary: Colors.white,
  onSurface: Colors.black87,
);

// Check contrast ratios
bool hasGoodContrast(Color background, Color text) {
  final contrast = (background.computeLuminance() + 0.05) /
                   (text.computeLuminance() + 0.05);
  return contrast >= 4.5; // WCAG AA standard
}
```

## Troubleshooting

### Common Issues and Solutions

**Theme not found in context**

```dart
// ✅ Ensure FSTheme is properly wrapped
void main() {
  runApp(
    FSTheme(  // ← Must be at root level
      data: FSThemeData.light(),
      child: MaterialApp(  // ← MaterialApp inside FSTheme
        home: MyApp(),
      ),
    ),
  );
}

// ✅ Use the extension methods for easier access
Widget build(BuildContext context) {
  final colors = context.fsColors; // Uses extension method
  // Instead of: FSTheme.of(context).colors
}
```

**Colors not updating with theme changes**

```dart
// ✅ Use context.dependOnInheritedWidgetOfExactType for reactivity
class ReactiveThemedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // This will automatically rebuild when theme changes
    final theme = FSTheme.of(context);
    return Container(color: theme.colors.primary);
  }
}
```

**Custom theme not applying**

```dart
// ✅ Ensure all required properties are set
final completeTheme = FSThemeData.light().copyWith(
  colors: customColors,
  typography: customTypography,
  spacing: customSpacing,
  // Don't forget breakpoints and animation if needed
  breakpoints: customBreakpoints,
  animation: customAnimation,
);
```

This comprehensive theming system provides everything needed to create beautifully consistent, accessible, and brand-aligned Flutter applications that work seamlessly across light and dark modes while maintaining excellent performance and developer experience.
