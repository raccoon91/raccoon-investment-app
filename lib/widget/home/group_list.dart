import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raccoon_investment/bloc/group/group_bloc.dart';
import 'package:raccoon_investment/widget/home/group.dart';

class GroupList extends StatelessWidget {
  const GroupList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupBloc, GroupState>(
      buildWhen: (prev, current) => current.status.isSuccess,
      builder: (context, state) {
        return ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 160),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: state.groups.map((group) {
                return GroupCard(group: group);
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
