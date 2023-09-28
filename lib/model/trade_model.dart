class Trade {
  final int id;
  final String date;
  final String type;
  final num price;
  final num count;
  final num commission;
  final String text;
  final String ticker;
  final String name;

  const Trade({
    required this.id,
    required this.date,
    required this.type,
    required this.price,
    required this.count,
    required this.commission,
    required this.text,
    required this.ticker,
    required this.name,
  });

  factory Trade.fromJson(Map<String, dynamic> json) {
    return Trade(
      id: json['id'],
      date: json['date'],
      type: json['type'],
      price: json['price'],
      count: json['count'],
      commission: json['commission'],
      text: json['text'],
      ticker: json['symbol_id']['ticker'],
      name: json['symbol_id']['name'],
    );
  }
}
