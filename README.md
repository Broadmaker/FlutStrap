---
# 🌟 FlutStrap

[![pub version](https://img.shields.io/pub/v/flutstrap.svg)](https://pub.dev/packages/flutstrap)
[![likes](https://img.shields.io/pub/likes/flutstrap)](https://pub.dev/packages/flutstrap)
[![popularity](https://img.shields.io/pub/popularity/flutstrap)](https://pub.dev/packages/flutstrap)

FlutStrap is a **Flutter UI library inspired by Bootstrap**. It provides ready‑to‑use components, responsive layouts, and theming utilities to help you build Flutter apps faster and more consistently.
---

## ❓ Why FlutStrap?

FlutStrap brings the familiar design philosophy of Bootstrap into Flutter:

- ⚡ Pre‑built UI components
- 📱 Responsive grid and layout utilities
- 🎨 Built‑in light/dark theming
- 📏 Consistent spacing system
- 🧩 Developer‑friendly APIs

---

## 📦 Installation

Add FlutStrap to your `pubspec.yaml`:

```yaml
dependencies:
  flutstrap: ^0.0.2
```

Then run:

```bash
flutter pub get
```

Finally, import FlutStrap into your Dart code:

```dart
import 'package:flutstrap/flutstrap.dart';
```

---

## 🚀 Quick Example

Ensure your app is wrapped with the FlutStrap theme:

```dart
import 'package:flutter/material.dart';
import 'package:flutstrap/flutstrap.dart';

void main() {
  runApp(
    MaterialApp(
      home: FSTheme(
        data: FSThemeData.light(), // or FSThemeData.dark()
        child: MyApp(),
      ),
    ),
  );
}
```

Using a FlutStrap button:

```dart
import 'package:flutter/material.dart';
import 'package:flutstrap/flutstrap.dart';

class ExamplePage extends StatelessWidget {
  const ExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlutstrapButton(
          label: "Click Me",
          onPressed: () {
            print("FlutStrap Button Pressed");
          },
          variant: FSButtonVariant.success,
        ),
      ),
    );
  }
}
```

---

## 🧩 Components

FlutStrap includes a wide range of UI elements:

- Alerts, Badges, Buttons, Cards
- Dropdowns, Forms, Modals, Navbars
- Paginations, Progress bars, Spinners
- Tables, Tooltips

---

## 📐 Layouts

Responsive layout utilities:

- Rows & Columns
- Containers & Grids
- Visibility controls

---

## ⚙️ Core Features

- Responsive breakpoints for mobile, tablet, desktop
- Spacing utilities for consistent padding/margins
- Theming support for colors, typography, and styles
- Animation utilities (fade, scale, sequence, transitions)

---

## 📖 Documentation

- Hosted docs: [flutstrap.netlify.app](https://flutstrap.netlify.app)
- Full source & docs: [GitHub Repository](https://github.com/Broadmaker/FlutStrap)
- Example app included in `example/`

---

## 🤝 Contributing

Contributions are welcome!  
Open issues or submit pull requests on [GitHub](https://github.com/Broadmaker/FlutStrap).

---

## 📄 License

Licensed under the **MIT License**.  
You are free to use, modify, and distribute this library.

---
