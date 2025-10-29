/// Flutstrap - Bootstrap-inspired Component Library for Flutter
///
/// A comprehensive set of Flutter widgets that follow Bootstrap design principles
/// and provide a consistent, responsive UI framework.
///
/// ## Usage
///
/// ```dart
/// import 'package:flutstrap/flutstrap.dart';
///
/// class MyApp extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     return FSTheme(
///       data: FSThemeData.light(),
///       child: MaterialApp(
///         home: Scaffold(
///           body: FlutstrapButton(
///             onPressed: () {},
///             text: 'Hello Flutstrap',
///             variant: FSButtonVariant.primary,
///           ),
///         ),
///       ),
///     );
///   }
/// }
/// ```

library flutstrap;

// Core foundation
export 'core/index.dart';

// Theme system
export 'themes/index.dart';

// Layout components
export 'layout/index.dart';

// Animations
export 'animations/index.dart';

// UI Components
export 'components/index.dart';

// Extensions
// export 'extensions/index.dart';
