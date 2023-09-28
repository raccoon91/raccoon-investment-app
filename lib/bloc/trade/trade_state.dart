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
  final num totalCount;
  final num totalPrice;
  final List stockList;

  const TradeState({
    this.status = TradeStatus.initial,
    List<Trade>? trades,
    num? totalCount,
    num? totalPrice,
    List? stockList,
  })  : trades = trades ?? const [],
        totalCount = totalCount ?? 0,
        totalPrice = totalPrice ?? 0,
        stockList = stockList ?? const [];

  TradeState copyWith({
    TradeStatus? status,
    List<Trade>? trades,
    num? totalCount,
    num? totalPrice,
    List? stockList,
  }) {
    return TradeState(
      status: status ?? this.status,
      trades: trades ?? this.trades,
      totalCount: totalCount ?? this.totalCount,
      totalPrice: totalPrice ?? this.totalPrice,
      stockList: stockList ?? this.stockList,
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
