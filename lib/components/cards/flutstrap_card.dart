/// Flutstrap Card
///
/// A flexible card component with header, body, and footer sections
/// inspired by Bootstrap's card system.

import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../../core/spacing.dart';

/// Flutstrap Card Component
///
/// A container for displaying content and actions in a card format
/// with optional header, footer, and various styling options.
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
  final bool outlined;

  const FlutstrapCard({
    Key? key,
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
    this.borderRadius = 8.0,
    this.borderWidth = 1.0,
    this.shadow,
    this.outlined = false,
  })  : assert(header == null || headerText == null,
            'Cannot provide both header and headerText'),
        assert(body == null || bodyText == null,
            'Cannot provide both body and bodyText'),
        assert(footer == null || footerText == null,
            'Cannot provide both footer and footerText'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = FSTheme.of(context);
    final colors = theme.colors;

    return Card(
      color: backgroundColor ?? colors.surface,
      elevation: elevation ?? (outlined ? 0 : 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        side: outlined
            ? BorderSide(
                color: borderColor ?? colors.outline,
                width: borderWidth,
              )
            : BorderSide.none,
      ),
      shadowColor: colors.shadow,
      child: _buildCardContent(theme),
    );
  }

  Widget _buildCardContent(FSThemeData theme) {
    final hasHeader = header != null || headerText != null;
    final hasBody = body != null || bodyText != null;
    final hasFooter = footer != null || footerText != null;

    final contentPadding = padding ?? EdgeInsets.all(FSSpacing.md);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (hasHeader) _buildHeader(theme, contentPadding),
        if (hasHeader && hasBody) _buildDivider(theme),
        if (hasBody) _buildBody(theme, contentPadding),
        if (hasBody && hasFooter) _buildDivider(theme),
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
        ),
        child: header ?? Text(headerText!),
      ),
    );
  }

  Widget _buildBody(FSThemeData theme, EdgeInsetsGeometry padding) {
    return Padding(
      padding: padding,
      child: DefaultTextStyle(
        style: theme.typography.bodyMedium,
        child: body ?? Text(bodyText!),
      ),
    );
  }

  Widget _buildFooter(FSThemeData theme, EdgeInsetsGeometry padding) {
    return Padding(
      padding: padding,
      child: DefaultTextStyle(
        style: theme.typography.bodySmall.copyWith(
          color: theme.colors.onSurface.withOpacity(0.7),
        ),
        child: footer ?? Text(footerText!),
      ),
    );
  }

  Widget _buildDivider(FSThemeData theme) {
    return Divider(
      height: 1,
      thickness: 1,
      color: theme.colors.outline.withOpacity(0.1),
    );
  }

  // Builder methods for common card patterns
  FlutstrapCard withHeader(String headerText) {
    return FlutstrapCard(
      headerText: headerText,
      body: body,
      bodyText: bodyText,
      footer: footer,
      footerText: footerText,
      padding: padding,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      elevation: elevation,
      borderRadius: borderRadius,
      borderWidth: borderWidth,
      shadow: shadow,
      outlined: outlined,
    );
  }

  FlutstrapCard withBody(String bodyText) {
    return FlutstrapCard(
      header: header,
      headerText: headerText,
      bodyText: bodyText,
      footer: footer,
      footerText: footerText,
      padding: padding,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      elevation: elevation,
      borderRadius: borderRadius,
      borderWidth: borderWidth,
      shadow: shadow,
      outlined: outlined,
    );
  }

  FlutstrapCard withFooter(String footerText) {
    return FlutstrapCard(
      header: header,
      headerText: headerText,
      body: body,
      bodyText: bodyText,
      footerText: footerText,
      padding: padding,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      elevation: elevation,
      borderRadius: borderRadius,
      borderWidth: borderWidth,
      shadow: shadow,
      outlined: outlined,
    );
  }

  FlutstrapCard outlinedCard() {
    return FlutstrapCard(
      header: header,
      headerText: headerText,
      body: body,
      bodyText: bodyText,
      footer: footer,
      footerText: footerText,
      padding: padding,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      elevation: elevation,
      borderRadius: borderRadius,
      borderWidth: borderWidth,
      shadow: shadow,
      outlined: true,
    );
  }

  FlutstrapCard withPadding(EdgeInsetsGeometry customPadding) {
    return FlutstrapCard(
      header: header,
      headerText: headerText,
      body: body,
      bodyText: bodyText,
      footer: footer,
      footerText: footerText,
      padding: customPadding,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      elevation: elevation,
      borderRadius: borderRadius,
      borderWidth: borderWidth,
      shadow: shadow,
      outlined: outlined,
    );
  }

  FlutstrapCard withBackground(Color color) {
    return FlutstrapCard(
      header: header,
      headerText: headerText,
      body: body,
      bodyText: bodyText,
      footer: footer,
      footerText: footerText,
      padding: padding,
      backgroundColor: color,
      borderColor: borderColor,
      elevation: elevation,
      borderRadius: borderRadius,
      borderWidth: borderWidth,
      shadow: shadow,
      outlined: outlined,
    );
  }

  // Factory constructors for common card patterns
  factory FlutstrapCard.simple({
    required String title,
    required String content,
    String? footer,
    EdgeInsetsGeometry? padding,
  }) {
    return FlutstrapCard(
      headerText: title,
      bodyText: content,
      footerText: footer,
      padding: padding,
    );
  }

  factory FlutstrapCard.image({
    required Widget image,
    String? title,
    String? content,
    List<Widget>? actions,
    EdgeInsetsGeometry? padding,
  }) {
    return FlutstrapCard(
      header: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
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
                children: actions,
              ),
            )
          : null,
      padding: padding,
    );
  }

  factory FlutstrapCard.action({
    required String title,
    required String content,
    required List<Widget> actions,
    EdgeInsetsGeometry? padding,
  }) {
    return FlutstrapCard(
      headerText: title,
      bodyText: content,
      footer: Padding(
        padding: EdgeInsets.all(padding?.horizontal ?? FSSpacing.md),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: actions,
        ),
      ),
      padding: padding,
    );
  }
}
