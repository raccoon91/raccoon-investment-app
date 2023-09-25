part of 'trade_bloc.dart';

sealed class TradeEvent {
  const TradeEvent();
}

final class GetsTrade extends TradeEvent {}
