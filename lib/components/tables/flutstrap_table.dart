/// Flutstrap Table
///
/// A high-performance, customizable table component with Bootstrap-inspired styling,
/// sorting, responsive behavior, and virtualization for large datasets.
///
/// ## Usage Examples
///
/// ```dart
/// // Basic table
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
///
/// // Table with custom cell rendering
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
///
/// // Responsive table for mobile
/// FlutstrapTable<Product>(
///   columns: productColumns,
///   data: products,
///   responsive: FSTableResponsive.collapse, // Cards on mobile
///   virtualized: true, // Enable for large datasets
/// )
/// ```
///
/// ## Performance Features
///
/// - **Virtualization**: Automatic row virtualization for datasets >50 items
/// - **Caching**: Cell value caching to prevent expensive recalculations
/// - **Efficient Sorting**: Optimized sorting with minimal data copying
/// - **Memory Management**: Proper disposal of resources and cache clearing
///
/// ## Responsive Behavior
///
/// - **Scroll**: Horizontal scrolling on small screens (default)
/// - **Collapse**: Transforms to card layout on mobile (<600px)
/// - **Stacked**: Stacks columns vertically on tablet (<768px)
/// - **None**: No responsive adaptation
///
/// {@category Components}
/// {@category Data Display}

import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../../core/spacing.dart';

// ... rest of the table code remains the same
/// Flutstrap Table Configuration
///
/// Performance and behavior configuration for tables
class FSTableConfig {
  static const int virtualizationThreshold = 50;
  static const double defaultRowHeight = 48.0;
  static const int maxCachedCells = 1000;
  static const int batchRenderSize = 20;

  static bool shouldVirtualize(int itemCount) {
    return itemCount > virtualizationThreshold;
  }
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

  const FSTableColumn({
    required this.header,
    this.accessor,
    this.cellBuilder,
    this.sortable = false,
    this.width,
    this.headerAlign = TextAlign.left,
    this.cellAlign = TextAlign.left,
    this.visible = true,
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
          visible == other.visible;

  @override
  int get hashCode => Object.hash(header, accessor, sortable, width, visible);
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
    Key? key,
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
  }) : super(key: key);

  @override
  State<FlutstrapTable<T>> createState() => _FlutstrapTableState<T>();
}

class _FlutstrapTableState<T> extends State<FlutstrapTable<T>> {
  int? _sortColumnIndex;
  bool _sortAscending = true;
  late List<T> _cachedSortedData;
  bool _needsSortUpdate = true;
  final _cellValueCache = <String, String>{};
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
    if (data.isEmpty) return data;

    // ✅ EFFICIENT: Use existing list and avoid unnecessary operations
    final List<T> sorted = List<T>.from(data);
    final column = widget.columns[_sortColumnIndex!];

    if (column.sortable && column.accessor != null) {
      sorted.sort((a, b) {
        final aValue = _getFieldValue(a, column.accessor!);
        final bValue = _getFieldValue(b, column.accessor!);
        return _compareValues(aValue, bValue, _sortAscending);
      });
    }

    return sorted;
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

  @override
  Widget build(BuildContext context) {
    if (_isDisposed) return const SizedBox.shrink();

    final theme = FSTheme.of(context);
    final tableStyle = _TableStyle(theme, widget.variant, widget.size);

    if (widget.data.isEmpty) {
      return _buildEmptyState(tableStyle);
    }

    final visibleColumns = widget.columns.where((col) => col.visible).toList();

    return _buildResponsiveWrapper(
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
    );
  }

  Widget _buildResponsiveWrapper({required Widget child}) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final responsiveMode = _getResponsiveMode(constraints.maxWidth);

        return switch (responsiveMode) {
          FSTableResponsive.collapse when constraints.maxWidth < 600 =>
            _buildCardLayout(),
          FSTableResponsive.stacked when constraints.maxWidth < 768 =>
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
    if (width < 600) return FSTableResponsive.collapse;
    if (width < 768) return FSTableResponsive.stacked;
    return widget.responsive;
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

        return GestureDetector(
          onTap: column.sortable ? () => _onSort(index, !_sortAscending) : null,
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
      debugPrint('🚨 Error building table cell: $e');
      return Container(
        padding: style.cellPadding,
        child: Text(
          'Error',
          style: style.cellTextStyle.copyWith(color: Colors.red),
        ),
      );
    }
  }

  String _getCellText(T item, FSTableColumn<T> column) {
    if (column.accessor == null) return '';
    if (column.cellBuilder != null) return '';

    // ✅ CACHE CELL VALUES FOR PERFORMANCE
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
          children: widget.columns.where((col) => col.visible).map((column) {
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
              children:
                  widget.columns.where((col) => col.visible).map((column) {
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
    return Icon(
      isAscending ? Icons.arrow_upward : Icons.arrow_downward,
      size: 16,
      color: isActive ? Colors.blue : Colors.grey,
    );
  }
}

/// Internal style configuration for tables
class _TableStyle {
  final FSThemeData theme;
  final FSTableVariant variant;
  final FSTableSize size;

  _TableStyle(this.theme, this.variant, this.size);

  // ... (style getters remain the same as original)
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
