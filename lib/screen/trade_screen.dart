import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raccoon_investment/bloc/favorite/favorite_bloc.dart';
import 'package:raccoon_investment/widget/base/bottom_navigation.dart';

class TradeScreen extends StatelessWidget {
  const TradeScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute(builder: (context) => const TradeScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      bottomNavigationBar: const BottomNavigation(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
            child: BlocBuilder<FavoriteBloc, FavoriteState>(
              builder: (context, state) {
                return const Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text("trade"),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
