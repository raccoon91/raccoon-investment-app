import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:raccoon_investment/bloc/favorite/favorite_bloc.dart';
import 'package:raccoon_investment/repository/favorite_repository.dart';

class ChartViewScreen extends StatelessWidget {
  const ChartViewScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute(builder: (context) {
      return BlocProvider(
        create: (context) => FavoriteBloc(
          favoriteRepository: FavoriteRepository(),
        ),
        child: const ChartViewScreen(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: BlocBuilder<FavoriteBloc, FavoriteState>(
            buildWhen: (previous, current) {
              return current.status.isSuccess;
            },
            builder: (context, state) {
              return InAppWebView(
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
                      return [
                        {
                          'time': '2018-12-22',
                          'open': 75.16,
                          'high': 82.84,
                          'low': 36.16,
                          'close': 45.72
                        },
                        {
                          'time': '2018-12-23',
                          'open': 45.12,
                          'high': 53.90,
                          'low': 45.12,
                          'close': 48.09
                        },
                        {
                          'time': '2018-12-24',
                          'open': 60.71,
                          'high': 60.71,
                          'low': 53.39,
                          'close': 59.29
                        },
                      ];
                    },
                  );
                },
                onConsoleMessage: (controller, consoleMessage) {
                  print(consoleMessage.message);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
