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
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          // Migration from v1 to v2: Add reading status fields
          await m.addColumn(readingItems, readingItems.status);
          await m.addColumn(readingItems, readingItems.statusUpdatedAtUtc);
          await m.addColumn(readingItems, readingItems.completedAtUtc);
          
          // Backfill existing rows: set status = wantToRead and statusUpdatedAtUtc = addedAtUtc
          // Query existing items and update them individually to avoid SQLite column reference issues
          final existingItems = await (select(readingItems)..where((r) => r.statusUpdatedAtUtc.isNull())).get();
          for (final item in existingItems) {
            await (update(readingItems)..where((r) => r.id.equals(item.id))).write(
              ReadingItemsCompanion(
                status: const Value(ReadingStatus.wantToRead),
                statusUpdatedAtUtc: Value(item.addedAtUtc),
              ),
            );
          }
        }
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

