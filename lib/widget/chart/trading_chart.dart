import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:raccoon_investment/db/drift.dart';

class TradingChart extends StatelessWidget {
  final List<ValueTableData> values;

  const TradingChart({
    super.key,
    required this.values,
  });

  @override
  Widget build(BuildContext context) {
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
              final chartValues = values.map((value) {
                return {
                  'time': value.datetime,
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
          print('webview message');
          print(consoleMessage.message);
        },
      ),
    );
  }
}
