import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raccoon_investment/bloc/chart/chart_bloc.dart';
import 'package:raccoon_investment/bloc/favorite/favorite_bloc.dart';
import 'package:raccoon_investment/bloc/group/group_bloc.dart';
import 'package:raccoon_investment/bloc/navigation/navigation_cubit.dart';
import 'package:raccoon_investment/bloc/trade/trade_bloc.dart';
import 'package:raccoon_investment/repository/chart_repository.dart';
import 'package:raccoon_investment/repository/favorite_repository.dart';
import 'package:raccoon_investment/repository/group_repository.dart';
import 'package:raccoon_investment/repository/trade_repository.dart';
import 'package:raccoon_investment/screen/chart_screen.dart';
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
        BlocProvider(
          create: (context) => GroupBloc(
            groupRepository: GroupRepository(),
          )..add(GetsGroup()),
        ),
        BlocProvider(
          create: (context) => FavoriteBloc(
            favoriteRepository: FavoriteRepository(),
          )..add(GetsFavorite()),
        ),
        BlocProvider(
          create: (context) => ChartBloc(
            chartRepository: ChartRepository(),
          ),
        ),
        BlocProvider(create: (_) => NavigationCubit()),
      ],
      child: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          switch (state.menu) {
            case NavigationMenu.home:
              return const HomeScreen();
            case NavigationMenu.chart:
              return const ChartScreen();
            case NavigationMenu.setting:
              return const SettingScreen();
            default:
              return Container();
          }
        },
      ),
    );
  }
}
