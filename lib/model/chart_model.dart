class ChartMeta {
  final String ticker;
  final String interval;
  final String currency;
  final String exchangeTimezone;
  final String exchange;
  final String micCode;
  final String type;

  const ChartMeta({
    required this.ticker,
    required this.interval,
    required this.currency,
    required this.exchangeTimezone,
    required this.exchange,
    required this.micCode,
    required this.type,
  });

  factory ChartMeta.fromJson(Map<String, dynamic> json) {
    return ChartMeta(
      ticker: json['symbol'],
      interval: json['interval'],
      currency: json['currency'],
      exchangeTimezone: json['exchange_timezone'],
      exchange: json['exchange'],
      micCode: json['mic_code'],
      type: json['type'],
    );
  }
}

class ChartValue {
  final int timestamp;
  final double open;
  final double high;
  final double low;
  final double close;
  final int volume;

  const ChartValue({
    required this.timestamp,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.volume,
  });

  factory ChartValue.fromJson(Map<String, dynamic> json) {
    return ChartValue(
      timestamp: DateTime.parse(json['datetime']).millisecondsSinceEpoch,
      open: double.parse(json['open']),
      high: double.parse(json['high']),
      low: double.parse(json['low']),
      close: double.parse(json['close']),
      volume: int.parse(json['volume']),
    );
  }
}

class Chart {
  final ChartMeta? meta;
  final List<ChartValue>? values;

  const Chart({
    required this.meta,
    required this.values,
  });

  factory Chart.fromJson(Map<String, dynamic> json) {
    final metaData = json['meta'];
    List valueData = json['values'] ?? const [];

    final ChartMeta? meta =
        json['meta'] != null ? ChartMeta.fromJson(metaData) : null;
    final List<ChartValue> values = valueData.reversed.map((value) {
      return ChartValue.fromJson(value);
    }).toList();

    return Chart(
      meta: meta,
      values: values,
    );
  }
}
