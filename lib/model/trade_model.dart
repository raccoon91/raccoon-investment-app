class Trade {
  final int id;
  final int symbolId;
  final String date;
  final String type;
  final double price;
  final double count;
  final double commission;
  final String text;

  const Trade({
    required this.id,
    required this.symbolId,
    required this.date,
    required this.type,
    required this.price,
    required this.count,
    required this.commission,
    required this.text,
  });

  factory Trade.fromJson(Map<String, dynamic> json) {
    return Trade(
      id: json['id'],
      symbolId: json['symbol_id'],
      date: json['date'],
      type: json['type'],
      price: json['price'],
      count: json['count'],
      commission: json['commission'],
      text: json['text'],
    );
  }
}
