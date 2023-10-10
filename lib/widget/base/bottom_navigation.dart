import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raccoon_investment/bloc/navigation/navigation_cubit.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: 'Favorite',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'Trade',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.show_chart),
              label: 'Chart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Setting',
            ),
          ],
          currentIndex: state.index,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          onTap: (index) {
            if (index == 0) {
              context.read<NavigationCubit>().navigate(NavigationMenu.home);
            } else if (index == 1) {
              context.read<NavigationCubit>().navigate(NavigationMenu.favorite);
            } else if (index == 2) {
              context.read<NavigationCubit>().navigate(NavigationMenu.trade);
            } else if (index == 3) {
              context.read<NavigationCubit>().navigate(NavigationMenu.chart);
            } else if (index == 4) {
              context.read<NavigationCubit>().navigate(NavigationMenu.setting);
            }
          },
        );
      },
    );
  }
}
