/// Flutstrap Utilities Demo Screen
///
/// Comprehensive demonstration of Flutstrap utility systems including:
/// - 🔧 Validation utilities (email, phone, URL, password strength)
/// - 📝 String manipulation (capitalization, truncation, formatting)
/// - 📅 Date and time utilities (relative time, date operations)
/// - 🔢 Number formatting and mathematical utilities
/// - 📱 Platform detection and environment utilities
/// - 🛡️ Error handling and safe operations
///
/// Features:
/// - Live interactive utility demonstrations
/// - Real-time validation examples
/// - Code examples for each utility
/// - Responsive layout design
///
/// {@category Demo}
/// {@category Screens}
/// {@category Utilities}

import 'package:flutter/material.dart';
import 'package:flutstrap/flutstrap.dart';

class UtilitiesScreen extends StatefulWidget {
  const UtilitiesScreen({super.key});

  /// Route name for navigation
  static const String routeName = '/utilities';

  @override
  State<UtilitiesScreen> createState() => _UtilitiesScreenState();
}

class _UtilitiesScreenState extends State<UtilitiesScreen> {
  // ✅ STATE FOR INTERACTIVE EXAMPLES
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

  String _validationResult = '';
  String _stringOperationResult = '';
  String _dateOperationResult = '';
  String _numberOperationResult = '';
  String _platformInfo = '';

  // ✅ CONSTANTS FOR PERFORMANCE
  static const EdgeInsets _screenPadding = EdgeInsets.all(16.0);
  static const EdgeInsets _sectionPadding = EdgeInsets.only(bottom: 32.0);
  static const EdgeInsets _cardPadding = EdgeInsets.all(16.0);
  static const double _sectionSpacing = 24.0;
  static const double _itemSpacing = 16.0;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _updatePlatformInfo();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _urlController.dispose();
    _passwordController.dispose();
    _textController.dispose();
    _numberController.dispose();
    super.dispose();
  }

  void _initializeControllers() {
    _emailController.addListener(_validateEmail);
    _phoneController.addListener(_validatePhone);
    _urlController.addListener(_validateUrl);
    _passwordController.addListener(_checkPasswordStrength);
    _textController.addListener(_performStringOperations);
    _numberController.addListener(
        _performNumberOperations); // ✅ FIXED: Now this method exists
  }

  void _updatePlatformInfo() {
    setState(() {
      _platformInfo = '''
Platform: ${FSPlatform.platformName}
Is Web: ${FSPlatform.isWeb}
Is Mobile: ${FSPlatform.isMobile}
Is Desktop: ${FSPlatform.isDesktop}
Is Android: ${FSPlatform.isAndroid}
Is iOS: ${FSPlatform.isIOS}
''';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Utilities & Responsive'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      body: Padding(
        padding: _screenPadding,
        child: ListView(
          children: [
            // ✅ INTRODUCTION SECTION
            _buildIntroductionSection(context),
            const SizedBox(height: _sectionSpacing),

            // ✅ VALIDATION UTILITIES
            _buildValidationUtilitiesSection(context),
            const SizedBox(height: _sectionSpacing),

            // ✅ STRING UTILITIES
            _buildStringUtilitiesSection(context),
            const SizedBox(height: _sectionSpacing),

            // ✅ DATE & TIME UTILITIES
            _buildDateTimeUtilitiesSection(context),
            const SizedBox(height: _sectionSpacing),

            // ✅ NUMBER UTILITIES
            _buildNumberUtilitiesSection(context),
            const SizedBox(height: _sectionSpacing),

            // ✅ PLATFORM & ENVIRONMENT
            _buildPlatformUtilitiesSection(context),
            const SizedBox(height: _sectionSpacing),

            // ✅ ERROR HANDLING
            _buildErrorHandlingSection(context),
          ],
        ),
      ),
    );
  }

  /// Build introduction section
  Widget _buildIntroductionSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Utilities & Responsive System',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: _itemSpacing),
          Text(
            'Comprehensive utility functions for common development tasks including '
            'validation, string manipulation, date operations, number formatting, '
            'platform detection, and error handling.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  height: 1.5,
                ),
          ),
        ],
      ),
    );
  }

  /// Build validation utilities section
  Widget _buildValidationUtilitiesSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Validation Utilities',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Real-time validation for common input types',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: _itemSpacing),
          Card(
            child: Padding(
              padding: _cardPadding,
              child: Column(
                children: [
                  // Email validation
                  _buildValidationField(
                    'Email Address',
                    'user@example.com',
                    _emailController,
                    Icons.email,
                  ),
                  const SizedBox(height: 16),

                  // Phone validation
                  _buildValidationField(
                    'Phone Number',
                    '+1 (555) 123-4567',
                    _phoneController,
                    Icons.phone,
                  ),
                  const SizedBox(height: 16),

                  // URL validation
                  _buildValidationField(
                    'Website URL',
                    'https://example.com',
                    _urlController,
                    Icons.link,
                  ),
                  const SizedBox(height: 16),

                  // Password strength
                  _buildValidationField(
                    'Password Strength',
                    'Enter your password',
                    _passwordController,
                    Icons.lock,
                    obscureText: true,
                  ),
                  const SizedBox(height: 16),

                  // Validation results
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _validationResult.isEmpty
                          ? 'Enter values above to see validation results...'
                          : _validationResult,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build string utilities section
  Widget _buildStringUtilitiesSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'String Utilities',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Text manipulation and formatting functions',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: _itemSpacing),
          Card(
            child: Padding(
              padding: _cardPadding,
              child: Column(
                children: [
                  TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      labelText: 'Enter text to transform',
                      hintText: 'hello world example text',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 16),
                  if (_stringOperationResult.isNotEmpty) ...[
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceVariant,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(_stringOperationResult),
                    ),
                    const SizedBox(height: 16),
                  ],
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      FlutstrapButton(
                        onPressed: _capitalizeText,
                        text: 'Capitalize',
                        variant: FSButtonVariant.outlinePrimary,
                        size: FSButtonSize.sm,
                      ),
                      FlutstrapButton(
                        onPressed: _capitalizeWords,
                        text: 'Title Case',
                        variant: FSButtonVariant.outlinePrimary,
                        size: FSButtonSize.sm,
                      ),
                      FlutstrapButton(
                        onPressed: _truncateText,
                        text: 'Truncate',
                        variant: FSButtonVariant.outlinePrimary,
                        size: FSButtonSize.sm,
                      ),
                      FlutstrapButton(
                        onPressed: _generateId,
                        text: 'Generate ID',
                        variant: FSButtonVariant.outlinePrimary,
                        size: FSButtonSize.sm,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build date and time utilities section
  Widget _buildDateTimeUtilitiesSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Date & Time Utilities',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Date manipulation and relative time formatting',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: _itemSpacing),
          Card(
            child: Padding(
              padding: _cardPadding,
              child: Column(
                children: [
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      FlutstrapButton(
                        onPressed: _showRelativeTime,
                        text: 'Relative Time',
                        variant: FSButtonVariant.outlineSuccess,
                        size: FSButtonSize.sm,
                      ),
                      FlutstrapButton(
                        onPressed: _showDateOperations,
                        text: 'Date Operations',
                        variant: FSButtonVariant.outlineSuccess,
                        size: FSButtonSize.sm,
                      ),
                      FlutstrapButton(
                        onPressed: _calculateAge,
                        text: 'Calculate Age',
                        variant: FSButtonVariant.outlineSuccess,
                        size: FSButtonSize.sm,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (_dateOperationResult.isNotEmpty) ...[
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceVariant,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(_dateOperationResult),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build number utilities section
  Widget _buildNumberUtilitiesSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Number Utilities',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Number formatting and mathematical operations',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: _itemSpacing),
          Card(
            child: Padding(
              padding: _cardPadding,
              child: Column(
                children: [
                  TextField(
                    controller: _numberController,
                    decoration: const InputDecoration(
                      labelText: 'Enter numbers (comma or space separated)',
                      hintText: '1234.56, 7890, 1234567.89',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  if (_numberOperationResult.isNotEmpty) ...[
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceVariant,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(_numberOperationResult),
                    ),
                    const SizedBox(height: 16),
                  ],
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      FlutstrapButton(
                        onPressed: _formatNumbers,
                        text: 'Format Numbers',
                        variant: FSButtonVariant.outlineInfo,
                        size: FSButtonSize.sm,
                      ),
                      FlutstrapButton(
                        onPressed: _checkNumeric,
                        text: 'Check Numeric',
                        variant: FSButtonVariant.outlineInfo,
                        size: FSButtonSize.sm,
                      ),
                      FlutstrapButton(
                        onPressed: _showFileSizes,
                        text: 'File Sizes',
                        variant: FSButtonVariant.outlineInfo,
                        size: FSButtonSize.sm,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build platform utilities section
  Widget _buildPlatformUtilitiesSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Platform & Environment',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Platform detection and environment information',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: _itemSpacing),
          Card(
            child: Padding(
              padding: _cardPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Platform Information',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _platformInfo,
                      style: const TextStyle(
                          fontFamily: 'Monospace', fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build error handling section
  Widget _buildErrorHandlingSection(BuildContext context) {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Error Handling & Safe Operations',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Safe function execution with error boundaries',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: _itemSpacing),
          Card(
            child: Padding(
              padding: _cardPadding,
              child: Column(
                children: [
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      FlutstrapButton(
                        onPressed: _demoSafeOperation,
                        text: 'Safe Operation',
                        variant: FSButtonVariant.outlineWarning,
                        size: FSButtonSize.sm,
                      ),
                      FlutstrapButton(
                        onPressed: _demoErrorOperation,
                        text: 'Error Operation',
                        variant: FSButtonVariant.outlineDanger,
                        size: FSButtonSize.sm,
                      ),
                      FlutstrapButton(
                        onPressed: _demoAsyncSafeOperation,
                        text: 'Async Safe Op',
                        variant: FSButtonVariant.outlineWarning,
                        size: FSButtonSize.sm,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ✅ HELPER METHODS

  /// Build validation field with icon
  Widget _buildValidationField(
    String label,
    String hint,
    TextEditingController controller,
    IconData icon, {
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
      ),
      obscureText: obscureText,
    );
  }

  // ✅ VALIDATION HANDLERS

  void _validateEmail() {
    final email = _emailController.text;
    final isValid = FSValidators.isEmail(email);
    _updateValidationResult(
        'Email: "$email" - ${isValid ? '✅ Valid' : '❌ Invalid'}');
  }

  void _validatePhone() {
    final phone = _phoneController.text;
    final isValid = FSValidators.isPhoneNumber(phone);
    _updateValidationResult(
        'Phone: "$phone" - ${isValid ? '✅ Valid' : '❌ Invalid'}');
  }

  void _validateUrl() {
    final url = _urlController.text;
    final isValid = FSValidators.isUrl(url);
    _updateValidationResult(
        'URL: "$url" - ${isValid ? '✅ Valid' : '❌ Invalid'}');
  }

  void _checkPasswordStrength() {
    final password = _passwordController.text;
    if (password.isEmpty) return;

    final strength = FSValidators.checkPasswordStrength(password);
    _updateValidationResult(
        'Password: ${strength.name} ${_getStrengthEmoji(strength)}');
  }

  void _updateValidationResult(String result) {
    setState(() {
      _validationResult = result;
    });
  }

  String _getStrengthEmoji(FSPasswordStrength strength) {
    switch (strength) {
      case FSPasswordStrength.weak:
        return '🔴';
      case FSPasswordStrength.medium:
        return '🟡';
      case FSPasswordStrength.strong:
        return '🟢';
    }
  }

  // ✅ STRING OPERATION HANDLERS

  void _performStringOperations() {
    // This method is called when text changes, but we don't auto-update results
    // Users need to click buttons to see transformations
  }

  void _capitalizeText() {
    final text = _textController.text;
    final result = FSUtils.capitalize(text);
    _updateStringResult('Capitalized: "$result"');
  }

  void _capitalizeWords() {
    final text = _textController.text;
    final result = FSUtils.capitalizeWords(text);
    _updateStringResult('Title Case: "$result"');
  }

  void _truncateText() {
    final text = _textController.text;
    final result = FSUtils.truncate(text, 20);
    _updateStringResult('Truncated (20 chars): "$result"');
  }

  void _generateId() {
    final id = FSUtils.generateId(length: 12);
    _updateStringResult('Generated ID: "$id"');
  }

  void _updateStringResult(String result) {
    setState(() {
      _stringOperationResult = result;
    });
  }

  // ✅ DATE OPERATION HANDLERS

  void _showRelativeTime() {
    final now = DateTime.now();
    final fiveMinutesAgo = now.subtract(const Duration(minutes: 5));
    final twoHoursAgo = now.subtract(const Duration(hours: 2));
    final threeDaysAgo = now.subtract(const Duration(days: 3));

    setState(() {
      _dateOperationResult = '''
Relative Time Examples:
- 5 minutes ago: ${FSDates.relativeTime(fiveMinutesAgo)}
- 2 hours ago: ${FSDates.relativeTime(twoHoursAgo)}
- 3 days ago: ${FSDates.relativeTime(threeDaysAgo)}
- Now: ${FSDates.relativeTime(now)}
''';
    });
  }

  void _showDateOperations() {
    final now = DateTime.now();
    final startOfDay = FSDates.startOfDay(now);
    final endOfDay = FSDates.endOfDay(now);
    final isSameDay = FSDates.isSameDay(now, DateTime.now());

    setState(() {
      _dateOperationResult = '''
Date Operations:
- Start of Day: $startOfDay
- End of Day: $endOfDay
- Is Same Day (now vs now): $isSameDay
''';
    });
  }

  void _calculateAge() {
    final birthDate = DateTime(1990, 6, 15);
    final age = FSDates.calculateAge(birthDate);

    setState(() {
      _dateOperationResult = '''
Age Calculation:
- Birth Date: ${birthDate.toLocal()}
- Current Age: $age years old
''';
    });
  }

  // ✅ NUMBER OPERATION HANDLERS

  void _performNumberOperations() {
    // This method is called when number input changes, but we don't auto-update results
    // Users need to click buttons to see transformations
  }

  void _formatNumbers() {
    final numbers = _numberController.text.split(RegExp(r'[, ]+'));
    final results = numbers.map((n) {
      final parsed = double.tryParse(n);
      return parsed != null ? FSNumbers.formatNumber(parsed) : 'Invalid: $n';
    }).join('\n');

    setState(() {
      _numberOperationResult = 'Formatted Numbers:\n$results';
    });
  }

  void _checkNumeric() {
    final inputs = _numberController.text.split(RegExp(r'[, ]+'));
    final results = inputs.map((input) {
      final isNumeric =
          FSValidators.isNumeric(input); // ✅ FIXED: Use FSValidators.isNumeric
      return '"$input": ${isNumeric ? '✅ Numeric' : '❌ Not numeric'}';
    }).join('\n');

    setState(() {
      _numberOperationResult = 'Numeric Check:\n$results';
    });
  }

  void _showFileSizes() {
    final sizes = [1024, 1048576, 1073741824, 3221225472]; // 1KB, 1MB, 1GB, 3GB

    setState(() {
      _numberOperationResult = 'File Size Formatting:\n' +
          sizes
              .map((size) => '$size bytes = ${FSUtils.formatFileSize(size)}')
              .join('\n');
    });
  }

  // ✅ ERROR HANDLING DEMOS

  void _demoSafeOperation() {
    final result = FSErrors.tryCatch(
      () => 'Successful operation result',
      onError: (error, stack) => 'Error caught: $error',
      fallback: 'Fallback value',
    );

    _showSnackbar('Safe operation: $result');
  }

  void _demoErrorOperation() {
    final result = FSErrors.tryCatch(
      () => throw Exception('Simulated error'),
      onError: (error, stack) => 'Error safely handled: $error',
      fallback: 'Fallback value used',
    );

    _showSnackbar('Error operation: $result');
  }

  void _demoAsyncSafeOperation() async {
    final result = await FSErrors.tryCatchAsync(
      () async {
        await Future.delayed(const Duration(seconds: 1));
        return 'Async operation completed';
      },
      onError: (error, stack) => 'Async error: $error',
      fallback: 'Async fallback',
    );

    _showSnackbar('Async safe operation: $result');
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
