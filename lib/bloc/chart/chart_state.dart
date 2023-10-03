part of 'chart_bloc.dart';

enum ChartStatus { initial, loading, success, failure }

extension ChartStatusX on ChartStatus {
  bool get isInitial => this == ChartStatus.initial;
  bool get isLoading => this == ChartStatus.loading;
  bool get isSuccess => this == ChartStatus.success;
  bool get isFailure => this == ChartStatus.failure;
}

class ChartState extends Equatable {
  final ChartStatus status;
  final ChartMeta? meta;
  final List<ChartValue> values;

  ChartState({
    this.status = ChartStatus.initial,
    Chart? chartData,
  })  : meta = chartData?.meta,
        values = chartData?.values ?? const [];

  ChartState copyWith({
    ChartStatus? status,
    Chart? chartData,
  }) {
    return ChartState(
      status: status ?? this.status,
      chartData: chartData,
    );
  }

  @override
  List<Object?> get props => [status, meta, values];
}
