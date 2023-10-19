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
import 'package:raccoon_investment/screen/chart_list_screen.dart';
import 'package:raccoon_investment/screen/favorite_list_screen.dart';
import 'package:raccoon_investment/screen/home_screen.dart';
import 'package:raccoon_investment/screen/setting_screen.dart';
import 'package:raccoon_investment/screen/trade_calendar_screen.dart';

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
          )..add(GetTrades()),
        ),
        BlocProvider(
          create: (context) => GroupBloc(
            groupRepository: GroupRepository(),
          )..add(GetGroups()),
        ),
        BlocProvider(
          create: (context) => FavoriteBloc(
            favoriteRepository: FavoriteRepository(),
          )..add(GetFavorites()),
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
            case NavigationMenu.favorite:
              return const FavoriteListScreen();
            case NavigationMenu.trade:
              return const TradeCalendarScreen();
            case NavigationMenu.chart:
              return const ChartListScreen();
            case NavigationMenu.setting:
              return const SettingScreen();
            default:
              return const HomeScreen();
          }
        },
      ),
    );
  }
}
