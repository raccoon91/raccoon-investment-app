import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raccoon_investment/home/models/trade_model.dart';
import 'package:raccoon_investment/main.dart';

class HomeBloc extends Cubit<List<Trade>> {
  HomeBloc() : super([]);

  void getTradeData() async {
    try {
      final List data = await supabase.from("trades").select("*");

      final List<Trade> trades =
          data.map((element) => Trade.fromJson(element)).toList();

      emit(trades);
    } catch (error) {
      print(error);
    }
  }
}