part of 'favorite_bloc.dart';

sealed class FavoriteEvent {
  const FavoriteEvent();
}

final class GetsFavorite extends FavoriteEvent {}
