import 'package:flutter/material.dart';
import 'package:master_flutstrap/flutstrap.dart';
import 'screens/home_screen.dart';

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FSTheme(
      data: FSThemeData.light(),
      child: MaterialApp(
        title: 'Flutstrap Examples',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme:
              ColorScheme.fromSeed(seedColor: FlutstrapTheme.defaultPrimary),
        ),
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
