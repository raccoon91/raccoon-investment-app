import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raccoon_investment/bloc/auth/auth_bloc.dart';
import 'package:raccoon_investment/bloc/home/home_bloc.dart';
import 'package:raccoon_investment/model/trade_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const HomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    final dataBloc = BlocProvider.of<HomeBloc>(context);

    if (dataBloc.state.isEmpty) {
      dataBloc.getTradeData();
    }

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
              child: BlocBuilder<HomeBloc, List<Trade>>(
                builder: (context, data) {
                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Wrap(
                          children: [
                            Text(data[index].date),
                            Text(data[index].type),
                            // Text(data[index].symbolId.toString()),
                            // Text(data[index].price.toString()),
                            Text(data[index].count.toString()),
                          ],
                        );
                      });
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
