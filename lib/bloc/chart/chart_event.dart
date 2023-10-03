part of 'chart_bloc.dart';

sealed class ChartEvent {
  const ChartEvent();
}

final class SyncChart extends ChartEvent {
  final String? ticker;
  final String? type;

  SyncChart(
    this.ticker,
    this.type,
  );
}
