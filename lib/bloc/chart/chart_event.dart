part of 'chart_bloc.dart';

sealed class ChartEvent {
  const ChartEvent();
}

final class SyncChart extends ChartEvent {
  final Symbol? symbol;

  SyncChart(this.symbol);
}
