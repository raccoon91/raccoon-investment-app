part of 'trade_bloc.dart';

enum TradeStatus { initial, loading, success, failure }

extension TradeStatusX on TradeStatus {
  bool get isInitial => this == TradeStatus.initial;
  bool get isLoading => this == TradeStatus.loading;
  bool get isSuccess => this == TradeStatus.success;
  bool get isFailure => this == TradeStatus.failure;
}

class TradeState extends Equatable {
  final TradeStatus status;
  final List<Trade> trades;

  const TradeState({
    this.status = TradeStatus.initial,
    List<Trade>? trades,
  }) : trades = trades ?? const [];

  TradeState copyWith({
    TradeStatus? status,
    List<Trade>? trades,
  }) {
    return TradeState(
      status: status ?? this.status,
      trades: trades ?? this.trades,
    );
  }

  @override
  List<Object?> get props => [status, trades];
}
