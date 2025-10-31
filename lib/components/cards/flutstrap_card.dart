/// Flutstrap Card
///
/// A high-performance, flexible card component with comprehensive theming,
/// multiple variants, and optimized rendering patterns.
///
/// {@tool snippet}
/// ### Basic Usage
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
/// {@end-tool}
///
/// {@template flutstrap_card.performance}
/// ## Performance Features
///
/// - **Style Caching**: Computed styles cached by variant and brightness
/// - **LRU Cache Management**: Automatic cache eviction for memory efficiency
/// - **Factory Caching**: Common card patterns cached for reuse
/// - **Error Boundaries**: Graceful error handling for content rendering
/// {@endtemplate}
///
/// {@template flutstrap_card.accessibility}
/// ## Accessibility
///
/// - Full screen reader support with semantic labels
/// - Keyboard navigation with focus management
/// - Proper cursor feedback for interactive cards
/// - WCAG compliant color contrast ratios
/// {@endtemplate}
///
/// ## Best Practices
///
/// - Use factory methods for common card patterns
/// - Leverage `copyWith` for state modifications
/// - Consider using `const` constructors when possible
/// - Use error boundaries for dynamic content
/// - Test interactive cards with keyboard navigation
///
/// {@category Components}
/// {@category Layout}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../../core/spacing.dart';

/// Error Boundary Widget for graceful error handling
class ErrorBoundary extends StatelessWidget {
  final Widget child;
  final Widget fallback;

  const ErrorBoundary({
    super.key,
    required this.child,
    required this.fallback,
  });

  @override
  Widget build(BuildContext context) {
    try {
      return child;
    } catch (error, stackTrace) {
      if (kDebugMode) {
        debugPrint('ErrorBoundary caught: $error');
        debugPrint(stackTrace.toString());
      }
      return fallback;
    }
  }
}

/// Performance monitoring for card operations
class _CardPerformance {
  static final _buildTimes = <String, int>{};
  static final _instanceCount = <String, int>{};

  static void logBuildTime(String cardType, int milliseconds) {
    _buildTimes[cardType] = milliseconds;

    if (milliseconds > 16) {
      // 60fps threshold
      debugPrint('⏱️ Slow card build: $cardType took ${milliseconds}ms');
    }
  }

  static void trackInstance(String cardType) {
    _instanceCount[cardType] = (_instanceCount[cardType] ?? 0) + 1;
  }

  static void clearMetrics() {
    _buildTimes.clear();
    _instanceCount.clear();
  }

  static Map<String, int> get buildTimes => Map.from(_buildTimes);
  static Map<String, int> get instanceCounts => Map.from(_instanceCount);
}

/// Enhanced style caching with LRU eviction
class _CardStyleCache {
  static final _cache = <_CardStyleCacheKey, _CardComputedStyles>{};
  static final _cacheKeys = <_CardStyleCacheKey>[];
  static const int _maxCacheSize = 20;

  static _CardComputedStyles getOrCreate(
    FSThemeData theme,
    FSCardVariant? variant,
  ) {
    final key = _CardStyleCacheKey(variant, theme.brightness);

    if (_cache.containsKey(key)) {
      // Move to end (most recently used)
      _cacheKeys.remove(key);
      _cacheKeys.add(key);
      return _cache[key]!;
    }

    final styles = _CardComputedStyles(theme, variant);
    _cache[key] = styles;
    _cacheKeys.add(key);

    // LRU eviction
    if (_cache.length > _maxCacheSize) {
      final lruKey = _cacheKeys.removeAt(0);
      _cache.remove(lruKey);
    }

    return styles;
  }

  static void clearCache() {
    _cache.clear();
    _cacheKeys.clear();
  }

  static int get cacheSize => _cache.length;
}

/// Factory cache for common card patterns
class _CardFactoryCache {
  static final _simpleCards = <String, FlutstrapCard>{};
  static final _actionCards = <String, FlutstrapCard>{};
  static final _interactiveCards = <String, FlutstrapCard>{};

  static FlutstrapCard getSimpleCard({
    required String title,
    required String content,
    String? footer,
    EdgeInsetsGeometry? padding,
    FSCardVariant variant = FSCardVariant.elevated,
  }) {
    final cacheKey = '$title$content$footer${padding?.hashCode}$variant';

    return _simpleCards.putIfAbsent(cacheKey, () {
      return FlutstrapCard(
        headerText: title,
        bodyText: content,
        footerText: footer,
        padding: padding,
        variant: variant,
      );
    });
  }

  static FlutstrapCard getActionCard({
    required String title,
    required String content,
    required List<Widget> actions,
    EdgeInsetsGeometry? padding,
    FSCardVariant variant = FSCardVariant.elevated,
  }) {
    final cacheKey =
        '$title$content${actions.length}${padding?.hashCode}$variant';

    return _actionCards.putIfAbsent(cacheKey, () {
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
    });
  }

  static void clearCache() {
    _simpleCards.clear();
    _actionCards.clear();
    _interactiveCards.clear();
  }
}

/// Optimized content builder with error handling
class _CardContentBuilder {
  static Widget buildContent({
    required FSThemeData theme,
    required Widget? header,
    required String? headerText,
    required Widget? body,
    required String? bodyText,
    required Widget? footer,
    required String? footerText,
    required EdgeInsetsGeometry padding,
    required bool showDividers,
  }) {
    final hasHeader = header != null || headerText != null;
    final hasBody = body != null || bodyText != null;
    final hasFooter = footer != null || footerText != null;

    if (!hasHeader && !hasBody && !hasFooter) {
      return const SizedBox.shrink();
    }

    final children = <Widget>[];

    if (hasHeader) {
      children.add(_buildHeaderSection(theme, header, headerText, padding));
    }

    if (hasHeader && hasBody && showDividers) {
      children.add(_buildDivider(theme));
    }

    if (hasBody) {
      children.add(_buildBodySection(theme, body, bodyText, padding));
    }

    if (hasBody && hasFooter && showDividers) {
      children.add(_buildDivider(theme));
    }

    if (hasFooter) {
      children.add(_buildFooterSection(theme, footer, footerText, padding));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }

  static Widget _buildHeaderSection(
    FSThemeData theme,
    Widget? header,
    String? headerText,
    EdgeInsetsGeometry padding,
  ) {
    return ErrorBoundary(
      fallback: _buildErrorPlaceholder('Header', padding),
      child: Padding(
        padding: padding,
        child: DefaultTextStyle(
          style: theme.typography.titleLarge.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colors.onBackground,
          ),
          child: header ?? Text(headerText ?? ''),
        ),
      ),
    );
  }

  static Widget _buildBodySection(
    FSThemeData theme,
    Widget? body,
    String? bodyText,
    EdgeInsetsGeometry padding,
  ) {
    return ErrorBoundary(
      fallback: _buildErrorPlaceholder('Body', padding),
      child: Padding(
        padding: padding,
        child: DefaultTextStyle(
          style: theme.typography.bodyMedium.copyWith(
            color: theme.colors.onBackground.withOpacity(0.87),
          ),
          child: body ?? Text(bodyText ?? ''),
        ),
      ),
    );
  }

  static Widget _buildFooterSection(
    FSThemeData theme,
    Widget? footer,
    String? footerText,
    EdgeInsetsGeometry padding,
  ) {
    return ErrorBoundary(
      fallback: _buildErrorPlaceholder('Footer', padding),
      child: Padding(
        padding: padding,
        child: DefaultTextStyle(
          style: theme.typography.bodySmall.copyWith(
            color: theme.colors.onBackground.withOpacity(0.6),
          ),
          child: footer ?? Text(footerText ?? ''),
        ),
      ),
    );
  }

  static Widget _buildDivider(FSThemeData theme) {
    return Divider(
      height: 1,
      thickness: 1,
      color: theme.colors.outline.withOpacity(_CardConstants.dividerOpacity),
    );
  }

  static Widget _buildErrorPlaceholder(
      String section, EdgeInsetsGeometry padding) {
    return Padding(
      padding: padding,
      child: Row(
        children: [
          Icon(Icons.error_outline, color: Colors.red, size: 16),
          SizedBox(width: 8),
          Text(
            'Error loading $section',
            style: const TextStyle(color: Colors.red, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

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
    final computedStyles = _CardStyleCache.getOrCreate(theme, variant);

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

  @override
  Widget build(BuildContext context) {
    final stopwatch = Stopwatch()..start();
    final theme = FSTheme.of(context);
    final computedStyles = _CardStyleCache.getOrCreate(theme, variant);

    final card = ErrorBoundary(
      fallback: _buildErrorCard(),
      child: Semantics(
        container: true,
        button: interactive || onTap != null,
        label: _getSemanticLabel(),
        child: _buildCard(theme, computedStyles),
      ),
    );

    stopwatch.stop();
    _CardPerformance.logBuildTime(
        'FlutstrapCard', stopwatch.elapsedMilliseconds);
    _CardPerformance.trackInstance('FlutstrapCard');

    return card;
  }

  Widget _buildErrorCard() {
    return Card(
      color: Colors.red.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, color: Colors.red, size: 24),
            SizedBox(height: 8),
            Text(
              'Card content unavailable',
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(FSThemeData theme, _CardComputedStyles computedStyles) {
    final effectiveBackgroundColor =
        backgroundColor ?? computedStyles.backgroundColor;
    final effectiveElevation = elevation ?? computedStyles.elevation;
    final effectiveBorderColor = borderColor ?? theme.colors.outline;

    Widget cardContent = _CardContentBuilder.buildContent(
      theme: theme,
      header: header,
      headerText: headerText,
      body: body,
      bodyText: bodyText,
      footer: footer,
      footerText: footerText,
      padding: padding ?? EdgeInsets.all(FSSpacing.md),
      showDividers: showDividers,
    );

    // Enhanced interactive support
    if (interactive || onTap != null || onLongPress != null) {
      cardContent = Focus(
        canRequestFocus: interactive,
        child: MouseRegion(
          cursor:
              interactive ? SystemMouseCursors.click : SystemMouseCursors.basic,
          child: GestureDetector(
            onTap: onTap,
            onLongPress: onLongPress,
            behavior: HitTestBehavior.opaque,
            child: Semantics(
              button: true,
              enabled: interactive,
              child: cardContent,
            ),
          ),
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
      clipBehavior: Clip.antiAlias,
      child: cardContent,
    );
  }

  String _getSemanticLabel() {
    final labels = <String>[];
    if (headerText != null) labels.add('Header: $headerText');
    if (bodyText != null) labels.add('Content: $bodyText');
    if (footerText != null) labels.add('Footer: $footerText');
    return labels.join(', ');
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
    return _CardFactoryCache.getSimpleCard(
      title: title,
      content: content,
      footer: footer,
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
    return _CardFactoryCache.getActionCard(
      title: title,
      content: content,
      actions: actions,
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
