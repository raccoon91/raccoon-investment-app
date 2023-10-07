part of 'chart_bloc.dart';

sealed class ChartEvent {
  const ChartEvent();
}

final class GetChart extends ChartEvent {
  final Symbol? symbol;

  GetChart(this.symbol);
}

final class SyncChart extends ChartEvent {
  final Symbol? symbol;

  SyncChart(this.symbol);
}

final class DeleteChart extends ChartEvent {}
