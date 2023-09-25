import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raccoon_investment/bloc/auth/auth_bloc.dart';
import 'package:raccoon_investment/bloc/trade/trade_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const HomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Builder(
              builder: (context) {
                final userId = context.select(
                  (AuthBloc bloc) => bloc.state.user?.email,
                );
                return Text('UserID: $userId');
              },
            ),
            Flexible(
              child: BlocBuilder<TradeBloc, TradeState>(
                buildWhen: (prev, current) => current.status.isSuccess,
                builder: (context, state) {
                  return ListView.builder(
                    itemCount: state.trades.length,
                    itemBuilder: (context, index) {
                      return Wrap(
                        children: [
                          Text(state.trades[index].date),
                          Text(state.trades[index].type),
                          Text(state.trades[index].count.toString()),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            ElevatedButton(
              child: const Text('Logout'),
              onPressed: () {
                context.read<AuthBloc>().add(AuthLogoutRequested());
              },
            ),
          ],
        ),
      ),
    );
  }
}
