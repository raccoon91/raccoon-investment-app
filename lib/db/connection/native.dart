import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:drift_dev/api/migrations.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

Future<File> get databaseFile async {
  final appDir = await getApplicationDocumentsDirectory();

  final dbPath = p.join(appDir.path, 'db.sqlite');

  return File(dbPath);
}

DatabaseConnection connect() {
  return DatabaseConnection.delayed(
    Future(() async {
      return NativeDatabase.createBackgroundConnection(await databaseFile);
    }),
  );
}

Future<void> validateDatabaseSchema(GeneratedDatabase database) async {
  if (kDebugMode) {
    await VerifySelf(database).validateDatabaseSchema();
  }
}
