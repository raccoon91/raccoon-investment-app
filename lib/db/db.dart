import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:raccoon_investment/db/todo_table.dart';

part 'db.g.dart';

@DriftDatabase(tables: [Todos])
class Drift extends _$Drift {
  Drift() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<int> addTodo(TodosCompanion entry) {
    return into(todos).insert(entry);
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(
    () async {
      final dbFolder = await getApplicationDocumentsDirectory();

      final file = File(p.join(dbFolder.path, 'db.sqlite'));

      return NativeDatabase.createInBackground(file);
    },
  );
}
