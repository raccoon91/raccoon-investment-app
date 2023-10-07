part of 'trade_bloc.dart';

sealed class TradeEvent {
  const TradeEvent();
}

final class GetTrades extends TradeEvent {}

final class PostTrade extends TradeEvent {
  final String userId;
  final String type;
  final String symbolId;
  final String date;
  final num price;
  final num count;
  final num commission;
  final String text;

  PostTrade(
    String? userId,
    String? type,
    String? symbolId,
    this.date,
    String price,
    String count,
    String commission,
    this.text,
  )   : userId = userId ?? '',
        type = type ?? '',
        symbolId = symbolId ?? '',
        price = price.isNotEmpty ? num.parse(price) : 0,
        count = count.isNotEmpty ? num.parse(count) : 0,
        commission = commission.isNotEmpty ? num.parse(commission) : 0;
}
