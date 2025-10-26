// layout_screen.dart
import 'package:flutter/material.dart';
import 'package:master_flutstrap/flutstrap.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  double _currentWidth = 0;

  @override
  Widget build(BuildContext context) {
    _currentWidth = MediaQuery.of(context).size.width;
    final responsive = FSResponsive.of(_currentWidth);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Layout & Grid System'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Breakpoint Info
            _buildBreakpointInfo(responsive),
            const SizedBox(height: 24),

            // Basic Grid System
            _buildSectionTitle('Basic Grid System'),
            const SizedBox(height: 16),
            _buildBasicGridExamples(),

            const SizedBox(height: 32),

            // Responsive Columns
            _buildSectionTitle('Responsive Columns'),
            const SizedBox(height: 16),
            _buildResponsiveColumnExamples(),

            const SizedBox(height: 32),

            // Container Examples
            _buildSectionTitle('Containers'),
            const SizedBox(height: 16),
            _buildContainerExamples(),

            const SizedBox(height: 32),

            // Visibility Examples
            _buildSectionTitle('Visibility Utilities'),
            const SizedBox(height: 16),
            _buildVisibilityExamples(responsive),

            const SizedBox(height: 32),

            // Card Grid Layout
            _buildSectionTitle('Card Grid Layout'),
            const SizedBox(height: 16),
            _buildCardGridExample(),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildBreakpointInfo(FSResponsive responsive) {
    return Card(
      color: Colors.blue[50],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(Icons.info, color: Colors.blue),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Current Breakpoint: ${responsive.breakpoint.name.toUpperCase()}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Screen Width: ${_currentWidth.toStringAsFixed(0)}px',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }

  Widget _buildBasicGridExamples() {
    return Column(
      children: [
        _buildExampleCard(
          'Equal Columns',
          'Three equal-width columns',
          FlutstrapGrid.singleRow(
            columns: [
              _buildGridColumn('Column 1', Colors.blue),
              _buildGridColumn('Column 2', Colors.green),
              _buildGridColumn('Column 3', Colors.orange),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildExampleCard(
          'Mixed Column Sizes',
          'Different column width combinations',
          FlutstrapGrid.singleRow(
            columns: [
              FlutstrapCol(
                child: _buildGridColumn('8 cols', Colors.purple),
                size: const FSColSize.all(8),
              ),
              FlutstrapCol(
                child: _buildGridColumn('4 cols', Colors.teal),
                size: const FSColSize.all(4),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildExampleCard(
          'Multiple Rows',
          'Grid with multiple rows',
          FlutstrapGrid.multipleRows(
            rows: [
              [
                _buildGridColumn('Row 1 - Col 1', Colors.red),
                _buildGridColumn('Row 1 - Col 2', Colors.red),
              ],
              [
                _buildGridColumn('Row 2 - Col 1', Colors.blue),
                _buildGridColumn('Row 2 - Col 2', Colors.blue),
                _buildGridColumn('Row 2 - Col 3', Colors.blue),
              ],
            ],
            rowGap: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildResponsiveColumnExamples() {
    return Column(
      children: [
        _buildExampleCard(
          'Mobile-First Responsive',
          'Full width on mobile, half on tablet, third on desktop',
          FlutstrapGrid.singleRow(
            columns: [
              FlutstrapCol(
                child: _buildGridColumn('Responsive', Colors.indigo),
                size: FSColSize(
                  xs: 12, // Full width on mobile
                  sm: 6, // Half width on small
                  md: 4, // Third width on medium+
                  lg: 4,
                  xl: 4,
                ),
              ),
              FlutstrapCol(
                child: _buildGridColumn('Responsive', Colors.indigo),
                size: FSColSize(
                  xs: 12,
                  sm: 6,
                  md: 4,
                  lg: 4,
                  xl: 4,
                ),
              ),
              FlutstrapCol(
                child: _buildGridColumn('Responsive', Colors.indigo),
                size: FSColSize(
                  xs: 12,
                  sm: 12,
                  md: 4,
                  lg: 4,
                  xl: 4,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildExampleCard(
          'Preset Responsive Sizes',
          'Using FSGrid utility presets',
          FlutstrapGrid.singleRow(
            columns: [
              FlutstrapCol(
                child: _buildGridColumn('Half', Colors.pink),
                size: FSGrid.responsiveHalf,
              ),
              FlutstrapCol(
                child: _buildGridColumn('Third', Colors.pink),
                size: FSGrid.responsiveThird,
              ),
              FlutstrapCol(
                child: _buildGridColumn('Fourth', Colors.pink),
                size: FSGrid.responsiveFourth,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContainerExamples() {
    return Column(
      children: [
        _buildExampleCard(
          'Fixed Container',
          'Container with max-width constraints',
          FlutstrapContainer(
            child: _buildContentBox('Fixed Container', Colors.green),
          ),
        ),
        const SizedBox(height: 16),
        _buildExampleCard(
          'Fluid Container',
          'Full-width container',
          FlutstrapContainer(
            child: _buildContentBox('Fluid Container', Colors.blue),
            fluid: true,
          ),
        ),
        const SizedBox(height: 16),
        _buildExampleCard(
          'Styled Container',
          'With custom padding and decoration',
          FlutstrapContainer(
            child: _buildContentBox('Styled Container', Colors.purple),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.purple[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.purple),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVisibilityExamples(FSResponsive responsive) {
    return Column(
      children: [
        _buildExampleCard(
          'Mobile Only',
          'Visible only on mobile screens',
          Row(
            children: [
              Expanded(
                child: FlutstrapVisibility.mobileOnly(
                  child: _buildContentBox('Mobile Only', Colors.red),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: FlutstrapVisibility.desktopOnly(
                  child: _buildContentBox('Desktop Only', Colors.blue),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildExampleCard(
          'Breakpoint Specific',
          'Different content for different breakpoints',
          FlutstrapVisibility(
            child: _buildContentBox('Default Content', Colors.green),
            showOnXs: true,
            showOnSm: true,
            showOnMd: false,
            showOnLg: false,
            showOnXl: true,
            showOnXxl: true,
            fallback: _buildContentBox('Fallback Content', Colors.orange),
          ),
        ),
        const SizedBox(height: 16),
        _buildExampleCard(
          'Current Breakpoint Display',
          'Shows current breakpoint name',
          _buildContentBox(
            'Current: ${responsive.breakpoint.name.toUpperCase()}',
            Colors.teal,
          ),
        ),
      ],
    );
  }

  Widget _buildCardGridExample() {
    final cards = List.generate(6, (index) => _buildCardItem(index + 1));

    return FlutstrapGrid.cards(
      cards: cards,
      columns: 3,
      gap: 16,
      padding: const EdgeInsets.all(0),
    );
  }

  Widget _buildExampleCard(String title, String description, Widget content) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            content,
          ],
        ),
      ),
    );
  }

  Widget _buildGridColumn(String text, Color color) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildContentBox(String text, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildCardItem(int number) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  'Card $number',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'This is a sample card content that demonstrates the card grid layout.',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
