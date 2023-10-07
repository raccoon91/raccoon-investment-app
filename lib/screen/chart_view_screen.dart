import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:intl/intl.dart';
import 'package:raccoon_investment/bloc/chart/chart_bloc.dart';
import 'package:raccoon_investment/model/symbol_model.dart';
import 'package:raccoon_investment/repository/chart_repository.dart';

class ChartViewScreen extends StatelessWidget {
  final Symbol? symbol;

  const ChartViewScreen({super.key, this.symbol});

  static Route<void> route(Symbol? symbol) {
    return MaterialPageRoute(builder: (context) {
      return BlocProvider(
        create: (context) => ChartBloc(
          chartRepository: ChartRepository(),
        ),
        child: ChartViewScreen(symbol: symbol),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.cloud_download_outlined),
            tooltip: 'sync chart data',
            onPressed: () {
              context.read<ChartBloc>().add(SyncChart(symbol));
            },
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Column(
            children: [
              Flexible(
                child: BlocBuilder<ChartBloc, ChartState>(
                  buildWhen: (previous, current) {
                    return current.values.isNotEmpty;
                  },
                  builder: (context, state) {
                    if (state.values.isEmpty) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        child: const Center(
                          child: Text('No chart data'),
                        ),
                      );
                    }

                    if (kIsWeb) {
                      return SingleChildScrollView(
                        child: Column(
                          children: state.values.map((value) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 36,
                              ),
                              child: Text(
                                '${DateFormat('yyyy-MM-dd').format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                    value.timestamp,
                                  ),
                                )}, ${value.high}, ${value.low}',
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    } else {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 500,
                        child: InAppWebView(
                          initialFile: 'assets/chart.html',
                          initialOptions: InAppWebViewGroupOptions(
                            crossPlatform: InAppWebViewOptions(
                              transparentBackground: true,
                            ),
                          ),
                          onWebViewCreated: (controller) {
                            controller.addJavaScriptHandler(
                              handlerName: 'chartData',
                              callback: (args) {
                                final chartValues =
                                    state.values.reversed.map((value) {
                                  return {
                                    'time': DateFormat('yyyy-MM-dd').format(
                                      DateTime.fromMillisecondsSinceEpoch(
                                        value.timestamp,
                                      ),
                                    ),
                                    'open': value.open,
                                    'high': value.high,
                                    'low': value.low,
                                    'close': value.close,
                                  };
                                }).toList();

                                return chartValues;
                              },
                            );
                          },
                          onConsoleMessage: (controller, consoleMessage) {
                            print("webview message");
                            print(consoleMessage.message);
                          },
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
