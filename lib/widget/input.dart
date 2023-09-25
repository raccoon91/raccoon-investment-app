import 'package:flutter/material.dart';

class Input extends StatefulWidget {
  final String id;
  final String type;
  final String label;
  final IconData icon;
  final String? error;
  final bool? autoFocus;
  final void Function(String)? onChanged;

  const Input({
    super.key,
    required this.id,
    required this.type,
    required this.label,
    required this.icon,
    this.error,
    this.autoFocus,
    this.onChanged,
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
    return TextField(
      key: Key(widget.id),
      focusNode: focusNode,
      autofocus: widget.autoFocus ?? false,
      onChanged: widget.onChanged,
      keyboardType: widget.type == "email"
          ? TextInputType.emailAddress
          : TextInputType.text,
      obscureText: widget.type == "password" ? true : false,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyle(
          color: widget.error != null
              ? Colors.red
              : focusNode.hasFocus
                  ? Colors.teal
                  : Colors.white,
        ),
        errorText: widget.error,
        prefixIcon: Icon(widget.icon),
        prefixIconColor: widget.error != null
            ? Colors.red
            : focusNode.hasFocus
                ? Colors.teal
                : Colors.white,
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
        color: widget.error != null
            ? Colors.red
            : focusNode.hasFocus
                ? Colors.teal
                : Colors.white,
      ),
    );
  }
}
