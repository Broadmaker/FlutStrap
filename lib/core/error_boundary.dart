/// Flutstrap Error Boundary
///
/// A reusable error boundary component that provides graceful error handling
/// and fallback UI when component rendering fails.
///
/// {@category Core}
/// {@category Utilities}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ErrorBoundary extends StatelessWidget {
  final Widget child;
  final WidgetBuilder? fallbackBuilder;
  final VoidCallback? onError;
  final String? componentName;

  const ErrorBoundary({
    super.key,
    required this.child,
    this.fallbackBuilder,
    this.onError,
    this.componentName,
  });

  @override
  Widget build(BuildContext context) {
    try {
      return child;
    } catch (error, stackTrace) {
      // Call error callback if provided
      onError?.call();

      if (kDebugMode) {
        debugPrint(
            '🔴 Flutstrap ErrorBoundary [${componentName ?? 'Unknown'}] caught: $error');
        debugPrint('Stack trace: $stackTrace');
      }

      // Use custom fallback or default
      return fallbackBuilder?.call(context) ?? _buildDefaultFallback(context);
    }
  }

  Widget _buildDefaultFallback(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(6),
        color: Colors.red.withOpacity(0.05),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline, color: Colors.red, size: 16),
          const SizedBox(width: 8),
          Text(
            componentName != null
                ? '$componentName unavailable'
                : 'Component unavailable',
            style: TextStyle(
              color: Colors.red,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
