import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raccoon_investment/bloc/navigation/navigation_cubit.dart';
import 'package:raccoon_investment/bloc/trade/trade_bloc.dart';
import 'package:raccoon_investment/repository/trade_repository.dart';
import 'package:raccoon_investment/screen/home_screen.dart';
import 'package:raccoon_investment/screen/setting_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute(builder: (context) => const MainScreen());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TradeBloc(
            tradeRepository: TradeRepository(),
          )..add(GetsTrade()),
        ),
        BlocProvider(create: (_) => NavigationCubit()),
      ],
      child: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          switch (state.menu) {
            case NavigationMenu.home:
              return const HomeScreen();
            case NavigationMenu.settings:
              return const SettingScreen();
            default:
              return Container();
          }
        },
      ),
    );
  }
}
