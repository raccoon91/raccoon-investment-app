import 'package:flutter/material.dart';

class Input extends StatefulWidget {
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
  State<Input> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<Input> {
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      autofocus: widget.autoFocus ?? false,
      controller: widget.controller,
      keyboardType: widget.type == "email"
          ? TextInputType.emailAddress
          : TextInputType.text,
      obscureText: widget.type == "password" ? true : false,
      validator: widget.validator,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyle(
          color: focusNode.hasFocus ? Colors.teal : Colors.white,
        ),
        prefixIcon: Icon(widget.icon),
        prefixIconColor: focusNode.hasFocus ? Colors.teal : Colors.white,
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: Colors.teal),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
      style: TextStyle(
        color: focusNode.hasFocus ? Colors.teal : Colors.white,
      ),
    );
  }
}
