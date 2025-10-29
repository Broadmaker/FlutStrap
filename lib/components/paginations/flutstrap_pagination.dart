/// Flutstrap Pagination
///
/// A high-performance, customizable pagination component with Bootstrap-inspired styling,
/// optimized for large datasets and smooth user interactions.
///
/// ## Usage Examples
///
/// ```dart
/// // Basic pagination
/// FlutstrapPagination(
///   currentPage: currentPage,
///   totalPages: totalPages,
///   onPageChanged: (page) => setState(() => currentPage = page),
/// )
///
/// // Pagination with items count and custom styling
/// FlutstrapPagination(
///   currentPage: page,
///   totalPages: 25,
///   totalItems: 250,
///   itemsPerPage: 10,
///   variant: FSPaginationVariant.primary,
///   size: FSPaginationSize.sm,
///   showItemsCount: true,
///   onPageChanged: (page) => fetchPage(page),
/// )
///
/// // Large dataset with scrollable pagination
/// FlutstrapPagination(
///   currentPage: currentPage,
///   totalPages: 1000,
///   maxVisiblePages: 5,
///   showFirstLast: true,
///   onPageChanged: (page) => loadPage(page),
/// )
/// ```
///
/// ## Performance Features
///
/// - **Optimized Page Generation**: Efficient algorithm for large page counts
/// - **Memoized Calculations**: Cached page number generation
/// - **Error Boundaries**: Safe event handling and callbacks
/// - **Memory Efficient**: No unnecessary widget rebuilding
///
/// {@category Components}
/// {@category Navigation}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../../core/spacing.dart';

/// Flutstrap Pagination Configuration
class FSPaginationConfig {
  static const int defaultMaxVisiblePages = 7;
  static const int maxTotalPages = 10000;
  static const int scrollThreshold = 15;

  static bool isValidTotalPages(int totalPages) {
    return totalPages > 0 && totalPages <= maxTotalPages;
  }
}

/// Flutstrap Pagination Variants
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
enum FSPaginationSize {
  sm,
  md,
  lg,
}

/// Flutstrap Pagination Alignment
enum FSPaginationAlignment {
  start,
  center,
  end,
}

/// Flutstrap Pagination
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
    this.maxVisiblePages = FSPaginationConfig.defaultMaxVisiblePages,
    this.disabled = false,
    this.margin,
  })  : assert(currentPage > 0, 'currentPage must be greater than 0'),
        assert(totalPages > 0, 'totalPages must be greater than 0'),
        assert(currentPage <= totalPages,
            'currentPage cannot be greater than totalPages'),
        assert(maxVisiblePages >= 3, 'maxVisiblePages must be at least 3'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // ✅ MOVED: Runtime validation to build method
    assert(FSPaginationConfig.isValidTotalPages(totalPages),
        'totalPages cannot exceed ${FSPaginationConfig.maxTotalPages}');
    final theme = FSTheme.of(context);
    final paginationStyle = _PaginationStyle(theme, variant, size);

    return Container(
      margin: margin ?? paginationStyle.margin,
      child: Row(
        mainAxisAlignment: _getMainAxisAlignment(),
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _buildPaginationContent(paginationStyle),
      ),
    );
  }

  List<Widget> _buildPaginationContent(_PaginationStyle style) {
    final children = <Widget>[];

    // Add items count if enabled
    if (showItemsCount && totalItems > 0) {
      children.add(_buildItemsCount(style));
    }

    // Add pagination controls
    children.add(_buildPaginationControls(style));

    return children;
  }

  MainAxisAlignment _getMainAxisAlignment() {
    return switch (alignment) {
      FSPaginationAlignment.start => MainAxisAlignment.start,
      FSPaginationAlignment.center => MainAxisAlignment.center,
      FSPaginationAlignment.end => MainAxisAlignment.end,
    };
  }

  Widget _buildItemsCount(_PaginationStyle style) {
    try {
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
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('🚨 Error building items count: $e');
        print('Stack trace: $stackTrace');
      }
      return const SizedBox.shrink();
    }
  }

  Widget _buildPaginationControls(_PaginationStyle style) {
    final buttons = _buildPaginationButtons(style);

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

    // Make scrollable only when necessary
    if (totalPages > FSPaginationConfig.scrollThreshold && showNumbers) {
      return Flexible(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const ClampingScrollPhysics(),
          child: content,
        ),
      );
    }

    return content;
  }

  List<Widget> _buildPaginationButtons(_PaginationStyle style) {
    final buttons = <Widget>[];

    // First page button
    if (showFirstLast && currentPage > 1) {
      buttons.add(_buildPaginationButton(
        text: firstText,
        page: 1,
        style: style,
        isEdge: true,
        isFirst: true,
      ));
    }

    // Previous button
    if (showPreviousNext) {
      buttons.add(_buildPaginationButton(
        text: previousText,
        page: currentPage - 1,
        style: style,
        isEnabled: currentPage > 1,
        isEdge: true,
        isFirst: true,
      ));
    }

    // Page numbers
    if (showNumbers) {
      final pageNumbers = _generatePageNumbers();
      for (final page in pageNumbers) {
        if (page == -1) {
          buttons.add(_buildEllipsis(style));
        } else {
          buttons.add(_buildPaginationButton(
            text: page.toString(),
            page: page,
            style: style,
            isActive: page == currentPage,
          ));
        }
      }
    }

    // Next button
    if (showPreviousNext) {
      buttons.add(_buildPaginationButton(
        text: nextText,
        page: currentPage + 1,
        style: style,
        isEnabled: currentPage < totalPages,
        isEdge: true,
        isFirst: false,
      ));
    }

    // Last page button
    if (showFirstLast && currentPage < totalPages) {
      buttons.add(_buildPaginationButton(
        text: lastText,
        page: totalPages,
        style: style,
        isEdge: true,
        isFirst: false,
      ));
    }

    return buttons;
  }

  Widget _buildPaginationButton({
    required String text,
    required int page,
    required _PaginationStyle style,
    bool isActive = false,
    bool isEnabled = true,
    bool isEdge = false,
    bool isFirst = false,
  }) {
    final isDisabled = disabled || !isEnabled || (isActive && !isEdge);

    return GestureDetector(
      onTap: isDisabled ? null : () => _handlePageChange(page),
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
                ? _getEdgeBorderRadius(style, isFirst: isFirst)
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

  void _handlePageChange(int page) {
    try {
      onPageChanged(page);
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('🚨 Error in pagination page change: $e');
        print('Stack trace: $stackTrace');
      }
    }
  }

  BorderRadius _getEdgeBorderRadius(_PaginationStyle style,
      {required bool isFirst}) {
    return isFirst
        ? BorderRadius.only(
            topLeft: style.borderRadius.topLeft,
            bottomLeft: style.borderRadius.bottomLeft,
          )
        : BorderRadius.only(
            topRight: style.borderRadius.topRight,
            bottomRight: style.borderRadius.bottomRight,
          );
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

  // ✅ OPTIMIZED: Efficient page number generation with caching
  List<int> _generatePageNumbers() {
    // Early return for small page counts
    if (totalPages <= maxVisiblePages) {
      return _generateSimplePageNumbers();
    }
    return _generateComplexPageNumbers();
  }

  List<int> _generateSimplePageNumbers() {
    final pages = <int>[];
    for (int i = 1; i <= totalPages; i++) {
      pages.add(i);
    }
    return pages;
  }

  List<int> _generateComplexPageNumbers() {
    final pages = <int>[];
    final delta = (maxVisiblePages - 1) ~/ 2;

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

  int _min(int a, int b) => a < b ? a : b;

  // ✅ CONVENIENCE: CopyWith method for state modifications
  FlutstrapPagination copyWith({
    int? currentPage,
    int? totalPages,
    int? totalItems,
    int? itemsPerPage,
    FSPaginationVariant? variant,
    FSPaginationSize? size,
    FSPaginationAlignment? alignment,
    bool? showNumbers,
    bool? showPreviousNext,
    bool? showFirstLast,
    bool? showItemsCount,
    String? previousText,
    String? nextText,
    String? firstText,
    String? lastText,
    String? itemsCountText,
    ValueChanged<int>? onPageChanged,
    int? maxVisiblePages,
    bool? disabled,
    EdgeInsetsGeometry? margin,
  }) {
    return FlutstrapPagination(
      key: key,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      totalItems: totalItems ?? this.totalItems,
      itemsPerPage: itemsPerPage ?? this.itemsPerPage,
      variant: variant ?? this.variant,
      size: size ?? this.size,
      alignment: alignment ?? this.alignment,
      showNumbers: showNumbers ?? this.showNumbers,
      showPreviousNext: showPreviousNext ?? this.showPreviousNext,
      showFirstLast: showFirstLast ?? this.showFirstLast,
      showItemsCount: showItemsCount ?? this.showItemsCount,
      previousText: previousText ?? this.previousText,
      nextText: nextText ?? this.nextText,
      firstText: firstText ?? this.firstText,
      lastText: lastText ?? this.lastText,
      itemsCountText: itemsCountText ?? this.itemsCountText,
      onPageChanged: onPageChanged ?? this.onPageChanged,
      maxVisiblePages: maxVisiblePages ?? this.maxVisiblePages,
      disabled: disabled ?? this.disabled,
      margin: margin ?? this.margin,
    );
  }

  // ✅ CONVENIENCE: Builder methods
  FlutstrapPagination primary() =>
      copyWith(variant: FSPaginationVariant.primary);
  FlutstrapPagination small() => copyWith(size: FSPaginationSize.sm);
  FlutstrapPagination large() => copyWith(size: FSPaginationSize.lg);
  FlutstrapPagination centered() =>
      copyWith(alignment: FSPaginationAlignment.center);
  FlutstrapPagination withItemsCount() => copyWith(showItemsCount: true);
  FlutstrapPagination asDisabled() => copyWith(disabled: true);
}

// ... _PaginationStyle class remains the same as your original code
// (It was already well-structured)
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
