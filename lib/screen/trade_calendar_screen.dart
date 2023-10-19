import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:raccoon_investment/bloc/trade/trade_bloc.dart';
import 'package:raccoon_investment/widget/base/layout.dart';
import 'package:raccoon_investment/widget/trade/calendar.dart';

class TradeCalendarScreen extends StatefulWidget {
  const TradeCalendarScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute(builder: (context) => const TradeCalendarScreen());
  }

  @override
  State<TradeCalendarScreen> createState() => _TradeCalendarScreenState();
}

class _TradeCalendarScreenState extends State<TradeCalendarScreen> {
  String? selected;

  onPressedDay(selectedDay, focusedDay) {
    setState(() {
      selected = DateFormat('yyyy-MM-dd').format(selectedDay);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: BlocBuilder<TradeBloc, TradeState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Calendar(
                tradeMap: state.tradeMap,
                selected: selected,
                onDaySelected: onPressedDay,
              ),
              const SizedBox(height: 20),
              (selected != null && state.tradeMap[selected] != null)
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: state.tradeMap[selected]?.map(
                              (trade) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 12,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(trade.symbols?.ticker ?? ''),
                                          const SizedBox(height: 6),
                                          Text(
                                            trade.symbols?.name ?? '',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(trade.date),
                                          const SizedBox(height: 6),
                                          Text(
                                            '${trade.count}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ).toList() ??
                            [],
                      ),
                    )
                  : Container(),
            ],
          );
        },
      ),
    );
  }
}
