import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final String type;
  final String label;
  final TextEditingController controller;
  final IconData? icon;
  final String? Function(String?)? validator;
  final bool? autoFocus;
  final double? width;
  final double? height;

  const Input({
    super.key,
    required this.type,
    required this.label,
    required this.controller,
    this.icon,
    this.validator,
    this.autoFocus,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height ?? 50,
      padding: const EdgeInsets.only(top: 6),
      child: TextFormField(
        autofocus: autoFocus ?? false,
        controller: controller,
        keyboardType: type == 'email'
            ? TextInputType.emailAddress
            : type == "number"
                ? TextInputType.number
                : TextInputType.text,
        obscureText: type == 'password' ? true : false,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: icon != null ? Icon(icon) : null,
        ),
      ),
    );
  }
}
