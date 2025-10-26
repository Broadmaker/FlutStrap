// lib/components/tables/flutstrap_table.dart
import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../../core/spacing.dart';

/// Flutstrap Table Variants
///
/// Defines the visual style variants for tables
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
///
/// Defines the size variants for tables
enum FSTableSize {
  sm,
  md,
  lg,
}

/// Flutstrap Table Responsive Behavior
///
/// Defines how the table behaves on different screen sizes
enum FSTableResponsive {
  none, // No responsive behavior
  scroll, // Horizontal scrolling on small screens
  collapse, // Collapse to card layout on small screens
  stacked, // Stack columns vertically on small screens
}

/// Table Column Definition
///
/// Defines the configuration for each column in the table
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
}

/// Flutstrap Table
///
/// A customizable table component with Bootstrap-inspired styling,
/// sorting, and responsive behavior.
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
  }) : super(key: key);

  @override
  State<FlutstrapTable<T>> createState() => _FlutstrapTableState<T>();
}

class _FlutstrapTableState<T> extends State<FlutstrapTable<T>> {
  int? _sortColumnIndex;
  bool _sortAscending = true;

  void _onSort(int columnIndex, bool ascending) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  List<T> get _sortedData {
    if (_sortColumnIndex == null) return widget.data;

    final column = widget.columns[_sortColumnIndex!];
    if (!column.sortable || column.accessor == null) return widget.data;

    return List<T>.from(widget.data)
      ..sort((a, b) {
        final dynamic aValue = _getFieldValue(a, column.accessor!);
        final dynamic bValue = _getFieldValue(b, column.accessor!);

        if (aValue == null && bValue == null) return 0;
        if (aValue == null) return _sortAscending ? -1 : 1;
        if (bValue == null) return _sortAscending ? 1 : -1;

        final comparison = _compareValues(aValue, bValue);
        return _sortAscending ? comparison : -comparison;
      });
  }

  dynamic _getFieldValue(T item, String accessor) {
    try {
      // Handle Map types directly
      if (item is Map<String, dynamic>) {
        return _getValueFromMap(item, accessor);
      }

      // For non-Map types, use a simpler approach that doesn't rely on reflection
      // This will work for most use cases where cellBuilder is used for complex data
      return _getSimpleValue(item, accessor);
    } catch (e) {
      return null;
    }
  }

  dynamic _getSimpleValue(T item, String accessor) {
    // For simple cases, we can handle common patterns
    // In practice, most complex data should use cellBuilder

    // Convert the item to string and try to extract the value
    // This is a fallback for simple objects
    final itemString = item.toString();

    // This is a basic implementation - in real usage, cellBuilder should be used
    // for complex object types
    return null; // Return null and rely on cellBuilder for display
  }

  dynamic _getValueFromMap(Map<String, dynamic> map, String accessor) {
    var value = map;
    final fields = accessor.split('.');
    for (int i = 0; i < fields.length; i++) {
      final field = fields[i];
      if (value is Map<String, dynamic> && value.containsKey(field)) {
        value = value[field];
        if (value == null) return null;
      } else {
        return null;
      }
    }
    return value;
  }

  int _compareValues(dynamic a, dynamic b) {
    if (a is num && b is num) return a.compareTo(b);
    if (a is String && b is String) return a.compareTo(b);
    if (a is DateTime && b is DateTime) return a.compareTo(b);
    if (a is bool && b is bool) return a == b ? 0 : (a ? 1 : -1);
    return a.toString().compareTo(b.toString());
  }

  @override
  Widget build(BuildContext context) {
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
    switch (widget.responsive) {
      case FSTableResponsive.scroll:
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: child,
        );
      case FSTableResponsive.collapse:
        return LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 600) {
              return _buildCardLayout();
            }
            return child;
          },
        );
      case FSTableResponsive.stacked:
        return LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 768) {
              return _buildStackedLayout();
            }
            return child;
          },
        );
      case FSTableResponsive.none:
      default:
        return child;
    }
  }

  Widget _buildTable(List<FSTableColumn<T>> visibleColumns, _TableStyle style) {
    return Table(
      columnWidths:
          widget.columnWidths ?? _getDefaultColumnWidths(visibleColumns),
      border: TableBorder(
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
      ),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        if (widget.showHeader) _buildTableHeader(visibleColumns, style),
        ..._buildTableRows(visibleColumns, style),
      ],
    );
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
      }).toList(),
    );
  }

  List<TableRow> _buildTableRows(
      List<FSTableColumn<T>> columns, _TableStyle style) {
    return _sortedData.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value;

      return TableRow(
        decoration: BoxDecoration(
          color: _getRowColor(index, style),
        ),
        children: columns.map((column) {
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
        }).toList(),
      );
    }).toList();
  }

  Color _getRowColor(int index, _TableStyle style) {
    if (widget.striped && index.isOdd) {
      return style.stripedRowColor;
    }
    return Colors.transparent;
  }

  String _getCellText(T item, FSTableColumn<T> column) {
    if (column.accessor == null) return '';

    // For complex objects, use cellBuilder instead of accessor
    // The accessor approach mainly works well with Map data
    if (column.cellBuilder == null) {
      final value = _getFieldValue(item, column.accessor!);
      return value?.toString() ?? '';
    }

    return '';
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
    // Simplified card layout for mobile
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.data.length,
      itemBuilder: (context, index) {
        final item = widget.data[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  widget.columns.where((col) => col.visible).map((column) {
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
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStackedLayout() {
    // Stacked layout for mobile
    return Column(
      children: widget.data.map((item) {
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
              }).toList(),
            ),
          ),
        );
      }).toList(),
    );
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
