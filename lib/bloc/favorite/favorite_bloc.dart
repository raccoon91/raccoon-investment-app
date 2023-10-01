import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raccoon_investment/model/favorite_model.dart';
import 'package:raccoon_investment/repository/favorite_repository.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoriteRepository favoriteRepository;

  FavoriteBloc({required this.favoriteRepository})
      : super(const FavoriteState()) {
    on<GetsFavorite>(onGetsFavorite);
  }

  void onGetsFavorite(GetsFavorite event, Emitter<FavoriteState> emit) async {
    try {
      emit(state.copyWith(status: FavoriteStatus.loading));

      final favorites = await favoriteRepository.getsFavorite();

      emit(
        state.copyWith(status: FavoriteStatus.success, favorites: favorites),
      );
    } catch (error) {
      emit(state.copyWith(status: FavoriteStatus.failure));
    }
  }
}
