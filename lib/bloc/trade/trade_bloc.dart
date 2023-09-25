import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raccoon_investment/model/trade_model.dart';
import 'package:raccoon_investment/repository/trade_repository.dart';

part 'trade_event.dart';
part 'trade_state.dart';

class TradeBloc extends Bloc<TradeEvent, TradeState> {
  final TradeRepository tradeRepository;

  TradeBloc({required this.tradeRepository}) : super(const TradeState()) {
    on<GetsTrade>(_onGetsTrade);
  }

  void _onGetsTrade(TradeEvent event, Emitter<TradeState> emit) async {
    emit(state.copyWith(status: TradeStatus.loading));

    try {
      final trades = await tradeRepository.getsTrade();

      emit(
        state.copyWith(
          status: TradeStatus.success,
          trades: trades,
        ),
      );
    } catch (error, stacktrace) {
      emit(state.copyWith(status: TradeStatus.failure));
      print(stacktrace);
    }
  }
}
