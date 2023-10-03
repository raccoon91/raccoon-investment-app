import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:raccoon_investment/bloc/chart/chart_bloc.dart';
import 'package:raccoon_investment/repository/chart_repository.dart';

class ChartViewScreen extends StatelessWidget {
  final String? ticker;
  final String? type;

  const ChartViewScreen({super.key, this.ticker, this.type});

  static Route<void> route(String? ticker, String? type) {
    return MaterialPageRoute(builder: (context) {
      return BlocProvider(
        create: (context) => ChartBloc(
          chartRepository: ChartRepository(),
        ),
        child: ChartViewScreen(ticker: ticker, type: type),
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
              context.read<ChartBloc>().add(SyncChart(ticker, type));
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
                    return state.values.isEmpty
                        ? SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 200,
                            child: const Center(
                              child: Text("No chart data"),
                            ),
                          )
                        : SizedBox(
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
                                    return state.values.map((value) {
                                      return {
                                        'time': value.datetime,
                                        'open': num.parse(value.open),
                                        'high': num.parse(value.high),
                                        'low': num.parse(value.low),
                                        'close': num.parse(value.close),
                                      };
                                    }).toList();
                                  },
                                );
                              },
                              onConsoleMessage: (controller, consoleMessage) {
                                print(consoleMessage.message);
                              },
                            ),
                          );
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
