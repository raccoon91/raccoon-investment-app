import 'dart:async';

import 'package:raccoon_investment/main.dart';
import 'package:raccoon_investment/model/trade_model.dart';

class TradeRepository {
  Future<List<Trade>> getsTrade() async {
    try {
      final List data =
          await supabase.from('trades').select('*, symbols ( * )');

      final List<Trade> trades =
          data.map((element) => Trade.fromJson(element)).toList();

      return trades;
    } catch (error) {
      throw Exception(error);
    }
  }
}
