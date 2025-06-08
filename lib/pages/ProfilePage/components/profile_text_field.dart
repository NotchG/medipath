import 'package:flutter/material.dart';

class ProfileTextField extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool obscureText;
  final String? initialValue;
  final Function(String) onChanged;

  const ProfileTextField({
    Key? key,
    required this.label,
    this.icon,
    this.obscureText = false,
    this.initialValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: initialValue);

    return TextField(
      controller: controller,
      onChanged: (value) => onChanged(value),
      obscureText: obscureText,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: label,
        prefixIcon: icon != null ? Icon(icon) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}