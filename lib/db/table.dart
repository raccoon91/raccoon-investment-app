import 'package:drift/drift.dart';

class MetaTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get ticker => text()();
  TextColumn get type => text()();
}

class ValueTable extends Table {
  IntColumn get timestamp => integer()();
  RealColumn get open => real()();
  RealColumn get high => real()();
  RealColumn get low => real()();
  RealColumn get close => real()();
  IntColumn get volume => integer()();
  IntColumn get symbol => integer().references(MetaTable, #id)();

  @override
  Set<Column> get primaryKey => {timestamp, symbol};
}
