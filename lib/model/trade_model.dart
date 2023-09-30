import 'package:raccoon_investment/model/symbol_model.dart';

class Trade {
  final int id;
  final String type;
  final num price;
  final num count;
  final num commission;
  final String date;
  final String text;
  final Symbol? symbols;

  const Trade({
    required this.id,
    required this.type,
    required this.price,
    required this.count,
    required this.commission,
    required this.date,
    required this.text,
    this.symbols,
  });

  factory Trade.fromJson(Map<String, dynamic> json) {
    final Symbol? symbols =
        json['symbols'] != null ? Symbol.fromJson(json['symbols']) : null;

    return Trade(
      id: json['id'],
      type: json['type'],
      price: json['price'],
      count: json['count'],
      commission: json['commission'],
      date: json['date'],
      text: json['text'],
      symbols: symbols,
    );
  }
}
