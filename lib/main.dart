import 'package:flutter/material.dart';
import 'package:blabla/ui/screens/ride_pref/ride_prefs_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BlaBlaCar',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const RidePrefsScreen(),
    );
  }
}
