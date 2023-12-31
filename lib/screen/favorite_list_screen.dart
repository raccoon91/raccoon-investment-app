import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raccoon_investment/bloc/favorite/favorite_bloc.dart';
import 'package:raccoon_investment/bloc/group/group_bloc.dart';
import 'package:raccoon_investment/screen/favorite_screen.dart';
import 'package:raccoon_investment/widget/base/layout.dart';

class FavoriteListScreen extends StatelessWidget {
  const FavoriteListScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute(builder: (context) => const FavoriteListScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      child: BlocBuilder<GroupBloc, GroupState>(
        buildWhen: (previous, current) {
          return current.groups.isNotEmpty;
        },
        builder: (context, groupState) {
          return BlocBuilder<FavoriteBloc, FavoriteState>(
            buildWhen: (previous, current) {
              return current.favorites.isNotEmpty;
            },
            builder: (context, favoriteState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: favoriteState.favorites.map((favorite) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        FavoriteScreen.route(groupState.groups, favorite),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 24,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(favorite.symbols?.name ?? ''),
                          const SizedBox(width: 24, height: 24),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          );
        },
      ),
    );
  }
}
