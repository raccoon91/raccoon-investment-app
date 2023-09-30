class Stock {
  final String ticker;
  final String name;
  num count;
  num price;

  Stock({
    required this.ticker,
    required this.name,
    int? count,
    int? price,
  })  : count = count ?? 0,
        price = price ?? 0;

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      ticker: json['ticker'],
      name: json['name'],
      count: json['count'],
      price: json['price'],
    );
  }

  addCount(num count) {
    this.count += count;
  }

  subCount(num count) {
    this.count -= count;
  }

  addPrice(num price) {
    this.price += price;
  }

  subPrice(num price) {
    this.price -= price;
  }
}
