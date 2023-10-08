import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:raccoon_investment/bloc/trade/trade_bloc.dart';
import 'package:raccoon_investment/widget/base/bottom_navigation.dart';
import 'package:raccoon_investment/widget/trade/calendar.dart';

class TradeScreen extends StatefulWidget {
  const TradeScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute(builder: (context) => const TradeScreen());
  }

  @override
  State<TradeScreen> createState() => _TradeScreenState();
}

class _TradeScreenState extends State<TradeScreen> {
  String? selected;

  onPressedDay(selectedDay, focusedDay) {
    setState(() {
      selected = DateFormat('yyyy-MM-dd').format(selectedDay);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      bottomNavigationBar: const BottomNavigation(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
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
                                                Text(trade.symbols?.ticker ??
                                                    ''),
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
          ),
        ),
      ),
    );
  }
}
