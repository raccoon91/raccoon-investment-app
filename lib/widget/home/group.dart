import 'package:flutter/material.dart';
import 'package:raccoon_investment/model/group_model.dart';

class GroupCard extends StatelessWidget {
  final Group group;

  const GroupCard({
    super.key,
    required this.group,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(group.name),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: const BorderRadius.all(Radius.circular(4)),
            ),
            child: Column(
              children: group.fovorites?.map(
                    (fovorite) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(fovorite.symbols?.ticker ?? ""),
                                Text(fovorite.symbols?.currency ?? ""),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              fovorite.symbols?.name ?? "",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      );
                    },
                  ).toList() ??
                  [],
            ),
          ),
        ],
      ),
    );
  }
}
