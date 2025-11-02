/* /// Flutstrap Code Viewer Demo Screen
///
/// Demonstrates the FSCodeViewer component with various code examples
/// showcasing different Flutstrap components and patterns.
///
/// Features:
/// - 📝 Multiple code examples with syntax highlighting
/// - 🎯 Interactive code viewer with expand/collapse functionality
/// - 📱 Responsive layout design
/// - 🎨 Consistent theming with Flutstrap design system
/// - ⚡ Performance optimized with constants
///
/// {@category Demo}
/// {@category Screens}
import 'package:flutter/material.dart';
import 'package:master_flutstrap/components/code_viewer.dart';

class CodeViewerDemoScreen extends StatelessWidget {
  const CodeViewerDemoScreen({super.key});

  /// Route name for navigation
  static const String routeName = '/code-viewer';

  // ✅ CONSTANTS FOR BETTER PERFORMANCE AND MAINTAINABILITY
  static const EdgeInsets _screenPadding = EdgeInsets.all(16.0);
  static const EdgeInsets _sectionPadding = EdgeInsets.only(bottom: 24.0);
  static const EdgeInsets _titlePadding = EdgeInsets.only(bottom: 8.0);
  static const double _titleSpacing = 8.0;
  static const double _sectionSpacing = 24.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Code Viewer Demo'),
        backgroundColor: colorScheme.inversePrimary,
        elevation: 0,
      ),
      body: Padding(
        padding: _screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ ENHANCED: Header section with better typography
            _buildHeader(context),
            const SizedBox(height: _sectionSpacing),

            // ✅ ENHANCED: Demo sections with proper spacing
            Expanded(
              child: ListView(
                children: [
                  _buildButtonExample(context),
                  const SizedBox(height: _sectionSpacing),
                  _buildGridExample(context),
                  const SizedBox(height: _sectionSpacing),
                  _buildFormExample(context),
                  const SizedBox(height: _sectionSpacing),
                  _buildAnimationExample(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build header section with title and description
  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Flutstrap Code Viewer',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w700,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: _titleSpacing),
        Text(
          'Click on the code examples below to expand and see the implementation. '
          'Each example demonstrates real-world usage of Flutstrap components.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.7),
            height: 1.5,
          ),
        ),
      ],
    );
  }

  /// Build button component example
  Widget _buildButtonExample(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '1. Button Components',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
          const SizedBox(height: _titleSpacing),
          Text(
            'Various button variants and sizes with proper event handling.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: _titleSpacing),
          FSCodeViewer(
            title: 'Primary Button Implementation',
            code: _buttonExampleCode,
            language: 'dart',
          ),
        ],
      ),
    );
  }

  /// Build grid layout example
  Widget _buildGridExample(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '2. Responsive Grid System',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
          const SizedBox(height: _titleSpacing),
          Text(
            'Create adaptive layouts that work across different screen sizes.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: _titleSpacing),
          FSCodeViewer(
            title: 'Responsive Grid Layout',
            code: _gridExampleCode,
            language: 'dart',
          ),
        ],
      ),
    );
  }

  /// Build form validation example
  Widget _buildFormExample(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '3. Form with Validation',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
          const SizedBox(height: _titleSpacing),
          Text(
            'Complete form implementation with real-time validation and error handling.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: _titleSpacing),
          FSCodeViewer(
            title: 'Email Validation Form',
            code: _formExampleCode,
            language: 'dart',
          ),
        ],
      ),
    );
  }

  /// Build animation example (NEW)
  Widget _buildAnimationExample(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '4. Animation Components',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
          const SizedBox(height: _titleSpacing),
          Text(
            'Smooth animations and transitions using Flutstrap animation system.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: _titleSpacing),
          FSCodeViewer(
            title: 'Fade-In Animation',
            code: _animationExampleCode,
            language: 'dart',
          ),
        ],
      ),
    );
  }

  // ✅ CODE EXAMPLES AS CONSTANTS FOR BETTER PERFORMANCE

  /// Button component example code
  static const String _buttonExampleCode = '''
// Primary button with different sizes
FlutstrapButton(
  onPressed: () {
    // Handle button press
    print('Primary button clicked!');
  },
  child: const Text('Primary Button'),
  variant: FSButtonVariant.primary,
  size: FSButtonSize.medium,
),

// Outline button variant
FlutstrapButton(
  onPressed: () {
    // Handle outline button press
    print('Outline button clicked!');
  },
  child: const Text('Outline Button'),
  variant: FSButtonVariant.outline,
  size: FSButtonSize.small,
),

// Danger button for destructive actions
FlutstrapButton(
  onPressed: () {
    // Handle danger action
    print('Danger button clicked!');
  },
  child: const Text('Delete Item'),
  variant: FSButtonVariant.danger,
  size: FSButtonSize.medium,
),

// Disabled button state
FlutstrapButton(
  onPressed: null, // null disables the button
  child: const Text('Disabled Button'),
  variant: FSButtonVariant.primary,
  size: FSButtonSize.medium,
),
''';

  /// Grid layout example code
  static const String _gridExampleCode = '''
// Responsive grid with multiple breakpoints
FlutstrapGrid.singleRow(
  columns: [
    FlutstrapCol(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text(
          'Column 1',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      size: const FSColSize(
        xs: 12,  // Full width on mobile
        sm: 6,   // Half width on small screens
        md: 4,   // One third on medium screens
        lg: 3,   // One quarter on large screens
      ),
    ),
    FlutstrapCol(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text(
          'Column 2',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      size: const FSColSize(
        xs: 12,
        sm: 6,
        md: 4,
        lg: 3,
      ),
    ),
    FlutstrapCol(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiaryContainer,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text(
          'Column 3',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      size: const FSColSize(
        xs: 12,
        sm: 6,
        md: 4,
        lg: 3,
      ),
    ),
    FlutstrapCol(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text(
          'Column 4',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      size: const FSColSize(
        xs: 12,
        sm: 6,
        md: 4,
        lg: 3,
      ),
    ),
  ],
  spacing: 16.0, // Space between columns
)
''';

  /// Form validation example code
  static const String _formExampleCode = '''
class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Email input with validation
          FlutstrapInput(
            controller: _emailController,
            label: 'Email Address',
            prefixIcon: Icons.email_rounded,
            placeholder: 'Enter your email address',
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter your email address';
              }
              if (!FSValidators.isEmail(value)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
          
          const SizedBox(height: 16),
          
          // Password input with validation
          FlutstrapInput(
            controller: _passwordController,
            label: 'Password',
            prefixIcon: Icons.lock_rounded,
            placeholder: 'Enter your password',
            obscureText: true,
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter your password';
              }
              if (value!.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),
          
          const SizedBox(height: 24),
          
          // Submit button
          FlutstrapButton(
            onPressed: _isLoading ? null : _submitForm,
            child: _isLoading 
                ? const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text('Signing In...'),
                    ],
                  )
                : const Text('Sign In'),
            variant: FSButtonVariant.primary,
            size: FSButtonSize.large,
          ),
        ],
      ),
    );
  }
  
  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    
    setState(() => _isLoading = true);
    
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // Handle successful login
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Welcome back, \${_emailController.text}!'),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        );
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login failed: \$error'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
}
''';

  /// Animation example code (NEW)
  static const String _animationExampleCode = '''
class AnimatedCard extends StatelessWidget {
  const AnimatedCard({
    super.key,
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return FSFadeIn(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(description),
            ],
          ),
        ),
      ),
    );
  }
}

// Usage in a list
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    return FSSlideTransition(
      direction: FSAnimationDirection.bottom,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
      child: AnimatedCard(
        title: 'Item \${index + 1}',
        description: 'This item animates into view from the bottom.',
      ),
    );
  },
)

// Scale animation for buttons
FSScaleAnimation(
  duration: const Duration(milliseconds: 200),
  curve: Curves.easeInOut,
  child: FlutstrapButton(
    onPressed: () {
      // Button action
    },
    child: const Text('Animated Button'),
    variant: FSButtonVariant.primary,
  ),
)
''';
}
 */