import 'package:drift/drift.dart';
import 'package:raccoon_investment/db/table.dart';
import 'package:raccoon_investment/model/chart_model.dart';

import 'connection/connection.dart' as impl;

part 'drift.g.dart';

@DriftDatabase(tables: [MetaTable, ValueTable])
class Drift extends _$Drift {
  Drift() : super(impl.connect());

  @override
  int get schemaVersion => 1;

  Future<List<ValueTableData>> getsChartValue(int symbolId) async {
    final query = select(valueTable).join(
      [
        leftOuterJoin(
          metaTable,
          metaTable.id.equalsExp(valueTable.symbol),
          useColumns: false,
        ),
      ],
    )..where(valueTable.symbol.equals(symbolId));

    return query.map((row) => row.readTable(valueTable)).get();
  }

  Future<void> upsertCharts(Chart chart) async {
    late int symbolId;

    if (chart.meta != null) {
      symbolId = await into(metaTable).insertOnConflictUpdate(
        MetaTableCompanion(
          ticker: Value(chart.meta!.ticker),
          type: Value(chart.meta!.type),
        ),
      );
    }

    if (chart.values != null) {
      await batch((batch) {
        batch.insertAllOnConflictUpdate(
          valueTable,
          chart.values!.map((value) {
            return ValueTableCompanion(
              timestamp: Value(value.timestamp),
              open: Value(value.open),
              high: Value(value.high),
              low: Value(value.low),
              close: Value(value.close),
              volume: Value(value.volume),
              symbol: Value(symbolId),
            );
          }).toList(),
        );
      });
    }
  }

  Future<void> deleteChart(int symbolId) async {
    (delete(valueTable)..where((value) => value.symbol.equals(symbolId))).go();
    (delete(metaTable)..where((meta) => meta.id.equals(symbolId))).go();
  }

  Future<void> deleteEverything() {
    return transaction(() async {
      for (final table in allTables) {
        await delete(table).go();
      }
    });
  }
}
