class Symbol {
  final int id;
  final String ticker;
  final String name;
  final String country;
  final String currency;
  final String exchange;
  final String micCode;
  final String type;

  const Symbol({
    required this.id,
    required this.ticker,
    required this.name,
    required this.country,
    required this.currency,
    required this.exchange,
    required this.micCode,
    required this.type,
  });

  factory Symbol.fromJson(Map<String, dynamic> json) {
    return Symbol(
      id: json['id'],
      ticker: json['ticker'],
      name: json['name'],
      country: json['country'],
      currency: json['currency'],
      exchange: json['exchange'],
      micCode: json['mic_code'],
      type: json['type'],
    );
  }
}
