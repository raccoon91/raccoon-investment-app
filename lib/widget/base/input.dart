import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final String type;
  final String label;
  final IconData icon;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool? autoFocus;

  const Input({
    super.key,
    required this.type,
    required this.label,
    required this.icon,
    required this.controller,
    this.validator,
    this.autoFocus,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autoFocus ?? false,
      controller: controller,
      keyboardType:
          type == 'email' ? TextInputType.emailAddress : TextInputType.text,
      obscureText: type == 'password' ? true : false,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
      ),
    );
  }
}
