import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raccoon_investment/db/drift.dart';
import 'package:raccoon_investment/model/symbol_model.dart';
import 'package:raccoon_investment/repository/chart_repository.dart';

part 'chart_event.dart';
part 'chart_state.dart';

class ChartBloc extends Bloc<ChartEvent, ChartState> {
  final ChartRepository chartRepository;

  ChartBloc({required this.chartRepository}) : super(ChartState()) {
    on<GetChart>(onGetChart);
    on<SyncChart>(onSyncChart);
    on<DeleteChart>(onDeleteChart);
  }

  void onGetChart(GetChart event, Emitter<ChartState> emit) async {
    if (event.symbol == null) return;

    try {
      emit(state.copyWith(status: ChartStatus.loading));

      final chartValues = await chartRepository.getChartData(event.symbol);

      emit(
        state.copyWith(
          status: chartValues.isEmpty ? ChartStatus.empty : ChartStatus.success,
          chartValues: chartValues,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: ChartStatus.failure));
    }
  }

  void onSyncChart(SyncChart event, Emitter<ChartState> emit) async {
    if (event.symbol == null) return;

    try {
      emit(state.copyWith(status: ChartStatus.loading));

      final chartValues = await chartRepository.syncChartData(event.symbol);

      emit(
        state.copyWith(
          status: chartValues.isEmpty ? ChartStatus.empty : ChartStatus.success,
          chartValues: chartValues,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: ChartStatus.failure));
    }
  }

  void onDeleteChart(DeleteChart event, Emitter<ChartState> emit) async {
    try {
      await chartRepository.deleteDatabase();

      emit(
        state.copyWith(
          status: ChartStatus.empty,
          chartValues: [],
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: ChartStatus.failure));
    }
  }
}
