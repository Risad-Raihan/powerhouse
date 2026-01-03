import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'converters/enum_converters.dart';
import 'tables/prayer_tables.dart';
import 'tables/reading_tables.dart';
import 'tables/capture_tables.dart';
import 'tables/gamification_tables.dart';
import 'tables/insights_tables.dart';

part 'app_database.g.dart';

/// Main PowerHouse database
/// Uses Drift ORM with SQLite
/// 
/// To regenerate code after schema changes, run:
///   dart run build_runner build --delete-conflicting-outputs
@DriftDatabase(tables: [
  PrayerEntries,
  ReadingItems,
  ReadingSessions,
  CaptureItems,
  XpEvents,
  InsightEntries,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // Future migrations will go here
      },
    );
  }
}

/// Open SQLite database connection
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'powerhouse.db'));
    return NativeDatabase(file);
  });
}

