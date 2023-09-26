import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raccoon_investment/bloc/auth/auth_bloc.dart';
import 'package:raccoon_investment/bloc/trade/trade_bloc.dart';
import 'package:raccoon_investment/repository/trade_repository.dart';

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
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Builder(
                    builder: (context) {
                      final userId = context.select(
                        (AuthBloc bloc) => bloc.state.user?.email,
                      );
                      return Text(
                        'UserID: $userId',
                        style: const TextStyle(color: Colors.white),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    child: const Text('Logout'),
                    onPressed: () {
                      context.read<AuthBloc>().add(AuthLogoutRequested());
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
