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
  final List<Stock> stockList;
  final num totalCount;
  final num totalPrice;

  const TradeState({
    this.status = TradeStatus.initial,
    List<Trade>? trades,
    List<Stock>? stockList,
    num? totalCount,
    num? totalPrice,
  })  : trades = trades ?? const [],
        totalCount = totalCount ?? 0,
        totalPrice = totalPrice ?? 0,
        stockList = stockList ?? const [];

  TradeState copyWith({
    TradeStatus? status,
    List<Trade>? trades,
    List<Stock>? stockList,
    num? totalCount,
    num? totalPrice,
  }) {
    return TradeState(
      status: status ?? this.status,
      trades: trades ?? this.trades,
      stockList: stockList ?? this.stockList,
      totalCount: totalCount ?? this.totalCount,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  @override
  List<Object?> get props => [
        status,
        trades,
        totalCount,
        totalPrice,
        stockList,
      ];
}
