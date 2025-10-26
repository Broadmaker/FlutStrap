import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../../core/spacing.dart';

/// Flutstrap Pagination Variants
///
/// Defines the visual style variants for pagination
enum FSPaginationVariant {
  primary,
  secondary,
  success,
  danger,
  warning,
  info,
  light,
  dark,
}

/// Flutstrap Pagination Size
///
/// Defines the size variants for pagination
enum FSPaginationSize {
  sm,
  md,
  lg,
}

/// Flutstrap Pagination Alignment
///
/// Defines the alignment of pagination component
enum FSPaginationAlignment {
  start,
  center,
  end,
}

/// Flutstrap Pagination
///
/// A customizable pagination component with Bootstrap-inspired styling.
class FlutstrapPagination extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final int totalItems;
  final int itemsPerPage;
  final FSPaginationVariant variant;
  final FSPaginationSize size;
  final FSPaginationAlignment alignment;
  final bool showNumbers;
  final bool showPreviousNext;
  final bool showFirstLast;
  final bool showItemsCount;
  final String previousText;
  final String nextText;
  final String firstText;
  final String lastText;
  final String itemsCountText;
  final ValueChanged<int> onPageChanged;
  final int maxVisiblePages;
  final bool disabled;
  final EdgeInsetsGeometry? margin;

  const FlutstrapPagination({
    Key? key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
    this.totalItems = 0,
    this.itemsPerPage = 10,
    this.variant = FSPaginationVariant.primary,
    this.size = FSPaginationSize.md,
    this.alignment = FSPaginationAlignment.center,
    this.showNumbers = true,
    this.showPreviousNext = true,
    this.showFirstLast = false,
    this.showItemsCount = false,
    this.previousText = 'Previous',
    this.nextText = 'Next',
    this.firstText = 'First',
    this.lastText = 'Last',
    this.itemsCountText = 'Showing {start} to {end} of {total} items',
    this.maxVisiblePages = 7,
    this.disabled = false,
    this.margin,
  })  : assert(currentPage > 0, 'currentPage must be greater than 0'),
        assert(totalPages > 0, 'totalPages must be greater than 0'),
        assert(currentPage <= totalPages,
            'currentPage cannot be greater than totalPages'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = FSTheme.of(context);
    final paginationStyle = _PaginationStyle(theme, variant, size);

    final List<Widget> children = [];

    // Add items count if enabled
    if (showItemsCount && totalItems > 0) {
      children.add(
        _buildItemsCount(paginationStyle),
      );
    }

    // Add pagination controls
    children.add(
      _buildPaginationControls(paginationStyle),
    );

    return Container(
      margin: margin ?? paginationStyle.margin,
      child: Row(
        mainAxisAlignment: _getMainAxisAlignment(),
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }

  MainAxisAlignment _getMainAxisAlignment() {
    switch (alignment) {
      case FSPaginationAlignment.start:
        return MainAxisAlignment.start;
      case FSPaginationAlignment.center:
        return MainAxisAlignment.center;
      case FSPaginationAlignment.end:
        return MainAxisAlignment.end;
    }
  }

  Widget _buildItemsCount(_PaginationStyle style) {
    final startItem = ((currentPage - 1) * itemsPerPage) + 1;
    final endItem = _min(currentPage * itemsPerPage, totalItems);
    final countText = itemsCountText
        .replaceAll('{start}', startItem.toString())
        .replaceAll('{end}', endItem.toString())
        .replaceAll('{total}', totalItems.toString());

    return Padding(
      padding: style.itemsCountPadding,
      child: Text(
        countText,
        style: style.itemsCountTextStyle,
      ),
    );
  }

  // In the FlutstrapPagination build method, update the _buildPaginationControls method:
  Widget _buildPaginationControls(_PaginationStyle style) {
    final List<Widget> buttons = [];

    // First page button
    if (showFirstLast && currentPage > 1) {
      buttons.add(
        _buildPaginationButton(
          text: firstText,
          page: 1,
          style: style,
          isEdge: true,
        ),
      );
    }

    // Previous button
    if (showPreviousNext) {
      buttons.add(
        _buildPaginationButton(
          text: previousText,
          page: currentPage - 1,
          style: style,
          isEnabled: currentPage > 1,
          isEdge: true,
        ),
      );
    }

    // Page numbers
    if (showNumbers) {
      final pageNumbers = _generatePageNumbers();
      for (final page in pageNumbers) {
        if (page == -1) {
          // Ellipsis
          buttons.add(
            _buildEllipsis(style),
          );
        } else {
          buttons.add(
            _buildPaginationButton(
              text: page.toString(),
              page: page,
              style: style,
              isActive: page == currentPage,
            ),
          );
        }
      }
    }

    // Next button
    if (showPreviousNext) {
      buttons.add(
        _buildPaginationButton(
          text: nextText,
          page: currentPage + 1,
          style: style,
          isEnabled: currentPage < totalPages,
          isEdge: true,
        ),
      );
    }

    // Last page button
    if (showFirstLast && currentPage < totalPages) {
      buttons.add(
        _buildPaginationButton(
          text: lastText,
          page: totalPages,
          style: style,
          isEdge: true,
        ),
      );
    }

    // Wrap in SingleChildScrollView if there are many buttons to prevent overflow
    final content = Container(
      decoration: BoxDecoration(
        borderRadius: style.borderRadius,
        border: style.border,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: buttons,
      ),
    );

    // If there are many pages, make it scrollable
    if (totalPages > 10 && showNumbers) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: content,
      );
    }

    return content;
  }

  Widget _buildPaginationButton({
    required String text,
    required int page,
    required _PaginationStyle style,
    bool isActive = false,
    bool isEnabled = true,
    bool isEdge = false,
  }) {
    final isDisabled = disabled || !isEnabled || (isActive && !isEdge);

    return GestureDetector(
      onTap: isDisabled ? null : () => onPageChanged(page),
      child: MouseRegion(
        cursor: isDisabled
            ? SystemMouseCursors.forbidden
            : SystemMouseCursors.click,
        child: Container(
          padding: style.buttonPadding,
          decoration: BoxDecoration(
            color:
                isActive ? style.activeBackgroundColor : style.backgroundColor,
            border: isActive ? style.activeBorder : style.border,
            borderRadius: isEdge
                ? _getEdgeBorderRadius(style,
                    isFirst: text == firstText || text == previousText)
                : style.buttonBorderRadius,
          ),
          child: Text(
            text,
            style: isActive ? style.activeTextStyle : style.textStyle,
          ),
        ),
      ),
    );
  }

  BorderRadius _getEdgeBorderRadius(_PaginationStyle style,
      {required bool isFirst}) {
    if (isFirst) {
      return BorderRadius.only(
        topLeft: style.borderRadius.topLeft,
        bottomLeft: style.borderRadius.bottomLeft,
      );
    } else {
      return BorderRadius.only(
        topRight: style.borderRadius.topRight,
        bottomRight: style.borderRadius.bottomRight,
      );
    }
  }

  Widget _buildEllipsis(_PaginationStyle style) {
    return Container(
      padding: style.buttonPadding,
      child: Text(
        '...',
        style: style.textStyle.copyWith(
          color: style.textStyle.color?.withOpacity(0.5),
        ),
      ),
    );
  }

  List<int> _generatePageNumbers() {
    if (totalPages <= maxVisiblePages) {
      return List.generate(totalPages, (index) => index + 1);
    }

    final List<int> pages = [];
    final int delta = (maxVisiblePages - 1) ~/ 2; // FIXED: Removed const

    int start = currentPage - delta;
    int end = currentPage + delta;

    if (start < 1) {
      start = 1;
      end = maxVisiblePages;
    }

    if (end > totalPages) {
      end = totalPages;
      start = totalPages - maxVisiblePages + 1;
    }

    // Always show first page
    if (start > 1) {
      pages.add(1);
      if (start > 2) {
        pages.add(-1); // Ellipsis
      }
    }

    // Add middle pages
    for (int i = start; i <= end; i++) {
      pages.add(i);
    }

    // Always show last page
    if (end < totalPages) {
      if (end < totalPages - 1) {
        pages.add(-1); // Ellipsis
      }
      pages.add(totalPages);
    }

    return pages;
  }

  // Helper method for min calculation
  int _min(int a, int b) => a < b ? a : b;
}

/// Internal style configuration for pagination
class _PaginationStyle {
  final FSThemeData theme;
  final FSPaginationVariant variant;
  final FSPaginationSize size;

  _PaginationStyle(this.theme, this.variant, this.size);

  // Colors
  Color get backgroundColor => _getBackgroundColor();
  Color get activeBackgroundColor => _getActiveBackgroundColor();
  Color get borderColor => _getBorderColor();

  // Text styles
  TextStyle get textStyle => theme.typography.bodyMedium.copyWith(
        color: _getTextColor(),
        fontSize: _getFontSize(),
      );

  TextStyle get activeTextStyle => theme.typography.bodyMedium.copyWith(
        color: _getActiveTextColor(),
        fontSize: _getFontSize(),
        fontWeight: FontWeight.bold,
      );

  TextStyle get itemsCountTextStyle => theme.typography.bodySmall.copyWith(
        color: theme.colors.onBackground.withOpacity(0.7),
      );

  // Layout
  EdgeInsets get margin => const EdgeInsets.symmetric(vertical: 16);
  EdgeInsets get buttonPadding => _getButtonPadding();
  EdgeInsets get itemsCountPadding => const EdgeInsets.only(right: 16);

  BorderRadius get borderRadius => BorderRadius.circular(4);
  BorderRadius get buttonBorderRadius => BorderRadius.zero;

  Border get border => Border.all(
        color: borderColor,
        width: 1,
      );

  Border get activeBorder => Border.all(
        color: activeBackgroundColor,
        width: 1,
      );

  double _getFontSize() {
    switch (size) {
      case FSPaginationSize.sm:
        return 12;
      case FSPaginationSize.md:
        return 14;
      case FSPaginationSize.lg:
        return 16;
    }
  }

  EdgeInsets _getButtonPadding() {
    switch (size) {
      case FSPaginationSize.sm:
        return const EdgeInsets.symmetric(horizontal: 8, vertical: 4);
      case FSPaginationSize.md:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
      case FSPaginationSize.lg:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
    }
  }

  Color _getBackgroundColor() {
    switch (variant) {
      case FSPaginationVariant.primary:
        return theme.colors.surface;
      case FSPaginationVariant.secondary:
        return theme.colors.surface;
      case FSPaginationVariant.success:
        return theme.colors.surface;
      case FSPaginationVariant.danger:
        return theme.colors.surface;
      case FSPaginationVariant.warning:
        return theme.colors.surface;
      case FSPaginationVariant.info:
        return theme.colors.surface;
      case FSPaginationVariant.light:
        return theme.colors.surface;
      case FSPaginationVariant.dark:
        return theme.colors.onBackground;
    }
  }

  Color _getActiveBackgroundColor() {
    final colors = theme.colors;
    switch (variant) {
      case FSPaginationVariant.primary:
        return colors.primary;
      case FSPaginationVariant.secondary:
        return colors.secondary;
      case FSPaginationVariant.success:
        return colors.success;
      case FSPaginationVariant.danger:
        return colors.danger;
      case FSPaginationVariant.warning:
        return colors.warning;
      case FSPaginationVariant.info:
        return colors.info;
      case FSPaginationVariant.light:
        return colors.surface
            .withOpacity(0.3); // FIXED: Use surface instead of surfaceVariant
      case FSPaginationVariant.dark:
        return colors.surface;
    }
  }

  Color _getBorderColor() {
    switch (variant) {
      case FSPaginationVariant.dark:
        return theme.colors.surface;
      default:
        return theme.colors.outline;
    }
  }

  Color _getTextColor() {
    switch (variant) {
      case FSPaginationVariant.dark:
        return theme.colors.surface;
      default:
        return theme.colors.onBackground;
    }
  }

  Color _getActiveTextColor() {
    switch (variant) {
      case FSPaginationVariant.light:
        return theme.colors.onSurface;
      case FSPaginationVariant.dark:
        return theme.colors.onBackground;
      default:
        return theme.colors.onPrimary;
    }
  }
}
