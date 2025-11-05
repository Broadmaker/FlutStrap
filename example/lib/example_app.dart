/// Flutstrap Example Application
///
/// Main entry point for the Flutstrap component library demo.
///
/// Features:
/// - 🎨 Theming with Flutstrap's FSTheme system
/// - 📱 Material 3 design system
/// - 🚀 Production-ready configuration with named routes
/// - ♿ Accessibility enhancements
/// - 🔧 Comprehensive error handling
///
/// Usage:
/// ```dart
/// void main() {
///   runApp(const ExampleApp());
/// }
/// ```
///
/// {@category Demo}
/// {@category Application}
import 'package:flutter/material.dart';
import 'package:flutstrap/flutstrap.dart';
import 'screens/home_screen.dart';
import 'screens/animation_screen.dart';
import 'screens/buttons_screen.dart';
import 'screens/cards_screen.dart';
import 'screens/code_viewer_demo.dart';
import 'screens/dropdowns_screen.dart';
import 'screens/forms_screen.dart';
import 'screens/layout_screen.dart';
import 'screens/alerts_screen.dart';
import 'screens/modals_screen.dart';
import 'screens/navbars_screen.dart';
import 'screens/progress_screen.dart';
import 'screens/spinners_screen.dart';
import 'screens/tables_screen.dart';
import 'screens/tooltips_screen.dart';
import 'screens/theme_screen.dart';
import 'screens/typography_screen.dart';
import 'screens/utilities_screen.dart';

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  /// Application routes configuration
  static final Map<String, WidgetBuilder> routes = {
    HomeScreen.routeName: (context) => const HomeScreen(),
    ThemeScreen.routeName: (context) => const ThemeScreen(),
    UtilitiesScreen.routeName: (context) => const UtilitiesScreen(),
    TypographyScreen.routeName: (context) => const TypographyScreen(),
    //CodeViewerDemoScreen.routeName: (context) => const CodeViewerDemoScreen(),
    AnimationsScreen.routeName: (context) => const AnimationsScreen(),
    ButtonsScreen.routeName: (context) => const ButtonsScreen(),
    CardsScreen.routeName: (context) => const CardsScreen(),
    FormsScreen.routeName: (context) => const FormsScreen(),
    LayoutScreen.routeName: (context) => const LayoutScreen(),
    AlertsScreen.routeName: (context) => const AlertsScreen(),
    ModalsScreen.routeName: (context) => const ModalsScreen(),
    DropdownsScreen.routeName: (context) => const DropdownsScreen(),
    NavbarsScreen.routeName: (context) => const NavbarsScreen(),
    ProgressScreen.routeName: (context) => const ProgressScreen(),
    SpinnersScreen.routeName: (context) => const SpinnersScreen(),
    TooltipsScreen.routeName: (context) => const TooltipsScreen(),
    TablesScreen.routeName: (context) => const TablesScreen(),
  };

  @override
  Widget build(BuildContext context) {
    return FSTheme(
      data: FSThemeData.light(),
      child: MaterialApp(
        title: 'Flutstrap Examples',

        // ✅ NAMED ROUTES CONFIGURATION
        routes: routes,
        initialRoute: HomeScreen.routeName,

        // ✅ THEME CONFIGURATION
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: FlutstrapTheme.defaultPrimary,
          ),
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: FlutstrapTheme.defaultPrimary,
            brightness: Brightness.dark,
          ),
        ),

        // ✅ ERROR HANDLING & ACCESSIBILITY
        onUnknownRoute: (settings) => _buildErrorRoute(settings),
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaleFactor:
                  MediaQuery.of(context).textScaleFactor.clamp(0.8, 1.4),
            ),
            child: child!,
          );
        },

        debugShowCheckedModeBanner: false,
      ),
    );
  }

  /// Build error route for unknown routes
  static MaterialPageRoute _buildErrorRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text('Route Not Found'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline_rounded,
                  size: 64,
                  color: Theme.of(context).colorScheme.error,
                ),
                const SizedBox(height: 24),
                Text(
                  'Route Not Found',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                ),
                const SizedBox(height: 12),
                Text(
                  'The route "${settings.name}" was not found.',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: () => Navigator.pushReplacementNamed(
                      context, HomeScreen.routeName),
                  child: const Text('Return to Home'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
