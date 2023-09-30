part of 'group_bloc.dart';

sealed class GroupEvent {
  const GroupEvent();
}

final class GetsGroup extends GroupEvent {}
