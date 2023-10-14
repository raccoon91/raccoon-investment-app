import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raccoon_investment/bloc/chart/chart_bloc.dart';
import 'package:raccoon_investment/model/symbol_model.dart';
import 'package:raccoon_investment/repository/chart_repository.dart';
import 'package:raccoon_investment/widget/chart/trading_chart.dart';

class ChartScreen extends StatelessWidget {
  final Symbol? symbol;

  const ChartScreen({super.key, this.symbol});

  static Route<void> route(Symbol? symbol) {
    return MaterialPageRoute(builder: (context) {
      return BlocProvider(
        create: (context) => ChartBloc(
          chartRepository: ChartRepository(),
        )..add(GetChart(symbol)),
        child: ChartScreen(symbol: symbol),
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
                child: BlocConsumer<ChartBloc, ChartState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state.status.isLoading) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 300,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    if (state.status.isEmpty) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 300,
                        child: const Center(
                          child: Text('No chart data'),
                        ),
                      );
                    }

                    if (Platform.isAndroid) {
                      return state.values.isNotEmpty
                          ? TradingChart(values: state.values)
                          : Container();
                    } else {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 300,
                        child: const Center(
                          child: Text('Unsupported platform'),
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
