part of 'favorite_bloc.dart';

enum FavoriteStatus { initial, loading, success, failure }

extension FavoriteStatusX on FavoriteStatus {
  bool get isInitial => this == FavoriteStatus.initial;
  bool get isLoading => this == FavoriteStatus.loading;
  bool get isSuccess => this == FavoriteStatus.success;
  bool get isFailure => this == FavoriteStatus.failure;
}

class FavoriteState extends Equatable {
  final FavoriteStatus status;
  final Favorite? favorite;
  final List<Favorite> favorites;

  const FavoriteState({
    this.status = FavoriteStatus.initial,
    this.favorite,
    List<Favorite>? favorites,
  }) : favorites = favorites ?? const [];

  FavoriteState copyWith({
    FavoriteStatus? status,
    Favorite? favorite,
    List<Favorite>? favorites,
  }) {
    return FavoriteState(
      status: status ?? this.status,
      favorite: favorite ?? this.favorite,
      favorites: favorites ?? this.favorites,
    );
  }

  @override
  List<Object?> get props => [status, favorite, favorites];
}
