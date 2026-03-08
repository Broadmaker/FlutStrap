# 🌟 FlutStrap

[![pub version](https://img.shields.io/pub/v/flutstrap.svg)](https://pub.dev/packages/flutstrap)
[![likes](https://img.shields.io/pub/likes/flutstrap)](https://pub.dev/packages/flutstrap)
[![popularity](https://img.shields.io/pub/popularity/flutstrap)](https://pub.dev/packages/flutstrap)

FlutStrap is a **Flutter UI library inspired by Bootstrap**. It provides **ready-to-use UI components**, **responsive layouts**, and **light/dark theming** to help you build Flutter apps quickly and efficiently.

Whether you're building a small project or a complex application, FlutStrap provides essential UI components and layout utilities to accelerate Flutter development.

---

# ❓ Why FlutStrap?

FlutStrap brings the familiar design philosophy of Bootstrap to Flutter.

Key advantages include:

- ⚡ Pre-built UI components
- 📱 Responsive layout utilities
- 🎨 Built-in theming support
- 📏 Consistent spacing system
- 🧩 Developer-friendly APIs

---

# 📦 Installation

Add FlutStrap to your `pubspec.yaml`:

```yaml
dependencies:
  flutstrap: ^0.0.1
```

Then run:

```bash
flutter pub get
```

### Alternative Installation (GitHub)

You can also install directly from GitHub:

```yaml
dependencies:
  flutstrap:
    git:
      url: https://github.com/Broadmaker/FlutStrap.git
      ref: main
```

Then run:

```bash
flutter pub get
```

---

# 🚀 Quick Example

Below is a simple example using FlutStrap components.

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

# 🧩 Components

FlutStrap includes a variety of UI components that make it easy to build beautiful Flutter applications.

- **[Alerts](docs/components/alerts.md)** – Show important messages or notifications to the user.
- **[Badges](docs/components/badges.md)** – Display labels or counts for items.
- **[Buttons](docs/components/buttons.md)** – Different button styles including primary, secondary, and disabled states.
- **[Cards](docs/components/cards.md)** – Container widgets used to display grouped content.
- **[Dropdowns](docs/components/dropdowns.md)** – Interactive dropdown menus.
- **[Forms](docs/components/forms/)** – Form elements including checkboxes, radio buttons, and text inputs.
- **[Modals](docs/components/modals.md)** – Popup dialogs to display additional content.
- **[Navbars](docs/components/navbars.md)** – Responsive navigation bars.
- **[Paginations](docs/components/paginations.md)** – Pagination controls for multi-page content.
- **[Progress](docs/components/progress.md)** – Progress bars for loading states.
- **[Spinners](docs/components/spinners.md)** – Animated loading indicators.
- **[Tables](docs/components/tables.md)** – Structured and responsive tables.
- **[Tooltips](docs/components/tooltips.md)** – Informational hints for UI elements.

---

# 📐 Layouts

FlutStrap provides layout utilities to help structure Flutter apps efficiently and responsively.

### 🧩 Key Layout Utilities

- **[Columns](docs/layouts/columns.md)**  
  Divide your layout into columns for flexible responsive designs.

- **[Containers](docs/layouts/containers.md)**  
  Wrap content to control width, padding, alignment, and styling.

- **[Grids](docs/layouts/grids.md)**  
  Build responsive grid systems that adapt across screen sizes.

- **[Rows](docs/layouts/rows.md)**  
  Organize content horizontally and combine with columns for grid layouts.

- **[Visibility](docs/layouts/visibility.md)**  
  Control when widgets appear depending on device size or conditions.

---

# ⚙️ Core Features

FlutStrap provides core utilities that power layouts, spacing, and responsiveness.

### 🧩 Core Utilities

- **[Responsive Layouts](docs/core/responsives.md)**  
  Automatically adjust UI layouts based on screen size.

- **[Spacings](docs/core/spacings.md)**  
  Maintain consistent padding and margins across your application.

- **[Breakpoints](docs/core/breakpoints.md)**  
  Define responsive breakpoints for mobile, tablet, and desktop layouts.

- **[Themes](docs/core/themes.md)**  
  Manage global color schemes, typography, and component styles.

- **[Utilities](docs/core/utilities.md)**  
  Helper widgets and functions for alignment, positioning, and layout control.

---

# 📸 Preview

Screenshots of FlutStrap components will be added soon.

Example preview layout:

| Buttons                             | Alerts                            |
| ----------------------------------- | --------------------------------- |
| ![Buttons](screenshots/buttons.png) | ![Alerts](screenshots/alerts.png) |

---

# ⚡ Contribution

We welcome contributions!

If you have suggestions, improvements, or bug fixes:

1. Fork the repository
2. Create a new branch
3. Make your changes
4. Submit a pull request

Your contributions help improve FlutStrap for everyone.

---

# 💬 Support

If you have questions or encounter issues, feel free to open an issue on the GitHub repository.

---

# 📄 License

FlutStrap is licensed under the **MIT License**.  
You are free to use, modify, and distribute this library in your own projects.
