import 'dart:async';
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:raccoon_investment/model/chart_model.dart';

class ChartRepository {
  Future<Chart> syncChartData(String? ticker, String? type) async {
    try {
      final res = await http.get(
        Uri.https('${dotenv.env['TWELVE_DATA_API']}', '/time_series', {
          'apikey': '${dotenv.env['TWELVE_DATA_API_KEY']}',
          'symbol': ticker,
          'interval': '1week',
          'type': type,
          'country': 'United States',
          'outputsize': '50',
        }),
      );

      final data = jsonDecode(res.body);

      final Chart chartData = Chart.fromJson(data);

      return chartData;
    } catch (error) {
      throw Exception(error);
    }
  }
}
