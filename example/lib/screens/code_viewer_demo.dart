// lib/screens/code_viewer_demo.dart
import 'package:flutter/material.dart';
import 'package:master_flutstrap/components/code_viewer.dart';
//C:\Users\Mark\Desktop\Masters Thesis\master_flutstrap\lib\components\code_viewer.dart

class CodeViewerDemoScreen extends StatelessWidget {
  const CodeViewerDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Code Viewer Demo'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Flutstrap Code Viewer',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Click on the code examples below to expand and see the implementation:',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 24),

            // Demo 1: Simple Button
            Text(
              '1. Simple Button Example',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            FSCodeViewer(
              title: 'Primary Button Implementation',
              code: '''
FlutstrapButton(
  onPressed: () {
    print('Button clicked!');
  },
  child: Text('Click Me'),
  variant: FSTableVariant.primary,
  size: FSTableSize.md,
)''',
            ),

            SizedBox(height: 24),

            // Demo 2: Grid Layout
            Text(
              '2. Grid Layout Example',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            FSCodeViewer(
              title: 'Responsive Grid',
              code: '''
FlutstrapGrid.singleRow(
  columns: [
    FlutstrapCol(
      child: Container(
        padding: EdgeInsets.all(16),
        color: Colors.blue[100],
        child: Text('Column 1'),
      ),
      size: FSColSize(xs: 12, sm: 6, md: 4),
    ),
    FlutstrapCol(
      child: Container(
        padding: EdgeInsets.all(16),
        color: Colors.green[100],
        child: Text('Column 2'),
      ),
      size: FSColSize(xs: 12, sm: 6, md: 4),
    ),
    FlutstrapCol(
      child: Container(
        padding: EdgeInsets.all(16),
        color: Colors.orange[100],
        child: Text('Column 3'),
      ),
      size: FSColSize(xs: 12, sm: 12, md: 4),
    ),
  ],
)''',
            ),

            SizedBox(height: 24),

            // Demo 3: Form with Validation
            Text(
              '3. Form Validation Example',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            FSCodeViewer(
              title: 'Email Validation',
              code: '''
class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          FlutstrapInput(
            controller: _emailController,
            label: 'Email Address',
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter your email';
              }
              if (!FSValidators.isEmail(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          FlutstrapButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Form is valid
                _loginUser();
              }
            },
            child: Text('Login'),
          ),
        ],
      ),
    );
  }
  
  void _loginUser() {
    // Login logic here
  }
}''',
            ),
          ],
        ),
      ),
    );
  }
}
