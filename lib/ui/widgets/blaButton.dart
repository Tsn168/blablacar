import 'package:flutter/material.dart';

class BlaButton extends StatelessWidget {
  final String text; // Button label
  final VoidCallback onPressed; // Callback when clicked
  final bool isPrimary; // Primary or secondary color
  final IconData? icon; // Optional icon

  const BlaButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isPrimary = true,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: icon != null ? Icon(icon) : const SizedBox.shrink(),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? Colors.blue : Colors.grey,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      onPressed: onPressed,
    );
  }
}
