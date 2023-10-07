import 'dart:async';
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:raccoon_investment/db/drift.dart';
import 'package:raccoon_investment/main.dart';
import 'package:raccoon_investment/model/chart_model.dart';
import 'package:raccoon_investment/model/symbol_model.dart';

class ChartRepository {
  Future<List<ValueTableData>> getChartData(Symbol? symbol) async {
    try {
      var chartValues = await drift.getsChartValue(symbol?.id);

      return chartValues;
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<List<ValueTableData>> syncChartData(Symbol? symbol) async {
    try {
      if (symbol == null) return [];

      final res = await http.get(
        Uri.https('${dotenv.env['TWELVE_DATA_API']}', '/time_series', {
          'apikey': '${dotenv.env['TWELVE_DATA_API_KEY']}',
          'symbol': symbol.ticker,
          'interval': '1week',
          'type': symbol.type,
          'country': 'United States',
          'outputsize': '5000',
        }),
      );

      final data = jsonDecode(res.body);

      final Chart chartData = Chart.fromJson(data);

      await drift.upsertCharts(symbol, chartData);

      var chartValues = await drift.getsChartValue(symbol.id);

      return chartValues;
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<void> deleteChartData() async {
    try {
      await drift.deleteEverything();
    } catch (error) {
      throw Exception(error);
    }
  }
}
