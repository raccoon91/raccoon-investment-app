import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class ChartViewScreen extends StatelessWidget {
  const ChartViewScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute(builder: (context) => const ChartViewScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 24),
          child: InAppWebView(
            initialFile: 'assets/chart.html',
            initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(transparentBackground: true),
            ),
          ),
        ),
      ),
    );
  }
}
