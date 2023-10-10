import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raccoon_investment/model/favorite_model.dart';
import 'package:raccoon_investment/model/symbol_model.dart';
import 'package:raccoon_investment/repository/favorite_repository.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoriteRepository favoriteRepository;

  FavoriteBloc({required this.favoriteRepository})
      : super(const FavoriteState()) {
    on<GetFavorites>(onGetFavorites);
    on<GetFavorite>(onGetFavorite);
  }

  void onGetFavorites(GetFavorites event, Emitter<FavoriteState> emit) async {
    try {
      emit(state.copyWith(status: FavoriteStatus.loading));

      final favorites = await favoriteRepository.getFavorites();

      emit(
        state.copyWith(status: FavoriteStatus.success, favorites: favorites),
      );
    } catch (error) {
      emit(state.copyWith(status: FavoriteStatus.failure));
    }
  }

  void onGetFavorite(GetFavorite event, Emitter<FavoriteState> emit) async {
    try {
      emit(state.copyWith(status: FavoriteStatus.loading));

      final favorite = await favoriteRepository.getFavorite(event.symbol);

      emit(state.copyWith(status: FavoriteStatus.success, favorite: favorite));
    } catch (error) {
      emit(state.copyWith(status: FavoriteStatus.failure));
    }
  }
}
