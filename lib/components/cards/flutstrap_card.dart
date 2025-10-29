/// Flutstrap Card
///
/// A high-performance, flexible card component with comprehensive theming,
/// multiple variants, and optimized rendering patterns.
///
/// {@macro flutstrap_card.usage}
/// {@macro flutstrap_card.accessibility}
///
/// {@template flutstrap_card.usage}
/// ## Usage Examples
///
/// ```dart
/// // Basic card with text content
/// FlutstrapCard(
///   headerText: 'Card Title',
///   bodyText: 'Card content goes here...',
///   footerText: 'Footer text',
/// )
///
/// // Interactive card with tap action
/// FlutstrapCard.interactive(
///   title: 'Clickable Card',
///   content: 'Tap me for action',
///   onTap: () => print('Card tapped'),
///   trailing: Icon(Icons.chevron_right),
/// )
///
/// // Image card with custom layout
/// FlutstrapCard.image(
///   image: Image.network('https://example.com/image.jpg'),
///   title: 'Beautiful Image',
///   content: 'This card features an image header',
///   actions: [
///     FlutstrapButton(
///       onPressed: () {},
///       child: Text('Action'),
///     ),
///   ],
/// )
/// ```
/// {@endtemplate}
///
/// {@template flutstrap_card.accessibility}
/// ## Accessibility
///
/// - Uses `Semantics` widget for screen readers
/// - Provides proper semantic labels for card content
/// - Supports interactive states with proper cursor feedback
/// - Follows WCAG contrast guidelines
/// {@endtemplate}
///
/// {@category Components}
/// {@category Layout}

import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../../core/spacing.dart';

/// Flutstrap Card Variants
///
/// Defines the visual style variants for cards
enum FSCardVariant {
  elevated,
  outlined,
  filled,
  surface,
}

/// Flutstrap Card Component
///
/// A container for displaying content and actions in a card format
/// with comprehensive theming, flexible layouts, and performance optimizations.
@immutable
class FlutstrapCard extends StatelessWidget {
  final Widget? header;
  final String? headerText;
  final Widget? body;
  final String? bodyText;
  final Widget? footer;
  final String? footerText;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? elevation;
  final double borderRadius;
  final double borderWidth;
  final List<BoxShadow>? shadow;
  final bool showDividers;
  final FSCardVariant variant;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool interactive;

  const FlutstrapCard({
    super.key,
    this.header,
    this.headerText,
    this.body,
    this.bodyText,
    this.footer,
    this.footerText,
    this.padding,
    this.backgroundColor,
    this.borderColor,
    this.elevation,
    this.borderRadius = _CardConstants.defaultBorderRadius,
    this.borderWidth = _CardConstants.defaultBorderWidth,
    this.shadow,
    this.showDividers = true,
    this.variant = FSCardVariant.elevated,
    this.onTap,
    this.onLongPress,
    this.interactive = false,
  })  : assert(header == null || headerText == null,
            'Cannot provide both header and headerText'),
        assert(body == null || bodyText == null,
            'Cannot provide both body and bodyText'),
        assert(footer == null || footerText == null,
            'Cannot provide both footer and footerText');

  /// Create a card using theme configuration
  factory FlutstrapCard.themed({
    Key? key,
    required BuildContext context,
    Widget? header,
    String? headerText,
    Widget? body,
    String? bodyText,
    Widget? footer,
    String? footerText,
    EdgeInsetsGeometry? padding,
    Color? backgroundColor,
    Color? borderColor,
    double? elevation,
    double? borderRadius,
    double? borderWidth,
    List<BoxShadow>? shadow,
    bool? showDividers,
    FSCardVariant? variant,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    bool? interactive,
  }) {
    final theme = FSTheme.of(context);
    final computedStyles = _CardComputedStyles(theme, variant);

    return FlutstrapCard(
      key: key,
      header: header,
      headerText: headerText,
      body: body,
      bodyText: bodyText,
      footer: footer,
      footerText: footerText,
      padding: padding ?? EdgeInsets.all(FSSpacing.md),
      backgroundColor: backgroundColor ?? computedStyles.backgroundColor,
      borderColor: borderColor ?? theme.colors.outline,
      elevation: elevation ?? computedStyles.elevation,
      borderRadius: borderRadius ?? _CardConstants.defaultBorderRadius,
      borderWidth: borderWidth ?? _CardConstants.defaultBorderWidth,
      shadow: shadow,
      showDividers: showDividers ?? true,
      variant: variant ?? FSCardVariant.elevated,
      onTap: onTap,
      onLongPress: onLongPress,
      interactive: interactive ?? false,
    );
  }

  // STYLE CACHING FOR PERFORMANCE
  static final _styleCache = <_CardStyleCacheKey, _CardComputedStyles>{};

  @override
  Widget build(BuildContext context) {
    final theme = FSTheme.of(context);
    final computedStyles = _getComputedStyles(theme);

    return Semantics(
      container: true,
      button: interactive || onTap != null,
      label: _getSemanticLabel(),
      child: _buildCard(theme, computedStyles),
    );
  }

  Widget _buildCard(FSThemeData theme, _CardComputedStyles computedStyles) {
    final effectiveBackgroundColor =
        backgroundColor ?? computedStyles.backgroundColor;
    final effectiveElevation = elevation ?? computedStyles.elevation;
    final effectiveBorderColor = borderColor ?? theme.colors.outline;

    Widget cardContent = _buildCardContent(theme);

    // Wrap with gesture detector if interactive
    if (interactive || onTap != null || onLongPress != null) {
      cardContent = MouseRegion(
        cursor:
            interactive ? SystemMouseCursors.click : SystemMouseCursors.basic,
        child: GestureDetector(
          onTap: onTap,
          onLongPress: onLongPress,
          child: cardContent,
        ),
      );
    }

    return Card(
      color: effectiveBackgroundColor,
      elevation: effectiveElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        side: variant == FSCardVariant.outlined
            ? BorderSide(
                color: effectiveBorderColor,
                width: borderWidth,
              )
            : BorderSide.none,
      ),
      shadowColor: theme.colors.shadow,
      child: cardContent,
    );
  }

  Widget _buildCardContent(FSThemeData theme) {
    final hasHeader = header != null || headerText != null;
    final hasBody = body != null || bodyText != null;
    final hasFooter = footer != null || footerText != null;

    if (!hasHeader && !hasBody && !hasFooter) {
      return const SizedBox.shrink();
    }

    final contentPadding = padding ?? EdgeInsets.all(FSSpacing.md);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (hasHeader) _buildHeader(theme, contentPadding),
        if (hasHeader && hasBody && showDividers) _buildDivider(theme),
        if (hasBody) _buildBody(theme, contentPadding),
        if (hasBody && hasFooter && showDividers) _buildDivider(theme),
        if (hasFooter) _buildFooter(theme, contentPadding),
      ],
    );
  }

  Widget _buildHeader(FSThemeData theme, EdgeInsetsGeometry padding) {
    return Padding(
      padding: padding,
      child: DefaultTextStyle(
        style: theme.typography.titleLarge.copyWith(
          fontWeight: FontWeight.w600,
          color: theme.colors.onBackground,
        ),
        child: header ?? Text(headerText!),
      ),
    );
  }

  Widget _buildBody(FSThemeData theme, EdgeInsetsGeometry padding) {
    return Padding(
      padding: padding,
      child: DefaultTextStyle(
        style: theme.typography.bodyMedium.copyWith(
          color: theme.colors.onBackground.withOpacity(0.87),
        ),
        child: body ?? Text(bodyText!),
      ),
    );
  }

  Widget _buildFooter(FSThemeData theme, EdgeInsetsGeometry padding) {
    return Padding(
      padding: padding,
      child: DefaultTextStyle(
        style: theme.typography.bodySmall.copyWith(
          color: theme.colors.onBackground.withOpacity(0.6),
        ),
        child: footer ?? Text(footerText!),
      ),
    );
  }

  Widget _buildDivider(FSThemeData theme) {
    return Divider(
      height: 1,
      thickness: 1,
      color: theme.colors.outline.withOpacity(_CardConstants.dividerOpacity),
    );
  }

  String _getSemanticLabel() {
    final labels = <String>[];
    if (headerText != null) labels.add('Header: $headerText');
    if (bodyText != null) labels.add('Content: $bodyText');
    if (footerText != null) labels.add('Footer: $footerText');
    return labels.join(', ');
  }

  _CardComputedStyles _getComputedStyles(FSThemeData theme) {
    final cacheKey = _CardStyleCacheKey(variant, theme.brightness);
    return _styleCache.putIfAbsent(
        cacheKey, () => _CardComputedStyles(theme, variant));
  }

  // CONVENIENCE: Builder methods using copyWith
  FlutstrapCard copyWith({
    Key? key,
    Widget? header,
    String? headerText,
    Widget? body,
    String? bodyText,
    Widget? footer,
    String? footerText,
    EdgeInsetsGeometry? padding,
    Color? backgroundColor,
    Color? borderColor,
    double? elevation,
    double? borderRadius,
    double? borderWidth,
    List<BoxShadow>? shadow,
    bool? showDividers,
    FSCardVariant? variant,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    bool? interactive,
  }) {
    return FlutstrapCard(
      key: key ?? this.key,
      header: header ?? this.header,
      headerText: headerText ?? this.headerText,
      body: body ?? this.body,
      bodyText: bodyText ?? this.bodyText,
      footer: footer ?? this.footer,
      footerText: footerText ?? this.footerText,
      padding: padding ?? this.padding,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      elevation: elevation ?? this.elevation,
      borderRadius: borderRadius ?? this.borderRadius,
      borderWidth: borderWidth ?? this.borderWidth,
      shadow: shadow ?? this.shadow,
      showDividers: showDividers ?? this.showDividers,
      variant: variant ?? this.variant,
      onTap: onTap ?? this.onTap,
      onLongPress: onLongPress ?? this.onLongPress,
      interactive: interactive ?? this.interactive,
    );
  }

  // CONVENIENCE: Builder methods using copyWith
  FlutstrapCard withHeader(String headerText) =>
      copyWith(headerText: headerText);
  FlutstrapCard withBody(String bodyText) => copyWith(bodyText: bodyText);
  FlutstrapCard withFooter(String footerText) =>
      copyWith(footerText: footerText);
  FlutstrapCard withPadding(EdgeInsetsGeometry customPadding) =>
      copyWith(padding: customPadding);
  FlutstrapCard withBackground(Color color) => copyWith(backgroundColor: color);
  FlutstrapCard asOutlined() => copyWith(variant: FSCardVariant.outlined);
  FlutstrapCard asFilled() => copyWith(variant: FSCardVariant.filled);
  FlutstrapCard asElevated() => copyWith(variant: FSCardVariant.elevated);
  FlutstrapCard withoutDividers() => copyWith(showDividers: false);
  FlutstrapCard asInteractive() => copyWith(interactive: true);

  // FACTORY: Common card patterns
  factory FlutstrapCard.simple({
    required String title,
    required String content,
    String? footer,
    EdgeInsetsGeometry? padding,
    FSCardVariant variant = FSCardVariant.elevated,
  }) {
    return FlutstrapCard(
      headerText: title,
      bodyText: content,
      footerText: footer,
      padding: padding,
      variant: variant,
    );
  }

  factory FlutstrapCard.image({
    required Widget image,
    String? title,
    String? content,
    List<Widget>? actions,
    EdgeInsetsGeometry? padding,
    FSCardVariant variant = FSCardVariant.elevated,
  }) {
    return FlutstrapCard(
      header: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
                top: Radius.circular(_CardConstants.defaultBorderRadius)),
            child: image,
          ),
          if (title != null) ...[
            SizedBox(height: FSSpacing.sm),
            Padding(
              padding: EdgeInsets.all(FSSpacing.md),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ],
      ),
      body: content != null ? Text(content) : null,
      footer: actions != null
          ? Padding(
              padding: EdgeInsets.all(FSSpacing.md),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: actions,
              ),
            )
          : null,
      padding: padding,
      variant: variant,
    );
  }

  factory FlutstrapCard.action({
    required String title,
    required String content,
    required List<Widget> actions,
    EdgeInsetsGeometry? padding,
    FSCardVariant variant = FSCardVariant.elevated,
  }) {
    return FlutstrapCard(
      headerText: title,
      bodyText: content,
      footer: Padding(
        padding: EdgeInsets.all(FSSpacing.md),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: actions,
        ),
      ),
      padding: padding,
      variant: variant,
    );
  }

  factory FlutstrapCard.interactive({
    required String title,
    required String content,
    required VoidCallback onTap,
    Widget? trailing,
    EdgeInsetsGeometry? padding,
    FSCardVariant variant = FSCardVariant.elevated,
  }) {
    return FlutstrapCard(
      headerText: title,
      bodyText: content,
      footer: trailing != null
          ? Padding(
              padding: EdgeInsets.all(FSSpacing.md),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [trailing],
              ),
            )
          : null,
      padding: padding,
      variant: variant,
      onTap: onTap,
      interactive: true,
    );
  }
}

// COMPUTED STYLES FOR BETTER PERFORMANCE
class _CardComputedStyles {
  final FSThemeData theme;
  final FSCardVariant? variant;

  _CardComputedStyles(this.theme, this.variant);

  Color get backgroundColor {
    switch (variant) {
      case FSCardVariant.filled:
        return theme.colors.surface.withOpacity(_CardConstants.filledOpacity);
      case FSCardVariant.surface:
        return theme.colors.surface;
      case FSCardVariant.outlined:
      case FSCardVariant.elevated:
      default:
        return theme.colors.background;
    }
  }

  double get elevation {
    switch (variant) {
      case FSCardVariant.elevated:
        return _CardConstants.elevatedCardElevation;
      default:
        return 0.0;
    }
  }
}

// STYLE CACHE KEY FOR EFFICIENT CACHING
class _CardStyleCacheKey {
  final FSCardVariant? variant;
  final Brightness brightness;

  const _CardStyleCacheKey(this.variant, this.brightness);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _CardStyleCacheKey &&
          runtimeType == other.runtimeType &&
          variant == other.variant &&
          brightness == other.brightness;

  @override
  int get hashCode => Object.hash(variant, brightness);
}

// CONSTANTS FOR BETTER MAINTAINABILITY
class _CardConstants {
  static const double defaultBorderRadius = 8.0;
  static const double defaultBorderWidth = 1.0;
  static const double elevatedCardElevation = 2.0;
  static const double filledOpacity = 0.1;
  static const double dividerOpacity = 0.1;
}
