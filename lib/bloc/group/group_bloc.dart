import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raccoon_investment/model/group_model.dart';
import 'package:raccoon_investment/repository/group_repository.dart';

part 'group_event.dart';
part 'group_state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  final GroupRepository groupRepository;

  GroupBloc({required this.groupRepository}) : super(const GroupState()) {
    on<GetsGroup>(onGetsGroup);
  }

  void onGetsGroup(GetsGroup event, Emitter<GroupState> emit) async {
    try {
      emit(state.copyWith(status: GroupStatus.loading));

      final groups = await groupRepository.getsGroup();

      emit(
        state.copyWith(
          status: GroupStatus.success,
          groups: groups,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: GroupStatus.failure));
    }
  }
}
