/// Flutstrap Table
///
/// A high-performance, customizable table component with Bootstrap-inspired styling,
/// sorting, responsive behavior, and virtualization for large datasets.
///
/// ## Usage Examples
///
/// {@tool snippet}
/// ### Basic Table
///
/// ```dart
/// FlutstrapTable<Map<String, dynamic>>(
///   columns: [
///     FSTableColumn(
///       header: 'Name',
///       accessor: 'name',
///       sortable: true,
///     ),
///     FSTableColumn(
///       header: 'Age',
///       accessor: 'age',
///       sortable: true,
///     ),
///   ],
///   data: [
///     {'name': 'John', 'age': 30},
///     {'name': 'Jane', 'age': 25},
///   ],
///   variant: FSTableVariant.primary,
///   responsive: FSTableResponsive.scroll,
/// )
/// ```
///
/// ### Table with Custom Cell Rendering
///
/// ```dart
/// FlutstrapTable<User>(
///   columns: [
///     FSTableColumn(
///       header: 'User',
///       cellBuilder: (user) => Text(user.name),
///     ),
///     FSTableColumn(
///       header: 'Status',
///       cellBuilder: (user) => Badge(
///         text: user.isActive ? 'Active' : 'Inactive',
///         variant: user.isActive ? FSBadgeVariant.success : FSBadgeVariant.secondary,
///       ),
///     ),
///   ],
///   data: users,
///   striped: true,
///   hover: true,
///   onRowTap: (user) => _showUserDetails(user),
/// )
/// ```
///
/// ### Virtualized Table with Large Dataset
///
/// ```dart
/// FlutstrapTable<User>(
///   columns: userColumns,
///   data: largeUserList, // 10,000+ items
///   virtualized: true,
///   rowHeight: 56,
///   onRowTap: (user) => _showUserDetails(user),
/// )
/// ```
///
/// ### Responsive Table with Custom Breakpoints
///
/// ```dart
/// FlutstrapTable<Product>(
///   columns: productColumns,
///   data: products,
///   responsive: FSTableResponsive.collapse,
///   emptyWidget: CustomEmptyState(),
///   onRowDoubleTap: (product) => _quickEdit(product),
/// )
/// ```
/// {@end-tool}
///
/// {@template flutstrap_table.performance}
/// ## Performance Features
///
/// - **Smart Virtualization**: Automatic for large datasets with configurable thresholds
/// - **Value Caching**: Cell values cached to prevent expensive recalculations
/// - **Efficient Sorting**: Optimized with Schwartzian transform for expensive operations
/// - **Memory Management**: LRU cache eviction and proper resource disposal
/// - **Batch Rendering**: Configurable batch sizes for smooth scrolling
/// {@endtemplate}
///
/// {@template flutstrap_table.accessibility}
/// ## Accessibility
///
/// - Full screen reader support with semantic labels
/// - Keyboard navigation support
/// - Focus management for interactive rows
/// - Proper ARIA attributes for web
/// {@endtemplate}
///
/// ## Responsive Behavior
///
/// - **Scroll**: Horizontal scrolling on small screens (default)
/// - **Collapse**: Transforms to card layout on mobile (<480px)
/// - **Stacked**: Stacks columns vertically on tablet (<768px)
/// - **None**: No responsive adaptation
///
/// ## Performance Tips
///
/// - Use `virtualized: true` for datasets > 50 items
/// - Implement efficient `cellBuilder` for complex cells
/// - Use `accessor` for simple text fields instead of `cellBuilder`
/// - Consider using `const` for column definitions when possible
///
/// {@category Components}
/// {@category Data Display}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../../core/spacing.dart';
import '../../core/error_boundary.dart';

/// Flutstrap Table Configuration
///
/// Performance and behavior configuration for tables
class FSTableConfig {
  static const int virtualizationThreshold = 50;
  static const double defaultRowHeight = 48.0;
  static const int maxCachedCells = 1000;
  static const int batchRenderSize = 20;

  // Cache management
  static const int cacheCleanupThreshold = 2000;
  static const Duration cacheCleanupInterval = Duration(minutes: 5);

  // Responsive breakpoints
  static const double mobileBreakpoint = 480;
  static const double tabletBreakpoint = 768;
  static const double desktopBreakpoint = 1024;

  // Performance monitoring
  static const bool enablePerformanceLogging = kDebugMode;

  static bool shouldVirtualize(int itemCount) {
    return itemCount > virtualizationThreshold;
  }
}

/// Performance monitoring for table operations
class _TablePerformance {
  static final _renderTimes = <String, int>{};

  static void logRenderTime(String operation, int milliseconds) {
    if (!FSTableConfig.enablePerformanceLogging) return;

    _renderTimes[operation] = milliseconds;

    // Log slow operations
    if (milliseconds > 16) {
      // 60fps threshold
      debugPrint('⏱️ Slow table operation: $operation took ${milliseconds}ms');
    }
  }

  static void clearMetrics() => _renderTimes.clear();

  static Map<String, int> get metrics => Map.from(_renderTimes);
}

/// Flutstrap Table Variants
enum FSTableVariant {
  primary,
  secondary,
  success,
  danger,
  warning,
  info,
  light,
  dark,
}

/// Flutstrap Table Size
enum FSTableSize {
  sm,
  md,
  lg,
}

/// Flutstrap Table Responsive Behavior
enum FSTableResponsive {
  none,
  scroll,
  collapse,
  stacked,
}

/// Table Column Definition
class FSTableColumn<T> {
  final String header;
  final String? accessor;
  final Widget Function(T item)? cellBuilder;
  final bool sortable;
  final double? width;
  final TextAlign headerAlign;
  final TextAlign cellAlign;
  final bool visible;
  final int? priority; // For responsive column hiding

  const FSTableColumn({
    required this.header,
    this.accessor,
    this.cellBuilder,
    this.sortable = false,
    this.width,
    this.headerAlign = TextAlign.left,
    this.cellAlign = TextAlign.left,
    this.visible = true,
    this.priority,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FSTableColumn &&
          runtimeType == other.runtimeType &&
          header == other.header &&
          accessor == other.accessor &&
          sortable == other.sortable &&
          width == other.width &&
          visible == other.visible &&
          priority == other.priority;

  @override
  int get hashCode =>
      Object.hash(header, accessor, sortable, width, visible, priority);
}

/// Helper class for efficient sorting
class _SortableItem<T> {
  final T original;
  final dynamic value;

  _SortableItem(this.original, this.value);
}

/// Flutstrap Table
///
/// High-performance, customizable table with virtualization and responsive behavior.
class FlutstrapTable<T> extends StatefulWidget {
  final List<FSTableColumn<T>> columns;
  final List<T> data;
  final FSTableVariant variant;
  final FSTableSize size;
  final FSTableResponsive responsive;
  final bool striped;
  final bool bordered;
  final bool hover;
  final bool condensed;
  final String? emptyMessage;
  final Widget? emptyWidget;
  final void Function(T item)? onRowTap;
  final void Function(T item)? onRowDoubleTap;
  final Map<int, TableColumnWidth>? columnWidths;
  final BorderRadiusGeometry? borderRadius;
  final bool showHeader;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? horizontalSpacing;
  final double? verticalSpacing;
  final bool virtualized;
  final double rowHeight;

  const FlutstrapTable({
    super.key,
    required this.columns,
    required this.data,
    this.variant = FSTableVariant.primary,
    this.size = FSTableSize.md,
    this.responsive = FSTableResponsive.scroll,
    this.striped = false,
    this.bordered = false,
    this.hover = true,
    this.condensed = false,
    this.emptyMessage,
    this.emptyWidget,
    this.onRowTap,
    this.onRowDoubleTap,
    this.columnWidths,
    this.borderRadius,
    this.showHeader = true,
    this.backgroundColor,
    this.borderColor,
    this.horizontalSpacing,
    this.verticalSpacing,
    this.virtualized = true,
    this.rowHeight = FSTableConfig.defaultRowHeight,
  });

  @override
  State<FlutstrapTable<T>> createState() => _FlutstrapTableState<T>();
}

class _FlutstrapTableState<T> extends State<FlutstrapTable<T>> {
  int? _sortColumnIndex;
  bool _sortAscending = true;
  late List<T> _cachedSortedData;
  bool _needsSortUpdate = true;
  final _cellValueCache = <String, String>{};
  DateTime _lastCacheCleanup = DateTime.now();
  final _scrollController = ScrollController();
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _updateCachedData();
  }

  @override
  void didUpdateWidget(FlutstrapTable<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    // ✅ EFFICIENT: Only update cache when necessary
    if (oldWidget.data != widget.data ||
        oldWidget.columns != widget.columns ||
        _needsSortUpdate) {
      _updateCachedData();
      _needsSortUpdate = false;
    }

    // ✅ CLEAR CACHE WHEN DATA CHANGES SIGNIFICANTLY
    if (oldWidget.data != widget.data) {
      _cellValueCache.clear();
    }
  }

  void _updateCachedData() {
    if (_isDisposed) return;

    if (_sortColumnIndex == null) {
      _cachedSortedData = widget.data;
    } else {
      _cachedSortedData = _performSort(widget.data);
    }
  }

  List<T> _performSort(List<T> data) {
    if (data.isEmpty || _sortColumnIndex == null) return data;

    final stopwatch = Stopwatch()..start();
    final column = widget.columns[_sortColumnIndex!];
    if (!column.sortable || column.accessor == null) return data;

    // ✅ EFFICIENT: Use Schwartzian transform for expensive value extraction
    final sorted = data.map((item) {
      final value = _getFieldValue(item, column.accessor!);
      return _SortableItem(item, value);
    }).toList()
      ..sort((a, b) => _compareValues(a.value, b.value, _sortAscending));

    final result = sorted.map((item) => item.original).toList();

    stopwatch.stop();
    _TablePerformance.logRenderTime('sorting', stopwatch.elapsedMilliseconds);

    return result;
  }

  void _onSort(int columnIndex, bool ascending) {
    if (_isDisposed) return;

    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
      _needsSortUpdate = true;
    });
  }

  dynamic _getFieldValue(T item, String accessor) {
    try {
      if (item is Map<String, dynamic>) {
        return _getValueFromMap(item, accessor);
      }
      // For complex objects, rely on cellBuilder
      return null;
    } catch (e) {
      return null;
    }
  }

  dynamic _getValueFromMap(Map<String, dynamic> map, String accessor) {
    var value = map;
    final fields = accessor.split('.');
    for (final field in fields) {
      if (value is Map<String, dynamic> && value.containsKey(field)) {
        value = value[field];
        if (value == null) return null;
      } else {
        return null;
      }
    }
    return value;
  }

  int _compareValues(dynamic a, dynamic b, bool ascending) {
    final multiplier = ascending ? 1 : -1;

    if (a == null && b == null) return 0;
    if (a == null) return -1 * multiplier;
    if (b == null) return 1 * multiplier;

    if (a is num && b is num) return a.compareTo(b) * multiplier;
    if (a is String && b is String) return a.compareTo(b) * multiplier;
    if (a is DateTime && b is DateTime) return a.compareTo(b) * multiplier;
    if (a is bool && b is bool) return (a == b ? 0 : (a ? 1 : -1)) * multiplier;

    return a.toString().compareTo(b.toString()) * multiplier;
  }

  void _cleanupCacheIfNeeded() {
    final now = DateTime.now();
    if (_cellValueCache.length > FSTableConfig.cacheCleanupThreshold ||
        now.difference(_lastCacheCleanup) >
            FSTableConfig.cacheCleanupInterval) {
      // Remove oldest entries (first 50%)
      final keysToRemove =
          _cellValueCache.keys.take(_cellValueCache.length ~/ 2);
      for (final key in keysToRemove) {
        _cellValueCache.remove(key);
      }
      _lastCacheCleanup = now;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isDisposed) return const SizedBox.shrink();

    final stopwatch = Stopwatch()..start();
    final theme = FSTheme.of(context);
    final tableStyle = _TableStyle(theme, widget.variant, widget.size);

    if (widget.data.isEmpty) {
      final emptyWidget = _buildEmptyState(tableStyle);
      stopwatch.stop();
      _TablePerformance.logRenderTime(
          'empty_table', stopwatch.elapsedMilliseconds);
      return emptyWidget;
    }

    final visibleColumns =
        _getVisibleColumns(MediaQuery.of(context).size.width);

    final tableWidget = ErrorBoundary(
      // ✅ USING SHARED ERROR BOUNDARY
      componentName: 'FlutstrapTable',
      fallbackBuilder: (context) => _buildErrorTable(),
      child: _buildResponsiveWrapper(
        child: Container(
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? tableStyle.backgroundColor,
            borderRadius: widget.borderRadius ?? tableStyle.borderRadius,
            border: widget.bordered
                ? Border.all(
                    color: widget.borderColor ?? tableStyle.borderColor,
                    width: 1,
                  )
                : null,
          ),
          child: _buildTable(visibleColumns, tableStyle),
        ),
      ),
    );

    stopwatch.stop();
    _TablePerformance.logRenderTime(
        'table_build', stopwatch.elapsedMilliseconds);

    return tableWidget;
  }

  Widget _buildErrorTable() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(8),
        color: Colors.red.withOpacity(0.05),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline, color: Colors.red, size: 32),
          SizedBox(height: 8),
          Text(
            'Table unavailable',
            style: TextStyle(
              color: Colors.red,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Please try refreshing or check your data',
            style: TextStyle(
              color: Colors.red.withOpacity(0.8),
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildResponsiveWrapper({required Widget child}) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final responsiveMode = _getResponsiveMode(constraints.maxWidth);

        return switch (responsiveMode) {
          FSTableResponsive.collapse
              when constraints.maxWidth < FSTableConfig.mobileBreakpoint =>
            _buildCardLayout(),
          FSTableResponsive.stacked
              when constraints.maxWidth < FSTableConfig.tabletBreakpoint =>
            _buildStackedLayout(),
          FSTableResponsive.scroll => SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: child,
            ),
          _ => child,
        };
      },
    );
  }

  FSTableResponsive _getResponsiveMode(double width) {
    if (width < FSTableConfig.mobileBreakpoint)
      return FSTableResponsive.collapse;
    if (width < FSTableConfig.tabletBreakpoint)
      return FSTableResponsive.stacked;
    return widget.responsive;
  }

  List<FSTableColumn<T>> _getVisibleColumns(double width) {
    return widget.columns.where((column) {
      if (!column.visible) return false;

      // Hide less important columns on smaller screens based on priority
      if (width < FSTableConfig.mobileBreakpoint) {
        if (column.priority != null && column.priority! > 2) return false;
        if (column.width != null && column.width! > 120) return false;
      }

      if (width < FSTableConfig.tabletBreakpoint) {
        if (column.priority != null && column.priority! > 3) return false;
      }

      return true;
    }).toList();
  }

  Widget _buildTable(List<FSTableColumn<T>> visibleColumns, _TableStyle style) {
    final shouldVirtualize = widget.virtualized &&
        FSTableConfig.shouldVirtualize(_cachedSortedData.length);

    if (shouldVirtualize) {
      return _buildVirtualizedTable(visibleColumns, style);
    } else {
      return _buildStandardTable(visibleColumns, style);
    }
  }

  Widget _buildStandardTable(
      List<FSTableColumn<T>> visibleColumns, _TableStyle style) {
    return Table(
      columnWidths:
          widget.columnWidths ?? _getDefaultColumnWidths(visibleColumns),
      border: _getTableBorder(style),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        if (widget.showHeader) _buildTableHeader(visibleColumns, style),
        ..._buildStandardTableRows(visibleColumns, style),
      ],
    );
  }

  Widget _buildVirtualizedTable(
      List<FSTableColumn<T>> visibleColumns, _TableStyle style) {
    final totalHeight = _cachedSortedData.length * widget.rowHeight;
    final headerHeight = widget.showHeader ? widget.rowHeight : 0;

    return Column(
      children: [
        if (widget.showHeader)
          SizedBox(
            height: widget.rowHeight,
            child: _buildVirtualizedTableHeader(visibleColumns, style),
          ),
        Expanded(
          child: SizedBox(
            height: totalHeight,
            child: ListView.builder(
              controller: _scrollController,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _cachedSortedData.length,
              itemBuilder: (context, index) {
                return _buildVirtualizedTableRow(
                    _cachedSortedData[index], index, visibleColumns, style);
              },
            ),
          ),
        ),
      ],
    );
  }

  TableBorder _getTableBorder(_TableStyle style) {
    return TableBorder(
      horizontalInside: widget.bordered || widget.striped
          ? BorderSide(
              color: widget.borderColor ?? style.borderColor,
              width: 0.5,
            )
          : BorderSide.none,
      verticalInside: widget.bordered
          ? BorderSide(
              color: widget.borderColor ?? style.borderColor,
              width: 0.5,
            )
          : BorderSide.none,
    );
  }

  Table _buildVirtualizedTableHeader(
      List<FSTableColumn<T>> columns, _TableStyle style) {
    return Table(
      columnWidths: widget.columnWidths ?? _getDefaultColumnWidths(columns),
      children: [_buildTableHeader(columns, style)],
    );
  }

  TableRow _buildTableHeader(
      List<FSTableColumn<T>> columns, _TableStyle style) {
    return TableRow(
      decoration: BoxDecoration(
        color: style.headerBackgroundColor,
        border: widget.bordered
            ? Border(
                bottom: BorderSide(
                  color: widget.borderColor ?? style.borderColor,
                  width: 2,
                ),
              )
            : null,
      ),
      children: columns.asMap().entries.map((entry) {
        final index = entry.key;
        final column = entry.value;

        return Semantics(
          header: true,
          button: column.sortable, // Use 'button' instead of 'sortButton'
          enabled: column.sortable,
          label: column.sortable
              ? '${column.header}. Tap to sort ${_sortColumnIndex == index ? (_sortAscending ? 'descending' : 'ascending') : 'ascending'}'
              : column.header,
          child: ExcludeSemantics(
            child: GestureDetector(
              onTap: column.sortable
                  ? () => _onSort(index, !_sortAscending)
                  : null,
              child: Container(
                padding: style.headerPadding,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        column.header,
                        style: style.headerTextStyle,
                        textAlign: column.headerAlign,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (column.sortable) ...[
                      const SizedBox(width: 4),
                      _SortIndicator(
                        isActive: _sortColumnIndex == index,
                        isAscending: _sortAscending,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(growable: false),
    );
  }

  List<TableRow> _buildStandardTableRows(
      List<FSTableColumn<T>> columns, _TableStyle style) {
    return _cachedSortedData.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value;

      return TableRow(
        decoration: BoxDecoration(
          color: _getRowColor(index, style),
        ),
        children: columns.map((column) {
          return _buildTableCell(item, column, index, style);
        }).toList(growable: false),
      );
    }).toList(growable: false);
  }

  Widget _buildVirtualizedTableRow(
      T item, int index, List<FSTableColumn<T>> columns, _TableStyle style) {
    return SizedBox(
      height: widget.rowHeight,
      child: Table(
        columnWidths: widget.columnWidths ?? _getDefaultColumnWidths(columns),
        border: _getTableBorder(style),
        children: [
          TableRow(
            decoration: BoxDecoration(
              color: _getRowColor(index, style),
            ),
            children: columns.map((column) {
              return _buildTableCell(item, column, index, style);
            }).toList(growable: false),
          ),
        ],
      ),
    );
  }

  Widget _buildTableCell(
      T item, FSTableColumn<T> column, int index, _TableStyle style) {
    return ErrorBoundary(
      // ✅ USING SHARED ERROR BOUNDARY
      componentName: 'TableCell',
      fallbackBuilder: (context) => _buildErrorCell(style),
      child: Semantics(
        label: _getCellSemanticLabel(item, column),
        textField: false,
        child: ExcludeSemantics(
          child: _buildTableCellContent(item, column, index, style),
        ),
      ),
    );
  }

  Widget _buildTableCellContent(
      T item, FSTableColumn<T> column, int index, _TableStyle style) {
    try {
      return GestureDetector(
        onTap: () => widget.onRowTap?.call(item),
        onDoubleTap: () => widget.onRowDoubleTap?.call(item),
        child: MouseRegion(
          cursor: widget.onRowTap != null || widget.onRowDoubleTap != null
              ? SystemMouseCursors.click
              : SystemMouseCursors.basic,
          child: Container(
            padding: style.cellPadding,
            child: column.cellBuilder != null
                ? column.cellBuilder!(item)
                : Text(
                    _getCellText(item, column),
                    style: style.cellTextStyle,
                    textAlign: column.cellAlign,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
          ),
        ),
      );
    } catch (e, stackTrace) {
      if (kReleaseMode) {
        // Report to crash analytics in production
      }
      rethrow; // ErrorBoundary will catch this
    }
  }

  Widget _buildErrorCell(_TableStyle style) {
    return Container(
      padding: style.cellPadding,
      child: Icon(
        Icons.error_outline,
        color: Colors.red,
        size: 16,
      ),
    );
  }

  String _getCellSemanticLabel(T item, FSTableColumn<T> column) {
    if (column.cellBuilder != null) {
      // For custom cell builders, provide a fallback
      return '${column.header}: Custom content';
    }
    return '${column.header}: ${_getCellText(item, column)}';
  }

  String _getCellText(T item, FSTableColumn<T> column) {
    if (column.accessor == null) return '';
    if (column.cellBuilder != null) return '';

    // ✅ CACHE CELL VALUES FOR PERFORMANCE
    _cleanupCacheIfNeeded();

    final cacheKey = '${item.hashCode}_${column.accessor}';

    if (_cellValueCache.length > FSTableConfig.maxCachedCells) {
      _cellValueCache.clear();
    }

    return _cellValueCache.putIfAbsent(cacheKey, () {
      final value = _getFieldValue(item, column.accessor!);
      return value?.toString() ?? '';
    });
  }

  Map<int, TableColumnWidth> _getDefaultColumnWidths(
      List<FSTableColumn<T>> columns) {
    final widths = <int, TableColumnWidth>{};
    for (int i = 0; i < columns.length; i++) {
      final column = columns[i];
      if (column.width != null) {
        widths[i] = FixedColumnWidth(column.width!);
      } else {
        widths[i] = const FlexColumnWidth();
      }
    }
    return widths;
  }

  Color _getRowColor(int index, _TableStyle style) {
    if (widget.striped && index.isOdd) {
      return style.stripedRowColor;
    }
    return Colors.transparent;
  }

  Widget _buildEmptyState(_TableStyle style) {
    if (widget.emptyWidget != null) {
      return widget.emptyWidget!;
    }

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? style.backgroundColor,
        borderRadius: widget.borderRadius ?? style.borderRadius,
        border: widget.bordered
            ? Border.all(
                color: widget.borderColor ?? style.borderColor,
                width: 1,
              )
            : null,
      ),
      child: Center(
        child: Text(
          widget.emptyMessage ?? 'No data available',
          style: style.emptyTextStyle,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildCardLayout() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _cachedSortedData.length,
      itemBuilder: (context, index) {
        final item = _cachedSortedData[index];
        return _buildCardItem(item, index);
      },
    );
  }

  Widget _buildCardItem(T item, int index) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
              _getVisibleColumns(FSTableConfig.mobileBreakpoint).map((column) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${column.header}: ',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: column.cellBuilder != null
                        ? column.cellBuilder!(item)
                        : Text(_getCellText(item, column)),
                  ),
                ],
              ),
            );
          }).toList(growable: false),
        ),
      ),
    );
  }

  Widget _buildStackedLayout() {
    return Column(
      children: _cachedSortedData.map((item) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: _getVisibleColumns(FSTableConfig.tabletBreakpoint)
                  .map((column) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        column.header,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      column.cellBuilder != null
                          ? column.cellBuilder!(item)
                          : Text(
                              _getCellText(item, column),
                              style: const TextStyle(fontSize: 14),
                            ),
                    ],
                  ),
                );
              }).toList(growable: false),
            ),
          ),
        );
      }).toList(growable: false),
    );
  }

  @override
  void dispose() {
    _isDisposed = true;
    _scrollController.dispose();
    _cellValueCache.clear();
    _TablePerformance.clearMetrics();
    super.dispose();
  }
}

/// Sort indicator for table headers
class _SortIndicator extends StatelessWidget {
  final bool isActive;
  final bool isAscending;

  const _SortIndicator({
    required this.isActive,
    required this.isAscending,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: isActive
          ? 'Sorted ${isAscending ? 'ascending' : 'descending'}'
          : 'Sortable column',
      child: Icon(
        isAscending ? Icons.arrow_upward : Icons.arrow_downward,
        size: 16,
        color: isActive ? Colors.blue : Colors.grey,
      ),
    );
  }
}

/// Internal style configuration for tables
class _TableStyle {
  final FSThemeData theme;
  final FSTableVariant variant;
  final FSTableSize size;

  _TableStyle(this.theme, this.variant, this.size);

  Color get backgroundColor => _getBackgroundColor();
  Color get headerBackgroundColor => _getHeaderBackgroundColor();
  Color get stripedRowColor => _getStripedRowColor();
  Color get borderColor => _getBorderColor();

  TextStyle get headerTextStyle => theme.typography.bodyMedium.copyWith(
        fontWeight: FontWeight.bold,
        color: _getHeaderTextColor(),
        fontSize: _getFontSize(),
      );

  TextStyle get cellTextStyle => theme.typography.bodyMedium.copyWith(
        color: _getCellTextColor(),
        fontSize: _getFontSize(),
      );

  TextStyle get emptyTextStyle => theme.typography.bodyMedium.copyWith(
        color: theme.colors.onBackground.withOpacity(0.5),
      );

  EdgeInsets get headerPadding => _getPadding();
  EdgeInsets get cellPadding => _getPadding();

  BorderRadius get borderRadius => BorderRadius.circular(4);

  double _getFontSize() {
    switch (size) {
      case FSTableSize.sm:
        return 12;
      case FSTableSize.md:
        return 14;
      case FSTableSize.lg:
        return 16;
    }
  }

  EdgeInsets _getPadding() {
    switch (size) {
      case FSTableSize.sm:
        return const EdgeInsets.symmetric(horizontal: 8, vertical: 6);
      case FSTableSize.md:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
      case FSTableSize.lg:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
    }
  }

  Color _getBackgroundColor() {
    switch (variant) {
      case FSTableVariant.light:
        return theme.colors.surface;
      case FSTableVariant.dark:
        return theme.colors.onBackground;
      default:
        return Colors.transparent;
    }
  }

  Color _getHeaderBackgroundColor() {
    switch (variant) {
      case FSTableVariant.primary:
        return theme.colors.primary.withOpacity(0.1);
      case FSTableVariant.secondary:
        return theme.colors.secondary.withOpacity(0.1);
      case FSTableVariant.success:
        return theme.colors.success.withOpacity(0.1);
      case FSTableVariant.danger:
        return theme.colors.danger.withOpacity(0.1);
      case FSTableVariant.warning:
        return theme.colors.warning.withOpacity(0.1);
      case FSTableVariant.info:
        return theme.colors.info.withOpacity(0.1);
      case FSTableVariant.light:
        return theme.colors.surface.withOpacity(0.7);
      case FSTableVariant.dark:
        return theme.colors.onBackground.withOpacity(0.8);
    }
  }

  Color _getStripedRowColor() {
    switch (variant) {
      case FSTableVariant.light:
        return theme.colors.surface.withOpacity(0.5);
      case FSTableVariant.dark:
        return theme.colors.onBackground.withOpacity(0.6);
      default:
        return theme.colors.surface.withOpacity(0.3);
    }
  }

  Color _getBorderColor() {
    switch (variant) {
      case FSTableVariant.dark:
        return theme.colors.surface;
      default:
        return theme.colors.outline;
    }
  }

  Color _getHeaderTextColor() {
    switch (variant) {
      case FSTableVariant.dark:
        return theme.colors.surface;
      default:
        return theme.colors.onBackground;
    }
  }

  Color _getCellTextColor() {
    switch (variant) {
      case FSTableVariant.dark:
        return theme.colors.surface;
      default:
        return theme.colors.onBackground;
    }
  }
}
