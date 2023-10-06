import 'dart:async';

// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:http/http.dart' as http;
import 'package:raccoon_investment/main.dart';
import 'package:raccoon_investment/model/chart_model.dart';

class ChartRepository {
  Future<Chart> syncChartData(String? ticker, String? type) async {
    try {
      // final res = await http.get(
      //   Uri.https('${dotenv.env['TWELVE_DATA_API']}', '/time_series', {
      //     'apikey': '${dotenv.env['TWELVE_DATA_API_KEY']}',
      //     'symbol': ticker,
      //     'interval': '1week',
      //     'type': type,
      //     'country': 'United States',
      //     'outputsize': '50',
      //   }),
      // );

      // final data = jsonDecode(res.body);

      final chart = {
        'meta': {
          'symbol': 'AAPL',
          'interval': '1min',
          'currency': 'USD',
          'exchange_timezone': 'America/New_York',
          'exchange': 'NASDAQ',
          'mic_code': 'XNAS',
          'type': 'Common Stock'
        },
        'values': [
          {
            'datetime': '2021-09-01 15:59:00',
            'open': '148.73500',
            'high': '148.86000',
            'low': '148.73000',
            'close': '148.85001',
            'volume': '624277'
          },
          {
            'datetime': '2021-09-08 15:58:00',
            'open': '148.72000',
            'high': '148.78000',
            'low': '148.70000',
            'close': '148.74001',
            'volume': '274622'
          },
          {
            'datetime': '2021-09-15 15:57:00',
            'open': '148.77499',
            'high': '148.79500',
            'low': '148.71001',
            'close': '148.72501',
            'volume': '254725'
          },
          {
            'datetime': '2021-09-22 15:56:00',
            'open': '148.76500',
            'high': '148.78999',
            'low': '148.72000',
            'close': '148.78000',
            'volume': '230758'
          },
          {
            'datetime': '2021-09-29 15:55:00',
            'open': '148.80000',
            'high': '148.80000',
            'low': '148.70000',
            'close': '148.76230',
            'volume': '348577'
          }
        ],
      };

      final Chart chartData = Chart.fromJson(chart);

      await drfit.upsertCharts(chartData);

      return chartData;
    } catch (error) {
      throw Exception(error);
    }
  }
}
