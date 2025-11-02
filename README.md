

````markdown
# 🌟 FlutStrap

FlutStrap is a **Flutter UI library inspired by Bootstrap**.  
It provides **ready-to-use UI components**, responsive layouts, and light/dark theming for faster app development.

---

## 📦 Installation

Add FlutStrap directly from GitHub:

```yaml
dependencies:
  flutstrap:
    git:
      url: https://github.com/Broadmaker/FlutStrap.git
      ref: main
````

Then run:

```bash
flutter pub get
```

---

## 🧩 Import

```dart
import 'package:flutstrap/flutstrap.dart';
```

---

## 🚀 Usage Examples

### Buttons

```dart
FlutstrapButton(
  onPressed: () {},
  text: 'Primary Button',
  variant: FSButtonVariant.primary,
)

FlutstrapButton(
  onPressed: _submitForm,
  text: 'Submit',
  variant: FSButtonVariant.success,
  leading: Icon(Icons.check),
  loading: _isSubmitting,
  expanded: true,
)

FlutstrapButton(
  onPressed: () {},
  text: 'Button',
).copyWith(variant: FSButtonVariant.danger)

FlutstrapButton(
  onPressed: null,
  text: 'Disabled',
  variant: FSButtonVariant.outlinePrimary,
)

const FlutstrapButton.primary(
  onPressed: _handlePress,
  text: 'Primary Button',
)
```

---

### Alerts

```dart
FlutstrapAlert.success(
  message: 'Operation completed successfully!',
  autoDismissDuration: Duration(seconds: 5),
)

FlutstrapAlert.error(
  title: 'Upload Failed',
  message: 'Please check your connection and try again.',
  dismissible: true,
)
```

---

### Badges

```dart
FlutstrapBadge(
  text: 'New',
  variant: FSBadgeVariant.primary,
)

FlutstrapBadge.count(
  count: 150,
  maxCount: 99,
  variant: FSBadgeVariant.danger,
)

FlutstrapBadge.dot(
  variant: FSBadgeVariant.success,
)

FlutstrapBadgePositioned(
  child: Icon(Icons.notifications),
  badge: FlutstrapBadge.count(count: 5),
  alignment: Alignment.topRight,
)
```

---

### Cards

```dart
FlutstrapCard(
  headerText: 'Card Title',
  bodyText: 'Card content goes here...',
  footerText: 'Footer text',
)

FlutstrapCard.interactive(
  title: 'Clickable Card',
  content: 'Tap me for action',
  onTap: () => print('Card tapped'),
  trailing: Icon(Icons.chevron_right),
)

FlutstrapCard.image(
  image: Image.network('https://example.com/image.jpg'),
  title: 'Beautiful Image',
  content: 'This card features an image header',
  actions: [
    FlutstrapButton(
      onPressed: () {},
      child: Text('Action'),
    ),
  ],
)
```

---

### Dropdowns

```dart
FlutstrapDropdown<String>(
  items: [
    FSDropdownItem(value: '1', label: 'Option 1'),
    FSDropdownItem(value: '2', label: 'Option 2'),
  ],
  value: selectedValue,
  onChanged: (value) => setState(() => selectedValue = value),
)

FlutstrapDropdown<User>(
  items: users.map((user) => FSDropdownItem(
    value: user,
    label: user.name,
    leading: CircleAvatar(backgroundImage: NetworkImage(user.avatar)),
  )).toList(),
  value: selectedUser,
  onChanged: (user) => setState(() => selectedUser = user),
  showSearch: true,
)

FlutstrapDropdown<String>(
  items: items,
  value: selectedValue,
  onChanged: null,
  helperText: 'This field is currently disabled',
  variant: FSDropdownVariant.light,
)
```

---

### Checkboxes

```dart
FlutstrapCheckbox(
  value: _isChecked,
  onChanged: (value) => setState(() => _isChecked = value!),
  label: 'Accept terms and conditions',
)

FlutstrapCheckbox(
  value: _isSuccess,
  onChanged: (value) => setState(() => _isSuccess = value!),
  variant: FSCheckboxVariant.success,
  label: 'Completed',
)

FlutstrapCheckbox(
  value: true,
  onChanged: null,
  label: 'Disabled checkbox',
  disabled: true,
)

FlutstrapCheckbox(
  value: _triStateValue,
  onChanged: (value) => setState(() => _triStateValue = value),
  tristate: true,
  label: 'Tri-state option',
)

FlutstrapCheckbox(
  value: _isChecked,
  onChanged: (value) => setState(() => _isChecked = value!),
).success().withLabel('Success state')
```

---

### Form Groups & Inputs

```dart
FlutstrapFormGroup(
  label: 'Personal Information',
  children: [
    FlutstrapInput(labelText: 'First Name'),
    FlutstrapInput(labelText: 'Last Name'),
    FlutstrapInput(labelText: 'Email'),
  ],
)

FlutstrapFormGroup(
  label: 'Contact Details',
  layout: FSFormGroupLayout.horizontal,
  showValidation: true,
  isValid: false,
  validationMessage: 'Please fill all required fields',
  children: [
    FlutstrapInput(labelText: 'Phone'),
    FlutstrapInput(labelText: 'Email'),
  ],
)

FlutstrapFormGroup(
  label: 'Filters',
  layout: FSFormGroupLayout.inline,
  spacing: 12.0,
  children: [
    FlutstrapInput(labelText: 'Search'),
    FlutstrapDropdown(items: [...]),
    FlutstrapButton(child: Text('Apply')),
  ],
)
```

---

### Inputs

```dart
FlutstrapInput(
  labelText: 'Email',
  hintText: 'Enter your email',
  validator: (value) {
    if (value?.isEmpty ?? true) return 'Email is required';
    if (!value!.contains('@')) return 'Enter a valid email';
    return null;
  },
)

FlutstrapInput(
  labelText: 'Password',
  obscureText: true,
  prefixIcon: Icon(Icons.lock),
  suffixIcon: Icon(Icons.visibility),
  variant: FSInputVariant.success,
)

final inputKey = GlobalKey<FlutstrapInputState>();
FlutstrapInput(
  key: inputKey,
  labelText: 'Controlled input',
)

// Later
inputKey.currentState?.clear();
inputKey.currentState?.focus();
```

---

### Radios

```dart
Column(
  children: [
    FlutstrapRadio<String>(
      value: 'option1',
      groupValue: _selectedOption,
      onChanged: (value) => setState(() => _selectedOption = value),
      label: 'Option 1',
    ),
    FlutstrapRadio<String>(
      value: 'option2',
      groupValue: _selectedOption,
      onChanged: (value) => setState(() => _selectedOption = value),
      label: 'Option 2',
    ),
  ],
)

FlutstrapRadio<String>(
  value: 'success',
  groupValue: _status,
  onChanged: (value) => setState(() => _status = value),
  variant: FSRadioVariant.success,
  label: 'Success Status',
)

FlutstrapRadio<String>(
  value: 'custom',
  groupValue: _selected,
  onChanged: (value) => setState(() => _selected = value),
).success().withLabel('Custom styled')
```

---

### Textareas

```dart
FlutstrapTextArea(
  label: 'Description',
  placeholder: 'Enter your description...',
  rows: 4,
)

FlutstrapTextArea(
  label: 'Bio',
  maxLength: 500,
  showCharacterCounter: true,
  rows: 3,
)

FlutstrapTextArea(
  label: 'Notes',
  autoResize: true,
  placeholder: 'Start typing...',
)

final textareaKey = GlobalKey<FlutstrapTextAreaState>();
FlutstrapTextArea(
  key: textareaKey,
  label: 'Controlled textarea',
)

// Later
textareaKey.currentState?.clear();
textareaKey.currentState?.focus();
```

---

### Progress

```dart
FlutstrapProgress(
  value: 75,
  progressColor: Colors.purple,
  backgroundColor: Colors.purple.withOpacity(0.2),
  height: 12,
)

FlutstrapProgress(
  value: currentProgress,
  animated: true,
  animationDuration: Duration(seconds: 2),
  animationCurve: Curves.bounceOut,
)

FlutstrapProgress(
  value: 50,
  fixedWidth: 200,
  expandToFill: false,
)

FlutstrapProgressGroup(
  children: [
    FlutstrapProgress(value: 25, variant: FSProgressVariant.primary),
    FlutstrapProgress(value: 50, variant: FSProgressVariant.success),
    FlutstrapProgress(value: 75, variant: FSProgressVariant.warning),
  ],
  spacing: 12,
)
```

---

### Spinners

```dart
FlutstrapSpinner(
  variant: FSSpinnerVariant.primary,
  type: FSSpinnerType.border,
  animationDuration: Duration(milliseconds: 800),
  strokeWidth: 3.0,
)

FlutstrapSpinner(
  variant: FSSpinnerVariant.success,
  type: FSSpinnerType.growing,
  label: 'Processing payment...',
  centered: true,
)

FlutstrapSpinner(
type: FSSpinnerType.dots,
color: Colors.purple,
size: FSSpinnerSize.lg,
)

FlutstrapSpinnerButton(
isLoading: isSubmitting,
onPressed: submitForm,
child: Text('Save Changes'),
spinner: FlutstrapSpinner(
variant: FSSpinnerVariant.light,
size: FSSpinnerSize.sm,
),
loadingLabel: 'Saving...',
onAnimationError: (error) {
print('Spinner animation error: $error');
},
)

```

---

## ⚡ Contribution

Contributions are welcome! Feel free to open an issue or submit a pull request.

---

## 📄 License

MIT License
```


