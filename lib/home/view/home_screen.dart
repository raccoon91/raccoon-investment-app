import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raccoon_investment/auth/bloc/auth_bloc.dart';
import 'package:raccoon_investment/home/bloc/home_bloc.dart';
import 'package:raccoon_investment/home/models/trade_model.dart';

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
            BlocBuilder<HomeBloc, List<Trade>>(
              builder: (context, data) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return ListTile(title: Text(data[index].text));
                    });
              },
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
