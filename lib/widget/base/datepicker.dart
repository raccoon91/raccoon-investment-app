import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:raccoon_investment/widget/base/input.dart';

class Datepicker extends StatelessWidget {
  const Datepicker({
    super.key,
    required this.dateController,
  });

  final TextEditingController dateController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Input(
          width: MediaQuery.of(context).size.width - 114,
          type: 'text',
          label: 'Date',
          controller: dateController,
        ),
        SizedBox(
          width: 60,
          height: 44,
          child: ElevatedButton(
            onPressed: () {
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1980),
                lastDate: DateTime.now(),
                initialEntryMode: DatePickerEntryMode.input,
                builder: (context, child) {
                  return Theme(
                    data: ThemeData.dark().copyWith(
                      colorScheme: ColorScheme.dark(
                        primary: Theme.of(context).colorScheme.primary,
                        surface: Theme.of(context).colorScheme.background,
                      ),
                      dialogBackgroundColor:
                          Theme.of(context).colorScheme.background,
                    ),
                    child: child ?? Container(),
                  );
                },
              ).then((value) {
                if (value == null) return;

                dateController.text = DateFormat('yyyy-MM-dd').format(value);
              });
            },
            child: const Icon(Icons.calendar_month),
          ),
        ),
      ],
    );
  }
}
