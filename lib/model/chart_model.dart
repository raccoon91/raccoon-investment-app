class ChartMeta {
  final String symbol;
  final String interval;
  final String currency;
  final String exchangeTimezone;
  final String exchange;
  final String micCode;
  final String type;

  const ChartMeta({
    required this.symbol,
    required this.interval,
    required this.currency,
    required this.exchangeTimezone,
    required this.exchange,
    required this.micCode,
    required this.type,
  });

  factory ChartMeta.fromJson(Map<String, dynamic> json) {
    return ChartMeta(
      symbol: json['symbol'],
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
  final String datetime;
  final String open;
  final String high;
  final String low;
  final String close;
  final String volume;

  const ChartValue({
    required this.datetime,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.volume,
  });

  factory ChartValue.fromJson(Map<String, dynamic> json) {
    return ChartValue(
      datetime: json['datetime'],
      open: json['open'],
      high: json['high'],
      low: json['low'],
      close: json['close'],
      volume: json['volume'],
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
