import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raccoon_investment/model/trade_model.dart';
import 'package:raccoon_investment/repository/trade_repository.dart';

part 'trade_event.dart';
part 'trade_state.dart';

class TradeBloc extends Bloc<TradeEvent, TradeState> {
  final TradeRepository tradeRepository;

  TradeBloc({required this.tradeRepository}) : super(const TradeState()) {
    on<GetsTrade>(onGetsTrade);
  }

  void onGetsTrade(GetsTrade event, Emitter<TradeState> emit) async {
    try {
      emit(state.copyWith(status: TradeStatus.loading));

      num totalCount = 0;
      num totalPrice = 0;

      final trades = await tradeRepository.getsTrade();

      for (Trade trade in trades) {
        if (trade.type == "buy") {
          totalCount += trade.count;
          totalPrice += (trade.price * trade.count);
        } else if (trade.type == "sell") {
          totalCount -= trade.count;
          totalPrice -= (trade.price * trade.count);
        }
      }

      emit(
        state.copyWith(
          status: TradeStatus.success,
          trades: trades,
          totalCount: totalCount,
          totalPrice: totalPrice,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: TradeStatus.failure));
    }
  }
}
