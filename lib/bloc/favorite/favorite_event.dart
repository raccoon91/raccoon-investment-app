part of 'favorite_bloc.dart';

sealed class FavoriteEvent {
  const FavoriteEvent();
}

final class GetFavorites extends FavoriteEvent {}
