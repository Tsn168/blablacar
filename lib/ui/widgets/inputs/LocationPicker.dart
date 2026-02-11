import 'package:flutter/material.dart';

class Locationpicker extends StatefulWidget {
  final bool selectedLocation;
  const Locationpicker({super.key, required this.selectedLocation});

  @override
  State<Locationpicker> createState() => _LocationpickerState();
}

class _LocationpickerState extends State<Locationpicker> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
