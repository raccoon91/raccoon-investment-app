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
      case NavigationMenu.trade:
        emit(state.copyWith(
          menu: NavigationMenu.trade,
          index: 2,
        ));
      case NavigationMenu.chart:
        emit(state.copyWith(
          menu: NavigationMenu.chart,
          index: 3,
        ));
      case NavigationMenu.setting:
        emit(state.copyWith(
          menu: NavigationMenu.setting,
          index: 4,
        ));
      default:
        break;
    }
  }
}
