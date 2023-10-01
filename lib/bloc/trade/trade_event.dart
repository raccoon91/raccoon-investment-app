part of 'trade_bloc.dart';

sealed class TradeEvent {
  const TradeEvent();
}

final class GetsTrade extends TradeEvent {}

final class PostTrade extends TradeEvent {
  String? userId;
  String? type;
  final String date;
  num price;
  num count;
  num commission;
  final String text;

  PostTrade(
    this.userId,
    this.type,
    this.date,
    String price,
    String count,
    String commission,
    this.text,
  )   : price = price.isNotEmpty ? num.parse(price) : 0,
        count = count.isNotEmpty ? num.parse(count) : 0,
        commission = commission.isNotEmpty ? num.parse(commission) : 0;
}
