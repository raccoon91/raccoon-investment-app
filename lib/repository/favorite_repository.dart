import 'dart:async';

import 'package:raccoon_investment/main.dart';
import 'package:raccoon_investment/model/favorite_model.dart';
import 'package:raccoon_investment/model/symbol_model.dart';

class FavoriteRepository {
  Future<List<Favorite>> getFavorites() async {
    try {
      final List data = await supabase
          .from('favorites')
          .select('*, symbols ( * )')
          .order('order', ascending: true);

      final List<Favorite> favorites =
          data.map((element) => Favorite.fromJson(element)).toList();

      return favorites;
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<Favorite?> getFavorite(Symbol? symbol) async {
    try {
      if (symbol == null) return null;

      final data = await supabase
          .from('favorites')
          .select('*, symbols ( * )')
          .eq('symbol_id', symbol.id)
          .single();

      final Favorite favorite = Favorite.fromJson(data);

      return favorite;
    } catch (error) {
      throw Exception(error);
    }
  }
}
