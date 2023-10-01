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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: Theme.of(context).colorScheme.background,
          padding:
              const EdgeInsets.only(top: 24, right: 24, bottom: 12, left: 24),
          child: Text(
            group.name,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
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
                              Text(fovorite.symbols?.ticker ?? ''),
                              Text(fovorite.symbols?.currency ?? ''),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            fovorite.symbols?.name ?? '',
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
    );
  }
}
