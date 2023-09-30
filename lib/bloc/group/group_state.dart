part of 'group_bloc.dart';

enum GroupStatus { initial, loading, success, failure }

extension GroupStatusX on GroupStatus {
  bool get isInitial => this == GroupStatus.initial;
  bool get isLoading => this == GroupStatus.loading;
  bool get isSuccess => this == GroupStatus.success;
  bool get isFailure => this == GroupStatus.failure;
}

class GroupState extends Equatable {
  final GroupStatus status;
  final List<Group> groups;

  const GroupState({
    this.status = GroupStatus.initial,
    List<Group>? groups,
  }) : groups = groups ?? const [];

  GroupState copyWith({
    GroupStatus? status,
    List<Group>? groups,
  }) {
    return GroupState(
      status: status ?? this.status,
      groups: groups ?? this.groups,
    );
  }

  @override
  List<Object?> get props => [status, groups];
}
