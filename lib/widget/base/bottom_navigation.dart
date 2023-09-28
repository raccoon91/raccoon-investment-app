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
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          currentIndex: state.index,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          onTap: (index) {
            if (index == 0) {
              context.read<NavigationCubit>().navigate(NavigationMenu.home);
            } else if (index == 1) {
              context.read<NavigationCubit>().navigate(NavigationMenu.settings);
            }
          },
        );
      },
    );
  }
}
