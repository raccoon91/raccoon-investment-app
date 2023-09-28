import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raccoon_investment/bloc/trade/trade_bloc.dart';
import 'package:raccoon_investment/repository/trade_repository.dart';
import 'package:raccoon_investment/widget/base/bottom_navigation.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute(
      builder: (context) => BlocProvider(
        create: (context) => TradeBloc(
          tradeRepository: TradeRepository(),
        )..add(GetsTrade()),
        child: const HomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      bottomNavigationBar: const BottomNavigation(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocBuilder<TradeBloc, TradeState>(
                    buildWhen: (prev, current) => current.status.isSuccess,
                    builder: (context, state) {
                      return Text(
                        state.totalCount.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<TradeBloc, TradeState>(
                    buildWhen: (prev, current) => current.status.isSuccess,
                    builder: (context, state) {
                      return Text(
                        state.totalPrice.toStringAsFixed(2),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 2,
              child: BlocBuilder<TradeBloc, TradeState>(
                buildWhen: (prev, current) => current.status.isSuccess,
                builder: (context, state) {
                  return ListView.builder(
                    itemCount: state.trades.length,
                    itemBuilder: (context, index) {
                      return Wrap(
                        children: [
                          Text(state.trades[index].date),
                          Text(
                            state.trades[index].type,
                            style: const TextStyle(color: Colors.white),
                          ),
                          Text(
                            state.trades[index].count.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
