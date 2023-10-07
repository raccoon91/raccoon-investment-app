import 'package:drift/drift.dart';
import 'package:raccoon_investment/db/table.dart';
import 'package:raccoon_investment/model/chart_model.dart';
import 'package:raccoon_investment/model/symbol_model.dart';

import 'connection/connection.dart' as impl;

part 'drift.g.dart';

@DriftDatabase(tables: [MetaTable, ValueTable])
class Drift extends _$Drift {
  Drift() : super(impl.connect());

  @override
  int get schemaVersion => 1;

  Future<List<ValueTableData>> getChartValues(int? symbolId) async {
    try {
      if (symbolId == null) return [];

      final query = select(valueTable).join(
        [
          leftOuterJoin(
            metaTable,
            metaTable.id.equalsExp(valueTable.symbol),
            useColumns: false,
          ),
        ],
      );
      query.where(valueTable.symbol.equals(symbolId));
      query.orderBy([OrderingTerm.asc(valueTable.datetime)]);

      var chartValues =
          await query.map((row) => row.readTable(valueTable)).get();

      return chartValues;
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<void> upsertChartValues(Symbol? symbol, Chart chart) async {
    try {
      if (symbol != null) {
        await into(metaTable).insertOnConflictUpdate(
          MetaTableCompanion(
            id: Value(symbol.id),
            ticker: Value(symbol.ticker),
            type: Value(symbol.type),
          ),
        );
      }

      if (symbol != null && chart.values != null) {
        await batch((batch) {
          batch.insertAllOnConflictUpdate(
            valueTable,
            chart.values!.map((value) {
              return ValueTableCompanion(
                datetime: Value(value.datetime),
                open: Value(value.open),
                high: Value(value.high),
                low: Value(value.low),
                close: Value(value.close),
                volume: Value(value.volume),
                symbol: Value(symbol.id),
              );
            }).toList(),
          );
        });
      }
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<void> deleteChart(int symbolId) async {
    try {
      (delete(valueTable)..where((value) => value.symbol.equals(symbolId)))
          .go();
      (delete(metaTable)..where((meta) => meta.id.equals(symbolId))).go();
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<void> deleteEverything() {
    try {
      return transaction(() async {
        for (final table in allTables) {
          await delete(table).go();
        }
      });
    } catch (error) {
      throw Exception(error);
    }
  }
}
