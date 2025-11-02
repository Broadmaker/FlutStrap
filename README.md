
````markdown
# 🌟 FlutStrap

FlutStrap is a **Flutter UI library inspired by Bootstrap**.  
It provides **ready-to-use UI components**, responsive layout utilities, and light/dark theming to make building Flutter apps easier and faster.

---

## 📦 Installation

You can add FlutStrap directly from GitHub.  

1. Open your `pubspec.yaml` file.  
2. Add this under `dependencies`:

```yaml
dependencies:
  flutstrap:
    git:
      url: https://github.com/Broadmaker/FlutStrap.git
````

3. Run:

```bash
flutter pub get
```

---

## 🧩 Import in your Dart code

```dart
import 'package:flutstrap/flutstrap.dart';
```

---

## 🚀 Quick Examples

### Buttons

```dart
FlutstrapButton(
  label: 'Click Me',
  onPressed: () => print('Button clicked!'),
)
```

### Alerts

```dart
FlutstrapAlert(
  message: 'This is a success alert!',
  type: FlutstrapAlertType.success,
)
```

### Layout

```dart
FlutstrapContainer(
  child: FlutstrapRow(
    children: [
      FlutstrapCol(child: Text('Column 1')),
      FlutstrapCol(child: Text('Column 2')),
    ],
  ),
)
```

### Forms

```dart
FlutstrapFormGroup(
  label: 'Email',
  child: FlutstrapInput(hintText: 'Enter your email'),
)
```

### Modals

```dart
FlutstrapModal(
  title: 'Example Modal',
  content: Text('This is a modal body.'),
  onConfirm: () => print('Confirmed!'),
)
```

---

## 🧱 Components Overview

| Category  | Widgets                                                                      |
| --------- | ---------------------------------------------------------------------------- |
| Layout    | `FlutstrapRow`, `FlutstrapCol`, `FlutstrapContainer`                         |
| Buttons   | `FlutstrapButton`                                                            |
| Alerts    | `FlutstrapAlert`                                                             |
| Forms     | `FlutstrapInput`, `FlutstrapCheckbox`, `FlutstrapRadio`, `FlutstrapTextarea` |
| Modals    | `FlutstrapModal`                                                             |
| Tables    | `FlutstrapTable`                                                             |
| Dropdowns | `FlutstrapDropdown`                                                          |
| Spinners  | `FlutstrapSpinner`                                                           |
| Tooltips  | `FlutstrapTooltip`                                                           |
| Progress  | `FlutstrapProgress`                                                          |

---

## 📌 Example App

You can test all components by cloning the repo:

```bash
git clone https://github.com/Broadmaker/FlutStrap.git
cd FlutStrap
flutter run
```

---




