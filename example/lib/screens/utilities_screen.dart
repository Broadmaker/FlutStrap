// utilities_screen.dart
import 'package:flutter/material.dart';
import 'package:master_flutstrap/flutstrap.dart';

class UtilitiesScreen extends StatefulWidget {
  const UtilitiesScreen({super.key});

  @override
  State<UtilitiesScreen> createState() => _UtilitiesScreenState();
}

class _UtilitiesScreenState extends State<UtilitiesScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _textController = TextEditingController();

  String _emailValidation = '';
  String _phoneValidation = '';
  FSPasswordStrength _passwordStrength = FSPasswordStrength.weak;
  double _currentWidth = 0;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_updatePasswordStrength);
    _emailController.addListener(_validateEmail);
    _phoneController.addListener(_validatePhone);
  }

  void _updatePasswordStrength() {
    setState(() {
      _passwordStrength =
          FSValidators.checkPasswordStrength(_passwordController.text);
    });
  }

  void _validateEmail() {
    setState(() {
      if (_emailController.text.isEmpty) {
        _emailValidation = '';
      } else if (FSValidators.isEmail(_emailController.text)) {
        _emailValidation = '✓ Valid email';
      } else {
        _emailValidation = '✗ Invalid email format';
      }
    });
  }

  void _validatePhone() {
    setState(() {
      if (_phoneController.text.isEmpty) {
        _phoneValidation = '';
      } else if (FSValidators.isPhoneNumber(_phoneController.text)) {
        _phoneValidation = '✓ Valid phone number';
      } else {
        _phoneValidation = '✗ Invalid phone number';
      }
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _currentWidth = MediaQuery.of(context).size.width;
    final responsive = FSResponsive.of(_currentWidth);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Utilities & Responsive'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Breakpoint & Screen Info
            _buildInfoCard(responsive),
            const SizedBox(height: 24),

            // Spacing System
            _buildSectionTitle('Spacing System'),
            const SizedBox(height: 16),
            _buildSpacingExamples(),

            const SizedBox(height: 32),

            // Responsive Utilities
            _buildSectionTitle('Responsive Utilities'),
            const SizedBox(height: 16),
            _buildResponsiveExamples(responsive),

            const SizedBox(height: 32),

            // Validation Examples
            _buildSectionTitle('Validation Utilities'),
            const SizedBox(height: 16),
            _buildValidationExamples(),

            const SizedBox(height: 32),

            // String & Number Utilities
            _buildSectionTitle('String & Number Utilities'),
            const SizedBox(height: 16),
            _buildStringNumberExamples(),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(FSResponsive responsive) {
    return Card(
      color: Colors.blue[50],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.info, color: Colors.blue),
                SizedBox(width: 8),
                Text(
                  'Current Device Info',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildInfoRow('Breakpoint', responsive.breakpoint.displayName),
            _buildInfoRow(
                'Screen Width', '${_currentWidth.toStringAsFixed(0)}px'),
            _buildInfoRow('Platform', FSPlatform.isWeb ? 'Web' : 'Mobile'),
            _buildInfoRow(
                'Is Mobile', responsive.breakpoint.isMobile.toString()),
            _buildInfoRow(
                'Is Desktop', responsive.breakpoint.isDesktop.toString()),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Text(value),
        ],
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

  Widget _buildSpacingExamples() {
    return Column(
      children: [
        _buildExampleCard(
          'Spacing Scale',
          'Visual representation of spacing values',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: FSSpacing.map.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Container(
                      width: entry.value,
                      height: 20,
                      color: Colors.blue,
                      margin: const EdgeInsets.only(right: 12),
                    ),
                    SizedBox(
                      width: 40,
                      child: Text(
                        entry.key,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text('${entry.value}px'),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 16),
        _buildExampleCard(
          'Spacing in Layout',
          'Using spacing values in real layout',
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(FSSpacing.sm),
                color: Colors.green[100],
                child: const Text('Small Padding (8px)'),
              ),
              SizedBox(height: FSSpacing.md),
              Container(
                padding: EdgeInsets.all(FSSpacing.md),
                color: Colors.blue[100],
                child: const Text('Medium Padding (16px)'),
              ),
              SizedBox(height: FSSpacing.lg),
              Container(
                padding: EdgeInsets.all(FSSpacing.lg),
                color: Colors.orange[100],
                child: const Text('Large Padding (24px)'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildResponsiveExamples(FSResponsive responsive) {
    return Column(
      children: [
        _buildExampleCard(
          'Responsive Values',
          'Different values based on breakpoint',
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: responsive.value<Color>(
                xs: Colors.red[100]!,
                sm: Colors.orange[100]!,
                md: Colors.yellow[100]!,
                lg: Colors.green[100]!,
                xl: Colors.blue[100]!,
                xxl: Colors.purple[100]!,
                fallback: Colors.grey[100]!,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                responsive.value<String>(
                  xs: 'Extra Small Screen',
                  sm: 'Small Screen',
                  md: 'Medium Screen',
                  lg: 'Large Screen',
                  xl: 'Extra Large Screen',
                  xxl: 'Double Extra Large Screen',
                  fallback: 'Unknown Screen Size',
                ),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        _buildExampleCard(
          'Conditional Visibility',
          'Show/hide content based on breakpoint',
          Row(
            children: [
              Expanded(
                child: responsive.show(
                  child: _buildUtilityBox('Visible on Mobile', Colors.green),
                  showOnXs: true,
                  showOnSm: true,
                  showOnMd: false,
                  showOnLg: false,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: responsive.show(
                  child: _buildUtilityBox('Visible on Desktop', Colors.blue),
                  showOnXs: false,
                  showOnSm: false,
                  showOnMd: true,
                  showOnLg: true,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildExampleCard(
          'Breakpoint Checks',
          'Conditional logic based on screen size',
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildStatusChip('isMobile', responsive.breakpoint.isMobile),
              _buildStatusChip('isTablet', responsive.breakpoint.isTablet),
              _buildStatusChip('isDesktop', responsive.breakpoint.isDesktop),
              _buildStatusChip(
                  '>= Medium', responsive.isEqualOrLargerThan(FSBreakpoint.md)),
              _buildStatusChip(
                  '< Large', responsive.isSmallerThan(FSBreakpoint.lg)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildValidationExamples() {
    return Column(
      children: [
        _buildExampleCard(
          'Email Validation',
          'Real-time email format validation',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  hintText: 'Enter your email',
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 8),
              if (_emailValidation.isNotEmpty)
                Text(
                  _emailValidation,
                  style: TextStyle(
                    color: _emailValidation.startsWith('✓')
                        ? Colors.green
                        : Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildExampleCard(
          'Phone Validation',
          'Phone number format validation',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  hintText: 'Enter your phone number',
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 8),
              if (_phoneValidation.isNotEmpty)
                Text(
                  _phoneValidation,
                  style: TextStyle(
                    color: _phoneValidation.startsWith('✓')
                        ? Colors.green
                        : Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildExampleCard(
          'Password Strength',
          'Real-time password strength checking',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 8),
              if (_passwordController.text.isNotEmpty)
                Row(
                  children: [
                    Text(
                      'Strength: ',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      _passwordStrength.name,
                      style: TextStyle(
                        color: _passwordStrength.color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStringNumberExamples() {
    return Column(
      children: [
        _buildExampleCard(
          'String Utilities',
          'Text transformation and formatting',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _textController,
                decoration: const InputDecoration(
                  labelText: 'Enter text to transform',
                  hintText: 'Type something here...',
                ),
              ),
              const SizedBox(height: 16),
              if (_textController.text.isNotEmpty) ...[
                _buildStringExample(
                    'Capitalized:', FSUtils.capitalize(_textController.text)),
                _buildStringExample('Words Capitalized:',
                    FSUtils.capitalizeWords(_textController.text)),
                _buildStringExample('Truncated (10):',
                    FSUtils.truncate(_textController.text, 10)),
                _buildStringExample('Random ID:', FSUtils.generateId()),
              ],
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildExampleCard(
          'Number Utilities',
          'Number formatting and utilities',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildNumberExample(
                  'Formatted 1234567:', FSNumbers.formatNumber(1234567)),
              _buildNumberExample(
                  'Clamped (5, 0-10):', FSNumbers.clamp(5, 0, 10).toString()),
              _buildNumberExample('Lerp (0→100 at 0.5):',
                  FSNumbers.lerp(0, 100, 0.5).toStringAsFixed(1)),
              _buildNumberExample(
                  'Is "123" numeric:', FSNumbers.isNumeric('123').toString()),
              _buildNumberExample(
                  'File Size 1048576:', FSUtils.formatFileSize(1048576)),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildExampleCard(
          'Date Utilities',
          'Relative time and date helpers',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStringExample('Now:', FSDates.relativeTime(DateTime.now())),
              _buildStringExample(
                  '5 mins ago:',
                  FSDates.relativeTime(
                      DateTime.now().subtract(const Duration(minutes: 5)))),
              _buildStringExample(
                  '2 days ago:',
                  FSDates.relativeTime(
                      DateTime.now().subtract(const Duration(days: 2)))),
              _buildStringExample('Same day check:',
                  FSDates.isSameDay(DateTime.now(), DateTime.now()).toString()),
            ],
          ),
        ),
      ],
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

  Widget _buildUtilityBox(String text, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
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
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildStatusChip(String label, bool isActive) {
    return Chip(
      label: Text(label),
      backgroundColor: isActive ? Colors.green[100] : Colors.grey[200],
      labelStyle: TextStyle(
        color: isActive ? Colors.green[800] : Colors.grey[600],
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildStringExample(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _buildNumberExample(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 180,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Text(value),
        ],
      ),
    );
  }
}
