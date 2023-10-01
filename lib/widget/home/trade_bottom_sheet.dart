import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:raccoon_investment/bloc/auth/auth_bloc.dart';
import 'package:raccoon_investment/bloc/favorite/favorite_bloc.dart';
import 'package:raccoon_investment/bloc/trade/trade_bloc.dart';
import 'package:raccoon_investment/model/option_model.dart';
import 'package:raccoon_investment/widget/base/dropdown.dart';
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
  String? symbolId;
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

  onPressedSell() {
    textController.text = 'sell';

    setState(() {
      type = 'sell';
    });
  }

  onPressedBuy() {
    textController.text = 'buy';

    setState(() {
      type = 'buy';
    });
  }

  onChangedSymbol(String? value) {
    setState(() {
      symbolId = value;
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
                    onPressed: onPressedSell,
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
                    onPressed: onPressedBuy,
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
                    BlocBuilder<FavoriteBloc, FavoriteState>(
                      builder: (context, state) {
                        return Dropdown(
                          hint: 'Symbol',
                          value: symbolId,
                          options: state.favorites.map((favorite) {
                            return Option.fromJson({
                              'label': favorite.symbols?.name,
                              'value': '${favorite.symbols?.id}',
                            });
                          }).toList(),
                          onChanged: onChangedSymbol,
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
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
                            onPressed:
                                (type != null && symbolId != null && isValid)
                                    ? () {
                                        context.read<TradeBloc>().add(
                                              PostTrade(
                                                state.user?.id,
                                                type,
                                                symbolId,
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
