part of 'navigation_cubit.dart';

enum NavigationMenu { home, settings }

class NavigationState extends Equatable {
  final NavigationMenu menu;
  final int index;

  const NavigationState({
    this.menu = NavigationMenu.home,
    this.index = 0,
  });

  NavigationState copyWith({
    NavigationMenu? menu,
    int? index,
  }) {
    return NavigationState(
      menu: menu ?? this.menu,
      index: index ?? this.index,
    );
  }

  @override
  List<Object?> get props => [menu, index];
}
