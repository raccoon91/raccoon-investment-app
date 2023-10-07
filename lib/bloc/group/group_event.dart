part of 'group_bloc.dart';

sealed class GroupEvent {
  const GroupEvent();
}

final class GetGroups extends GroupEvent {}
