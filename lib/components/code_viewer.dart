// lib/components/code_viewer.dart
import 'package:flutter/material.dart';

class FSCodeViewer extends StatefulWidget {
  final String code;
  final String? title;

  const FSCodeViewer({
    Key? key,
    required this.code,
    this.title,
  }) : super(key: key);

  @override
  State<FSCodeViewer> createState() => _FSCodeViewerState();
}

class _FSCodeViewerState extends State<FSCodeViewer> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with expand button
          ListTile(
            leading: const Icon(Icons.code, size: 20),
            title: Text(
              widget.title ?? 'Code Example',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: Icon(
              _isExpanded ? Icons.expand_less : Icons.expand_more,
            ),
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            dense: true,
          ),

          // Code content (collapsible)
          if (_isExpanded)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                border: Border(
                  top: BorderSide(color: Colors.grey[300]!),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Code text
                  SelectableText(
                    widget.code,
                    style: const TextStyle(
                      fontFamily: 'RobotoMono',
                      fontSize: 12,
                      color: Colors.black87,
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Copy button
                  Align(
                    alignment: Alignment.centerRight,
                    child: FilledButton.tonal(
                      onPressed: () {
                        _showCopiedMessage(context);
                      },
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.content_copy, size: 16),
                          SizedBox(width: 4),
                          Text('Copy Code'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  void _showCopiedMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Code copied to clipboard!'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
