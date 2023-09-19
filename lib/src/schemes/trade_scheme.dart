class Trade {
  int? id;
  DateTime? date;
  String? type;
  int? price;
  int? count;
  int? commission;
  String? text;

  Trade({
    required this.id,
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
      date: json['date'],
      type: json['type'],
      price: json['price'],
      count: json['count'],
      commission: json['commission'],
      text: json['text'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['id'] = id;
    data['date'] = date;
    data['type'] = type;
    data['price'] = price;
    data['count'] = count;
    data['commission'] = commission;
    data['text'] = text;

    return data;
  }
}
