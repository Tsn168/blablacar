import 'package:flutter/material.dart';
import 'ui/screens/ride_pref/ride_prefs_screen.dart';
import 'ui/theme/theme.dart';
import 'ui/widgets/blaButton.dart';

void main() {
  runApp(const BlaBlaApp());
}

class BlaBlaApp extends StatelessWidget {
  const BlaBlaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: blaTheme,
      home: Scaffold(
        body: Column(
          children: [
            const Expanded(child: RidePrefsScreen()),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BlaButton(
                    text: 'Request to book',
                    isPrimary: true,
                    icon: Icons.calendar_month,
                    onPressed: () => print('Search button pressed!'),
                  ),
                  const SizedBox(height: 8),
                  BlaButton(
                    text: 'Contact Voloduia',
                    isPrimary: false,
                    icon: Icons.message,
                    onPressed: () => print('contact'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
