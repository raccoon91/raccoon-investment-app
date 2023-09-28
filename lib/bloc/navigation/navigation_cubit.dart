import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState());

  void navigate(NavigationMenu menu) {
    switch (menu) {
      case NavigationMenu.home:
        emit(state.copyWith(
          menu: NavigationMenu.home,
          index: 0,
        ));
        break;
      case NavigationMenu.settings:
        emit(state.copyWith(
          menu: NavigationMenu.settings,
          index: 1,
        ));
        break;
    }
  }
}
