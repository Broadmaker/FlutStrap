import 'package:flutter/material.dart';
//import 'package:master_flutstrap/flutstrap.dart';
import 'animation_screen.dart';
import 'buttons_screen.dart';
import 'cards_screen.dart';
import 'code_viewer_demo.dart';
import 'dropdowns_screen.dart';
import 'forms_screen.dart';
import 'layout_screen.dart';
import 'alerts_screen.dart';
import 'modals_screen.dart';
import 'navbars_screen.dart';
import 'progress_screen.dart';
import 'spinners_screen.dart';
import 'tables_screen.dart';
import 'tooltips_screen.dart';
import 'theme_screen.dart';
import 'typography_screen.dart';
import 'utilities_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutstrap Examples'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Flutstrap Components',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildComponentCard(
                    context,
                    'Theme System',
                    'Typography, colors, and design tokens',
                    Icons.palette,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ThemeScreen()),
                      );
                    },
                  ),
                  _buildComponentCard(
                    context,
                    'Utilities & Responsive',
                    'Spacing, breakpoints, validation, and utilities',
                    Icons.build,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UtilitiesScreen()),
                      );
                    },
                  ),
                  _buildComponentCard(
                    context,
                    'Typography & Icons',
                    'Text styles and icon usage patterns',
                    Icons.text_fields,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TypographyScreen()),
                      );
                    },
                  ),
                  // Add this to your home_screen.dart ListView temporarily:
                  _buildComponentCard(
                    context,
                    'Code Viewer Demo',
                    'Test the code viewer component',
                    Icons.code,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CodeViewerDemoScreen()),
                      );
                    },
                  ),
                  // Add this card in the ListView with the other _buildComponentCard items:
                  _buildComponentCard(
                    context,
                    'Animations',
                    'Fade-in, slide transitions, and animation effects',
                    Icons.animation,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AnimationsScreen()),
                      );
                    },
                  ),
                  _buildComponentCard(
                    context,
                    'Buttons',
                    'All button variants, sizes, and states',
                    Icons.touch_app,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ButtonsScreen()),
                      );
                    },
                  ),
                  _buildComponentCard(
                    context,
                    'Cards',
                    'Card components with headers and content',
                    Icons.dashboard,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CardsScreen()),
                      );
                    },
                  ),
                  _buildComponentCard(
                    context,
                    'Forms',
                    'Input fields, checkboxes, and radios',
                    Icons.text_fields,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FormsScreen()),
                      );
                    },
                  ),
                  _buildComponentCard(
                    context,
                    'Layout',
                    'Grid system and responsive layouts',
                    Icons.grid_view,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LayoutScreen()),
                      );
                    },
                  ),
                  _buildComponentCard(
                    context,
                    'Alerts & Badges',
                    'Contextual feedback and indicators',
                    Icons.notifications,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AlertsScreen()),
                      );
                    },
                  ),
                  _buildComponentCard(
                    context,
                    'Modals',
                    'Dialog windows and modal services',
                    Icons.layers,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ModalsScreen()),
                      );
                    },
                  ),
                  _buildComponentCard(
                    context,
                    'Dropdowns',
                    'Selection menus and dropdown variants',
                    Icons.arrow_drop_down_circle,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DropdownsScreen()),
                      );
                    },
                  ),
                  _buildComponentCard(
                    context,
                    'Navbars',
                    'Navigation bars and responsive menus',
                    Icons.menu,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NavbarsScreen()),
                      );
                    },
                  ),
                  _buildComponentCard(
                    context,
                    'Progress Bars',
                    'Loading indicators and progress tracking',
                    Icons.timeline,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProgressScreen()),
                      );
                    },
                  ),
                  _buildComponentCard(
                    context,
                    'Spinners',
                    'Loading indicators and animated spinners',
                    Icons.autorenew,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SpinnersScreen()),
                      );
                    },
                  ),
                  _buildComponentCard(
                    context,
                    'Tooltips',
                    'Contextual hints and information popovers',
                    Icons.tips_and_updates,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TooltipsScreen()),
                      );
                    },
                  ),
                  _buildComponentCard(
                    context,
                    'Tables',
                    'Data tables with sorting and responsive layouts',
                    Icons.table_chart,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TablesScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComponentCard(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
        title: Text(title),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}
