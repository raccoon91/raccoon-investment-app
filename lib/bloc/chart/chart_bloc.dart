import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raccoon_investment/model/chart_model.dart';
import 'package:raccoon_investment/model/symbol_model.dart';
import 'package:raccoon_investment/repository/chart_repository.dart';

part 'chart_event.dart';
part 'chart_state.dart';

class ChartBloc extends Bloc<ChartEvent, ChartState> {
  final ChartRepository chartRepository;

  ChartBloc({required this.chartRepository}) : super(ChartState()) {
    on<SyncChart>(onSyncChart);
  }

  void onSyncChart(SyncChart event, Emitter<ChartState> emit) async {
    if (event.symbol == null) return;

    try {
      emit(state.copyWith(status: ChartStatus.loading));

      final chartData = await chartRepository.syncChartData(event.symbol);

      emit(
        state.copyWith(
          status: ChartStatus.success,
          chartData: chartData,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: ChartStatus.failure));
    }
  }
}
