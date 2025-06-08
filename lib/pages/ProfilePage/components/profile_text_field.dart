import 'package:flutter/material.dart';

class ProfileTextField extends StatefulWidget {
  final String label;
  final IconData? icon;
  final bool obscureText;
  final String? initialValue;
  final Function(String) onChanged;
  const ProfileTextField({
    super.key,
    required this.label,
    this.icon,
    this.obscureText = false,
    this.initialValue,
    required this.onChanged,
  });

  @override
  State<ProfileTextField> createState() => _ProfileTextFieldState();
}

class _ProfileTextFieldState extends State<ProfileTextField> {

  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.initialValue);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: (value) => widget.onChanged(value),
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: widget.label,
        prefixIcon: widget.icon != null ? Icon(widget.icon) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
