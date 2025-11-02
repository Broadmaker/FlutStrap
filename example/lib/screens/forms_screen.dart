/// Flutstrap Form Demo Screen
///
/// Comprehensive demonstration of Flutstrap form system including:
/// - 📝 All form components (input, textarea, checkbox, radio)
/// - ✅ Form validation and error states
/// - 🎯 Interactive form controls
/// - 📱 Responsive form layouts
/// - ♿ Accessibility features
/// - ⚡ Performance-optimized forms
///
/// Features:
/// - Live interactive form demonstrations
/// - Real-time validation feedback
/// - Multiple form layout examples
/// - Accessibility testing tools
/// - Form state management
///
/// {@category Demo}
/// {@category Screens}
/// {@category Forms}

import 'package:flutter/material.dart';

class FormsScreen extends StatefulWidget {
  const FormsScreen({super.key});

  /// Route name for navigation
  static const String routeName = '/forms';

  @override
  State<FormsScreen> createState() => _FormsScreenState();
}

class _FormsScreenState extends State<FormsScreen> {
  // ✅ FORM STATE MANAGEMENT
  final _formKey = GlobalKey<FormState>();

  // Input fields state
  String _firstName = '';
  String _lastName = '';
  String _email = '';
  String _phone = '';
  String _description = '';
  String _password = '';
  String _confirmPassword = '';

  // Checkbox state
  bool _acceptTerms = false;
  bool _newsletterSubscription = true;
  bool? _triStateValue;

  // Radio state
  String _selectedGender = 'male';
  String _selectedPlan = 'basic';
  String _selectedPriority = 'medium';

  // Form validation state
  bool _showValidation = false;
  bool _isSubmitting = false;

  // ✅ CONSTANTS
  static const EdgeInsets _screenPadding = EdgeInsets.all(16.0);
  static const EdgeInsets _sectionPadding = EdgeInsets.only(bottom: 32.0);
  static const EdgeInsets _demoPadding = EdgeInsets.all(16.0);
  static const double _sectionSpacing = 24.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form System'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: _showFormInfo,
            tooltip: 'Form Information',
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: _screenPadding,
          child: ListView(
            children: [
              // ✅ INTRODUCTION SECTION
              _buildIntroductionSection(context),
              const SizedBox(height: _sectionSpacing),

              // ✅ BASIC INPUT DEMONSTRATION
              _buildBasicInputsSection(),
              const SizedBox(height: _sectionSpacing),

              // ✅ TEXTAREA DEMONSTRATION
              _buildTextAreaSection(),
              const SizedBox(height: _sectionSpacing),

              // ✅ CHECKBOX DEMONSTRATION
              _buildCheckboxSection(),
              const SizedBox(height: _sectionSpacing),

              // ✅ RADIO BUTTON DEMONSTRATION
              _buildRadioSection(),
              const SizedBox(height: _sectionSpacing),

              // ✅ FORM LAYOUT DEMONSTRATION
              _buildFormLayoutSection(),
              const SizedBox(height: _sectionSpacing),

              // ✅ FORM CONTROLS
              _buildFormControlsSection(),
              const SizedBox(height: _sectionSpacing),

              // ✅ FORM STATE DISPLAY
              _buildFormStateSection(),
            ],
          ),
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
            'Flutstrap Form System',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            'Comprehensive form system with performance-optimized components, '
            'real-time validation, and accessibility features. Explore different '
            'form layouts, validation patterns, and interactive demonstrations.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  height: 1.5,
                ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: [
              _buildFeatureChip('✅ Real-time Validation'),
              _buildFeatureChip('♿ Accessibility Ready'),
              _buildFeatureChip('📱 Responsive Layouts'),
              _buildFeatureChip('⚡ Performance Optimized'),
              _buildFeatureChip('🎨 Theme Integrated'),
            ],
          ),
        ],
      ),
    );
  }

  /// Build basic inputs demonstration section
  Widget _buildBasicInputsSection() {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(
            title: 'Basic Input Fields',
            description: 'Text inputs with various states and validation',
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: _demoPadding,
              child: Column(
                children: [
                  // Personal Information Group
                  _buildFormGroup(
                    label: 'Personal Information',
                    children: [
                      _buildInputRow([
                        _buildInputField(
                          label: 'First Name',
                          value: _firstName,
                          onChanged: (value) =>
                              setState(() => _firstName = value),
                          required: true,
                          validator: _validateRequired,
                        ),
                        _buildInputField(
                          label: 'Last Name',
                          value: _lastName,
                          onChanged: (value) =>
                              setState(() => _lastName = value),
                          required: true,
                          validator: _validateRequired,
                        ),
                      ]),
                      _buildInputField(
                        label: 'Email Address',
                        value: _email,
                        onChanged: (value) => setState(() => _email = value),
                        keyboardType: TextInputType.emailAddress,
                        required: true,
                        validator: _validateEmail,
                      ),
                      _buildInputField(
                        label: 'Phone Number',
                        value: _phone,
                        onChanged: (value) => setState(() => _phone = value),
                        keyboardType: TextInputType.phone,
                        validator: _validatePhone,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Password Group
                  _buildFormGroup(
                    label: 'Account Security',
                    children: [
                      _buildInputField(
                        label: 'Password',
                        value: _password,
                        onChanged: (value) => setState(() => _password = value),
                        obscureText: true,
                        required: true,
                        validator: _validatePassword,
                      ),
                      _buildInputField(
                        label: 'Confirm Password',
                        value: _confirmPassword,
                        onChanged: (value) =>
                            setState(() => _confirmPassword = value),
                        obscureText: true,
                        required: true,
                        validator: (value) =>
                            _validatePasswordMatch(value, _password),
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

  /// Build textarea demonstration section
  Widget _buildTextAreaSection() {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(
            title: 'Text Area Fields',
            description:
                'Multi-line text inputs with auto-resize and character counters',
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: _demoPadding,
              child: Column(
                children: [
                  _buildFormGroup(
                    label: 'Description & Notes',
                    children: [
                      _buildTextAreaField(
                        label: 'Project Description',
                        value: _description,
                        onChanged: (value) =>
                            setState(() => _description = value),
                        placeholder: 'Describe your project in detail...',
                        rows: 4,
                        maxLength: 500,
                        showCharacterCounter: true,
                        validator: _validateDescription,
                      ),
                      _buildTextAreaField(
                        label: 'Additional Notes',
                        value: _description,
                        onChanged: (value) =>
                            setState(() => _description = value),
                        placeholder: 'Any additional information...',
                        autoResize: true,
                        maxLength: 200,
                        showCharacterCounter: true,
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

  /// Build checkbox demonstration section
  Widget _buildCheckboxSection() {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(
            title: 'Checkbox Fields',
            description: 'Single, multiple, and tri-state checkbox options',
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: _demoPadding,
              child: Column(
                children: [
                  _buildFormGroup(
                    label: 'Preferences & Agreements',
                    children: [
                      _buildCheckboxField(
                        label: 'I accept the terms and conditions',
                        value: _acceptTerms,
                        onChanged: (value) =>
                            setState(() => _acceptTerms = value ?? false),
                        required: true,
                        validator: _validateTerms,
                      ),
                      _buildCheckboxField(
                        label: 'Subscribe to newsletter',
                        value: _newsletterSubscription,
                        onChanged: (value) => setState(
                            () => _newsletterSubscription = value ?? false),
                      ),
                      _buildCheckboxField(
                        label: 'Tri-state option (for groups)',
                        value: _triStateValue,
                        onChanged: (value) =>
                            setState(() => _triStateValue = value),
                        tristate: true,
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

  /// Build radio button demonstration section
  Widget _buildRadioSection() {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(
            title: 'Radio Button Groups',
            description: 'Single selection options with various layouts',
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: _demoPadding,
              child: Column(
                children: [
                  // Gender Selection
                  _buildFormGroup(
                    label: 'Gender',
                    children: [
                      _buildRadioGroup(
                        options: const [
                          {'value': 'male', 'label': 'Male'},
                          {'value': 'female', 'label': 'Female'},
                          {'value': 'other', 'label': 'Other'},
                          {'value': 'prefer-not', 'label': 'Prefer not to say'},
                        ],
                        selectedValue: _selectedGender,
                        onChanged: (value) =>
                            setState(() => _selectedGender = value ?? ''),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Plan Selection
                  _buildFormGroup(
                    label: 'Subscription Plan',
                    children: [
                      _buildRadioGroup(
                        options: const [
                          {
                            'value': 'basic',
                            'label': 'Basic Plan',
                            'description': 'Free forever'
                          },
                          {
                            'value': 'pro',
                            'label': 'Pro Plan',
                            'description': '\$9.99/month'
                          },
                          {
                            'value': 'enterprise',
                            'label': 'Enterprise',
                            'description': '\$29.99/month'
                          },
                        ],
                        selectedValue: _selectedPlan,
                        onChanged: (value) =>
                            setState(() => _selectedPlan = value ?? ''),
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

  /// Build form layout demonstration section
  Widget _buildFormLayoutSection() {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(
            title: 'Form Layout Options',
            description: 'Different form grouping and layout patterns',
          ),
          const SizedBox(height: 16),

          // Vertical Layout
          Card(
            child: Padding(
              padding: _demoPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Vertical Layout (Default)',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Fields stacked vertically with consistent spacing',
                    style: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.6),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildFormGroup(
                    label: 'Contact Information',
                    layout: 'vertical',
                    children: [
                      _buildInputField(
                        label: 'Full Name',
                        value: _firstName,
                        onChanged: (value) =>
                            setState(() => _firstName = value),
                      ),
                      _buildInputField(
                        label: 'Email',
                        value: _email,
                        onChanged: (value) => setState(() => _email = value),
                      ),
                      _buildInputField(
                        label: 'Company',
                        value: _lastName,
                        onChanged: (value) => setState(() => _lastName = value),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Horizontal Layout
          Card(
            child: Padding(
              padding: _demoPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Horizontal Layout',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Fields arranged side-by-side for compact forms',
                    style: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.6),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildFormGroup(
                    label: 'Address',
                    layout: 'horizontal',
                    children: [
                      _buildInputField(
                        label: 'Street',
                        value: _firstName,
                        onChanged: (value) =>
                            setState(() => _firstName = value),
                      ),
                      _buildInputField(
                        label: 'City',
                        value: _lastName,
                        onChanged: (value) => setState(() => _lastName = value),
                      ),
                      _buildInputField(
                        label: 'ZIP',
                        value: _email,
                        onChanged: (value) => setState(() => _email = value),
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

  /// Build form controls section
  Widget _buildFormControlsSection() {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(
            title: 'Form Controls',
            description: 'Form validation, submission, and state management',
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: _demoPadding,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _validateForm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text('Validate Form'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _clearForm,
                          child: const Text('Clear Form'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton.tonal(
                          onPressed: _submitForm,
                          child: _isSubmitting
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child:
                                      CircularProgressIndicator(strokeWidth: 2),
                                )
                              : const Text('Submit Form'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    title: const Text('Show Validation States'),
                    subtitle:
                        const Text('Display real-time validation feedback'),
                    value: _showValidation,
                    onChanged: (value) =>
                        setState(() => _showValidation = value),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build form state display section
  Widget _buildFormStateSection() {
    return Container(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(
            title: 'Form State',
            description: 'Current form data and validation status',
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: _demoPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFormDataItem('First Name',
                      _firstName.isEmpty ? 'Not set' : _firstName),
                  _buildFormDataItem(
                      'Last Name', _lastName.isEmpty ? 'Not set' : _lastName),
                  _buildFormDataItem(
                      'Email', _email.isEmpty ? 'Not set' : _email),
                  _buildFormDataItem(
                      'Terms Accepted', _acceptTerms ? 'Yes' : 'No'),
                  _buildFormDataItem('Selected Gender', _selectedGender),
                  _buildFormDataItem('Selected Plan', _selectedPlan),
                  _buildFormDataItem('Form Valid', _isFormValid().toString()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ✅ HELPER METHODS

  Widget _buildSectionHeader(
      {required String title, required String description}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
        ),
      ],
    );
  }

  Widget _buildFeatureChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildFormGroup({
    required String label,
    required List<Widget> children,
    String layout = 'vertical',
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 12),
        if (layout == 'horizontal')
          Row(
            children: [
              for (int i = 0; i < children.length; i++) ...[
                Expanded(child: children[i]),
                if (i < children.length - 1) const SizedBox(width: 12),
              ],
            ],
          )
        else
          Column(
            children: [
              for (int i = 0; i < children.length; i++) ...[
                children[i],
                if (i < children.length - 1) const SizedBox(height: 12),
              ],
            ],
          ),
      ],
    );
  }

  Widget _buildInputRow(List<Widget> children) {
    return Row(
      children: [
        for (int i = 0; i < children.length; i++) ...[
          Expanded(child: children[i]),
          if (i < children.length - 1) const SizedBox(width: 12),
        ],
      ],
    );
  }

  Widget _buildInputField({
    required String label,
    required String value,
    required ValueChanged<String> onChanged,
    TextInputType? keyboardType,
    bool obscureText = false,
    bool required = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: '$label${required ? ' *' : ''}',
        border: const OutlineInputBorder(),
        errorText: _showValidation ? validator?.call(value) : null,
      ),
      keyboardType: keyboardType,
      obscureText: obscureText,
      onChanged: onChanged,
      validator: validator,
    );
  }

  Widget _buildTextAreaField({
    required String label,
    required String value,
    required ValueChanged<String> onChanged,
    String? placeholder,
    int rows = 3,
    int? maxLength,
    bool showCharacterCounter = false,
    bool autoResize = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        hintText: placeholder,
        errorText: _showValidation ? validator?.call(value) : null,
        counterText: showCharacterCounter && maxLength != null
            ? '${value.length}/$maxLength'
            : null,
      ),
      maxLines: autoResize ? null : rows,
      minLines: autoResize ? null : rows,
      maxLength: maxLength,
      onChanged: onChanged,
      validator: validator,
    );
  }

  Widget _buildCheckboxField({
    required String label,
    required bool? value,
    required ValueChanged<bool?> onChanged,
    bool required = false,
    bool tristate = false,
    String? Function(bool?)? validator,
  }) {
    return CheckboxListTile(
      title: Text('$label${required ? ' *' : ''}'),
      value: value,
      onChanged: onChanged,
      controlAffinity: ListTileControlAffinity.leading,
      tristate: tristate,
      subtitle: _showValidation && validator != null
          ? Text(
              validator(value) ?? '',
              style: const TextStyle(color: Colors.red),
            )
          : null,
    );
  }

  Widget _buildRadioGroup({
    required List<Map<String, String>> options,
    required String selectedValue,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      children: options.map((option) {
        return RadioListTile<String>(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(option['label']!),
              if (option['description'] != null)
                Text(
                  option['description']!,
                  style: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.6),
                    fontSize: 12,
                  ),
                ),
            ],
          ),
          value: option['value']!,
          groupValue: selectedValue,
          onChanged: onChanged,
        );
      }).toList(),
    );
  }

  Widget _buildFormDataItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ✅ VALIDATION METHODS
  String? _validateRequired(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value != null && value.isNotEmpty) {
      if (!RegExp(r'^[0-9+\-\s()]{10,}$').hasMatch(value)) {
        return 'Enter a valid phone number';
      }
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 8) return 'Password must be at least 8 characters';
    return null;
  }

  String? _validatePasswordMatch(String? value, String password) {
    if (value == null || value.isEmpty) return 'Please confirm your password';
    if (value != password) return 'Passwords do not match';
    return null;
  }

  String? _validateDescription(String? value) {
    if (value == null || value.isEmpty) return 'Description is required';
    if (value.length < 10) return 'Description must be at least 10 characters';
    return null;
  }

  String? _validateTerms(bool? value) {
    if (value != true) return 'You must accept the terms and conditions';
    return null;
  }

  // ✅ FORM CONTROL METHODS
  void _validateForm() {
    setState(() {
      _showValidation = true;
    });
  }

  void _clearForm() {
    _formKey.currentState?.reset();
    setState(() {
      _firstName = '';
      _lastName = '';
      _email = '';
      _phone = '';
      _description = '';
      _password = '';
      _confirmPassword = '';
      _acceptTerms = false;
      _newsletterSubscription = true;
      _triStateValue = null;
      _selectedGender = 'male';
      _selectedPlan = 'basic';
      _showValidation = false;
      _isSubmitting = false;
    });
  }

  Future<void> _submitForm() async {
    if (!_isFormValid()) {
      setState(() => _showValidation = true);
      return;
    }

    setState(() => _isSubmitting = true);

    // Simulate form submission
    await Future.delayed(const Duration(seconds: 2));

    setState(() => _isSubmitting = false);

    // Show success dialog
    if (context.mounted) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Form Submitted'),
          content: const Text('Your form has been submitted successfully!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  bool _isFormValid() {
    return _validateRequired(_firstName) == null &&
        _validateRequired(_lastName) == null &&
        _validateEmail(_email) == null &&
        _validatePassword(_password) == null &&
        _validatePasswordMatch(_confirmPassword, _password) == null &&
        _validateTerms(_acceptTerms) == null;
  }

  void _showFormInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Form System Information'),
        content: const Text(
          'The Flutstrap form system provides:\n\n'
          '• Comprehensive form validation\n'
          '• Real-time feedback and error states\n'
          '• Accessibility features for all users\n'
          '• Performance-optimized components\n'
          '• Responsive layout options\n'
          '• Theme integration\n\n'
          'All form components include proper error handling and state management.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
