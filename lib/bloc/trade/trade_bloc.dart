import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raccoon_investment/main.dart';
import 'package:raccoon_investment/model/stock_model.dart';
import 'package:raccoon_investment/model/trade_model.dart';
import 'package:raccoon_investment/repository/trade_repository.dart';

part 'trade_event.dart';
part 'trade_state.dart';

class TradeBloc extends Bloc<TradeEvent, TradeState> {
  final TradeRepository tradeRepository;

  TradeBloc({required this.tradeRepository}) : super(const TradeState()) {
    on<GetTrades>(onGetTrades);
    on<PostTrade>(onPostTrade);
  }

  void onGetTrades(GetTrades event, Emitter<TradeState> emit) async {
    try {
      emit(state.copyWith(status: TradeStatus.loading));

      num totalCount = 0;
      num totalPrice = 0;
      Map<String, List<Trade>> tradeMap = {};
      Map<String, Stock> stocks = {};
      List<Stock> stockList = [];

      final trades = await tradeRepository.getTrades();

      for (Trade trade in trades) {
        final symbol = trade.symbols;

        if (symbol == null) return;

        if (tradeMap[trade.date] == null) {
          tradeMap[trade.date] = [];
        }

        tradeMap[trade.date]?.add(trade);

        if (stocks[symbol.ticker] == null) {
          stocks[symbol.ticker] = Stock.fromJson({
            'ticker': symbol.ticker,
            'name': symbol.name,
          });
        }

        if (trade.type == 'buy') {
          totalCount += trade.count;
          totalPrice += (trade.price * trade.count);
          stocks[symbol.ticker]?.addCount(trade.count);
          stocks[symbol.ticker]?.addPrice(trade.price * trade.count);
        } else if (trade.type == 'sell') {
          totalCount -= trade.count;
          totalPrice -= (trade.price * trade.count);
          stocks[symbol.ticker]?.subCount(trade.count);
          stocks[symbol.ticker]?.subPrice(trade.price * trade.count);
        }
      }

      stocks.forEach((key, value) {
        stockList.add(value);
      });

      emit(
        state.copyWith(
          status: TradeStatus.success,
          trades: trades,
          tradeMap: tradeMap,
          stockList: stockList.sublist(0, 4),
          totalCount: totalCount,
          totalPrice: totalPrice,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: TradeStatus.failure));
    }
  }

  Future<void> onPostTrade(PostTrade event, Emitter<TradeState> emit) async {
    try {
      emit(state.copyWith(status: TradeStatus.loading));

      await supabase.from('trades').insert({
        'type': event.type,
        'date': event.date,
        'price': event.price.toString(),
        'count': event.count.toString(),
        'commission': event.commission.toString(),
        'text': event.text,
        'symbol_id': event.symbolId,
        'user_id': event.userId,
      });

      num totalCount = 0;
      num totalPrice = 0;
      Map<String, List<Trade>> tradeMap = {};
      Map<String, Stock> stocks = {};
      List<Stock> stockList = [];

      final trades = await tradeRepository.getTrades();

      for (Trade trade in trades) {
        final symbol = trade.symbols;

        if (symbol == null) return;

        if (tradeMap[trade.date] == null) {
          tradeMap[trade.date] = [];
        }

        tradeMap[trade.date]?.add(trade);

        if (stocks[symbol.ticker] == null) {
          stocks[symbol.ticker] = Stock.fromJson({
            'ticker': symbol.ticker,
            'name': symbol.name,
          });
        }

        if (trade.type == 'buy') {
          totalCount += trade.count;
          totalPrice += (trade.price * trade.count);
          stocks[symbol.ticker]?.addCount(trade.count);
          stocks[symbol.ticker]?.addPrice(trade.price * trade.count);
        } else if (trade.type == 'sell') {
          totalCount -= trade.count;
          totalPrice -= (trade.price * trade.count);
          stocks[symbol.ticker]?.subCount(trade.count);
          stocks[symbol.ticker]?.subPrice(trade.price * trade.count);
        }
      }

      stocks.forEach((key, value) {
        stockList.add(value);
      });

      emit(
        state.copyWith(
          status: TradeStatus.success,
          trades: trades,
          tradeMap: tradeMap,
          stockList: stockList.sublist(0, 4),
          totalCount: totalCount,
          totalPrice: totalPrice,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: TradeStatus.failure));
    }
  }
}
