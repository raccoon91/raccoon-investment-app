import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:raccoon_investment/bloc/auth/auth_bloc.dart';
import 'package:raccoon_investment/bloc/trade/trade_bloc.dart';
import 'package:raccoon_investment/widget/base/input.dart';

class TradeBottomSheet extends StatefulWidget {
  final String? type;

  const TradeBottomSheet({
    super.key,
    this.type,
  });

  @override
  State<TradeBottomSheet> createState() => _TradeBottomSheetState();
}

class _TradeBottomSheetState extends State<TradeBottomSheet> {
  String? type;
  final dateController = TextEditingController();
  final priceController = TextEditingController();
  final countController = TextEditingController();
  final commissionController = TextEditingController();
  final textController = TextEditingController();
  bool isValid = false;

  @override
  void initState() {
    super.initState();

    textController.text = widget.type == 'sell' ? 'sell' : 'buy';

    setState(() {
      type = widget.type;
    });
  }

  @override
  void dispose() {
    dateController.dispose();
    priceController.dispose();
    countController.dispose();
    commissionController.dispose();
    textController.dispose();
    super.dispose();
  }

  onPressSell() {
    textController.text = 'sell';

    setState(() {
      type = 'sell';
    });
  }

  onPressBuy() {
    textController.text = 'buy';

    setState(() {
      type = 'buy';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Theme.of(context).colorScheme.background,
      padding: const EdgeInsets.only(top: 42, right: 24, bottom: 12, left: 24),
      child: Form(
        onChanged: () {
          if (dateController.text.isNotEmpty &&
              priceController.text.isNotEmpty &&
              countController.text.isNotEmpty &&
              commissionController.text.isNotEmpty &&
              textController.text.isNotEmpty) {
            setState(() {
              isValid = true;
            });
          } else {
            setState(() {
              isValid = false;
            });
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: (MediaQuery.of(context).size.width / 3),
                  height: 4,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.outline,
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                )
              ],
            ),
            const SizedBox(height: 40),
            Text('Trade', style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: (MediaQuery.of(context).size.width / 2) - 34,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: onPressSell,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: type == 'sell'
                          ? Theme.of(context).colorScheme.error
                          : Theme.of(context).colorScheme.surface,
                    ),
                    child: Text(
                      'Sell',
                      style: TextStyle(
                        color: type == 'sell'
                            ? Theme.of(context).colorScheme.surface
                            : Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: (MediaQuery.of(context).size.width / 2) - 34,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: onPressBuy,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: type == 'buy'
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.surface,
                    ),
                    child: Text(
                      'Buy',
                      style: TextStyle(
                        color: type == 'buy'
                            ? Theme.of(context).colorScheme.surface
                            : Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 10),
                    // Input(
                    //   type: 'text',
                    //   label: 'Symbol',
                    //   controller: typeController,
                    // ),
                    // const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Input(
                          width: MediaQuery.of(context).size.width - 124,
                          type: 'text',
                          label: 'Date',
                          controller: dateController,
                        ),
                        SizedBox(
                          width: 70,
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
                                        primary: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        surface: Theme.of(context)
                                            .colorScheme
                                            .background,
                                      ),
                                      dialogBackgroundColor: Theme.of(context)
                                          .colorScheme
                                          .background,
                                    ),
                                    child: child ?? Container(),
                                  );
                                },
                              ).then((value) {
                                if (value == null) return;

                                dateController.text =
                                    DateFormat('yyyy-MM-dd').format(value);
                              });
                            },
                            child: const Icon(Icons.calendar_month),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Input(
                      type: 'number',
                      label: 'Price',
                      controller: priceController,
                    ),
                    const SizedBox(height: 20),
                    Input(
                      type: 'number',
                      label: 'Count',
                      controller: countController,
                    ),
                    const SizedBox(height: 20),
                    Input(
                      type: 'number',
                      label: 'Commission',
                      controller: commissionController,
                    ),
                    const SizedBox(height: 20),
                    Input(
                      type: 'text',
                      label: 'Text',
                      controller: textController,
                    ),
                    const SizedBox(height: 40),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        return SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: (type != null && isValid)
                                ? () {
                                    context.read<TradeBloc>().add(
                                          PostTrade(
                                            state.user?.id,
                                            type,
                                            dateController.text,
                                            priceController.text,
                                            countController.text,
                                            commissionController.text,
                                            textController.text,
                                          ),
                                        );
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              foregroundColor:
                                  Theme.of(context).colorScheme.surface,
                              disabledBackgroundColor:
                                  Theme.of(context).colorScheme.outline,
                              disabledForegroundColor:
                                  Theme.of(context).colorScheme.surface,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text(
                              'Create',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
