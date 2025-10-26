import 'package:flutter/material.dart';
import 'package:master_flutstrap/flutstrap.dart';

class FormsScreen extends StatefulWidget {
  const FormsScreen({super.key});

  @override
  State<FormsScreen> createState() => _FormsScreenState();
}

class _FormsScreenState extends State<FormsScreen> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _textareaController = TextEditingController();

  String? _selectedOption = 'option1';
  bool _checkbox1 = false;
  bool _checkbox2 = true;
  bool _checkbox3 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forms'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(context, 'Text Inputs'),
            _buildTextInputsSection(context),
            const SizedBox(height: 32),
            _buildSectionTitle(context, 'Checkboxes'),
            _buildCheckboxesSection(context),
            const SizedBox(height: 32),
            _buildSectionTitle(context, 'Radio Buttons'),
            _buildRadioButtonsSection(context),
            const SizedBox(height: 32),
            _buildSectionTitle(context, 'Textarea'),
            _buildTextareaSection(context),
            const SizedBox(height: 32),
            _buildSectionTitle(context, 'Form Groups'),
            _buildFormGroupsSection(context),
            const SizedBox(height: 32),
            _buildSectionTitle(context, 'Complete Form Example'),
            _buildCompleteFormSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }

  Widget _buildTextInputsSection(BuildContext context) {
    return FlutstrapFormGroup(
      children: [
        FlutstrapInput(
          controller: _textController,
          labelText: 'Basic Input',
          hintText:
              'Enter some text...', // Changed from placeholder to hintText
          helperText: 'This is a helper text',
        ),
        FlutstrapInput(
          controller: _emailController,
          labelText: 'Email Input',
          hintText: 'Enter your email', // Changed from placeholder to hintText
          keyboardType: TextInputType.emailAddress,
          variant: FSInputVariant.success,
          helperText: 'We\'ll never share your email',
        ),
        FlutstrapInput(
          labelText: 'Disabled Input',
          hintText:
              'This input is disabled', // Changed from placeholder to hintText
          enabled: false, // Changed from disabled to enabled
        ),
        FlutstrapInput(
          labelText: 'Error Input',
          hintText:
              'This input has an error', // Changed from placeholder to hintText
          variant: FSInputVariant.danger,
          errorText: 'This field is required',
          // Removed showValidation and isValid parameters
        ),
      ],
      layout: FSFormGroupLayout.vertical,
      spacing: 16,
    );
  }

  Widget _buildCheckboxesSection(BuildContext context) {
    return FlutstrapFormGroup(
      children: [
        FlutstrapCheckbox(
          value: _checkbox1,
          onChanged: (value) => setState(() => _checkbox1 = value ?? false),
          label: 'Primary Checkbox',
          variant: FSCheckboxVariant.primary,
        ),
        FlutstrapCheckbox(
          value: _checkbox2,
          onChanged: (value) => setState(() => _checkbox2 = value ?? false),
          label: 'Success Checkbox (Checked)',
          variant: FSCheckboxVariant.success,
        ),
        FlutstrapCheckbox(
          value: _checkbox3,
          onChanged: (value) => setState(() => _checkbox3 = value ?? false),
          label: 'Danger Checkbox with Error',
          variant: FSCheckboxVariant.danger,
          // Removed showValidation and isValid parameters
          validationMessage: 'This checkbox is required',
        ),
        FlutstrapCheckbox(
          value: false,
          onChanged: null,
          label: 'Disabled Checkbox',
          disabled: true,
        ),
      ],
      layout: FSFormGroupLayout.vertical,
      spacing: 12,
    );
  }

  Widget _buildRadioButtonsSection(BuildContext context) {
    return FlutstrapFormGroup(
      children: [
        FlutstrapRadio<String>(
          value: 'option1',
          groupValue: _selectedOption,
          onChanged: (value) => setState(() => _selectedOption = value),
          label: 'Primary Radio Option 1',
          variant: FSRadioVariant.primary,
        ),
        FlutstrapRadio<String>(
          value: 'option2',
          groupValue: _selectedOption,
          onChanged: (value) => setState(() => _selectedOption = value),
          label: 'Success Radio Option 2',
          variant: FSRadioVariant.success,
        ),
        FlutstrapRadio<String>(
          value: 'option3',
          groupValue: _selectedOption,
          onChanged: (value) => setState(() => _selectedOption = value),
          label: 'Danger Radio Option 3',
          variant: FSRadioVariant.danger,
        ),
        FlutstrapRadio<String>(
          value: 'option4',
          groupValue: _selectedOption,
          onChanged: null,
          label: 'Disabled Radio Option',
          disabled: true,
        ),
      ],
      layout: FSFormGroupLayout.vertical,
      spacing: 12,
    );
  }

  Widget _buildTextareaSection(BuildContext context) {
    return FlutstrapFormGroup(
      children: [
        FlutstrapTextArea(
          controller: _textareaController,
          label: 'Basic Textarea',
          placeholder: 'Enter your message here...',
          rows: 4,
          helperText: 'Maximum 500 characters',
          maxLength: 500,
          showCharacterCounter: true,
        ),
        const SizedBox(height: 16),
        FlutstrapTextArea(
          label: 'Auto-resize Textarea',
          placeholder: 'This textarea will grow as you type...',
          autoResize: true,
          rows: 2,
          variant: FSTextAreaVariant.info,
        ),
        const SizedBox(height: 16),
        FlutstrapTextArea(
          label: 'Disabled Textarea',
          placeholder: 'This textarea is disabled',
          disabled: true,
          rows: 3,
        ),
      ],
      layout: FSFormGroupLayout.vertical,
    );
  }

  Widget _buildFormGroupsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionSubtitle(context, 'Vertical Layout'),
        FlutstrapFormGroup(
          children: [
            FlutstrapInput(
              labelText: 'First Name',
              hintText: 'Enter first name',
            ),
            FlutstrapInput(
              labelText: 'Last Name',
              hintText: 'Enter last name',
            ),
          ],
          layout: FSFormGroupLayout.vertical,
          spacing: 12,
        ),

        const SizedBox(height: 24),
        _buildSectionSubtitle(context, 'Horizontal Layout'),
        // Alternative: Use SingleChildScrollView for horizontal scrolling
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: FlutstrapFormGroup(
            children: [
              SizedBox(
                width: 200, // Fixed width for horizontal inputs
                child: FlutstrapInput(
                  labelText: 'City',
                  hintText: 'Enter city',
                ),
              ),
              SizedBox(
                width: 200,
                child: FlutstrapInput(
                  labelText: 'State',
                  hintText: 'Enter state',
                ),
              ),
              SizedBox(
                width: 120,
                child: FlutstrapInput(
                  labelText: 'ZIP',
                  hintText: 'ZIP code',
                  maxLength: 5,
                ),
              ),
            ],
            layout: FSFormGroupLayout.horizontal,
            spacing: 12,
          ),
        ),

        const SizedBox(height: 24),
        _buildSectionSubtitle(context, 'Inline Layout'),
        FlutstrapFormGroup(
          children: [
            FlutstrapCheckbox(
              value: false,
              onChanged: (value) {},
              label: 'Option A',
              inline: true,
            ),
            FlutstrapCheckbox(
              value: false,
              onChanged: (value) {},
              label: 'Option B',
              inline: true,
            ),
            FlutstrapCheckbox(
              value: false,
              onChanged: (value) {},
              label: 'Option C',
              inline: true,
            ),
          ],
          layout: FSFormGroupLayout.inline,
          spacing: 16,
        ),
      ],
    );
  }

  Widget _buildCompleteFormSection(BuildContext context) {
    return FlutstrapCard(
      headerText: 'Registration Form',
      body: FlutstrapFormGroup(
        children: [
          FlutstrapInput(
            labelText: 'Full Name',
            hintText: 'Enter your full name', // Changed from placeholder
            // Removed required parameter
            helperText: 'As it appears on your ID',
          ),
          FlutstrapInput(
            labelText: 'Email Address',
            hintText: 'Enter your email', // Changed from placeholder
            keyboardType: TextInputType.emailAddress,
            // Removed required parameter
            variant: FSInputVariant.info,
          ),
          FlutstrapTextArea(
            label: 'Bio',
            placeholder: 'Tell us about yourself...',
            rows: 3,
            maxLength: 200,
            showCharacterCounter: true,
          ),
          _buildSectionSubtitle(context, 'Preferences'),
          FlutstrapFormGroup(
            children: [
              FlutstrapCheckbox(
                value: false,
                onChanged: (value) {},
                label: 'Receive newsletter',
                variant: FSCheckboxVariant.primary,
              ),
              FlutstrapCheckbox(
                value: false,
                onChanged: (value) {},
                label: 'Accept terms and conditions',
                variant: FSCheckboxVariant.success,
                // Removed required parameter
              ),
            ],
            layout: FSFormGroupLayout.vertical,
            spacing: 8,
          ),
          const SizedBox(height: 16),
          FlutstrapButton(
            onPressed: () {
              // Handle form submission
              _showSuccessDialog(context);
            },
            text: 'Submit Form',
            variant: FSButtonVariant.success,
            expanded: true,
          ),
        ],
        layout: FSFormGroupLayout.vertical,
        spacing: 16,
      ),
    );
  }

  Widget _buildSectionSubtitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.primary,
          ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Form Submitted'),
        content: const Text('Your form has been submitted successfully!'),
        actions: [
          FlutstrapButton(
            onPressed: () => Navigator.pop(context),
            text: 'OK',
            variant: FSButtonVariant.primary,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _emailController.dispose();
    _textareaController.dispose();
    super.dispose();
  }
}
