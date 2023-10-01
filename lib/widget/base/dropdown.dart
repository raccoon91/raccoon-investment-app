import 'package:flutter/material.dart';
import 'package:raccoon_investment/model/option_model.dart';

class Dropdown extends StatelessWidget {
  final double? width;
  final double? height;
  final String? value;
  final String? hint;
  final List<Option>? options;
  final Function(String? value)? onChanged;

  const Dropdown({
    super.key,
    this.width,
    this.height,
    this.value,
    this.hint,
    this.options,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height ?? 42,
      child: DropdownButtonFormField(
        hint: Text(
          hint ?? '',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.outline,
              ),
        ),
        value: value,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 12),
        ),
        dropdownColor: Theme.of(context).colorScheme.surface,
        items: options?.map((Option option) {
          return DropdownMenuItem(
            value: option.value,
            child: Text(option.label),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
