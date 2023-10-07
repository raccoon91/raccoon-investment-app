part of 'chart_bloc.dart';

enum ChartStatus { initial, loading, success, empty, failure }

extension ChartStatusX on ChartStatus {
  bool get isInitial => this == ChartStatus.initial;
  bool get isLoading => this == ChartStatus.loading;
  bool get isSuccess => this == ChartStatus.success;
  bool get isEmpty => this == ChartStatus.empty;
  bool get isFailure => this == ChartStatus.failure;
}

class ChartState extends Equatable {
  final ChartStatus status;
  final List<ValueTableData> values;

  ChartState({
    this.status = ChartStatus.initial,
    List<ValueTableData>? chartValues,
  }) : values = chartValues ?? [];

  ChartState copyWith({
    ChartStatus? status,
    List<ValueTableData>? chartValues,
  }) {
    return ChartState(
      status: status ?? this.status,
      chartValues: chartValues,
    );
  }

  @override
  List<Object?> get props => [status, values];
}
