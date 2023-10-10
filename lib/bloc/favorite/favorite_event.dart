part of 'favorite_bloc.dart';

sealed class FavoriteEvent {
  const FavoriteEvent();
}

final class GetFavorites extends FavoriteEvent {}

final class GetFavorite extends FavoriteEvent {
  final Symbol? symbol;

  GetFavorite(this.symbol);
}
